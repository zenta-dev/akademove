import { CONSTANTS } from "@repo/schema/constants";
import { relations } from "drizzle-orm";
import { pgEnum, pgTable, text, timestamp, uuid } from "drizzle-orm/pg-core";
import { user } from "./auth";
import { order } from "./order";

export const reportCategory = pgEnum(
	"report_category",
	CONSTANTS.REPORT_CATEGORIES,
);

export const reportStatus = pgEnum("report_status", CONSTANTS.REPORT_STATUS);

export const report = pgTable("reports", {
	id: uuid().primaryKey().defaultRandom(),
	orderId: uuid("order_id").references(() => order.id, {
		onDelete: "set null",
	}),
	reporterId: text("reporter_id")
		.notNull()
		.references(() => user.id, {
			onDelete: "no action",
		}),
	targetUserId: text("target_user_id")
		.notNull()
		.references(() => user.id, {
			onDelete: "no action",
		}),
	category: reportCategory().notNull().default("other"),
	description: text().notNull(),
	evidenceUrl: text("evidence_url"),
	status: reportStatus().notNull().default("pending"),
	handledById: text("handled_by_id").references(() => user.id, {
		onDelete: "set null",
	}),
	resolution: text(),
	reportedAt: timestamp("reported_at").notNull().defaultNow(),
	resolvedAt: timestamp("resolved_at"),
});

///
/// --- Relations --- ///
///
export const reportRelations = relations(report, ({ one }) => ({
	order: one(order, {
		fields: [report.orderId],
		references: [order.id],
	}),
	reporter: one(user, {
		fields: [report.reporterId],
		references: [user.id],
	}),
	targetUser: one(user, {
		fields: [report.targetUserId],
		references: [user.id],
	}),
	handledBy: one(user, {
		fields: [report.handledById],
		references: [user.id],
	}),
}));

export type ReportDatabase = typeof report.$inferSelect;
