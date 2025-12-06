ALTER TYPE "public"."am_allowed_logged_table" ADD VALUE 'user';--> statement-breakpoint
ALTER TYPE "public"."am_allowed_logged_table" ADD VALUE 'wallet';--> statement-breakpoint
CREATE TABLE "am___user_audit_log" (
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
CREATE TABLE "am___wallet_audit_log" (
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
CREATE INDEX "am_user_audit_record_idx" ON "am___user_audit_log" USING btree ("record_id");--> statement-breakpoint
CREATE INDEX "am_user_audit_updated_at_idx" ON "am___user_audit_log" USING btree ("updated_at");--> statement-breakpoint
CREATE INDEX "am_user_audit_updated_by_idx" ON "am___user_audit_log" USING btree ("updated_by_id");--> statement-breakpoint
CREATE INDEX "am_user_audit_ip_address_idx" ON "am___user_audit_log" USING btree ("ip_address");--> statement-breakpoint
CREATE INDEX "am_wallet_audit_record_idx" ON "am___wallet_audit_log" USING btree ("record_id");--> statement-breakpoint
CREATE INDEX "am_wallet_audit_updated_at_idx" ON "am___wallet_audit_log" USING btree ("updated_at");--> statement-breakpoint
CREATE INDEX "am_wallet_audit_updated_by_idx" ON "am___wallet_audit_log" USING btree ("updated_by_id");--> statement-breakpoint
CREATE INDEX "am_wallet_audit_ip_address_idx" ON "am___wallet_audit_log" USING btree ("ip_address");