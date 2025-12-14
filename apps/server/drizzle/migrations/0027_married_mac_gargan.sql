CREATE TABLE "am_emergency_contacts" (
	"id" uuid PRIMARY KEY NOT NULL,
	"name" text NOT NULL,
	"phone" text NOT NULL,
	"description" text,
	"is_active" boolean DEFAULT true NOT NULL,
	"priority" integer DEFAULT 0 NOT NULL,
	"created_at" timestamp NOT NULL,
	"updated_at" timestamp NOT NULL,
	"created_by_id" text,
	"updated_by_id" text
);
--> statement-breakpoint
-- Convert category (enum) to categories (jsonb array)
-- First, add a temp column with jsonb type
ALTER TABLE "am_reviews" ADD COLUMN "categories_temp" jsonb DEFAULT '[]'::jsonb;--> statement-breakpoint
-- Migrate existing data: convert single enum value to jsonb array
UPDATE "am_reviews" SET "categories_temp" = jsonb_build_array("category"::text) WHERE "category" IS NOT NULL;--> statement-breakpoint
-- Drop the old enum column
ALTER TABLE "am_reviews" DROP COLUMN "category";--> statement-breakpoint
-- Rename temp column to categories
ALTER TABLE "am_reviews" RENAME COLUMN "categories_temp" TO "categories";--> statement-breakpoint
-- Set NOT NULL constraint and default
ALTER TABLE "am_reviews" ALTER COLUMN "categories" SET NOT NULL;--> statement-breakpoint
ALTER TABLE "am_reviews" ALTER COLUMN "categories" SET DEFAULT '[]'::jsonb;--> statement-breakpoint
DROP INDEX IF EXISTS "am_review_category_idx";--> statement-breakpoint
DROP INDEX IF EXISTS "am_review_to_user_category_idx";--> statement-breakpoint
ALTER TABLE "am_orders" ADD COLUMN "completed_driver_id" uuid;--> statement-breakpoint
ALTER TABLE "am_orders" ADD COLUMN "delivery_item_photo_url" text;--> statement-breakpoint
ALTER TABLE "am_emergency_contacts" ADD CONSTRAINT "am_emergency_contacts_created_by_id_am_users_id_fk" FOREIGN KEY ("created_by_id") REFERENCES "public"."am_users"("id") ON DELETE set null ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "am_emergency_contacts" ADD CONSTRAINT "am_emergency_contacts_updated_by_id_am_users_id_fk" FOREIGN KEY ("updated_by_id") REFERENCES "public"."am_users"("id") ON DELETE set null ON UPDATE no action;--> statement-breakpoint
CREATE INDEX "am_emergency_contact_is_active_idx" ON "am_emergency_contacts" USING btree ("is_active");--> statement-breakpoint
CREATE INDEX "am_emergency_contact_priority_idx" ON "am_emergency_contacts" USING btree ("priority");--> statement-breakpoint
CREATE INDEX "am_emergency_contact_created_at_idx" ON "am_emergency_contacts" USING btree ("created_at");--> statement-breakpoint
ALTER TABLE "am_orders" ADD CONSTRAINT "am_orders_completed_driver_id_am_drivers_id_fk" FOREIGN KEY ("completed_driver_id") REFERENCES "public"."am_drivers"("id") ON DELETE set null ON UPDATE no action;--> statement-breakpoint
CREATE INDEX "am_order_completed_driver_id_idx" ON "am_orders" USING btree ("completed_driver_id");