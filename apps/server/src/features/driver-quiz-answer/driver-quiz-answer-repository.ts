import type {
	DriverQuizAnswer,
	DriverQuizQuestionAnswer,
	DriverQuizResult,
	ListDriverQuizAnswerQuery,
	StartDriverQuiz,
} from "@repo/schema/driver-quiz-answer";
import { eq, type SQL } from "drizzle-orm";
import { v7 } from "uuid";
import { BaseRepository } from "@/core/base";
import { CACHE_TTLS } from "@/core/constants";
import { RepositoryError } from "@/core/error";
import type { ListResult, PartialWithTx, WithTx } from "@/core/interface";
import { type DatabaseService, tables } from "@/core/services/db";
import type { KeyValueService } from "@/core/services/kv";
import type { DriverQuizAnswerDatabase } from "@/core/tables/driver-quiz-answer";
import { log } from "@/utils";
import type { DriverQuizQuestionRepository } from "../driver-quiz-question/driver-quiz-question-repository";

const PASSING_SCORE_PERCENTAGE = 70;

export class DriverQuizAnswerRepository extends BaseRepository {
	constructor(
		db: DatabaseService,
		kv: KeyValueService,
		private readonly questionRepo: DriverQuizQuestionRepository,
	) {
		super("driverQuizAnswer", kv, db);
	}

	static composeEntity(item: DriverQuizAnswerDatabase): DriverQuizAnswer {
		return {
			...item,
			scorePercentage: Number(item.scorePercentage),
			completedAt: item.completedAt ?? null,
			answers: item.answers ?? [],
		};
	}

