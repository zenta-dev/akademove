import { m } from "@repo/i18n";
import { trimObjectValues } from "@repo/shared";
import { createORPCRouter } from "@/core/router/orpc";
import { ReportSpec } from "./report-spec";

const { priv } = createORPCRouter(ReportSpec);

export const ReportHandler = priv.router({
	list: priv.list.handler(async ({ context, input: { query } }) => {
		const { rows, totalPages } = await context.repo.report.list(query);

		return {
			status: 200,
			body: {
				message: m.server_reports_retrieved(),
				data: rows,
				totalPages,
			},
		};
	}),
	get: priv.get.handler(async ({ context, input: { params } }) => {
		const result = await context.repo.report.get(params.id);

		return {
			status: 200,
			body: { message: m.server_report_retrieved(), data: result },
		};
	}),
	create: priv.create.handler(async ({ context, input: { body } }) => {
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
	update: priv.update.handler(async ({ context, input: { params, body } }) => {
		const data = trimObjectValues(body);
		const result = await context.repo.report.update(
			params.id,
			data,
			undefined,
			context,
		);

		return {
			status: 200,
			body: { message: m.server_report_updated(), data: result },
		};
	}),
	remove: priv.remove.handler(async ({ context, input: { params } }) => {
		await context.repo.report.remove(params.id);

		return {
			status: 200,
			body: { message: m.server_report_deleted(), data: null },
		};
	}),
	startInvestigation: priv.startInvestigation.handler(
		async ({ context, input: { params, body } }) => {
			const data = trimObjectValues(body);
			const result = await context.repo.report.startInvestigation(
				params.id,
				data.notes,
				context.user.id,
				undefined,
				context,
			);

			return {
				status: 200,
				body: {
					message: m.server_report_investigation_started(),
					data: result,
				},
			};
		},
	),
	resolve: priv.resolve.handler(
		async ({ context, input: { params, body } }) => {
			const data = trimObjectValues(body);
			const result = await context.repo.report.resolve(
				params.id,
				data.resolution,
				context.user.id,
				undefined,
				context,
			);

			return {
				status: 200,
				body: { message: m.server_report_resolved(), data: result },
			};
		},
	),
	dismiss: priv.dismiss.handler(
		async ({ context, input: { params, body } }) => {
			const data = trimObjectValues(body);
			const result = await context.repo.report.dismiss(
				params.id,
				data.reason,
				context.user.id,
				undefined,
				context,
			);

			return {
				status: 200,
				body: { message: m.server_report_dismissed(), data: result },
			};
		},
	),
});
