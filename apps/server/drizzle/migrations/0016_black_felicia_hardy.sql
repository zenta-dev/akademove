CREATE TYPE "public"."am_approval_document_status" AS ENUM('PENDING', 'APPROVED', 'REJECTED');--> statement-breakpoint
CREATE TYPE "public"."am_driver_approval_status" AS ENUM('PENDING', 'APPROVED', 'REJECTED');--> statement-breakpoint
ALTER TYPE "public"."am_allowed_logged_table" ADD VALUE 'driver_approval_review' BEFORE 'newsletter';--> statement-breakpoint
CREATE TABLE "am_driver_approval_reviews" (
	"id" uuid PRIMARY KEY NOT NULL,
	"driver_id" uuid NOT NULL,
	"status" "am_driver_approval_status" DEFAULT 'PENDING' NOT NULL,
	"student_card_status" "am_approval_document_status" DEFAULT 'PENDING' NOT NULL,
	"student_card_reason" text,
	"driver_license_status" "am_approval_document_status" DEFAULT 'PENDING' NOT NULL,
	"driver_license_reason" text,
	"vehicle_registration_status" "am_approval_document_status" DEFAULT 'PENDING' NOT NULL,
	"vehicle_registration_reason" text,
	"quiz_verified" boolean DEFAULT false NOT NULL,
	"quiz_reviewed_at" timestamp,
	"reviewed_by_id" text,
	"reviewed_at" timestamp,
	"review_notes" text,
	"created_at" timestamp NOT NULL,
	"updated_at" timestamp NOT NULL
);
--> statement-breakpoint
CREATE TABLE "am___driver_approval_review_audit_log" (
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
ALTER TABLE "am_driver_approval_reviews" ADD CONSTRAINT "am_driver_approval_reviews_driver_id_am_drivers_id_fk" FOREIGN KEY ("driver_id") REFERENCES "public"."am_drivers"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "am_driver_approval_reviews" ADD CONSTRAINT "am_driver_approval_reviews_reviewed_by_id_am_users_id_fk" FOREIGN KEY ("reviewed_by_id") REFERENCES "public"."am_users"("id") ON DELETE set null ON UPDATE no action;--> statement-breakpoint
CREATE INDEX "am_driver_approval_driver_id_idx" ON "am_driver_approval_reviews" USING btree ("driver_id");--> statement-breakpoint
CREATE INDEX "am_driver_approval_status_idx" ON "am_driver_approval_reviews" USING btree ("status");--> statement-breakpoint
CREATE INDEX "am_driver_approval_reviewed_by_idx" ON "am_driver_approval_reviews" USING btree ("reviewed_by_id");--> statement-breakpoint
CREATE INDEX "am_driver_approval_reviewed_at_idx" ON "am_driver_approval_reviews" USING btree ("reviewed_at");--> statement-breakpoint
CREATE INDEX "am_driver_approval_driver_status_idx" ON "am_driver_approval_reviews" USING btree ("driver_id","status");--> statement-breakpoint
CREATE INDEX "am_driver_approval_review_audit_record_idx" ON "am___driver_approval_review_audit_log" USING btree ("record_id");--> statement-breakpoint
CREATE INDEX "am_driver_approval_review_audit_updated_at_idx" ON "am___driver_approval_review_audit_log" USING btree ("updated_at");--> statement-breakpoint
CREATE INDEX "am_driver_approval_review_audit_updated_by_idx" ON "am___driver_approval_review_audit_log" USING btree ("updated_by_id");--> statement-breakpoint
CREATE INDEX "am_driver_approval_review_audit_ip_address_idx" ON "am___driver_approval_review_audit_log" USING btree ("ip_address");