import { CONSTANTS } from "@repo/schema/constants";
import { relations } from "drizzle-orm";
import { index, pgEnum, pgTable, text, uuid } from "drizzle-orm/pg-core";
import { user } from "./auth";
import { nowFn, timestamp } from "./common";
import { order } from "./order";

export const reportCategory = pgEnum(
	"report_category",
	CONSTANTS.REPORT_CATEGORIES,
);

export const reportStatus = pgEnum("report_status", CONSTANTS.REPORT_STATUS);

export const report = pgTable(
	"reports",
	{
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
		reportedAt: timestamp("reported_at").notNull().$defaultFn(nowFn),
		resolvedAt: timestamp("resolved_at"),
	},
	(t) => [
		index("report_order_id_idx").on(t.orderId),
		index("report_reporter_id_idx").on(t.reporterId),
		index("report_target_user_id_idx").on(t.targetUserId),
		index("report_handled_by_id_idx").on(t.handledById),
		index("report_category_idx").on(t.category),
		index("report_status_idx").on(t.status),
		index("report_status_category_idx").on(t.status, t.category),
		index("report_target_status_idx").on(t.targetUserId, t.status),
		index("report_reporter_status_idx").on(t.reporterId, t.status),
		index("report_reported_at_idx").on(t.reportedAt),
		index("report_resolved_at_idx").on(t.resolvedAt),
		index("report_status_reported_at_idx").on(t.status, t.reportedAt),
	],
);

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
