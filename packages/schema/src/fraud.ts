import * as z from "zod";
import { DateSchema, type SchemaRegistries } from "./common.js";
import {
	FRAUD_EVENT_TYPES,
	FRAUD_SEVERITY_LEVELS,
	FRAUD_STATUSES,
} from "./constants.js";
import { OffsetPaginationQuerySchema } from "./pagination.js";
import { LocationSchema } from "./position.js";

// Zod enums from constants
export const FraudEventTypeSchema = z.enum(FRAUD_EVENT_TYPES);
export const FraudSeveritySchema = z.enum(FRAUD_SEVERITY_LEVELS);
export const FraudStatusSchema = z.enum(FRAUD_STATUSES);

// Types
export type FraudEventType = z.infer<typeof FraudEventTypeSchema>;
export type FraudSeverity = z.infer<typeof FraudSeveritySchema>;
export type FraudStatus = z.infer<typeof FraudStatusSchema>;

// Signal schema (individual fraud indicator)
export const FraudSignalSchema = z.object({
	type: FraudEventTypeSchema,
	severity: FraudSeveritySchema,
	confidence: z.number().min(0).max(100),
	metadata: z.record(z.string(), z.unknown()).optional(),
});
export type FraudSignal = z.infer<typeof FraudSignalSchema>;

// Fraud event schema
export const FraudEventSchema = z.object({
	id: z.uuid(),
	eventType: FraudEventTypeSchema,
	severity: FraudSeveritySchema,
	status: FraudStatusSchema,
	userId: z.string().nullable(),
	driverId: z.uuid().nullable(),

	// Detection details
	signals: z.array(FraudSignalSchema),
	score: z.coerce.number().min(0).max(100),

	// Location context (GPS spoofing)
	location: LocationSchema.nullable(),
	previousLocation: LocationSchema.nullable(),
	distanceKm: z.coerce.number().nullable(),
	timeDeltaSeconds: z.coerce.number().int().nullable(),
	velocityKmh: z.coerce.number().nullable(),

	// Request context
	ipAddress: z.string().nullable(),
	userAgent: z.string().nullable(),

	// Resolution
	handledById: z.string().nullable(),
	resolution: z.string().nullable(),
	actionTaken: z.string().nullable(),

	detectedAt: DateSchema,
	resolvedAt: DateSchema.nullable(),
	createdAt: DateSchema,
	updatedAt: DateSchema,

	// Relations (optional, for populated queries)
	user: z
		.object({
			id: z.string(),
			name: z.string(),
			email: z.string(),
		})
		.optional(),
	driver: z
		.object({
			id: z.uuid(),
			studentId: z.number(),
			licensePlate: z.string(),
		})
		.optional(),
	handledBy: z
		.object({
			id: z.string(),
			name: z.string(),
		})
		.optional(),
});
export type FraudEvent = z.infer<typeof FraudEventSchema>;

export const InsertFraudEventSchema = FraudEventSchema.omit({
	id: true,
	createdAt: true,
	updatedAt: true,
	user: true,
	driver: true,
	handledBy: true,
});
export type InsertFraudEvent = z.infer<typeof InsertFraudEventSchema>;

export const UpdateFraudEventSchema = z.object({
	status: FraudStatusSchema.optional(),
	resolution: z.string().optional(),
	actionTaken: z.string().optional(),
});
export type UpdateFraudEvent = z.infer<typeof UpdateFraudEventSchema>;

// Review fraud event request
export const ReviewFraudEventSchema = z.object({
	status: z.enum(["REVIEWING", "CONFIRMED", "DISMISSED"]),
	resolution: z.string().min(1).max(1000).optional(),
	actionTaken: z.string().min(1).max(500).optional(),
});
export type ReviewFraudEvent = z.infer<typeof ReviewFraudEventSchema>;

// User fraud profile
export const UserFraudProfileSchema = z.object({
	id: z.uuid(),
	userId: z.string(),
	riskScore: z.coerce.number().min(0).max(100),
	totalEvents: z.number().int(),
	confirmedEvents: z.number().int(),
	isHighRisk: z.boolean(),
	knownIps: z.array(z.string()),
	lastEventAt: DateSchema.nullable(),
	createdAt: DateSchema,
	updatedAt: DateSchema,

	// Relations
	user: z
		.object({
			id: z.string(),
			name: z.string(),
			email: z.string(),
			role: z.string(),
		})
		.optional(),
});
export type UserFraudProfile = z.infer<typeof UserFraudProfileSchema>;

