import { timestamp as drizzle_pg_timestamp } from "drizzle-orm/pg-core";

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
