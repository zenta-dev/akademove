import { requireRoles } from "@/core/middlewares/auth";
import { createORPCRouter } from "@/core/router/orpc";
import { DriverQuizAnswerSpec } from "./driver-quiz-answer-spec";

const { priv } = createORPCRouter(DriverQuizAnswerSpec);

const _adminMiddleware = requireRoles("ADMIN", "OPERATOR");
const driverMiddleware = requireRoles("DRIVER");

export const DriverQuizAnswerHandler = priv.router({
	// Start a new quiz attempt (driver only)
	startQuiz: priv.startQuiz
		.use(driverMiddleware)
		.handler(async ({ context, input: { body } }) => {
			// Get driver ID from user context
			const driver = await context.repo.driver.main.getByUserId(
				context.user.id,
			);

			const result = await context.svc.db.transaction(async (tx) => {
				return await context.repo.driverQuizAnswer.startQuiz(driver.id, body, {
					tx,
				});
			});

			return {
				status: 201,
				body: {
					message: "Quiz started successfully",
					data: result,
				},
			};
		}),

	// Submit an answer to a question (driver only)
	submitAnswer: priv.submitAnswer
		.use(driverMiddleware)
		.handler(async ({ context, input: { body } }) => {
			const result = await context.svc.db.transaction(async (tx) => {
				return await context.repo.driverQuizAnswer.submitAnswer(
					body.attemptId,
					body.questionId,
					body.selectedOptionId,
					{ tx },
				);
			});

			return {
				status: 200,
				body: {
					message: "Answer submitted successfully",
					data: result,
				},
			};
		}),

	// Complete a quiz attempt (driver only)
	completeQuiz: priv.completeQuiz
		.use(driverMiddleware)
		.handler(async ({ context, input: { body } }) => {
			const result = await context.svc.db.transaction(async (tx) => {
				const quizResult = await context.repo.driverQuizAnswer.completeQuiz(
					body.attemptId,
					{ tx },
				);

				// Update driver's quiz status based on result
				const driver = await context.repo.driver.main.getByUserId(
					context.user.id,
				);
				await context.repo.driver.main.updateQuizStatus(
					driver.id,
					{
						quizStatus: quizResult.passed ? "PASSED" : "FAILED",
						quizAttemptId: body.attemptId,
						quizScore: quizResult.scorePercentage,
						quizCompletedAt: quizResult.completedAt ?? new Date(),
					},
					{ tx },
				);

				return quizResult;
			});

			return {
				status: 200,
				body: {
					message: "Quiz completed successfully",
					data: result,
				},
			};
		}),

	// Get current quiz attempt (driver or admin)
	getAttempt: priv.getAttempt.handler(
		async ({ context, input: { params } }) => {
			const result = await context.repo.driverQuizAnswer.get(params.attemptId);

			return {
				status: 200,
				body: {
					message: "Quiz attempt retrieved successfully",
					data: result,
				},
			};
		},
	),

	// Get quiz result (driver or admin)
	getResult: priv.getResult.handler(async ({ context, input: { params } }) => {
		const result = await context.repo.driverQuizAnswer.getResult(
			params.attemptId,
		);

		return {
			status: 200,
			body: {
				message: "Quiz result retrieved successfully",
				data: result,
			},
		};
	}),

	// List quiz attempts (admin can filter by driverId, driver sees their own)
	list: priv.list.handler(async ({ context, input: { query } }) => {
		// If not admin, restrict to user's own driver attempts
		let driverId = query.driverId;

		if (context.user.role === "DRIVER") {
			const driver = await context.repo.driver.main.getByUserId(
				context.user.id,
			);
			driverId = driver.id;
		}

		const { rows, totalPages } =
			await context.repo.driverQuizAnswer.listAttempts({
				...query,
				driverId,
			});

		return {
			status: 200,
			body: {
				message: "Quiz attempts retrieved successfully",
				data: { rows },
				totalPages,
			},
		};
	}),

	// Get driver's latest quiz attempt (for driver to check their status)
	getMyLatestAttempt: priv.getMyLatestAttempt
		.use(driverMiddleware)
		.handler(async ({ context }) => {
			const driver = await context.repo.driver.main.getByUserId(
				context.user.id,
			);
			const result = await context.repo.driverQuizAnswer.getLatestByDriverId(
				driver.id,
			);

			return {
				status: 200,
				body: {
					message: "Latest quiz attempt retrieved successfully",
					data: result,
				},
			};
		}),
});
