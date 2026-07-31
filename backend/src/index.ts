import { RoomDurableObject } from "./room";

export { RoomDurableObject };

export interface Env {
  ROOM_DO: DurableObjectNamespace;
}

export default {
  async fetch(request: Request, env: Env, ctx: ExecutionContext): Promise<Response> {
    const url = new URL(request.url);
    const path = url.pathname;

    // CORS headers
    const corsHeaders = {
      "Access-Control-Allow-Origin": "*",
      "Access-Control-Allow-Methods": "GET, POST, PUT, DELETE, OPTIONS",
      "Access-Control-Allow-Headers": "Content-Type, Authorization",
    };

    if (request.method === "OPTIONS") {
      return new Response(null, { headers: corsHeaders });
    }

    // Health check
    if (path === "/health" || path === "/") {
      return new Response(JSON.stringify({
        status: "ok",
        service: "syncinema-backend",
        version: "1.0.0",
        timestamp: Date.now(),
        features: ["websocket", "durable-objects", "room-sync", "chat", "presence"],
      }), {
        headers: { "Content-Type": "application/json", ...corsHeaders },
      });
    }

    // Room websocket and info
    const roomMatch = path.match(/^\/room\/([A-Z0-9]{4,10})(\/.*)?$/i);
    if (roomMatch) {
      const roomId = roomMatch[1].toUpperCase();
      const subPath = roomMatch[2] || "";

      // Get Durable Object ID and stub
      const doId = env.ROOM_DO.idFromName(roomId);
      const stub = env.ROOM_DO.get(doId);

      // Rewrite URL to include roomId for DO
      const newUrl = new URL(request.url);
      newUrl.pathname = `/room/${roomId}${subPath}`;

      // Forward request to DO
      const newRequest = new Request(newUrl.toString(), request);
      const response = await stub.fetch(newRequest);

      // Add CORS to response
      const res = new Response(response.body, response);
      Object.entries(corsHeaders).forEach(([k, v]) => res.headers.set(k, v));
      return res;
    }

    // 404
    return new Response(JSON.stringify({ error: "Not found", path }), {
      status: 404,
      headers: { "Content-Type": "application/json", ...corsHeaders },
    });
  },
};
