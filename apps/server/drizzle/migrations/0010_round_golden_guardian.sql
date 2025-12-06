CREATE TYPE "public"."am_account_deletion_reason" AS ENUM('NO_LONGER_NEEDED', 'PRIVACY_CONCERNS', 'SWITCHING_SERVICE', 'TOO_MANY_NOTIFICATIONS', 'DIFFICULT_TO_USE', 'POOR_EXPERIENCE', 'OTHER');--> statement-breakpoint
CREATE TYPE "public"."am_account_deletion_status" AS ENUM('PENDING', 'REVIEWING', 'APPROVED', 'REJECTED', 'COMPLETED');--> statement-breakpoint
CREATE TYPE "public"."am_account_type" AS ENUM('USER', 'DRIVER', 'MERCHANT');--> statement-breakpoint
ALTER TYPE "public"."am_allowed_logged_table" ADD VALUE 'account_deletion' BEFORE 'configurations';--> statement-breakpoint
CREATE TABLE "am_account_deletions" (
	"id" uuid PRIMARY KEY NOT NULL,
	"full_name" varchar(255) NOT NULL,
	"email" varchar(255) NOT NULL,
	"phone" varchar(50) NOT NULL,
	"account_type" "am_account_type" NOT NULL,
	"reason" "am_account_deletion_reason" NOT NULL,
	"additional_info" text,
	"status" "am_account_deletion_status" DEFAULT 'PENDING' NOT NULL,
	"user_id" text,
	"reviewed_by_id" text,
	"review_notes" text,
	"created_at" timestamp NOT NULL,
	"updated_at" timestamp NOT NULL,
	"reviewed_at" timestamp,
	"completed_at" timestamp
);
--> statement-breakpoint
CREATE TABLE "am___account_deletion_audit_log" (
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
ALTER TABLE "am_account_deletions" ADD CONSTRAINT "am_account_deletions_user_id_am_users_id_fk" FOREIGN KEY ("user_id") REFERENCES "public"."am_users"("id") ON DELETE set null ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "am_account_deletions" ADD CONSTRAINT "am_account_deletions_reviewed_by_id_am_users_id_fk" FOREIGN KEY ("reviewed_by_id") REFERENCES "public"."am_users"("id") ON DELETE set null ON UPDATE no action;--> statement-breakpoint
CREATE INDEX "am_account_deletion_email_idx" ON "am_account_deletions" USING btree ("email");--> statement-breakpoint
CREATE INDEX "am_account_deletion_phone_idx" ON "am_account_deletions" USING btree ("phone");--> statement-breakpoint
CREATE INDEX "am_account_deletion_user_id_idx" ON "am_account_deletions" USING btree ("user_id");--> statement-breakpoint
CREATE INDEX "am_account_deletion_status_idx" ON "am_account_deletions" USING btree ("status");--> statement-breakpoint
CREATE INDEX "am_account_deletion_reviewed_by_id_idx" ON "am_account_deletions" USING btree ("reviewed_by_id");--> statement-breakpoint
CREATE INDEX "am_account_deletion_created_at_idx" ON "am_account_deletions" USING btree ("created_at");--> statement-breakpoint
CREATE INDEX "am_account_deletion_status_created_at_idx" ON "am_account_deletions" USING btree ("status","created_at");--> statement-breakpoint
CREATE INDEX "am_account_deletion_user_status_idx" ON "am_account_deletions" USING btree ("user_id","status");--> statement-breakpoint
CREATE INDEX "am_account_deletion_audit_record_idx" ON "am___account_deletion_audit_log" USING btree ("record_id");--> statement-breakpoint
CREATE INDEX "am_account_deletion_audit_updated_at_idx" ON "am___account_deletion_audit_log" USING btree ("updated_at");--> statement-breakpoint
CREATE INDEX "am_account_deletion_audit_updated_by_idx" ON "am___account_deletion_audit_log" USING btree ("updated_by_id");--> statement-breakpoint
CREATE INDEX "am_account_deletion_audit_ip_address_idx" ON "am___account_deletion_audit_log" USING btree ("ip_address");