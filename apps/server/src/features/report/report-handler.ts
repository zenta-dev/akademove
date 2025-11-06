import { implement } from "@orpc/server";
import type { ORPCContext } from "@/core/interface";
import {
	hasPermission,
	orpcAuthMiddleware,
	orpcRequireAuthMiddleware,
} from "@/core/middlewares/auth";
import { ReportSpec } from "./report-spec";

const os = implement(ReportSpec)
	.$context<ORPCContext>()
	.use(orpcAuthMiddleware)
	.use(orpcRequireAuthMiddleware);

export const ReportHandler = os.router({
	list: os.list
		.use(hasPermission({ report: ["list"] }))
		.handler(async ({ context, input: { query } }) => {
			const result = await context.repo.report.list(query);

			return {
				status: 200,
				body: {
					message: "Successfully retrieved reports data",
					data: result,
				},
			};
		}),
	get: os.get
		.use(hasPermission({ report: ["get"] }))
		.handler(async ({ context, input: { params } }) => {
			const result = await context.repo.report.get(params.id);

			return {
				status: 200,
				body: { message: "Successfully retrieved report data", data: result },
			};
		}),
	create: os.create
		.use(hasPermission({ report: ["create"] }))
		.handler(async ({ context, input: { body } }) => {
			const result = await context.repo.report.create({
				...body,
				userId: context.user.id,
			});

			return {
				status: 200,
				body: { message: "Report created successfully", data: result },
			};
		}),
	update: os.update
		.use(hasPermission({ report: ["update"] }))
		.handler(async ({ context, input: { params, body } }) => {
			const result = await context.repo.report.update(params.id, body);

			return {
				status: 200,
				body: { message: "Report updated successfully", data: result },
			};
		}),
	remove: os.remove
		.use(hasPermission({ report: ["update"] }))
		.handler(async ({ context, input: { params } }) => {
			await context.repo.report.remove(params.id);

			return {
				status: 200,
				body: { message: "Report deleted successfully", data: null },
			};
		}),
});
