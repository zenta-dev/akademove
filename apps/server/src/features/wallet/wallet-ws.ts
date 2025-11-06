import type { WSTopUpEnvelope } from "@repo/schema/websocket";
import { BaseDurableObject } from "@/core/base";
import { safeSync } from "@/utils";

export class WalletRoom extends BaseDurableObject {
	async fetch(request: Request): Promise<Response> {
		return super.fetch(request);
	}

	async webSocketMessage(ws: WebSocket, message: ArrayBuffer | string) {
		console.log("Received message from", this.sessions.get(ws)?.id, message);
	}

	broadcast(message: WSTopUpEnvelope) {
		const payload = JSON.stringify(message);
		for (const ws of this.sessions.keys()) {
			try {
				ws.send(payload);
			} catch {
				this.sessions.delete(ws);
			}
		}
	}

	async webSocketClose(
		ws: WebSocket,
		code: number,
		_reason: string,
		_wasClean: boolean,
	) {
		this.sessions.delete(ws);
		safeSync(() => ws.close(code, "Durable Object is closing WebSocket"));
	}
}
