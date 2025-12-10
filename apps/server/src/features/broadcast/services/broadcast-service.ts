import { and, eq, inArray } from "drizzle-orm";
import type { WithTx } from "@/core/interface";
import { type DatabaseService, tables } from "@/core/services/db";
import type { MailService } from "@/core/services/mail";
import type { Broadcast } from "@/core/tables/broadcast";
import { TARGET_AUDIENCE } from "@/core/tables/broadcast";
import type { NotificationRepository } from "@/features/notification/notification-repository";
import { logger } from "@/utils/logger";

export class BroadcastService {
	constructor(
		private db: DatabaseService,
		private mailService: MailService,
		private notificationRepository: NotificationRepository,
	) {}

	async sendEmailBroadcast(broadcast: Broadcast, opts?: WithTx): Promise<void> {
		try {
			logger.info(
				{
					broadcastId: broadcast.id,
					targetAudience: broadcast.targetAudience,
				},
				"[BroadcastService] Starting email broadcast",
			);

			// Get target users based on audience
			const targetUsers = await this.getTargetUsers(
				broadcast.targetAudience,
				broadcast.targetIds,
				opts,
			);

			if (targetUsers.length === 0) {
				logger.warn(
					{ broadcastId: broadcast.id },
					"[BroadcastService] No target users found",
				);
				return;
			}

			// Update total recipients
			await this.updateBroadcastCounts(
				broadcast.id,
				{
					totalRecipients: targetUsers.length,
				},
				opts,
			);

			// Send emails in batches to prevent overwhelming the mail service
			const batchSize = 50;
			let sentCount = 0;
			let failedCount = 0;

			for (let i = 0; i < targetUsers.length; i += batchSize) {
				const batch = targetUsers.slice(i, i + batchSize);

				const emailPromises = batch.map(async (targetUser) => {
					try {
						await this.mailService.sendMail({
							from: "AkadeMove <no-reply@mail.akademove.com>",
							to: targetUser.email,
							subject: broadcast.title,
							text: broadcast.message,
						});
						return { success: true, userId: targetUser.id };
					} catch (error) {
						logger.error(
							{
								error,
								userId: targetUser.id,
								email: targetUser.email,
							},
							"[BroadcastService] Failed to send email to user",
						);
						return { success: false, userId: targetUser.id };
					}
				});

				const results = await Promise.all(emailPromises);
				sentCount += results.filter((r) => r.success).length;
				failedCount += results.filter((r) => !r.success).length;

				// Small delay between batches to respect rate limits
				if (i + batchSize < targetUsers.length) {
					await new Promise((resolve) => setTimeout(resolve, 100));
				}
			}

			// Update final counts
			await this.updateBroadcastCounts(
				broadcast.id,
				{
					sentCount,
					failedCount,
				},
				opts,
			);

			logger.info(
				{
					broadcastId: broadcast.id,
					totalRecipients: targetUsers.length,
					sentCount,
					failedCount,
				},
				"[BroadcastService] Email broadcast completed",
			);
		} catch (error) {
			logger.error(
				{
					error,
					broadcastId: broadcast.id,
				},
				"[BroadcastService] Email broadcast failed",
			);
			throw error;
		}
	}

	async sendInAppBroadcast(broadcast: Broadcast, opts?: WithTx): Promise<void> {
		try {
			logger.info(
				{
					broadcastId: broadcast.id,
					targetAudience: broadcast.targetAudience,
				},
				"[BroadcastService] Starting in-app broadcast",
			);

			// Get target users based on audience
			const targetUsers = await this.getTargetUsers(
				broadcast.targetAudience,
				broadcast.targetIds,
				opts,
			);

			if (targetUsers.length === 0) {
				logger.warn(
					{ broadcastId: broadcast.id },
					"[BroadcastService] No target users found",
				);
				return;
			}

			// Create notifications for all target users one by one
			let createdCount = 0;

			for (const targetUser of targetUsers) {
				try {
					await this.notificationRepository.sendNotificationToUserId(
						{
							toUserId: targetUser.id,
							fromUserId: "system",
							title: broadcast.title,
							body: broadcast.message,
							data: {
								broadcastId: broadcast.id,
								type: broadcast.type,
							},
						},
						opts,
					);
					createdCount++;
				} catch (error) {
					logger.error(
						{
							error,
							userId: targetUser.id,
						},
						"[BroadcastService] Failed to create notification for user",
					);
				}
			}

			logger.info(
				{
					broadcastId: broadcast.id,
					totalRecipients: targetUsers.length,
					createdNotifications: createdCount,
				},
				"[BroadcastService] In-app broadcast completed",
			);
		} catch (error) {
			logger.error(
				{
					error,
					broadcastId: broadcast.id,
				},
				"[BroadcastService] In-app broadcast failed",
			);
			throw error;
		}
	}

