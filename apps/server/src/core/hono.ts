import type { UserRole } from "@repo/schema/user";
import { type Env, Hono } from "hono";
import type { DatabaseService } from "./services/db";
import type { KeyValueService } from "./services/kv";
import type { MailService } from "./services/mail";
import type { RBACService } from "./services/rbac";
import type { StorageService } from "./services/storage";

export type HonoContext = {
	Variables: {
		db: DatabaseService;
		kv: KeyValueService;
		mail: MailService;
		storage: StorageService;
		rbac: RBACService;
		user: {
			id: string;
			role: UserRole;
			banned: boolean;
		};
	};
	Bindings: Env;
};

export const createHono = () => new Hono<HonoContext>();
