import { DurableObject } from "cloudflare:workers";
import type { WebsocketAttachment } from "@/core/interface";

export class BaseDurableObject extends DurableObject {
	protected sessions: Map<WebSocket, WebsocketAttachment>;

	constructor(ctx: DurableObjectState, env: Env) {
		super(ctx, env);
		this.sessions = new Map();

		ctx.getWebSockets().forEach((ws) => {
			const attachment = ws.deserializeAttachment?.();
			if (attachment) this.sessions.set(ws, { ...attachment });
		});

		ctx.setWebSocketAutoResponse?.(
			new WebSocketRequestResponsePair("ping", "pong"),
		);
	}

	async fetch(request: Request): Promise<Response> {
		const url = new URL(request.url);
		const userId = url.searchParams.get("userId");

		if (!userId) {
			return new Response("User ID is required", { status: 401 });
		}

		const pair = new WebSocketPair();
		const [client, server] = Object.values(pair);

		this.ctx.acceptWebSocket(server);
		server.serializeAttachment?.({ id: userId });

		this.sessions.set(server, { id: userId });

		return new Response(null, {
			status: 101,
			webSocket: client,
		});
	}

	findById(id: string): WebSocket | undefined {
		for (const [k, v] of this.sessions.entries()) {
			if (v.id === id) return k;
		}
	}
}
