import { DRIVER_QUIZ_ANSWER_STATUSES } from "@repo/schema/constants";
import type { DriverQuizQuestionAnswer } from "@repo/schema/driver-quiz-answer";
import { integer, jsonb, text, uuid } from "drizzle-orm/pg-core";
import { DateModifier, index, pgEnum, pgTable, timestamp } from "./common";

export const driverQuizAnswerStatus = pgEnum(
	"driver_quiz_answer_status",
	DRIVER_QUIZ_ANSWER_STATUSES,
);

export const driverQuizAnswer = pgTable(
	"driver_quiz_answers",
	{
		id: uuid().primaryKey(),
		driverId: text("driver_id").notNull(),
		status: driverQuizAnswerStatus().notNull().default("IN_PROGRESS"),
		totalQuestions: integer("total_questions").notNull(),
		correctAnswers: integer("correct_answers").notNull().default(0),
		totalPoints: integer("total_points").notNull().default(0),
		earnedPoints: integer("earned_points").notNull().default(0),
		passingScore: integer("passing_score").notNull().default(70),
		scorePercentage: integer("score_percentage").notNull().default(0),
		answers: jsonb().$type<DriverQuizQuestionAnswer[]>().notNull().default([]),
		startedAt: timestamp("started_at").notNull(),
		completedAt: timestamp("completed_at"),
		...DateModifier,
	},
	(t) => [
		index("driver_quiz_answer_driver_id_idx").on(t.driverId),
		index("driver_quiz_answer_status_idx").on(t.status),
		index("driver_quiz_answer_started_at_idx").on(t.startedAt),
		index("driver_quiz_answer_completed_at_idx").on(t.completedAt),
		index("driver_quiz_answer_driver_status_idx").on(t.driverId, t.status),
		index("driver_quiz_answer_score_idx").on(t.scorePercentage),
	],
);

export type DriverQuizAnswerDatabase = typeof driverQuizAnswer.$inferSelect;
