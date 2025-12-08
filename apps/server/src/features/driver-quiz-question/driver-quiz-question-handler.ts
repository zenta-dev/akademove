import { trimObjectValues } from "@repo/shared";
import { requireRoles } from "@/core/middlewares/auth";
import { createORPCRouter } from "@/core/router/orpc";
import { DriverQuizQuestionSpec } from "./driver-quiz-question-spec";

const { priv } = createORPCRouter(DriverQuizQuestionSpec);

const adminMiddleware = requireRoles("ADMIN", "OPERATOR");

export const DriverQuizQuestionHandler = priv.router({
	list: priv.list
		.use(adminMiddleware)
		.handler(async ({ context, input: { query } }) => {
			const { rows, totalPages } =
				await context.repo.driverQuizQuestion.list(query);
			return {
				status: 200,
				body: {
					message: "Driver quiz questions retrieved successfully",
					data: { rows },
					totalPages,
				},
			};
		}),

	get: priv.get
		.use(adminMiddleware)
		.handler(async ({ context, input: { params } }) => {
			const result = await context.repo.driverQuizQuestion.get(params.id);
			return {
				status: 200,
				body: {
					message: "Driver quiz question retrieved successfully",
					data: result,
				},
			};
		}),

	create: priv.create
		.use(adminMiddleware)
		.handler(async ({ context, input: { body } }) => {
			const data = trimObjectValues(body);
			const result = await context.svc.db.transaction(async (tx) => {
				return await context.repo.driverQuizQuestion.create(data, { tx });
			});
			return {
				status: 201,
				body: {
					message: "Driver quiz question created successfully",
					data: result,
				},
			};
		}),

	update: priv.update
		.use(adminMiddleware)
		.handler(async ({ context, input: { params, body } }) => {
			const data = trimObjectValues(body);
			const result = await context.svc.db.transaction(async (tx) => {
				return await context.repo.driverQuizQuestion.update(params.id, data, {
					tx,
				});
			});
			return {
				status: 200,
				body: {
					message: "Driver quiz question updated successfully",
					data: result,
				},
			};
		}),

	remove: priv.remove
		.use(adminMiddleware)
		.handler(async ({ context, input: { params } }) => {
			await context.svc.db.transaction(async (tx) => {
				await context.repo.driverQuizQuestion.remove(params.id, { tx });
			});
			return {
				status: 200,
				body: {
					message: "Driver quiz question deleted successfully",
					data: null,
				},
			};
		}),

	// Public endpoint for drivers to get quiz questions (correct answers hidden)
	getQuizQuestions: priv.getQuizQuestions.handler(
		async ({ context, input: { query } }) => {
			const questions =
				await context.repo.driverQuizQuestion.getQuizQuestions(query);
			return {
				status: 200,
				body: {
					message: "Quiz questions retrieved successfully",
					data: questions,
				},
			};
		},
	),
});
