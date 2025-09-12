import { Hono } from "hono";
import type { AuthInstance } from "./services/auth";
import type { DatabaseInstance } from "./services/db";

export type HonoContext = {
	Variables: {
		db: DatabaseInstance;
		auth: AuthInstance;
	};
	Bindings: Env;
};

export const createHono = () => new Hono<HonoContext>();
