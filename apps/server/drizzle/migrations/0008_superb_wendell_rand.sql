ALTER TYPE "public"."am_order_status" ADD VALUE 'PREPARING' BEFORE 'ARRIVING';--> statement-breakpoint
ALTER TYPE "public"."am_order_status" ADD VALUE 'READY_FOR_PICKUP' BEFORE 'ARRIVING';--> statement-breakpoint
ALTER TABLE "am_orders" ADD COLUMN "prepared_at" timestamp;--> statement-breakpoint
ALTER TABLE "am_orders" ADD COLUMN "ready_at" timestamp;