export const InsertUserFraudProfileSchema = UserFraudProfileSchema.omit({
	id: true,
	createdAt: true,
	updatedAt: true,
	user: true,
});
export type InsertUserFraudProfile = z.infer<
	typeof InsertUserFraudProfileSchema
>;

// Fraud config schema (stored in configurations table)
export const FraudConfigSchema = z.object({
	gpsMaxVelocityKmh: z.number().default(200),
	gpsTeleportThresholdKm: z.number().default(50),
	gpsMinUpdateIntervalMs: z.number().default(1000),
	duplicateIpWindowHours: z.number().default(24),
	duplicateIpMaxRegistrations: z.number().default(3),
	nameSimilarityThreshold: z.number().min(0).max(1).default(0.85),
	highRiskScoreThreshold: z.number().min(0).max(100).default(70),
});
export type FraudConfig = z.infer<typeof FraudConfigSchema>;

// List query
export const FraudEventListQuerySchema = OffsetPaginationQuerySchema.extend({
	status: FraudStatusSchema.optional(),
	severity: FraudSeveritySchema.optional(),
	eventType: FraudEventTypeSchema.optional(),
	userId: z.string().optional(),
	driverId: z.uuid().optional(),
	startDate: z.coerce.date().optional(),
	endDate: z.coerce.date().optional(),
	sortBy: z.enum(["detectedAt", "severity", "score"]).optional(),
	order: z.enum(["asc", "desc"]).optional(),
});
export type FraudEventListQuery = z.infer<typeof FraudEventListQuerySchema>;

// Trend item schema
export const FraudTrendItemSchema = z.object({
	date: z.string(),
	count: z.number().int(),
});

// Events by severity schema
export const EventsBySeveritySchema = z.object({
	LOW: z.number().int(),
	MEDIUM: z.number().int(),
	HIGH: z.number().int(),
	CRITICAL: z.number().int(),
});

// Stats response
export const FraudStatsSchema = z.object({
	totalEvents: z.number().int(),
	pendingEvents: z.number().int(),
	reviewingEvents: z.number().int(),
	confirmedEvents: z.number().int(),
	dismissedEvents: z.number().int(),
	eventsBySeverity: EventsBySeveritySchema,
	eventsByType: z.record(z.string(), z.number().int()),
	highRiskUsers: z.number().int(),
	recentTrend: z.array(FraudTrendItemSchema),
});
export type FraudStats = z.infer<typeof FraudStatsSchema>;

// Stats query
export const FraudStatsQuerySchema = z.object({
	startDate: z.coerce.date().optional(),
	endDate: z.coerce.date().optional(),
	trendDays: z.coerce.number().int().min(1).max(90).optional(),
});
export type FraudStatsQuery = z.infer<typeof FraudStatsQuerySchema>;

// Location validation result (internal use)
export const LocationValidationResultSchema = z.object({
	isValid: z.boolean(),
	signals: z.array(FraudSignalSchema),
	shouldWarn: z.boolean(),
	highestSeverity: FraudSeveritySchema.nullable(),
});
export type LocationValidationResult = z.infer<
	typeof LocationValidationResultSchema
>;

// Duplicate check result (internal use)
export const DuplicateCheckResultSchema = z.object({
	hasDuplicates: z.boolean(),
	signals: z.array(FraudSignalSchema),
	shouldFlag: z.boolean(),
	relatedUserIds: z.array(z.string()),
});
export type DuplicateCheckResult = z.infer<typeof DuplicateCheckResultSchema>;

// Schema registries for OpenAPI generation
export const FraudSchemaRegistries = {
	FraudEventType: { schema: FraudEventTypeSchema, strategy: "output" },
	FraudSeverity: { schema: FraudSeveritySchema, strategy: "output" },
	FraudStatus: { schema: FraudStatusSchema, strategy: "output" },
	FraudSignal: { schema: FraudSignalSchema, strategy: "output" },
	FraudEvent: { schema: FraudEventSchema, strategy: "output" },
	InsertFraudEvent: { schema: InsertFraudEventSchema, strategy: "input" },
	UpdateFraudEvent: { schema: UpdateFraudEventSchema, strategy: "input" },
	ReviewFraudEvent: { schema: ReviewFraudEventSchema, strategy: "input" },
	UserFraudProfile: { schema: UserFraudProfileSchema, strategy: "output" },
	FraudConfig: { schema: FraudConfigSchema, strategy: "output" },
	FraudEventListQuery: { schema: FraudEventListQuerySchema, strategy: "input" },
	FraudStats: { schema: FraudStatsSchema, strategy: "output" },
	FraudStatsQuery: { schema: FraudStatsQuerySchema, strategy: "input" },
} satisfies SchemaRegistries;
