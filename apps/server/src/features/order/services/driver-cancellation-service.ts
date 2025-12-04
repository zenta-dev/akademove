/**
 * Service responsible for driver cancellation tracking and suspension logic
 *
 * Per SRS 8.3:
 * - Track driver cancellations per day
 * - Suspend driver after 3 cancellations in one day
 * - Reset counter daily
 */
export class DriverCancellationService {
	/**
	 * Determine if last cancellation was today
	 *
	 * @param lastCancellationDate - Date of last cancellation
	 * @returns True if last cancellation was today
	 */
	static isCancellationToday(
		lastCancellationDate: Date | string | null,
	): boolean {
		if (!lastCancellationDate) return false;

		const lastDate = new Date(lastCancellationDate);
		const today = new Date();

		return lastDate.toDateString() === today.toDateString();
	}

	/**
	 * Calculate new cancellation count
	 *
	 * Resets to 1 if last cancellation was not today, otherwise increments
	 *
	 * @param currentCount - Current cancellation count
	 * @param lastCancellationDate - Date of last cancellation
	 * @returns New cancellation count
	 */
	static calculateNewCancellationCount(
		currentCount: number,
		lastCancellationDate: Date | string | null,
	): number {
		const isToday =
			DriverCancellationService.isCancellationToday(lastCancellationDate);
		return isToday ? currentCount + 1 : 1;
	}

	/**
	 * Check if driver should be suspended
	 *
	 * Per SRS 8.3: Suspend after 3 cancellations in one day
	 *
	 * @param cancellationCount - Number of cancellations
	 * @returns True if driver should be suspended
	 */
	static shouldSuspendDriver(cancellationCount: number): boolean {
		return cancellationCount >= 3;
	}

	/**
	 * Prepare driver update data for cancellation tracking
	 *
	 * @param currentCount - Current cancellation count
	 * @param lastCancellationDate - Date of last cancellation
	 * @returns Object with cancellationCount and lastCancellationDate
	 */
	static prepareCancellationUpdate(
		currentCount: number,
		lastCancellationDate: Date | string | null,
	): {
		cancellationCount: number;
		lastCancellationDate: Date;
	} {
		const newCount = DriverCancellationService.calculateNewCancellationCount(
			currentCount,
			lastCancellationDate,
		);
		return {
			cancellationCount: newCount,
			lastCancellationDate: new Date(),
		};
	}

	/**
	 * Prepare driver suspension data
	 *
	 * Sets driver status to SUSPENDED and marks as offline
	 *
	 * @returns Object with status, isOnline, and isTakingOrder
	 */
	static prepareSuspensionData(): {
		status: "SUSPENDED";
		isOnline: false;
		isTakingOrder: false;
	} {
		return {
			status: "SUSPENDED",
			isOnline: false,
			isTakingOrder: false,
		};
	}
}
