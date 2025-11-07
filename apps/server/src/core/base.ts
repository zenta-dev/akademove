import { DurableObject } from "cloudflare:workers";
import type { UnifiedPaginationQuery } from "@repo/schema/pagination";
import { log, type PromiseFn, safeSync } from "@/utils";
import { RepositoryError } from "./error";
import type { PartialWithTx } from "./interface";
import type { KeyValueService, PutCacheOptions } from "./services/kv";

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
			ws.send(encoded);
		}
	}
}

export abstract class BaseRepository {
	readonly #entity: string;
	readonly #kv: KeyValueService;

	constructor(entity: string, kv: KeyValueService) {
		this.#entity = entity;
		this.#kv = kv;
	}

	#composeCacheKey(key: string): string {
		return `${this.#entity.toLowerCase()}:${key}`;
	}

	protected async getCache<T>(
		key: string,
		options?: { fallback?: PromiseFn<T> },
	): Promise<T> {
		return await this.#kv.get(this.#composeCacheKey(key), options);
	}

	protected async setCache<T>(
		key: string,
		data: T,
		opts?: PutCacheOptions,
	): Promise<void> {
		try {
			await this.#kv.put(this.#composeCacheKey(key), data, opts);
		} catch {}
	}

	protected async deleteCache(key: string): Promise<void> {
		try {
			await this.#kv.delete(this.#composeCacheKey(key));
		} catch {}
	}

	protected handleError(error: unknown, action: string) {
		log.debug(
			{ detail: error },
			`[${this.constructor.name}] - ${action} failed`,
		);
		if (error instanceof RepositoryError) return error;
		return new RepositoryError(
			`Failed to ${action} ${this.#entity.toLowerCase()}`,
		);
	}

	async list(
		_query?: UnifiedPaginationQuery,
		_opts?: PartialWithTx,
		..._args: unknown[]
	): Promise<unknown> {
		throw new RepositoryError("Unimplemented");
	}

	async get(
		_id: string,
		_opts?: PartialWithTx,
		..._args: unknown[]
	): Promise<unknown> {
		throw new RepositoryError("Unimplemented");
	}

	async create(
		_item: unknown,
		_opts?: PartialWithTx,
		..._args: unknown[]
	): Promise<unknown> {
		throw new RepositoryError("Unimplemented");
	}

	async update(
		_id: string,
		_item: unknown,
		_opts?: PartialWithTx,
		..._args: unknown[]
	): Promise<unknown> {
		throw new RepositoryError("Unimplemented");
	}

	async delete(
		_id: string,
		_opts?: PartialWithTx,
		..._args: unknown[]
	): Promise<unknown> {
		throw new RepositoryError("Unimplemented");
	}
}
