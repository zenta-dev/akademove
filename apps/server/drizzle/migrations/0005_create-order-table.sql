CREATE TYPE "public"."order_status" AS ENUM('requested', 'matching', 'accepted', 'arriving', 'in_trip', 'completed', 'cancelled_by_user', 'cancelled_by_driver', 'cancelled_by_system');--> statement-breakpoint
CREATE TYPE "public"."order_type" AS ENUM('ride', 'delivery', 'food');--> statement-breakpoint
CREATE TABLE "orders" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"user_id" text NOT NULL,
	"driver_id" uuid,
	"merchant_id" uuid,
	"type" "order_type" NOT NULL,
	"status" "order_status" DEFAULT 'requested' NOT NULL,
	"pickup_location" jsonb NOT NULL,
	"dropoff_location" jsonb NOT NULL,
	"distance_km" numeric(10, 2) NOT NULL,
	"base_price" numeric(10, 2) NOT NULL,
	"tip" numeric(10, 2),
	"total_price" numeric(10, 2) NOT NULL,
	"note" jsonb,
	"requested_at" timestamp DEFAULT now() NOT NULL,
	"accepted_at" timestamp,
	"arrived_at" timestamp,
	"created_at" timestamp DEFAULT now() NOT NULL,
	"updated_at" timestamp DEFAULT now() NOT NULL
);
--> statement-breakpoint
ALTER TABLE "orders" ADD CONSTRAINT "orders_user_id_users_id_fk" FOREIGN KEY ("user_id") REFERENCES "public"."users"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "orders" ADD CONSTRAINT "orders_driver_id_drivers_id_fk" FOREIGN KEY ("driver_id") REFERENCES "public"."drivers"("id") ON DELETE set null ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "orders" ADD CONSTRAINT "orders_merchant_id_merchants_id_fk" FOREIGN KEY ("merchant_id") REFERENCES "public"."merchants"("id") ON DELETE set null ON UPDATE no action;