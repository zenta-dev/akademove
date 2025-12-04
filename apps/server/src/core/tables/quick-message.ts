import { boolean, integer, text, uuid } from "drizzle-orm/pg-core";
import { DateModifier, index, pgTable } from "./common";

export const quickMessageTemplate = pgTable(
	"quick_message_templates",
	{
		id: uuid().primaryKey(),
		role: text().notNull(), // DRIVER, USER, MERCHANT
		message: text().notNull(),
		orderType: text("order_type"), // RIDE, DELIVERY, FOOD (optional filter)
		locale: text().notNull().default("en"), // i18n support
		isActive: boolean("is_active").notNull().default(true),
		displayOrder: integer("display_order").notNull().default(0),
		...DateModifier,
	},
	(t) => [
		// Index for filtering by role and order type
		index("quick_message_role_idx").on(t.role),
		index("quick_message_order_type_idx").on(t.orderType),
		index("quick_message_locale_idx").on(t.locale),

		// Composite index for efficient queries by role + orderType + locale + active
		index("quick_message_filter_idx").on(
			t.role,
			t.orderType,
			t.locale,
			t.isActive,
		),

		// Index for sorting by display order
		index("quick_message_display_order_idx").on(t.displayOrder),
	],
);

export type QuickMessageTemplateDatabase =
	typeof quickMessageTemplate.$inferSelect;
