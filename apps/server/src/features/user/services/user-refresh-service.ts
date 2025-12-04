import { m } from "@repo/i18n";
import type { User } from "@repo/schema/user";
import { RepositoryError } from "@/core/error";
import type { DatabaseTransaction } from "@/core/services/db";
import type { StorageService } from "@/core/services/storage";

/**
 * Service responsible for user entity refresh operations
 *
 * @responsibility Refresh user data with relations after updates
 */
export class UserRefreshService {
	/**
	 * Refresh user with relations from database
	 */
	static async refreshUser(
		tx: DatabaseTransaction,
		userId: string,
	): Promise<unknown> {
		const refreshed = await tx.query.user.findFirst({
			with: { userBadges: { with: { badge: true } } },
			where: (f, op) => op.eq(f.id, userId),
		});

		if (!refreshed) {
			throw new RepositoryError(m.error_failed_fetch_updated_user());
		}

		return refreshed;
	}

	/**
	 * Refresh and compose user entity
	 */
	static async refreshAndCompose(
		tx: DatabaseTransaction,
		userId: string,
		storage: StorageService,
		composeEntity: (
			item: unknown,
			storage: StorageService,
			options?: unknown,
		) => Promise<User> | User,
		options?: unknown,
	): Promise<User> {
		const refreshed = await UserRefreshService.refreshUser(tx, userId);
		return await composeEntity(refreshed, storage, options);
	}
}
