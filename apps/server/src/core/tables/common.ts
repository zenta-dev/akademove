import {
	timestamp as drizzle_pg_timestamp,
	index as indexCreator,
	jsonb,
	pgEnum as pgEnumCreator,
	pgTableCreator,
	serial,
	text,
	uniqueIndex as uniqueIndexCreator,
} from "drizzle-orm/pg-core";

type TimetampParams = Parameters<typeof drizzle_pg_timestamp>;
export const timestamp = (
	name: TimetampParams[0],
	opts?: TimetampParams["1"],
) => drizzle_pg_timestamp(name, { mode: "date", ...opts });

export const nowFn = () => /* @__PURE__ */ new Date();

export const DateModifier = {
	createdAt: timestamp("created_at").notNull().$defaultFn(nowFn),
	updatedAt: timestamp("updated_at")
		.notNull()
		.$defaultFn(nowFn)
		.$onUpdateFn(nowFn),
};

export const pgTable = pgTableCreator((name) => `am_${name}`);
export const pgEnum = <
	U extends string,
	TName extends U,
	TVal extends Readonly<[U, ...U[]]>,
>(
	name: TName,
	val: TVal,
) => pgEnumCreator(`am_${name}`, val);
export const uniqueIndex = (name?: string) =>
	uniqueIndexCreator(name ? `am_${name}` : undefined);
export const index = (name?: string) =>
	indexCreator(name ? `am_${name}` : undefined);

export const allowedLoggedTables = pgEnum("allowed_logged_table", [
	"account_deletion",
	"configurations",
	"contact",
	"coupon",
	"driver_approval_review",
	"merchant_approval_review",
	"newsletter",
	"report",
	"user",
	"wallet",
]);

export type AllowedLoggedTable =
	(typeof allowedLoggedTables.enumValues)[number];

export const operationEnum = pgEnum("operation", [
	"INSERT",
	"UPDATE",
	"DELETE",
]);

export const createAuditLogTable = (tableName: AllowedLoggedTable) =>
	pgTable(
		`__${tableName}_audit_log`,
		{
			id: serial("id").primaryKey(),
			tableName: allowedLoggedTables("table_name").notNull(),
			recordId: text("record_id").notNull(),
			operation: operationEnum("operation").notNull(),
			oldData: jsonb("old_data"),
			newData: jsonb("new_data"),
			updatedById: text("updated_by_id"),
			ipAddress: text("ip_address"),
			userAgent: text("user_agent"),
			sessionId: text("session_id"),
			reason: text("reason"),
			updatedAt: timestamp("updated_at").$defaultFn(nowFn).notNull(),
		},
		(t) => [
			index(`${tableName}_audit_record_idx`).on(t.recordId),
			index(`${tableName}_audit_updated_at_idx`).on(t.updatedAt),
			index(`${tableName}_audit_updated_by_idx`).on(t.updatedById),
			index(`${tableName}_audit_ip_address_idx`).on(t.ipAddress),
		],
	);
export type AuditLogDatabase = ReturnType<typeof createAuditLogTable>;
