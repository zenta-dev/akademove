import type { ConfigurationDatabase } from "@/core/tables/configuration";

/**
 * Service responsible for managing configuration audit logging
 */
export class ConfigurationAuditService {
	/**
	 * Prepare audit log data for configuration updates
	 * @param key - Configuration key
	 * @param oldData - Previous configuration state
	 * @param newData - New configuration state
	 * @param updatedById - ID of user who made the update
	 * @returns Prepared audit log entry
	 */
	static prepareAuditLogEntry(
		key: string,
		oldData: ConfigurationDatabase,
		newData: ConfigurationDatabase,
		updatedById: string,
	): {
		tableName: "configurations";
		recordId: string;
		operation: "UPDATE";
		oldData: ConfigurationDatabase;
		newData: ConfigurationDatabase;
		updatedById: string;
	} {
		return {
			tableName: "configurations" as const,
			recordId: key,
			operation: "UPDATE" as const,
			oldData,
			newData,
			updatedById,
		};
	}

	/**
	 * Prepare configuration update data
	 * @param userId - ID of user making the update
	 * @returns Partial update object with updatedById and updatedAt
	 */
	static prepareUpdateData(userId: string): {
		updatedById: string;
		updatedAt: Date;
	} {
		return {
			updatedById: userId,
			updatedAt: new Date(),
		};
	}
}
