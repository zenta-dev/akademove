CREATE TYPE "public"."am_merchant_operating_status" AS ENUM('OPEN', 'CLOSED', 'BREAK', 'MAINTENANCE');--> statement-breakpoint
ALTER TABLE "am_drivers" ALTER COLUMN "student_id" SET DATA TYPE bigint;--> statement-breakpoint
ALTER TABLE "am_merchants" ADD COLUMN "is_online" boolean DEFAULT false NOT NULL;--> statement-breakpoint
ALTER TABLE "am_merchants" ADD COLUMN "is_taking_orders" boolean DEFAULT false NOT NULL;--> statement-breakpoint
ALTER TABLE "am_merchants" ADD COLUMN "operating_status" "am_merchant_operating_status" DEFAULT 'CLOSED' NOT NULL;--> statement-breakpoint
CREATE INDEX "am_merchant_is_online_idx" ON "am_merchants" USING btree ("is_online");--> statement-breakpoint
CREATE INDEX "am_merchant_is_taking_orders_idx" ON "am_merchants" USING btree ("is_taking_orders");--> statement-breakpoint
CREATE INDEX "am_merchant_operating_status_idx" ON "am_merchants" USING btree ("operating_status");--> statement-breakpoint
CREATE INDEX "am_merchant_online_taking_orders_idx" ON "am_merchants" USING btree ("is_online","is_taking_orders");