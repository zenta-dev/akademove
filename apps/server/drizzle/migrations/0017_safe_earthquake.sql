CREATE TYPE "public"."am_fraud_event_type" AS ENUM('GPS_SPOOF_VELOCITY', 'GPS_SPOOF_TELEPORT', 'GPS_SPOOF_MOCK_DETECTED', 'DUPLICATE_BANK_ACCOUNT', 'DUPLICATE_IP_PATTERN', 'DUPLICATE_NAME_SIMILARITY', 'SUSPICIOUS_REGISTRATION');--> statement-breakpoint
CREATE TYPE "public"."am_fraud_severity" AS ENUM('LOW', 'MEDIUM', 'HIGH', 'CRITICAL');--> statement-breakpoint
CREATE TYPE "public"."am_fraud_status" AS ENUM('PENDING', 'REVIEWING', 'CONFIRMED', 'DISMISSED');--> statement-breakpoint
CREATE TYPE "public"."am_merchant_approval_document_status" AS ENUM('PENDING', 'APPROVED', 'REJECTED');--> statement-breakpoint
CREATE TYPE "public"."am_merchant_approval_status" AS ENUM('PENDING', 'APPROVED', 'REJECTED');--> statement-breakpoint
CREATE TYPE "public"."am_merchant_status" AS ENUM('PENDING', 'APPROVED', 'REJECTED', 'ACTIVE', 'INACTIVE', 'SUSPENDED');--> statement-breakpoint
ALTER TYPE "public"."am_allowed_logged_table" ADD VALUE 'fraud_event' BEFORE 'newsletter';--> statement-breakpoint
ALTER TYPE "public"."am_allowed_logged_table" ADD VALUE 'merchant_approval_review' BEFORE 'newsletter';--> statement-breakpoint
CREATE TABLE "am_fraud_events" (
	"id" uuid PRIMARY KEY NOT NULL,
	"event_type" "am_fraud_event_type" NOT NULL,
	"severity" "am_fraud_severity" NOT NULL,
	"status" "am_fraud_status" DEFAULT 'PENDING' NOT NULL,
	"user_id" text,
	"driver_id" uuid,
	"signals" jsonb NOT NULL,
	"score" numeric(5, 2) DEFAULT '0' NOT NULL,
	"location" geometry(point),
	"previous_location" geometry(point),
	"distance_km" numeric(10, 3),
	"time_delta_seconds" integer,
	"velocity_kmh" numeric(10, 2),
	"ip_address" text,
	"user_agent" text,
	"handled_by_id" text,
	"resolution" text,
	"action_taken" text,
	"detected_at" timestamp NOT NULL,
	"resolved_at" timestamp,
	"created_at" timestamp NOT NULL,
	"updated_at" timestamp NOT NULL
);
--> statement-breakpoint
CREATE TABLE "am___fraud_event_audit_log" (
	"id" serial PRIMARY KEY NOT NULL,
	"table_name" "am_allowed_logged_table" NOT NULL,
	"record_id" text NOT NULL,
	"operation" "am_operation" NOT NULL,
	"old_data" jsonb,
	"new_data" jsonb,
	"updated_by_id" text,
	"ip_address" text,
	"user_agent" text,
	"session_id" text,
	"reason" text,
	"updated_at" timestamp NOT NULL
);
--> statement-breakpoint
CREATE TABLE "am_user_fraud_profiles" (
	"id" uuid PRIMARY KEY NOT NULL,
	"user_id" text NOT NULL,
	"risk_score" numeric(5, 2) DEFAULT '0' NOT NULL,
	"total_events" integer DEFAULT 0 NOT NULL,
	"confirmed_events" integer DEFAULT 0 NOT NULL,
	"is_high_risk" boolean DEFAULT false NOT NULL,
	"known_ips" jsonb DEFAULT '[]'::jsonb NOT NULL,
	"last_event_at" timestamp,
	"created_at" timestamp NOT NULL,
	"updated_at" timestamp NOT NULL,
	CONSTRAINT "am_user_fraud_profiles_user_id_unique" UNIQUE("user_id")
);
--> statement-breakpoint
CREATE TABLE "am_merchant_approval_reviews" (
	"id" uuid PRIMARY KEY NOT NULL,
	"merchant_id" uuid NOT NULL,
	"status" "am_merchant_approval_status" DEFAULT 'PENDING' NOT NULL,
	"business_document_status" "am_merchant_approval_document_status" DEFAULT 'PENDING' NOT NULL,
	"business_document_reason" text,
	"reviewed_by_id" text,
	"reviewed_at" timestamp,
	"review_notes" text,
	"created_at" timestamp NOT NULL,
	"updated_at" timestamp NOT NULL
);
--> statement-breakpoint
CREATE TABLE "am___merchant_approval_review_audit_log" (
	"id" serial PRIMARY KEY NOT NULL,
	"table_name" "am_allowed_logged_table" NOT NULL,
	"record_id" text NOT NULL,
	"operation" "am_operation" NOT NULL,
	"old_data" jsonb,
	"new_data" jsonb,
	"updated_by_id" text,
	"ip_address" text,
	"user_agent" text,
	"session_id" text,
	"reason" text,
	"updated_at" timestamp NOT NULL
);
--> statement-breakpoint
ALTER TABLE "am_merchants" ALTER COLUMN "is_active" SET DEFAULT false;--> statement-breakpoint
ALTER TABLE "am_merchants" ADD COLUMN "status" "am_merchant_status" DEFAULT 'PENDING' NOT NULL;--> statement-breakpoint
ALTER TABLE "am_fraud_events" ADD CONSTRAINT "am_fraud_events_user_id_am_users_id_fk" FOREIGN KEY ("user_id") REFERENCES "public"."am_users"("id") ON DELETE set null ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "am_fraud_events" ADD CONSTRAINT "am_fraud_events_driver_id_am_drivers_id_fk" FOREIGN KEY ("driver_id") REFERENCES "public"."am_drivers"("id") ON DELETE set null ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "am_fraud_events" ADD CONSTRAINT "am_fraud_events_handled_by_id_am_users_id_fk" FOREIGN KEY ("handled_by_id") REFERENCES "public"."am_users"("id") ON DELETE set null ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "am_user_fraud_profiles" ADD CONSTRAINT "am_user_fraud_profiles_user_id_am_users_id_fk" FOREIGN KEY ("user_id") REFERENCES "public"."am_users"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "am_merchant_approval_reviews" ADD CONSTRAINT "am_merchant_approval_reviews_merchant_id_am_merchants_id_fk" FOREIGN KEY ("merchant_id") REFERENCES "public"."am_merchants"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "am_merchant_approval_reviews" ADD CONSTRAINT "am_merchant_approval_reviews_reviewed_by_id_am_users_id_fk" FOREIGN KEY ("reviewed_by_id") REFERENCES "public"."am_users"("id") ON DELETE set null ON UPDATE no action;--> statement-breakpoint
CREATE INDEX "am_fraud_event_type_idx" ON "am_fraud_events" USING btree ("event_type");--> statement-breakpoint
CREATE INDEX "am_fraud_event_severity_idx" ON "am_fraud_events" USING btree ("severity");--> statement-breakpoint
CREATE INDEX "am_fraud_event_status_idx" ON "am_fraud_events" USING btree ("status");--> statement-breakpoint
CREATE INDEX "am_fraud_event_user_id_idx" ON "am_fraud_events" USING btree ("user_id");--> statement-breakpoint
CREATE INDEX "am_fraud_event_driver_id_idx" ON "am_fraud_events" USING btree ("driver_id");--> statement-breakpoint
CREATE INDEX "am_fraud_event_detected_at_idx" ON "am_fraud_events" USING btree ("detected_at");--> statement-breakpoint
CREATE INDEX "am_fraud_event_ip_address_idx" ON "am_fraud_events" USING btree ("ip_address");--> statement-breakpoint
CREATE INDEX "am_fraud_event_status_severity_idx" ON "am_fraud_events" USING btree ("status","severity");--> statement-breakpoint
CREATE INDEX "am_fraud_event_created_at_idx" ON "am_fraud_events" USING btree ("created_at");--> statement-breakpoint
CREATE INDEX "am_fraud_event_audit_record_idx" ON "am___fraud_event_audit_log" USING btree ("record_id");--> statement-breakpoint
CREATE INDEX "am_fraud_event_audit_updated_at_idx" ON "am___fraud_event_audit_log" USING btree ("updated_at");--> statement-breakpoint
CREATE INDEX "am_fraud_event_audit_updated_by_idx" ON "am___fraud_event_audit_log" USING btree ("updated_by_id");--> statement-breakpoint
CREATE INDEX "am_fraud_event_audit_ip_address_idx" ON "am___fraud_event_audit_log" USING btree ("ip_address");--> statement-breakpoint
CREATE INDEX "am_fraud_profile_user_id_idx" ON "am_user_fraud_profiles" USING btree ("user_id");--> statement-breakpoint
CREATE INDEX "am_fraud_profile_risk_score_idx" ON "am_user_fraud_profiles" USING btree ("risk_score");--> statement-breakpoint
CREATE INDEX "am_fraud_profile_is_high_risk_idx" ON "am_user_fraud_profiles" USING btree ("is_high_risk");--> statement-breakpoint
CREATE INDEX "am_fraud_profile_last_event_idx" ON "am_user_fraud_profiles" USING btree ("last_event_at");--> statement-breakpoint
CREATE INDEX "am_merchant_approval_merchant_id_idx" ON "am_merchant_approval_reviews" USING btree ("merchant_id");--> statement-breakpoint
CREATE INDEX "am_merchant_approval_status_idx" ON "am_merchant_approval_reviews" USING btree ("status");--> statement-breakpoint
CREATE INDEX "am_merchant_approval_reviewed_by_idx" ON "am_merchant_approval_reviews" USING btree ("reviewed_by_id");--> statement-breakpoint
CREATE INDEX "am_merchant_approval_reviewed_at_idx" ON "am_merchant_approval_reviews" USING btree ("reviewed_at");--> statement-breakpoint
CREATE INDEX "am_merchant_approval_merchant_status_idx" ON "am_merchant_approval_reviews" USING btree ("merchant_id","status");--> statement-breakpoint
CREATE INDEX "am_merchant_approval_review_audit_record_idx" ON "am___merchant_approval_review_audit_log" USING btree ("record_id");--> statement-breakpoint
CREATE INDEX "am_merchant_approval_review_audit_updated_at_idx" ON "am___merchant_approval_review_audit_log" USING btree ("updated_at");--> statement-breakpoint
CREATE INDEX "am_merchant_approval_review_audit_updated_by_idx" ON "am___merchant_approval_review_audit_log" USING btree ("updated_by_id");--> statement-breakpoint
CREATE INDEX "am_merchant_approval_review_audit_ip_address_idx" ON "am___merchant_approval_review_audit_log" USING btree ("ip_address");--> statement-breakpoint
CREATE INDEX "am_merchant_status_idx" ON "am_merchants" USING btree ("status");--> statement-breakpoint
CREATE INDEX "am_merchant_status_active_idx" ON "am_merchants" USING btree ("status","is_active");