ALTER TYPE "public"."am_order_status" ADD VALUE 'SCHEDULED' BEFORE 'REQUESTED';--> statement-breakpoint
ALTER TABLE "am_orders" ADD COLUMN "scheduled_at" timestamp;--> statement-breakpoint
ALTER TABLE "am_orders" ADD COLUMN "scheduled_matching_at" timestamp;--> statement-breakpoint
CREATE INDEX "am_order_scheduled_at_idx" ON "am_orders" USING btree ("scheduled_at");--> statement-breakpoint
CREATE INDEX "am_order_scheduled_status_idx" ON "am_orders" USING btree ("status","scheduled_at");