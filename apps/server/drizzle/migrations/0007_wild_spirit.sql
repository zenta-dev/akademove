ALTER TABLE "am_orders" ADD COLUMN "proof_of_delivery_url" text;--> statement-breakpoint
ALTER TABLE "am_orders" ADD COLUMN "delivery_otp" text;--> statement-breakpoint
ALTER TABLE "am_orders" ADD COLUMN "otp_verified_at" timestamp;