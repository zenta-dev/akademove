CREATE TYPE "public"."am_contact_status" AS ENUM('PENDING', 'REVIEWING', 'RESOLVED', 'CLOSED');--> statement-breakpoint
ALTER TYPE "public"."am_allowed_logged_table" ADD VALUE 'contact' BEFORE 'coupon';--> statement-breakpoint
CREATE TABLE "am_contacts" (
	"id" uuid PRIMARY KEY NOT NULL,
	"name" varchar(255) NOT NULL,
	"email" varchar(255) NOT NULL,
	"subject" varchar(500) NOT NULL,
	"message" text NOT NULL,
	"status" "am_contact_status" DEFAULT 'PENDING' NOT NULL,
	"user_id" text,
	"responded_by_id" text,
	"response" text,
	"created_at" timestamp NOT NULL,
	"updated_at" timestamp NOT NULL,
	"responded_at" timestamp
);
--> statement-breakpoint
CREATE TABLE "am___contact_audit_log" (
	"id" serial PRIMARY KEY NOT NULL,
	"table_name" "am_allowed_logged_table" NOT NULL,
	"record_id" text NOT NULL,
	"operation" "am_operation" NOT NULL,
	"old_data" jsonb,
	"new_data" jsonb,
	"updated_by_id" text,
	"updated_at" timestamp NOT NULL
);
--> statement-breakpoint
ALTER TABLE "am_coupons" ADD COLUMN "merchant_id" uuid;--> statement-breakpoint
ALTER TABLE "am_contacts" ADD CONSTRAINT "am_contacts_user_id_am_users_id_fk" FOREIGN KEY ("user_id") REFERENCES "public"."am_users"("id") ON DELETE set null ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "am_contacts" ADD CONSTRAINT "am_contacts_responded_by_id_am_users_id_fk" FOREIGN KEY ("responded_by_id") REFERENCES "public"."am_users"("id") ON DELETE set null ON UPDATE no action;--> statement-breakpoint
CREATE INDEX "am_contact_email_idx" ON "am_contacts" USING btree ("email");--> statement-breakpoint
CREATE INDEX "am_contact_user_id_idx" ON "am_contacts" USING btree ("user_id");--> statement-breakpoint
CREATE INDEX "am_contact_status_idx" ON "am_contacts" USING btree ("status");--> statement-breakpoint
CREATE INDEX "am_contact_responded_by_id_idx" ON "am_contacts" USING btree ("responded_by_id");--> statement-breakpoint
CREATE INDEX "am_contact_created_at_idx" ON "am_contacts" USING btree ("created_at");--> statement-breakpoint
CREATE INDEX "am_contact_status_created_at_idx" ON "am_contacts" USING btree ("status","created_at");--> statement-breakpoint
CREATE INDEX "am_contact_user_status_idx" ON "am_contacts" USING btree ("user_id","status");--> statement-breakpoint
CREATE INDEX "am_contact_audit_record_idx" ON "am___contact_audit_log" USING btree ("record_id");--> statement-breakpoint
CREATE INDEX "am_contact_audit_updated_at_idx" ON "am___contact_audit_log" USING btree ("updated_at");--> statement-breakpoint
ALTER TABLE "am_coupons" ADD CONSTRAINT "am_coupons_merchant_id_am_merchants_id_fk" FOREIGN KEY ("merchant_id") REFERENCES "public"."am_merchants"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
CREATE INDEX "am_coupon_merchant_id_idx" ON "am_coupons" USING btree ("merchant_id");