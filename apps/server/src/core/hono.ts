import { Hono } from "hono";
import type { AuthInstance } from "./services/auth";
import type { DatabaseInstance } from "./services/db";
import type { KeyValueService } from "./services/kv";

export type HonoContext<ExtendVars extends Record<string, unknown>> = {
	Variables: {
		db: DatabaseInstance;
		auth: AuthInstance;
		kv: KeyValueService;
	} & ExtendVars;
	Bindings: Env;
};

export const createHono = <Vars extends Record<string, unknown>>() =>
	new Hono<HonoContext<Vars>>();
