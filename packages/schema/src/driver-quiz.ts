import { v7 } from "uuid";
import { z } from "zod";

// Quiz Statuses: Initial implementation based on SRS requirements
export const DRIVER_QUIZ_STATUSES = [
	"NOT_STARTED",
	"STARTED",
	"PASSED",
	"FAILED",
] as const;
export type DriverQuizStatus = (typeof DRIVER_QUIZ_STATUSES)[number];

// Question difficulty levels
export const QUIZ_DIFFICULTY_LEVELS = ["EASY", "MEDIUM", "HARD"] as const;
export type QuizDifficultyLevel = (typeof QUIZ_DIFFICULTY_LEVELS)[number];

// Question type for multiple-choice format
export const QuestionSchema = z.object({
	id: z
		.string()
		.uuid()
		.default(() => v7()),
	content: z
		.string()
		.min(10, { message: "Question must be at least 10 characters" })
		.max(500, { message: "Question must be at most 500 characters" }),
	difficulty: z.enum(QUIZ_DIFFICULTY_LEVELS),
	points: z
		.number()
		.min(1, { message: "Points must be at least 1" })
		.max(5, { message: "Points must be at most 5" })
		.default(1),
	options: z
		.array(
			z.object({
				id: z
					.string()
					.uuid()
					.default(() => v7()),
				text: z
					.string()
					.min(1, { message: "Option text must not be empty" })
					.max(200, { message: "Option text must be at most 200 characters" }),
				isCorrect: z.boolean(),
			}),
		)
		.min(2, { message: "At least 2 options required" })
		.max(5, { message: "At most 5 options allowed" }),
});
export type Question = z.infer<typeof QuestionSchema>;

// Quiz attempt tracking
export const QuizAttemptSchema = z.object({
	id: z
		.string()
		.uuid()
		.default(() => v7()),
	driverId: z.string().uuid(),
	status: z.enum(DRIVER_QUIZ_STATUSES).default("NOT_STARTED"),
	totalQuestions: z
		.number()
		.min(1, { message: "At least 1 question required" }),
	correctAnswers: z
		.number()
		.min(0, { message: "Correct answers cannot be negative" })
		.default(0),
	score: z
		.number()
		.min(0, { message: "Score cannot be negative" })
		.max(100, { message: "Score cannot exceed 100" })
		.default(0),
	passThreshold: z
		.number()
		.min(0, { message: "Pass threshold cannot be negative" })
		.max(100, { message: "Pass threshold cannot exceed 100" })
		.default(70), // 70% pass rate
	startedAt: z.date().optional(),
	completedAt: z.date().optional(),
	questions: z.array(QuestionSchema),
	selectedAnswers: z.record(z.string().uuid(), z.string().uuid()).optional(),
});
export type QuizAttempt = z.infer<typeof QuizAttemptSchema>;

// Quiz configuration
export const QuizConfigSchema = z.object({
	maxAttempts: z
		.number()
		.min(1, { message: "At least 1 attempt allowed" })
		.max(3, { message: "Maximum 3 attempts allowed" })
		.default(3),
	questionCount: z
		.number()
		.min(5, { message: "At least 5 questions required" })
		.max(20, { message: "Maximum 20 questions allowed" })
		.default(10),
	timeLimit: z
		.number()
		.min(300, { message: "Minimum time limit is 5 minutes" })
		.max(1800, { message: "Maximum time limit is 30 minutes" })
		.default(900), // 15 minutes
	difficultyDistribution: z.object({
		EASY: z
			.number()
			.min(0, { message: "Difficulty distribution must be between 0 and 1" })
			.max(1, { message: "Difficulty distribution must be between 0 and 1" })
			.default(0.5),
		MEDIUM: z
			.number()
			.min(0, { message: "Difficulty distribution must be between 0 and 1" })
			.max(1, { message: "Difficulty distribution must be between 0 and 1" })
			.default(0.3),
		HARD: z
			.number()
			.min(0, { message: "Difficulty distribution must be between 0 and 1" })
			.max(1, { message: "Difficulty distribution must be between 0 and 1" })
			.default(0.2),
	}),
});
export type QuizConfig = z.infer<typeof QuizConfigSchema>;

// Validation helpers
export function calculateQuizScore(attempt: QuizAttempt): number {
	if (attempt.totalQuestions === 0) return 0;
	return Math.round((attempt.correctAnswers / attempt.totalQuestions) * 100);
}

export function isQuizPassed(attempt: QuizAttempt): boolean {
	return calculateQuizScore(attempt) >= attempt.passThreshold;
}
