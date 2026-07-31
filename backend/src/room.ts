export interface User {
  id: string;
  name: string;
  isHost: boolean;
  joinedAt: number;
  lastSeen: number;
  pingMs: number;
}

export interface RoomState {
  id: string;
  name: string;
  hostId: string;
  createdAt: number;
  participantIds: string[];
  allowAllControl: boolean;
  isMusicMode: boolean;
  currentMediaName?: string;
}

interface WsSession {
  ws: WebSocket;
  userId: string;
  userName: string;
  joinedAt: number;
}

export class RoomDurableObject implements DurableObject {
  private sessions: Map<WebSocket, WsSession> = new Map();
  private users: Map<string, User> = new Map();
  private room: RoomState | null = null;
  private storage: DurableObjectStorage;

  constructor(state: DurableObjectState, env: Env) {
    this.storage = state.storage;
    state.blockConcurrencyWhile(async () => {
      const storedRoom = await this.storage.get<RoomState>("room");
      const storedUsers = await this.storage.get<Record<string, User>>("users");
      if (storedRoom) this.room = storedRoom;
      if (storedUsers) {
        this.users = new Map(Object.entries(storedUsers));
      }
    });
  }

  async fetch(request: Request): Promise<Response> {
    const url = new URL(request.url);

    if (request.headers.get("Upgrade")?.toLowerCase() === "websocket") {
      return this.handleWebSocket(request);
    }

    // HTTP API for room info
    if (url.pathname.endsWith("/info")) {
      return this.handleRoomInfo();
    }

    // Health inside DO
    return new Response(JSON.stringify({
      room: this.room,
      users: Array.from(this.users.values()),
      sessionCount: this.sessions.size,
      timestamp: Date.now(),
    }), {
      headers: { "Content-Type": "application/json", "Access-Control-Allow-Origin": "*" }
    });
  }

  private async handleRoomInfo(): Promise<Response> {
    return new Response(JSON.stringify({
      room: this.room,
      users: Array.from(this.users.values()),
    }), {
      headers: { "Content-Type": "application/json", "Access-Control-Allow-Origin": "*" }
    });
  }

  private async handleWebSocket(request: Request): Promise<Response> {
    const url = new URL(request.url);
    const userId = url.searchParams.get("userId") || `user_${Date.now()}`;
    const userName = url.searchParams.get("userName") || "Anonymous";

    const pair = new WebSocketPair();
    const [client, server] = Object.values(pair);

    const session: WsSession = {
      ws: server,
      userId,
      userName: decodeURIComponent(userName),
      joinedAt: Date.now(),
    };

    // @ts-ignore accept
    server.accept();

    this.sessions.set(server, session);

    // Restore or create room
    if (!this.room) {
      const roomId = url.pathname.split("/")[2] || "UNKNOWN";
      this.room = {
        id: roomId,
        name: `Room ${roomId}`,
        hostId: userId,
        createdAt: Date.now(),
        participantIds: [userId],
        allowAllControl: true,
        isMusicMode: false,
      };
      await this.persist();
    }

    // Add user
    const isHost = this.room.hostId === userId;
    const user: User = {
      id: userId,
      name: session.userName,
      isHost,
      joinedAt: Date.now(),
      lastSeen: Date.now(),
      pingMs: 0,
    };
    this.users.set(userId, user);
    if (!this.room.participantIds.includes(userId)) {
      this.room.participantIds.push(userId);
    }
    await this.persist();

    // Send initial room state to new client
    this.sendTo(server, {
      type: "room_state",
      room: this.room,
      users: Array.from(this.users.values()),
      timestamp: Date.now(),
    });

    // Broadcast user joined to others
    this.broadcast({
      type: "user_joined",
      user,
      timestamp: Date.now(),
    }, server);

    // Message handling
    server.addEventListener("message", async (event: MessageEvent) => {
      try {
        const data = JSON.parse(event.data as string);
        await this.handleMessage(server, session, data);
      } catch (e) {
        console.error("Failed to parse message", e);
      }
    });

    server.addEventListener("close", async () => {
      await this.handleClose(server, session);
    });

    server.addEventListener("error", async () => {
      await this.handleClose(server, session);
    });

    return new Response(null, { status: 101, webSocket: client });
  }

