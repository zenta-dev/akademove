import { auth, driver, merchant, user } from "@repo/schema/auth";
import type { Broadcast } from "@repo/schema/broadcast";
import { TARGET_AUDIENCE } from "@repo/schema/broadcast";
import { and, eq, inArray } from "drizzle-orm";
import { convert } from "html-to-text";
import type { WithTx } from "@/core/interface";
import type { ResendMailService } from "@/core/services/mail";
import type { NotificationRepository } from "@/features/notification/notification-repository";
import { log } from "@/utils";

export class BroadcastService {
	constructor(
		private db: any,
		private mailService: ResendMailService,
		private notificationRepository: NotificationRepository,
	) {}

	async sendEmailBroadcast(broadcast: Broadcast, opts?: WithTx): Promise<void> {
		try {
			log.info(
				{
					broadcastId: broadcast.id,
					targetAudience: broadcast.targetAudience,
				},
				"[BroadcastService] Starting email broadcast",
			);

			// Get target users based on audience
			const targetUsers = await this.getTargetUsers(
				broadcast.targetAudience,
				broadcast.targetUserIds,
				opts,
			);

			if (targetUsers.length === 0) {
				log.warn(
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

				const emailPromises = batch.map(async (user) => {
					try {
						await this.mailService.sendEmail({
							to: user.email,
							subject: broadcast.title,
							html: this.createEmailTemplate(
								broadcast.message,
								user.fullName || user.email,
							),
							text: convert(broadcast.message, {
								wordwrap: 130,
							}),
						});
						return { success: true, userId: user.id };
					} catch (error) {
						log.error(
							{
								error,
								userId: user.id,
								email: user.email,
							},
							"[BroadcastService] Failed to send email to user",
						);
						return { success: false, userId: user.id };
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

			log.info(
				{
					broadcastId: broadcast.id,
					totalRecipients: targetUsers.length,
					sentCount,
					failedCount,
				},
				"[BroadcastService] Email broadcast completed",
			);
		} catch (error) {
			log.error(
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
			log.info(
				{
					broadcastId: broadcast.id,
					targetAudience: broadcast.targetAudience,
				},
				"[BroadcastService] Starting in-app broadcast",
			);

			// Get target users based on audience
			const targetUsers = await this.getTargetUsers(
				broadcast.targetAudience,
				broadcast.targetUserIds,
				opts,
			);

			if (targetUsers.length === 0) {
				log.warn(
					{ broadcastId: broadcast.id },
					"[BroadcastService] No target users found",
				);
				return;
			}

			// Create notifications for all target users
			const notifications = targetUsers.map((user) => ({
				id: `broadcast_${broadcast.id}_${user.id}`,
				userId: user.id,
				title: broadcast.title,
				message: broadcast.message,
				type: "BROADCAST" as const,
				data: {
					broadcastId: broadcast.id,
					type: broadcast.type,
				},
				isRead: false,
				createdAt: new Date(),
				updatedAt: new Date(),
			}));

			// Insert notifications in batches
			const batchSize = 100;
			let createdCount = 0;

			for (let i = 0; i < notifications.length; i += batchSize) {
				const batch = notifications.slice(i, i + batchSize);

				try {
					await this.notificationRepository.createMany(batch, opts);
					createdCount += batch.length;
				} catch (error) {
					log.error(
						{
							error,
							batchSize: batch.length,
						},
						"[BroadcastService] Failed to create notification batch",
					);
				}
			}

			log.info(
				{
					broadcastId: broadcast.id,
					totalRecipients: targetUsers.length,
					createdNotifications: createdCount,
				},
				"[BroadcastService] In-app broadcast completed",
			);
		} catch (error) {
			log.error(
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
		targetUserIds?: string[],
		opts?: WithTx,
	): Promise<Array<{ id: string; email: string; fullName?: string }>> {
		const db = opts?.tx ?? this.db;

		// If specific user IDs are provided, use those
		if (targetUserIds && targetUserIds.length > 0) {
			const users = await db
				.select({
					id: user.id,
					email: user.email,
					fullName: user.fullName,
				})
				.from(user)
				.where(inArray(user.id, targetUserIds));

			return users;
		}

		// Otherwise, get users based on audience
		switch (targetAudience) {
			case TARGET_AUDIENCE.ALL: {
				const allUsers = await db
					.select({
						id: user.id,
						email: user.email,
						fullName: user.fullName,
					})
					.from(user)
					.innerJoin(auth, eq(user.id, auth.userId))
					.where(eq(auth.isActive, true));
				return allUsers;
			}

			case TARGET_AUDIENCE.USERS: {
				const regularUsers = await db
					.select({
						id: user.id,
						email: user.email,
						fullName: user.fullName,
					})
					.from(user)
					.innerJoin(auth, eq(user.id, auth.userId))
					.where(and(eq(auth.isActive, true), eq(auth.role, "USER")));
				return regularUsers;
			}

			case TARGET_AUDIENCE.DRIVERS: {
				const drivers = await db
					.select({
						id: user.id,
						email: user.email,
						fullName: user.fullName,
					})
					.from(user)
					.innerJoin(auth, eq(user.id, auth.userId))
					.innerJoin(driver, eq(user.id, driver.userId))
					.where(
						and(
							eq(auth.isActive, true),
							eq(auth.role, "DRIVER"),
							eq(driver.isVerified, true),
						),
					);
				return drivers;
			}

			case TARGET_AUDIENCE.MERCHANTS: {
				const merchants = await db
					.select({
						id: user.id,
						email: user.email,
						fullName: user.fullName,
					})
					.from(user)
					.innerJoin(auth, eq(user.id, auth.userId))
					.innerJoin(merchant, eq(user.id, merchant.userId))
					.where(
						and(
							eq(auth.isActive, true),
							eq(auth.role, "MERCHANT"),
							eq(merchant.isVerified, true),
						),
					);
				return merchants;
			}

			case TARGET_AUDIENCE.ADMINS: {
				const admins = await db
					.select({
						id: user.id,
						email: user.email,
						fullName: user.fullName,
					})
					.from(user)
					.innerJoin(auth, eq(user.id, auth.userId))
					.where(and(eq(auth.isActive, true), eq(auth.role, "ADMIN")));
				return admins;
			}

			case TARGET_AUDIENCE.OPERATORS: {
				const operators = await db
					.select({
						id: user.id,
						email: user.email,
						fullName: user.fullName,
					})
					.from(user)
					.innerJoin(auth, eq(user.id, auth.userId))
					.where(and(eq(auth.isActive, true), eq(auth.role, "OPERATOR")));
				return operators;
			}

			default:
				return [];
		}
	}

	private createEmailTemplate(message: string, recipientName: string): string {
		return `
      <!DOCTYPE html>
      <html>
      <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>AkadeMove Broadcast</title>
        <style>
          body {
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
            line-height: 1.6;
            color: #333;
            max-width: 600px;
            margin: 0 auto;
            padding: 20px;
          }
          .header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 30px;
            text-align: center;
            border-radius: 10px 10px 0 0;
          }
          .content {
            background: #f9f9f9;
            padding: 30px;
            border-radius: 0 0 10px 10px;
          }
          .footer {
            text-align: center;
            margin-top: 30px;
            color: #666;
            font-size: 14px;
          }
        </style>
      </head>
      <body>
        <div class="header">
          <h1>AkadeMove</h1>
          <p>Important Announcement</p>
        </div>
        <div class="content">
          <p>Hi ${recipientName},</p>
          <div>${message}</div>
          <p>Best regards,<br>The AkadeMove Team</p>
        </div>
        <div class="footer">
          <p>&copy; 2024 AkadeMove. All rights reserved.</p>
          <p>If you no longer wish to receive these emails, you can unsubscribe in your account settings.</p>
        </div>
      </body>
      </html>
    `;
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

		await db.update(broadcast).set(counts).where(eq(broadcast.id, broadcastId));
	}
}
