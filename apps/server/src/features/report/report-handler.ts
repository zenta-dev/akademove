import { m } from "@repo/i18n";
import { trimObjectValues } from "@repo/shared";
import { hasPermission } from "@/core/middlewares/auth";
import { createORPCRouter } from "@/core/router/orpc";
import { ReportSpec } from "./report-spec";

const { priv } = createORPCRouter(ReportSpec);

export const ReportHandler = priv.router({
	list: priv.list
		.use(hasPermission({ report: ["list"] }))
		.handler(async ({ context, input: { query } }) => {
			const { rows, totalPages } = await context.repo.report.list(query);

			return {
				status: 200,
				body: {
					message: "Successfully retrieved reports data",
					data: rows,
					totalPages,
				},
			};
		}),
	get: priv.get
		.use(hasPermission({ report: ["get"] }))
		.handler(async ({ context, input: { params } }) => {
			const result = await context.repo.report.get(params.id);

			return {
				status: 200,
				body: { message: "Successfully retrieved report data", data: result },
			};
		}),
	create: priv.create
		.use(hasPermission({ report: ["create"] }))
		.handler(async ({ context, input: { body } }) => {
			const data = trimObjectValues(body);
			const result = await context.repo.report.create({
				...data,
				reporterId: context.user.id,
			});

			return {
				status: 200,
				body: { message: m.server_report_created(), data: result },
			};
		}),
	update: priv.update
		.use(hasPermission({ report: ["update"] }))
		.handler(async ({ context, input: { params, body } }) => {
			const data = trimObjectValues(body);
			const result = await context.repo.report.update(params.id, data);

			return {
				status: 200,
				body: { message: m.server_report_updated(), data: result },
			};
		}),
	remove: priv.remove
		.use(hasPermission({ report: ["update"] }))
		.handler(async ({ context, input: { params } }) => {
			await context.repo.report.remove(params.id);

			return {
				status: 200,
				body: { message: m.server_report_deleted(), data: null },
			};
		}),
});
