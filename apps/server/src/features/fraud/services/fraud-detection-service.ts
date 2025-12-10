import type {
	FraudConfig,
	FraudSeverity,
	FraudSignal,
} from "@repo/schema/fraud";
import type { LocationSchema } from "@repo/schema/position";
import type * as z from "zod";
import { logger } from "@/utils/logger";

type Location = z.infer<typeof LocationSchema>;

interface LocationUpdate {
	location: Location;
	previousLocation?: Location | null;
	timestamp: Date;
	previousTimestamp?: Date | null;
	isMockLocation?: boolean;
}

interface ValidationContext {
	userId: string;
	driverId?: string;
	ipAddress?: string;
	userAgent?: string;
}

/**
 * GPS Spoofing Detection Service
 * Detects suspicious location patterns that may indicate GPS spoofing/mocking
 *
 * Detection methods:
 * 1. Velocity check - Detects impossible speeds (>200 km/h default)
 * 2. Teleportation - Detects sudden location jumps (>50km in <1min)
 * 3. Mock location flag - Checks if device reports mock location enabled
 */
export class FraudDetectionService {
	// Default config values
	private static readonly DEFAULT_CONFIG: FraudConfig = {
		gpsMaxVelocityKmh: 200,
		gpsTeleportThresholdKm: 50,
		gpsMinUpdateIntervalMs: 1000,
		duplicateIpWindowHours: 24,
		duplicateIpMaxRegistrations: 3,
		nameSimilarityThreshold: 0.85,
		highRiskScoreThreshold: 70,
	};

	/**
	 * Validate a location update for potential GPS spoofing
	 */
	static validateLocationUpdate(
		update: LocationUpdate,
		context: ValidationContext,
		config?: Partial<FraudConfig>,
	): {
		isValid: boolean;
		signals: FraudSignal[];
		shouldLog: boolean;
		highestSeverity: FraudSeverity | null;
	} {
		const cfg = { ...FraudDetectionService.DEFAULT_CONFIG, ...config };
		const signals: FraudSignal[] = [];

		// 1. Check for mock location flag
		if (update.isMockLocation === true) {
			signals.push({
				type: "GPS_SPOOF_MOCK_DETECTED",
				severity: "HIGH",
				confidence: 95,
				metadata: {
					userId: context.userId,
					driverId: context.driverId,
					location: update.location,
				},
			});

			logger.warn(
				{ userId: context.userId, driverId: context.driverId },
				"[FraudDetectionService] Mock location detected",
			);
		}

		// 2. Check velocity if we have previous location
		if (update.previousLocation && update.previousTimestamp) {
			const velocityResult = FraudDetectionService.checkVelocity(
				update.location,
				update.previousLocation,
				update.timestamp,
				update.previousTimestamp,
				cfg.gpsMaxVelocityKmh,
			);

			if (velocityResult.isAnomalous) {
				signals.push({
					type: "GPS_SPOOF_VELOCITY",
					severity: velocityResult.severity,
					confidence: velocityResult.confidence,
					metadata: {
						velocityKmh: velocityResult.velocityKmh,
						distanceKm: velocityResult.distanceKm,
						timeDeltaSeconds: velocityResult.timeDeltaSeconds,
						maxAllowedKmh: cfg.gpsMaxVelocityKmh,
					},
				});

				logger.warn(
					{
						userId: context.userId,
						driverId: context.driverId,
						velocityKmh: velocityResult.velocityKmh,
					},
					"[FraudDetectionService] Anomalous velocity detected",
				);
			}

			// 3. Check for teleportation
			const teleportResult = FraudDetectionService.checkTeleportation(
				update.location,
				update.previousLocation,
				update.timestamp,
				update.previousTimestamp,
				cfg.gpsTeleportThresholdKm,
			);

			if (teleportResult.isTeleport) {
				signals.push({
					type: "GPS_SPOOF_TELEPORT",
					severity: teleportResult.severity,
					confidence: teleportResult.confidence,
					metadata: {
						distanceKm: teleportResult.distanceKm,
						timeDeltaSeconds: teleportResult.timeDeltaSeconds,
						thresholdKm: cfg.gpsTeleportThresholdKm,
					},
				});

				logger.warn(
					{
						userId: context.userId,
						driverId: context.driverId,
						distanceKm: teleportResult.distanceKm,
					},
					"[FraudDetectionService] Teleportation detected",
				);
			}
		}

		// Determine highest severity
		const highestSeverity = FraudDetectionService.getHighestSeverity(signals);
		const shouldLog = signals.length > 0;

		return {
			isValid: signals.length === 0,
			signals,
			shouldLog,
			highestSeverity,
		};
	}

