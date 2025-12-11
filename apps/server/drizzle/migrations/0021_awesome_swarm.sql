DROP INDEX "am_merchant_is_taking_orders_idx";--> statement-breakpoint
DROP INDEX "am_merchant_online_taking_orders_idx";--> statement-breakpoint
ALTER TABLE "am_merchants" ADD COLUMN "active_order_count" integer DEFAULT 0 NOT NULL;--> statement-breakpoint
CREATE INDEX "am_driver_matching_idx" ON "am_drivers" USING btree ("status","quiz_status","is_online","is_taking_order");--> statement-breakpoint
CREATE INDEX "am_merchant_active_order_count_idx" ON "am_merchants" USING btree ("active_order_count");--> statement-breakpoint
ALTER TABLE "am_merchants" DROP COLUMN "is_taking_orders";