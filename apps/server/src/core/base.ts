import { DurableObject } from "cloudflare:workers";
import type { UnifiedPaginationQuery } from "@repo/schema/pagination";
import { count } from "drizzle-orm";
import type { PgColumn } from "drizzle-orm/pg-core";
import { log, type PromiseFn, safeSync } from "@/utils";
import { CACHE_TTLS } from "./constants";
import { RepositoryError } from "./error";
import type { CountCache, PartialWithTx } from "./interface";
import { type DatabaseName, type DatabaseService, tables } from "./services/db";
import type { KeyValueService, PutCacheOptions } from "./services/kv";

type UserId = string;
export class BaseDurableObject extends DurableObject {
	protected sessions: Map<UserId, WebSocket>; // key = userId

	constructor(ctx: DurableObjectState, env: Env) {
		super(ctx, env);
		this.sessions = new Map();

		ctx.getWebSockets().forEach((ws) => {
			const attachment = ws.deserializeAttachment?.();
			if (attachment?.id) {
				this.sessions.set(attachment.id, ws);
			}
		});

		ctx.setWebSocketAutoResponse?.(
			new WebSocketRequestResponsePair("ping", "pong"),
		);
	}

	async fetch(request: Request): Promise<Response> {
		const url = new URL(request.url);
		const userId = url.searchParams.get("userId");
		if (!userId) return new Response("User ID is required", { status: 401 });

		const pair = new WebSocketPair();
		const [client, server] = Object.values(pair);

		this.ctx.acceptWebSocket(server);
		server.serializeAttachment?.({ id: userId });

		this.sessions.set(userId, server);

		return new Response(null, {
			status: 101,
			webSocket: client,
		});
	}

	async webSocketMessage(ws: WebSocket, message: ArrayBuffer | string) {
		const userId = this.findUserIdBySocket(ws);
		log.debug(
			{ message, json: JSON.parse(message.toString()) },
			`[${this.className}] | Received message from ${userId}`,
		);
	}

	async webSocketClose(
		ws: WebSocket,
		code: number,
		reason: string,
		wasClean: boolean,
	) {
		const userId = this.findUserIdBySocket(ws);
		if (userId) this.sessions.delete(userId);

		log.debug(
			{ code, reason, wasClean },
			`[${this.className}] | Someone with id -> ${userId} left room`,
		);

		safeSync(() => ws.close(code, "Durable Object is closing WebSocket"));
	}

	protected get className(): string {
		return this.constructor.name;
	}

	protected findUserIdBySocket(ws: WebSocket): string | undefined {
		for (const [id, socket] of this.sessions.entries()) {
			if (socket === ws) return id;
		}
	}

	protected findById(id: string): WebSocket | undefined {
		return this.sessions.get(id);
	}

	protected findByIds(ids: string[]): WebSocket[] {
		return ids
			.map((id) => this.sessions.get(id))
			.filter((ws): ws is WebSocket => !!ws);
	}

	protected excludeSession(ws: WebSocket): Map<string, WebSocket> {
		const filtered = new Map(this.sessions);
		const userId = this.findUserIdBySocket(ws);
		if (userId) filtered.delete(userId);
		return filtered;
	}

	protected broadcast(object: unknown, opts?: { excludes?: WebSocket[] }) {
		const encoded = JSON.stringify(object);
		if (this.sessions.size === 0) return;

		const excludeSet = opts?.excludes?.length ? new Set(opts.excludes) : null;

		for (const ws of this.sessions.values()) {
			if (excludeSet?.has(ws)) continue;
			if (ws.readyState === ws.OPEN) ws.send(encoded);
		}
	}
}

export abstract class BaseRepository {
	readonly #entity: string;
	readonly #tableName: DatabaseName;
	readonly #kv: KeyValueService;
	protected readonly db: DatabaseService;

	constructor(
		entity: string,
		table: DatabaseName,
		kv: KeyValueService,
		database: DatabaseService,
	) {
		this.#entity = entity;
		this.#tableName = table;
		this.#kv = kv;
		this.db = database;
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

	async #setTotalRowCache(total: number): Promise<void> {
		try {
			await this.setCache<CountCache>(
				`${this.#entity}-${this.#tableName}:count`,
				{ total },
				{ expirationTtl: CACHE_TTLS["24h"] },
			);
		} catch (error) {
			log.error({ error }, "Failed to set total row cache");
		}
	}

	protected async getTotalRow(): Promise<number> {
		try {
			let tableToCount: PgColumn | undefined;

			const table = tables[this.#tableName];

			if ("id" in table) {
				tableToCount = table.id;
			} else if ("key" in table) {
				tableToCount = table.key;
			}

			const fallback = async () => {
				const [dbResult] = await this.db
					.select({
						count: count(tableToCount),
					})
					.from(table);
				const total = dbResult.count;
				await this.#setTotalRowCache(total);
				return { total };
			};
			const res = await this.getCache<CountCache>(
				`${this.#entity}-${this.#tableName}:count`,
				{ fallback },
			);

			return res.total;
		} catch (error) {
			log.error({ error }, "Failed to get total row count");
			return 0;
		}
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
