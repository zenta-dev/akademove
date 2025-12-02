ALTER TABLE "am_orders" ADD COLUMN "coupon_id" uuid;--> statement-breakpoint
ALTER TABLE "am_orders" ADD COLUMN "coupon_code" text;--> statement-breakpoint
ALTER TABLE "am_orders" ADD COLUMN "discount_amount" numeric(18, 2);--> statement-breakpoint
CREATE INDEX "am_order_coupon_id_idx" ON "am_orders" USING btree ("coupon_id");