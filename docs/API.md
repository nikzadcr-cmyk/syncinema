# API & WebSocket Protocol - Syncinema Backend

## Base URL
```
Production: wss://syncinema.your-subdomain.workers.dev
Local: ws://localhost:8787
```

## HTTP Endpoints

### GET /health
Returns service status.

Response:
```json
{
  "status": "ok",
  "service": "syncinema-backend",
  "version": "1.0.0",
  "timestamp": 1234567890,
  "features": ["websocket", "durable-objects", "room-sync", "chat", "presence"]
}
```

### GET /room/:roomId/info
Returns room state + users (via Durable Object).

Response:
```json
{
  "room": {
    "id": "ABC123",
    "name": "Room ABC123",
    "hostId": "user_123",
    "createdAt": 1234567890,
    "participantIds": ["user_123", "user_456"],
    "allowAllControl": true,
    "isMusicMode": false
  },
  "users": [
    {
      "id": "user_123",
      "name": "Ali",
      "isHost": true,
      "joinedAt": 1234567890,
      "lastSeen": 1234567891,
      "pingMs": 45
    }
  ]
}
```

## WebSocket

### Connect
```
GET /room/:roomId/websocket?userId=xxx&userName=yyy
Upgrade: websocket
```

Durable Object will:
- Accept WebSocket
- Create room if not exists (first user becomes host)
- Add user to room
- Send `room_state` to new client
- Broadcast `user_joined` to others

### Client -> Server Messages

All messages JSON with `type` field.

#### ping
```json
{
  "type": "ping",
  "pingId": "123456",
  "timestamp": 1234567890
}
```
Server responds `pong`.

#### sync_play / sync_pause / sync_seek / sync_speed
Broadcast to all. Permission check: if `allowAllControl=false`, only host can send.

```json
{
  "type": "sync_play",
  "roomId": "ABC123",
  "userId": "user_123",
  "positionMs": 12345,
  "isPlaying": true,
  "speed": 1.0,
  "timestamp": 1234567890
}
```

#### chat_message
```json
{
  "type": "chat_message",
  "id": "uuid",
  "roomId": "ABC123",
  "userId": "user_123",
  "userName": "Ali",
  "content": "Hello!",
  "messageType": "text", // text, emoji, reaction, system
  "timestamp": 1234567890
}
```

#### typing
```json
{
  "type": "typing",
  "roomId": "ABC123",
  "userId": "user_123",
  "userName": "Ali",
  "isTyping": true,
  "timestamp": 1234567890
}
```

#### host_transfer (host only)
```json
{
  "type": "host_transfer",
  "roomId": "ABC123",
  "newHostId": "user_456",
  "userId": "user_123",
  "timestamp": 1234567890
}
```

#### permission_change (host only)
```json
{
  "type": "permission_change",
  "roomId": "ABC123",
  "allowAllControl": false,
  "userId": "user_123",
  "timestamp": 1234567890
}
```

#### leave
```json
{
  "type": "leave",
  "roomId": "ABC123",
  "userId": "user_123",
  "timestamp": 1234567890
}
```

### Server -> Client Messages

#### room_state
Sent on join and on changes.

```json
{
  "type": "room_state",
  "room": { ... },
  "users": [ ... ],
  "timestamp": 1234567890
}
```

#### user_joined
```json
{
  "type": "user_joined",
  "user": { "id": "user_456", "name": "Sara", "isHost": false, ... },
  "timestamp": 1234567890
}
```

#### user_left
```json
{
  "type": "user_left",
  "userId": "user_456",
  "timestamp": 1234567890
}
```

#### pong
```json
{
  "type": "pong",
  "pingId": "123456",
  "timestamp": 1234567890
}
```

#### sync_* (broadcasted)
Same as client sends, but timestamp = server time.

#### chat_message (broadcasted)
```json
{
  "type": "chat_message",
  "id": "uuid",
  "roomId": "ABC123",
  "userId": "user_123",
  "userName": "Ali",
  "content": "Hello",
  "messageType": "text",
  "timestamp": 1234567890
}
```

#### typing (broadcasted, excluding sender)
```json
{
  "type": "typing",
  "userId": "user_123",
  "userName": "Ali",
  "roomId": "ABC123",
  "isTyping": true,
  "timestamp": 1234567890
}
```

#### host_transfer
```json
{
  "type": "host_transfer",
  "newHostId": "user_456",
  "roomId": "ABC123",
  "timestamp": 1234567890
}
```

#### permission_change
```json
{
  "type": "permission_change",
  "allowAllControl": false,
  "roomId": "ABC123",
  "timestamp": 1234567890
}
```

#### error
```json
{
  "type": "error",
  "message": "No permission to control playback",
  "timestamp": 1234567890
}
```

## Flow Diagrams

### Join Flow
```
Client -> WS Connect /room/ABC123/websocket?userId=x
DO: create/check room, add user, persist
DO -> Client: room_state
DO -> Others: user_joined
```

### Play Sync Flow
```
Host: play button -> SyncEngine.sendPlay(pos)
-> WS: sync_play {pos, isPlaying=true}
DO: permission check, broadcast to all
Clients: handleRemoteEvent -> applyState(seek + play)
```

### Chat Flow
```
Client: send chat_message
DO: broadcast to all
Clients: add to local list
```

## Durable Object Storage

Keys:
- `room`: RoomState
- `users`: Record<userId, User>

Persisted on every change. Survives DO restarts. Cleaned 5 min after last user leaves.

## Rate Limiting (Future)

- Could add per-IP rate limit for room creation
- Max 20 users per room (AppConstants.maxUsersInRoom)
- Max 100 messages per minute per user