	/**
	 * Check if velocity between two points is physically possible
	 */
	private static checkVelocity(
		current: Location,
		previous: Location,
		currentTime: Date,
		previousTime: Date,
		maxVelocityKmh: number,
	): {
		isAnomalous: boolean;
		velocityKmh: number;
		distanceKm: number;
		timeDeltaSeconds: number;
		severity: FraudSeverity;
		confidence: number;
	} {
		const distanceKm = FraudDetectionService.calculateDistanceKm(
			current,
			previous,
		);
		const timeDeltaMs = currentTime.getTime() - previousTime.getTime();
		const timeDeltaSeconds = timeDeltaMs / 1000;
		const timeDeltaHours = timeDeltaMs / (1000 * 60 * 60);

		// Avoid division by zero
		if (timeDeltaHours <= 0) {
			return {
				isAnomalous: false,
				velocityKmh: 0,
				distanceKm,
				timeDeltaSeconds,
				severity: "LOW",
				confidence: 0,
			};
		}

		const velocityKmh = distanceKm / timeDeltaHours;
		const isAnomalous = velocityKmh > maxVelocityKmh;

		// Calculate severity based on how much the velocity exceeds the limit
		let severity: FraudSeverity = "LOW";
		let confidence = 50;

		if (isAnomalous) {
			const ratio = velocityKmh / maxVelocityKmh;
			if (ratio > 10) {
				severity = "CRITICAL";
				confidence = 99;
			} else if (ratio > 5) {
				severity = "HIGH";
				confidence = 90;
			} else if (ratio > 2) {
				severity = "MEDIUM";
				confidence = 75;
			} else {
				severity = "LOW";
				confidence = 60;
			}
		}

		return {
			isAnomalous,
			velocityKmh: Math.round(velocityKmh * 100) / 100,
			distanceKm: Math.round(distanceKm * 1000) / 1000,
			timeDeltaSeconds: Math.round(timeDeltaSeconds),
			severity,
			confidence,
		};
	}

	/**
	 * Check for teleportation (large distance in short time)
	 */
	private static checkTeleportation(
		current: Location,
		previous: Location,
		currentTime: Date,
		previousTime: Date,
		teleportThresholdKm: number,
	): {
		isTeleport: boolean;
		distanceKm: number;
		timeDeltaSeconds: number;
		severity: FraudSeverity;
		confidence: number;
	} {
		const distanceKm = FraudDetectionService.calculateDistanceKm(
			current,
			previous,
		);
		const timeDeltaMs = currentTime.getTime() - previousTime.getTime();
		const timeDeltaSeconds = timeDeltaMs / 1000;

		// Teleportation is when distance > threshold AND time is < 60 seconds
		const isTeleport =
			distanceKm > teleportThresholdKm && timeDeltaSeconds < 60;

		let severity: FraudSeverity = "LOW";
		let confidence = 50;

		if (isTeleport) {
			if (distanceKm > teleportThresholdKm * 10) {
				severity = "CRITICAL";
				confidence = 99;
			} else if (distanceKm > teleportThresholdKm * 5) {
				severity = "HIGH";
				confidence = 95;
			} else if (distanceKm > teleportThresholdKm * 2) {
				severity = "MEDIUM";
				confidence = 85;
			} else {
				severity = "LOW";
				confidence = 70;
			}
		}

		return {
			isTeleport,
			distanceKm: Math.round(distanceKm * 1000) / 1000,
			timeDeltaSeconds: Math.round(timeDeltaSeconds),
			severity,
			confidence,
		};
	}

	/**
	 * Calculate distance between two coordinates using Haversine formula
	 */
	static calculateDistanceKm(loc1: Location, loc2: Location): number {
		const R = 6371; // Earth's radius in km
		const dLat = FraudDetectionService.toRad(loc2.lat - loc1.lat);
		const dLng = FraudDetectionService.toRad(loc2.lng - loc1.lng);
		const a =
			Math.sin(dLat / 2) * Math.sin(dLat / 2) +
			Math.cos(FraudDetectionService.toRad(loc1.lat)) *
				Math.cos(FraudDetectionService.toRad(loc2.lat)) *
				Math.sin(dLng / 2) *
				Math.sin(dLng / 2);
		const c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
		return R * c;
	}

	private static toRad(deg: number): number {
		return deg * (Math.PI / 180);
	}

	/**
	 * Get the highest severity from a list of signals
	 */
	private static getHighestSeverity(
		signals: FraudSignal[],
	): FraudSeverity | null {
		if (signals.length === 0) return null;

		const severityOrder: FraudSeverity[] = [
			"LOW",
			"MEDIUM",
			"HIGH",
			"CRITICAL",
		];
		let highest: FraudSeverity = "LOW";

		for (const signal of signals) {
			if (
				severityOrder.indexOf(signal.severity) > severityOrder.indexOf(highest)
			) {
				highest = signal.severity;
			}
		}

		return highest;
	}

	/**
	 * Calculate fraud score from signals (0-100)
	 */
	static calculateScore(signals: FraudSignal[]): number {
		if (signals.length === 0) return 0;

		const severityWeights: Record<FraudSeverity, number> = {
			LOW: 10,
			MEDIUM: 30,
			HIGH: 60,
			CRITICAL: 90,
		};

		let totalWeight = 0;
		let weightedScore = 0;

		for (const signal of signals) {
			const baseScore = severityWeights[signal.severity];
			const confidenceMultiplier = signal.confidence / 100;
			const signalScore = baseScore * confidenceMultiplier;

			weightedScore += signalScore;
			totalWeight += 1;
		}

		// Average score, capped at 100
		const score = totalWeight > 0 ? weightedScore / totalWeight : 0;
		return Math.min(Math.round(score * 100) / 100, 100);
	}
}