	private async getTargetUsers(
		targetAudience: string,
		targetIds?: string[],
		opts?: WithTx,
	): Promise<Array<{ id: string; email: string; name?: string }>> {
		const db = opts?.tx ?? this.db;

		// If specific user IDs are provided, use those
		if (targetIds && targetIds.length > 0) {
			const users = await db
				.select({
					id: tables.user.id,
					email: tables.user.email,
					name: tables.user.name,
				})
				.from(tables.user)
				.where(inArray(tables.user.id, targetIds));

			return users;
		}

		// Otherwise, get users based on audience
		switch (targetAudience) {
			case TARGET_AUDIENCE.ALL: {
				const allUsers = await db
					.select({
						id: tables.user.id,
						email: tables.user.email,
						name: tables.user.name,
					})
					.from(tables.user)
					.where(eq(tables.user.banned, false));
				return allUsers;
			}

			case TARGET_AUDIENCE.USERS: {
				const regularUsers = await db
					.select({
						id: tables.user.id,
						email: tables.user.email,
						name: tables.user.name,
					})
					.from(tables.user)
					.where(
						and(eq(tables.user.banned, false), eq(tables.user.role, "USER")),
					);
				return regularUsers;
			}

			case TARGET_AUDIENCE.DRIVERS: {
				const drivers = await db
					.select({
						id: tables.user.id,
						email: tables.user.email,
						name: tables.user.name,
					})
					.from(tables.user)
					.innerJoin(tables.driver, eq(tables.user.id, tables.driver.userId))
					.where(
						and(
							eq(tables.user.banned, false),
							eq(tables.user.role, "DRIVER"),
							eq(tables.driver.status, "ACTIVE"),
						),
					);
				return drivers;
			}

			case TARGET_AUDIENCE.MERCHANTS: {
				const merchants = await db
					.select({
						id: tables.user.id,
						email: tables.user.email,
						name: tables.user.name,
					})
					.from(tables.user)
					.innerJoin(
						tables.merchant,
						eq(tables.user.id, tables.merchant.userId),
					)
					.where(
						and(
							eq(tables.user.banned, false),
							eq(tables.user.role, "MERCHANT"),
							eq(tables.merchant.isActive, true),
						),
					);
				return merchants;
			}

			case TARGET_AUDIENCE.ADMINS: {
				const admins = await db
					.select({
						id: tables.user.id,
						email: tables.user.email,
						name: tables.user.name,
					})
					.from(tables.user)
					.where(
						and(eq(tables.user.banned, false), eq(tables.user.role, "ADMIN")),
					);
				return admins;
			}

			case TARGET_AUDIENCE.OPERATORS: {
				const operators = await db
					.select({
						id: tables.user.id,
						email: tables.user.email,
						name: tables.user.name,
					})
					.from(tables.user)
					.where(
						and(
							eq(tables.user.banned, false),
							eq(tables.user.role, "OPERATOR"),
						),
					);
				return operators;
			}

			default:
				return [];
		}
	}

	private async updateBroadcastCounts(
		broadcastId: string,
		counts: {
			sentCount?: number;
			failedCount?: number;
			totalRecipients?: number;
		},
		opts?: WithTx,
	): Promise<void> {
		const db = opts?.tx ?? this.db;

		await db
			.update(tables.broadcast)
			.set(counts)
			.where(eq(tables.broadcast.id, broadcastId));
	}
}