  private async handleMessage(ws: WebSocket, session: WsSession, data: any) {
    const now = Date.now();
    const userId = session.userId;

    // Update last seen
    const user = this.users.get(userId);
    if (user) {
      user.lastSeen = now;
      this.users.set(userId, user);
    }

    switch (data.type) {
      case "ping": {
        const pingId = data.pingId || `${now}`;
        this.sendTo(ws, {
          type: "pong",
          pingId,
          timestamp: now,
          rtt: 0,
        });
        break;
      }

      case "join": {
        // Already handled, but re-broadcast
        break;
      }

      case "leave": {
        await this.handleClose(ws, session);
        break;
      }

      // Sync events - broadcast to all others (or all)
      case "sync_play":
      case "sync_pause":
      case "sync_seek":
      case "sync_speed":
      case "sync_syncRequest":
      case "sync_syncResponse": {
        // Permission check: if allowAllControl false, only host can sync
        if (this.room && !this.room.allowAllControl && userId !== this.room.hostId) {
          this.sendTo(ws, { type: "error", message: "No permission to control playback", timestamp: now });
          return;
        }
        // Broadcast to all including sender? Send to others for performance, but also include for consistency
        this.broadcast({
          ...data,
          type: data.type, // keep original
          timestamp: now,
        }, null); // broadcast to all
        break;
      }

      case "chat_message": {
        // Broadcast chat
        this.broadcast({
          type: "chat_message",
          id: data.id,
          roomId: data.roomId || this.room?.id,
          userId,
          userName: session.userName,
          content: data.content,
          messageType: data.messageType || "text",
          timestamp: now,
        }, null);
        break;
      }

      case "typing": {
        this.broadcast({
          type: "typing",
          userId,
          userName: session.userName,
          roomId: this.room?.id,
          isTyping: data.isTyping,
          timestamp: now,
        }, ws); // exclude self
        break;
      }

      case "host_transfer": {
        if (userId !== this.room?.hostId) {
          this.sendTo(ws, { type: "error", message: "Only host can transfer", timestamp: now });
          return;
        }
        const newHostId = data.newHostId;
        if (!newHostId || !this.users.has(newHostId)) {
          this.sendTo(ws, { type: "error", message: "Invalid new host", timestamp: now });
          return;
        }
        if (this.room) {
          this.room.hostId = newHostId;
          // Update users host flag
          this.users.forEach((u, id) => {
            u.isHost = id === newHostId;
            this.users.set(id, u);
          });
          await this.persist();
          this.broadcast({
            type: "host_transfer",
            newHostId,
            roomId: this.room.id,
            timestamp: now,
          }, null);
          this.broadcast({
            type: "room_state",
            room: this.room,
            users: Array.from(this.users.values()),
            timestamp: now,
          }, null);
        }
        break;
      }

      case "permission_change": {
        if (userId !== this.room?.hostId) return;
        if (this.room) {
          this.room.allowAllControl = !!data.allowAllControl;
          await this.persist();
          this.broadcast({
            type: "permission_change",
            allowAllControl: this.room.allowAllControl,
            roomId: this.room.id,
            timestamp: now,
          }, null);
        }
        break;
      }

      case "media_change": {
        if (this.room) {
          this.room.currentMediaName = data.mediaName;
          await this.persist();
          this.broadcast({
            type: "media_change",
            mediaName: data.mediaName,
            userId,
            timestamp: now,
          }, null);
        }
        break;
      }

      default: {
        // Unknown - broadcast as is for extensibility
        console.log("Unknown message type", data.type);
      }
    }
  }

  private async handleClose(ws: WebSocket, session: WsSession) {
    try {
      ws.close();
    } catch {}
    this.sessions.delete(ws);

    const userId = session.userId;
    const wasHost = this.room?.hostId === userId;

    this.users.delete(userId);
    if (this.room) {
      this.room.participantIds = this.room.participantIds.filter(id => id !== userId);
    }

    // If host left and there are others, transfer host
    if (wasHost && this.users.size > 0 && this.room) {
      const next = Array.from(this.users.values())[0];
      this.room.hostId = next.id;
      next.isHost = true;
      this.users.set(next.id, next);
      console.log(`Host transferred from ${userId} to ${next.id}`);
      this.broadcast({
        type: "host_transfer",
        newHostId: next.id,
        roomId: this.room.id,
        timestamp: Date.now(),
      }, null);
    }

    await this.persist();

    this.broadcast({
      type: "user_left",
      userId,
      timestamp: Date.now(),
    }, null);

    // If no users left, consider cleaning up after some time (optional)
    if (this.users.size === 0) {
      // Keep room for 5 minutes after last user leaves
      setTimeout(async () => {
        if (this.users.size === 0) {
          await this.storage.deleteAll();
          this.room = null;
        }
      }, 5 * 60 * 1000);
    }
  }

  private broadcast(message: any, exclude?: WebSocket | null) {
    const data = JSON.stringify(message);
    for (const [ws] of this.sessions) {
      if (exclude && ws === exclude) continue;
      try {
        ws.send(data);
      } catch (e) {
        console.error("Broadcast send failed", e);
      }
    }
  }

  private sendTo(ws: WebSocket, message: any) {
    try {
      ws.send(JSON.stringify(message));
    } catch (e) {
      console.error("Send failed", e);
    }
  }

  private async persist() {
    if (this.room) {
      await this.storage.put("room", this.room);
    }
    const usersObj: Record<string, User> = {};
    this.users.forEach((u, id) => usersObj[id] = u);
    await this.storage.put("users", usersObj);
  }
}

interface Env {
  ROOM_DO: DurableObjectNamespace;
}