	async #getFromDB(
		id: string,
		opts?: PartialWithTx,
	): Promise<DriverQuizAnswer | undefined> {
		const tx = opts?.tx ?? this.db;
		const result = await tx.query.driverQuizAnswer.findFirst({
			where: (f, op) => op.eq(f.id, id),
		});
		return result
			? DriverQuizAnswerRepository.composeEntity(result)
			: undefined;
	}

	async get(id: string, opts?: PartialWithTx): Promise<DriverQuizAnswer> {
		try {
			const fallback = async () => {
				const res = await this.#getFromDB(id, opts);

				if (!res) {
					throw new RepositoryError("Driver quiz attempt not found", {
						code: "NOT_FOUND",
					});
				}

				await this.setCache(id, res, { expirationTtl: CACHE_TTLS["1h"] });

				return res;
			};

			return await this.getCache(id, { fallback });
		} catch (error) {
			log.error(
				{ error, id },
				"[DriverQuizAnswerRepository] Failed to get attempt",
			);
			throw this.handleError(error, "get");
		}
	}

	async listAttempts(
		query: ListDriverQuizAnswerQuery,
		opts?: PartialWithTx,
	): Promise<ListResult<DriverQuizAnswer>> {
		try {
			const { driverId, status, page = 1, limit = 20 } = query;
			const tx = opts?.tx ?? this.db;

			const conditions: SQL[] = [];
			if (driverId) {
				conditions.push(eq(tables.driverQuizAnswer.driverId, driverId));
			}
			if (status) {
				conditions.push(eq(tables.driverQuizAnswer.status, status));
			}

			const offset = (page - 1) * limit;

			const res = await tx.query.driverQuizAnswer.findMany({
				where: (_, op) =>
					conditions.length > 0 ? op.and(...conditions) : undefined,
				orderBy: (f, op) => [op.desc(f.createdAt)],
				offset,
				limit,
			});

			const rows = res.map(DriverQuizAnswerRepository.composeEntity);
			const totalCount = await this.getTotalRow(opts);
			const totalPages = Math.ceil(totalCount / limit);

			return { rows, totalPages };
		} catch (error) {
			log.error(
				{ error, query },
				"[DriverQuizAnswerRepository] Failed to list attempts",
			);
			throw this.handleError(error, "list");
		}
	}

	async getLatestByDriverId(
		driverId: string,
		opts?: PartialWithTx,
	): Promise<DriverQuizAnswer | null> {
		try {
			const tx = opts?.tx ?? this.db;
			const result = await tx.query.driverQuizAnswer.findFirst({
				where: (f, op) => op.eq(f.driverId, driverId),
				orderBy: (f, op) => [op.desc(f.createdAt)],
			});

			return result ? DriverQuizAnswerRepository.composeEntity(result) : null;
		} catch (error) {
			log.error(
				{ error, driverId },
				"[DriverQuizAnswerRepository] Failed to get latest attempt",
			);
			throw this.handleError(error, "getLatestByDriverId");
		}
	}

	async startQuiz(
		driverId: string,
		data: StartDriverQuiz,
		opts: WithTx,
	): Promise<{
		attemptId: string;
		questions: Array<{
			id: string;
			question: string;
			type: string;
			category: string;
			points: number;
			displayOrder: number;
			options: Array<{ id: string; text: string }>;
		}>;
		totalQuestions: number;
		totalPoints: number;
		passingScore: number;
	}> {
		try {
			// Get questions for the quiz
			const questions = await this.questionRepo.getQuizQuestions(
				{
					category: data.category,
					limit: data.questionIds?.length ?? 20,
				},
				opts,
			);

			if (questions.length === 0) {
				throw new RepositoryError("No quiz questions available", {
					code: "BAD_REQUEST",
				});
			}

			// Calculate total points
			const totalPoints = questions.reduce(
				(sum: number, q: { points: number }) => sum + q.points,
				0,
			);

			const now = new Date();
			const id = v7();

			await opts.tx.insert(tables.driverQuizAnswer).values({
				id,
				driverId,
				status: "IN_PROGRESS",
				totalQuestions: questions.length,
				correctAnswers: 0,
				totalPoints,
				earnedPoints: 0,
				passingScore: PASSING_SCORE_PERCENTAGE,
				scorePercentage: 0,
				answers: [],
				startedAt: now,
				completedAt: null,
				createdAt: now,
				updatedAt: now,
			});

			log.info(
				{ attemptId: id, driverId, questionCount: questions.length },
				"[DriverQuizAnswerRepository] Quiz started",
			);

			return {
				attemptId: id,
				questions,
				totalQuestions: questions.length,
				totalPoints,
				passingScore: PASSING_SCORE_PERCENTAGE,
			};
		} catch (error) {
			log.error(
				{ error, driverId },
				"[DriverQuizAnswerRepository] Failed to start quiz",
			);
			throw this.handleError(error, "startQuiz");
		}
	}

	async submitAnswer(
		attemptId: string,
		questionId: string,
		selectedOptionId: string,
		opts: WithTx,
	): Promise<{
		isCorrect: boolean;
		pointsEarned: number;
		correctOptionId?: string;
		explanation: string | null;
	}> {
		try {
			// Get the attempt
			const attempt = await this.get(attemptId, opts);

			if (attempt.status !== "IN_PROGRESS") {
				throw new RepositoryError("Quiz attempt is not in progress", {
					code: "BAD_REQUEST",
				});
			}

			// Check if question was already answered
			const alreadyAnswered = attempt.answers.some(
				(a: DriverQuizQuestionAnswer) => a.questionId === questionId,
			);
			if (alreadyAnswered) {
				throw new RepositoryError("Question already answered", {
					code: "BAD_REQUEST",
				});
			}

			// Get the question with correct answer
			const question = await this.questionRepo.get(questionId, opts);

			// Find the correct option and check if selected is correct
			const correctOption = question.options.find(
				(o: { isCorrect: boolean }) => o.isCorrect,
			);
			const isCorrect = correctOption?.id === selectedOptionId;
			const pointsEarned = isCorrect ? question.points : 0;

			// Create the answer record
			const answer: DriverQuizQuestionAnswer = {
				questionId,
				selectedOptionId,
				isCorrect,
				pointsEarned,
				answeredAt: new Date(),
			};

			// Update the attempt with new answer
			const updatedAnswers = [...attempt.answers, answer];
			const newCorrectAnswers = updatedAnswers.filter(
				(a: DriverQuizQuestionAnswer) => a.isCorrect,
			).length;
			const newEarnedPoints = updatedAnswers.reduce(
				(sum: number, a: DriverQuizQuestionAnswer) => sum + a.pointsEarned,
				0,
			);

			await opts.tx
				.update(tables.driverQuizAnswer)
				.set({
					answers: updatedAnswers,
					correctAnswers: newCorrectAnswers,
					earnedPoints: newEarnedPoints,
					updatedAt: new Date(),
				})
				.where(eq(tables.driverQuizAnswer.id, attemptId));

			await this.deleteCache(attemptId);

			log.info(
				{ attemptId, questionId, isCorrect, pointsEarned },
				"[DriverQuizAnswerRepository] Answer submitted",
			);

			return {
				isCorrect,
				pointsEarned,
				correctOptionId: correctOption?.id,
				explanation: question.explanation,
			};
		} catch (error) {
			log.error(
				{ error, attemptId, questionId },
				"[DriverQuizAnswerRepository] Failed to submit answer",
			);
			throw this.handleError(error, "submitAnswer");
		}
	}

	async completeQuiz(
		attemptId: string,
		opts: WithTx,
	): Promise<DriverQuizResult> {
		try {
			const attempt = await this.get(attemptId, opts);

			if (attempt.status !== "IN_PROGRESS") {
				throw new RepositoryError("Quiz attempt is not in progress", {
					code: "BAD_REQUEST",
				});
			}

			// Calculate score percentage
			const scorePercentage =
				attempt.totalPoints > 0
					? Math.round((attempt.earnedPoints / attempt.totalPoints) * 100)
					: 0;

			const passed = scorePercentage >= attempt.passingScore;
			const status = passed ? "PASSED" : "FAILED";
			const now = new Date();

			await opts.tx
				.update(tables.driverQuizAnswer)
				.set({
					status,
					scorePercentage,
					completedAt: now,
					updatedAt: now,
				})
				.where(eq(tables.driverQuizAnswer.id, attemptId));

			await this.deleteCache(attemptId);

			log.info(
				{ attemptId, status, scorePercentage, passed },
				"[DriverQuizAnswerRepository] Quiz completed",
			);

			return {
				attemptId,
				status,
				totalQuestions: attempt.totalQuestions,
				correctAnswers: attempt.correctAnswers,
				scorePercentage,
				passed,
				earnedPoints: attempt.earnedPoints,
				totalPoints: attempt.totalPoints,
				completedAt: now,
			};
		} catch (error) {
			log.error(
				{ error, attemptId },
				"[DriverQuizAnswerRepository] Failed to complete quiz",
			);
			throw this.handleError(error, "completeQuiz");
		}
	}

	async getResult(
		attemptId: string,
		opts?: PartialWithTx,
	): Promise<DriverQuizResult> {
		try {
			const attempt = await this.get(attemptId, opts);

			if (attempt.status === "IN_PROGRESS") {
				throw new RepositoryError("Quiz is still in progress", {
					code: "BAD_REQUEST",
				});
			}

			return {
				attemptId,
				status: attempt.status,
				totalQuestions: attempt.totalQuestions,
				correctAnswers: attempt.correctAnswers,
				scorePercentage: attempt.scorePercentage,
				passed: attempt.status === "PASSED",
				earnedPoints: attempt.earnedPoints,
				totalPoints: attempt.totalPoints,
				completedAt: attempt.completedAt,
			};
		} catch (error) {
			log.error(
				{ error, attemptId },
				"[DriverQuizAnswerRepository] Failed to get result",
			);
			throw this.handleError(error, "getResult");
		}
	}
}
