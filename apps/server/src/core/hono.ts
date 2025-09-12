import { Hono } from "hono";
import type { DriverRepository } from "@/features/driver/repository";
import type { AuthInstance } from "./services/auth";
import type { DatabaseInstance } from "./services/db";
import type { KeyValueService } from "./services/kv";

export type HonoContext = {
	Variables: {
		db: DatabaseInstance;
		auth: AuthInstance;
		kv: KeyValueService;
		repo: {
			driver: DriverRepository;
		};
	};
	Bindings: Env;
};

export const createHono = () => new Hono<HonoContext>();
