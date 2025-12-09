import type {
	FraudConfig,
	FraudSeverity,
	FraudSignal,
} from "@repo/schema/fraud";
import { log } from "@/utils";

interface RegistrationContext {
	userId: string;
	name: string;
	email: string;
	bankAccountNumber?: string;
	ipAddress?: string;
	userAgent?: string;
}

interface DuplicateCheckInput {
	/** Bank account number to check */
	bankAccountNumber?: string;
	/** IP address of the registration request */
	ipAddress?: string;
	/** Name to check for similarity */
	name?: string;
}

interface ExistingData {
	/** Existing bank accounts: [{ bankAccountNumber, userId }] */
	existingBankAccounts: Array<{ bankAccountNumber: string; userId: string }>;
	/** Recent registrations from same IP: [{ userId, registeredAt }] */
	recentIpRegistrations: Array<{ userId: string; registeredAt: Date }>;
	/** Existing users with similar names: [{ userId, name, similarity }] */
	similarNames: Array<{ userId: string; name: string; similarity: number }>;
}

/**
 * Duplicate Account Detection Service
 * Detects potential duplicate/fraudulent account registrations
 *
 * Detection methods:
 * 1. Bank account duplication - Same bank account used on multiple accounts
 * 2. IP pattern detection - Multiple registrations from same IP within window
 * 3. Name similarity - High similarity names suggesting same person
 */
export class DuplicateAccountService {
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
	 * Check for duplicate account indicators
	 */
	static checkForDuplicates(
		input: DuplicateCheckInput,
		existing: ExistingData,
		context: RegistrationContext,
		config?: Partial<FraudConfig>,
	): {
		hasDuplicates: boolean;
		signals: FraudSignal[];
		shouldFlag: boolean;
		relatedUserIds: string[];
	} {
		const cfg = { ...DuplicateAccountService.DEFAULT_CONFIG, ...config };
		const signals: FraudSignal[] = [];
		const relatedUserIds = new Set<string>();

		// 1. Check bank account duplication
		if (input.bankAccountNumber && existing.existingBankAccounts.length > 0) {
			const duplicateBank = existing.existingBankAccounts.find(
				(acc) => acc.bankAccountNumber === input.bankAccountNumber,
			);

			if (duplicateBank) {
				signals.push({
					type: "DUPLICATE_BANK_ACCOUNT",
					severity: "HIGH",
					confidence: 95,
					metadata: {
						bankAccountNumber: DuplicateAccountService.maskBankAccount(
							input.bankAccountNumber,
						),
						existingUserId: duplicateBank.userId,
					},
				});
				relatedUserIds.add(duplicateBank.userId);

				log.warn(
					{ userId: context.userId, existingUserId: duplicateBank.userId },
					"[DuplicateAccountService] Duplicate bank account detected",
				);
			}
		}

		// 2. Check IP registration pattern
		if (input.ipAddress && existing.recentIpRegistrations.length > 0) {
			const recentCount = existing.recentIpRegistrations.length;

			if (recentCount >= cfg.duplicateIpMaxRegistrations) {
				const severity = DuplicateAccountService.calculateIpSeverity(
					recentCount,
					cfg.duplicateIpMaxRegistrations,
				);

				signals.push({
					type: "DUPLICATE_IP_PATTERN",
					severity,
					confidence: Math.min(70 + recentCount * 5, 95),
					metadata: {
						ipAddress: input.ipAddress,
						registrationCount: recentCount,
						maxAllowed: cfg.duplicateIpMaxRegistrations,
						windowHours: cfg.duplicateIpWindowHours,
					},
				});

				for (const reg of existing.recentIpRegistrations) {
					relatedUserIds.add(reg.userId);
				}

				log.warn(
					{
						userId: context.userId,
						ipAddress: input.ipAddress,
						registrationCount: recentCount,
					},
					"[DuplicateAccountService] Suspicious IP registration pattern detected",
				);
			}
		}

		// 3. Check name similarity
		if (input.name && existing.similarNames.length > 0) {
			for (const match of existing.similarNames) {
				if (match.similarity >= cfg.nameSimilarityThreshold) {
					const severity =
						DuplicateAccountService.calculateNameSimilaritySeverity(
							match.similarity,
						);

					signals.push({
						type: "DUPLICATE_NAME_SIMILARITY",
						severity,
						confidence: Math.round(match.similarity * 100),
						metadata: {
							inputName: input.name,
							matchedName: match.name,
							matchedUserId: match.userId,
							similarity: match.similarity,
							threshold: cfg.nameSimilarityThreshold,
						},
					});
					relatedUserIds.add(match.userId);

					log.warn(
						{
							userId: context.userId,
							matchedUserId: match.userId,
							similarity: match.similarity,
						},
						"[DuplicateAccountService] Similar name detected",
					);
				}
			}
		}

		const hasDuplicates = signals.length > 0;
		const shouldFlag = signals.some(
			(s) => s.severity === "HIGH" || s.severity === "CRITICAL",
		);

		return {
			hasDuplicates,
			signals,
			shouldFlag,
			relatedUserIds: Array.from(relatedUserIds),
		};
	}

