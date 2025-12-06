import {
	DRIVER_QUIZ_QUESTION_CATEGORIES,
	DRIVER_QUIZ_QUESTION_TYPES,
} from "@repo/schema/constants";
import type { DriverQuizQuestionOption } from "@repo/schema/driver-quiz-question";
import { boolean, integer, jsonb, text, uuid } from "drizzle-orm/pg-core";
import { DateModifier, index, pgEnum, pgTable } from "./common";

export const driverQuizQuestionType = pgEnum(
	"driver_quiz_question_type",
	DRIVER_QUIZ_QUESTION_TYPES,
);

export const driverQuizQuestionCategory = pgEnum(
	"driver_quiz_question_category",
	DRIVER_QUIZ_QUESTION_CATEGORIES,
);

export const driverQuizQuestion = pgTable(
	"driver_quiz_questions",
	{
		id: uuid().primaryKey(),
		question: text().notNull(),
		type: driverQuizQuestionType().notNull(),
		category: driverQuizQuestionCategory().notNull(),
		options: jsonb().$type<DriverQuizQuestionOption[]>().notNull(),
		explanation: text(),
		points: integer().notNull().default(10),
		isActive: boolean("is_active").notNull().default(true),
		displayOrder: integer("display_order").notNull().default(0),
		...DateModifier,
	},
	(t) => [
		index("driver_quiz_question_type_idx").on(t.type),
		index("driver_quiz_question_category_idx").on(t.category),
		index("driver_quiz_question_is_active_idx").on(t.isActive),
		index("driver_quiz_question_display_order_idx").on(t.displayOrder),
		index("driver_quiz_question_category_active_idx").on(
			t.category,
			t.isActive,
		),
	],
);

export type DriverQuizQuestionDatabase = typeof driverQuizQuestion.$inferSelect;
