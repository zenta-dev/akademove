import { eq } from "drizzle-orm";
import { getManagers, getRepositories, getServices } from "@/core/factory";
import { tables } from "@/core/services/db";
import { log } from "@/utils";

/**
 * Auto-offline cron job handler
 * Runs every minute to check driver schedules and toggle availability
 *
 * Logic:
 * 1. Get current time and day of week
 * 2. Find all active schedules for current day
 * 3. For each schedule, check if current time is within [startTime, endTime]
 * 4. If in schedule period → set isOnline = false (driver is in class)
 * 5. If outside schedule → set isOnline = true (driver is free)
 */
export async function handleAutoOfflineCron() {
	const svc = getServices();
	const repo = getRepositories(svc, getManagers());

	try {
		const now = new Date();
		const currentDayNumber = now.getDay(); // 0=Sunday, 1=Monday, ..., 6=Saturday
		const currentHour = now.getHours();
		const currentMinute = now.getMinutes();

		// Convert numeric day to enum string
		const dayMap: Record<
			number,
			| "SUNDAY"
			| "MONDAY"
			| "TUESDAY"
			| "WEDNESDAY"
			| "THURSDAY"
			| "FRIDAY"
			| "SATURDAY"
		> = {
			0: "SUNDAY",
			1: "MONDAY",
			2: "TUESDAY",
			3: "WEDNESDAY",
			4: "THURSDAY",
			5: "FRIDAY",
			6: "SATURDAY",
		};
		const currentDay = dayMap[currentDayNumber];

		log.info(
			{ currentDay, currentHour, currentMinute },
			"[AutoOfflineCron] Starting auto-offline check",
		);

		// Get all active schedules for current day (recurring schedules)
		const schedules = await svc.db.query.driverSchedule.findMany({
			where: (f, op) =>
				op.and(
					op.eq(f.isActive, true),
					op.eq(f.isRecurring, true),
					op.eq(f.dayOfWeek, currentDay),
				),
			with: {
				driver: {
					columns: {
						id: true,
						userId: true,
						isOnline: true,
					},
				},
			},
		});

		log.info(
			{ scheduleCount: schedules.length },
			"[AutoOfflineCron] Found active schedules",
		);

		let toggledCount = 0;

		for (const schedule of schedules) {
			try {
				const { startTime, endTime, driver } = schedule;

				// Convert Time objects to minutes since midnight
				const scheduleStart = startTime.h * 60 + startTime.m;
				const scheduleEnd = endTime.h * 60 + endTime.m;
				const currentTimeMinutes = currentHour * 60 + currentMinute;

				// Check if current time is within schedule period
				const isInSchedule =
					currentTimeMinutes >= scheduleStart &&
					currentTimeMinutes <= scheduleEnd;

				log.debug(
					{
						driverId: driver.id,
						scheduleName: schedule.name,
						isInSchedule,
						currentIsOnline: driver.isOnline,
						scheduleStart,
						scheduleEnd,
						currentTimeMinutes,
					},
					"[AutoOfflineCron] Checking driver schedule",
				);

				// FIX: Only set driver offline when in schedule period
				// We should NOT automatically force drivers online when outside schedule,
				// as they may have manually set themselves offline for personal reasons.
				// The schedule system only enforces "class time = offline", not "free time = online"
				if (isInSchedule && driver.isOnline) {
					// Driver is in class but still online - set them offline
					await svc.db
						.update(tables.driver)
						.set({ isOnline: false })
						.where(eq(tables.driver.id, driver.id));

					// Invalidate driver cache
					await repo.driver.main.deleteCache(driver.id);

					toggledCount++;

					log.info(
						{
							driverId: driver.id,
							userId: driver.userId,
							previousStatus: true,
							newStatus: false,
							reason: "in_schedule",
						},
						"[AutoOfflineCron] Set driver offline due to class schedule",
					);
				}
			} catch (error) {
				log.error(
					{ error, scheduleId: schedule.id, driverId: schedule.driverId },
					"[AutoOfflineCron] Failed to process schedule",
				);
				// Continue processing other schedules
			}
		}

		log.info(
			{ totalSchedules: schedules.length, toggledCount },
			"[AutoOfflineCron] Completed auto-offline check",
		);

		return { success: true, toggledCount };
	} catch (error) {
		log.error({ error }, "[AutoOfflineCron] Fatal error during cron execution");
		throw error;
	}
}