	/**
	 * Calculate Levenshtein distance-based similarity between two strings
	 * Returns a value between 0 and 1 (1 = identical)
	 */
	static calculateNameSimilarity(name1: string, name2: string): number {
		const s1 = name1.toLowerCase().trim();
		const s2 = name2.toLowerCase().trim();

		if (s1 === s2) return 1;
		if (s1.length === 0 || s2.length === 0) return 0;

		const len1 = s1.length;
		const len2 = s2.length;
		const maxLen = Math.max(len1, len2);

		// Create matrix for Levenshtein distance
		const matrix: number[][] = [];
		for (let i = 0; i <= len1; i++) {
			matrix[i] = [i];
		}
		for (let j = 0; j <= len2; j++) {
			matrix[0][j] = j;
		}

		for (let i = 1; i <= len1; i++) {
			for (let j = 1; j <= len2; j++) {
				const cost = s1[i - 1] === s2[j - 1] ? 0 : 1;
				matrix[i][j] = Math.min(
					matrix[i - 1][j] + 1, // deletion
					matrix[i][j - 1] + 1, // insertion
					matrix[i - 1][j - 1] + cost, // substitution
				);
			}
		}

		const distance = matrix[len1][len2];
		return 1 - distance / maxLen;
	}

	/**
	 * Find similar names from a list of existing names
	 */
	static findSimilarNames(
		inputName: string,
		existingUsers: Array<{ userId: string; name: string }>,
		threshold = 0.85,
	): Array<{ userId: string; name: string; similarity: number }> {
		const results: Array<{ userId: string; name: string; similarity: number }> =
			[];

		for (const user of existingUsers) {
			const similarity = DuplicateAccountService.calculateNameSimilarity(
				inputName,
				user.name,
			);
			if (similarity >= threshold) {
				results.push({
					userId: user.userId,
					name: user.name,
					similarity: Math.round(similarity * 100) / 100,
				});
			}
		}

		// Sort by similarity descending
		return results.sort((a, b) => b.similarity - a.similarity);
	}

	/**
	 * Calculate severity based on IP registration count
	 */
	private static calculateIpSeverity(
		count: number,
		maxAllowed: number,
	): FraudSeverity {
		const ratio = count / maxAllowed;
		if (ratio >= 5) return "CRITICAL";
		if (ratio >= 3) return "HIGH";
		if (ratio >= 2) return "MEDIUM";
		return "LOW";
	}

	/**
	 * Calculate severity based on name similarity
	 */
	private static calculateNameSimilaritySeverity(
		similarity: number,
	): FraudSeverity {
		if (similarity >= 0.98) return "HIGH";
		if (similarity >= 0.95) return "MEDIUM";
		return "LOW";
	}

	/**
	 * Mask bank account number for logging (show last 4 digits only)
	 */
	private static maskBankAccount(accountNumber: string): string {
		if (accountNumber.length <= 4) return "****";
		return "*".repeat(accountNumber.length - 4) + accountNumber.slice(-4);
	}

	/**
	 * Calculate fraud score from signals
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

		const score = totalWeight > 0 ? weightedScore / totalWeight : 0;
		return Math.min(Math.round(score * 100) / 100, 100);
	}
}
