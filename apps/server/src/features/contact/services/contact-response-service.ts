/**
 * Service responsible for managing contact response logic
 */
export class ContactResponseService {
	/**
	 * Prepare contact response data for database update
	 * @param response - Response message
	 * @param status - New status after response
	 * @param respondedById - ID of user who responded
	 * @returns Prepared data object for database update
	 */
	static prepareResponseData(
		response: string,
		status: "PENDING" | "REVIEWING" | "RESOLVED" | "CLOSED",
		respondedById: string,
	): {
		response: string;
		status: "PENDING" | "REVIEWING" | "RESOLVED" | "CLOSED";
		respondedById: string;
		respondedAt: Date;
	} {
		return {
			response,
			status,
			respondedById,
			respondedAt: new Date(),
		};
	}

	/**
	 * Validate contact status transition
	 * @param currentStatus - Current contact status
	 * @param newStatus - New status to transition to
	 * @returns True if transition is valid
	 */
	static isValidStatusTransition(
		currentStatus: "PENDING" | "REVIEWING" | "RESOLVED" | "CLOSED",
		newStatus: "PENDING" | "REVIEWING" | "RESOLVED" | "CLOSED",
	): boolean {
		// Define valid transitions
		const validTransitions: Record<
			string,
			("PENDING" | "REVIEWING" | "RESOLVED" | "CLOSED")[]
		> = {
			PENDING: ["REVIEWING", "CLOSED"],
			REVIEWING: ["RESOLVED", "CLOSED", "PENDING"],
			RESOLVED: ["CLOSED", "REVIEWING"],
			CLOSED: ["REVIEWING"], // Allow reopening closed contacts
		};

		return validTransitions[currentStatus]?.includes(newStatus) ?? false;
	}

	/**
	 * Check if contact requires response
	 * @param status - Contact status
	 * @returns True if contact needs response
	 */
	static requiresResponse(
		status: "PENDING" | "REVIEWING" | "RESOLVED" | "CLOSED",
	): boolean {
		return status === "PENDING" || status === "REVIEWING";
	}
}
