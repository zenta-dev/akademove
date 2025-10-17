CREATE TYPE "public"."merchant_type" AS ENUM('merchant', 'tenant');--> statement-breakpoint
CREATE TABLE "merchants" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"user_id" text NOT NULL,
	"type" "merchant_type" NOT NULL,
	"name" text NOT NULL,
	"email" text NOT NULL,
	"phone" text NOT NULL,
	"address" text NOT NULL,
	"location" jsonb,
	"bank" jsonb NOT NULL,
	"is_active" boolean DEFAULT true NOT NULL,
	"rating" numeric(2, 1) DEFAULT 0 NOT NULL,
	"document" text,
	"created_at" timestamp DEFAULT now() NOT NULL,
	"updated_at" timestamp DEFAULT now() NOT NULL,
	CONSTRAINT "merchants_email_unique" UNIQUE("email"),
	CONSTRAINT "merchants_phone_unique" UNIQUE("phone")
);
--> statement-breakpoint
CREATE TABLE "merchant_menus" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"merchantId" uuid NOT NULL,
	"name" varchar(255) NOT NULL,
	"category" varchar(255),
	"base_price" numeric(10, 2) NOT NULL,
	"stock" integer NOT NULL,
	"image" text,
	"created_at" timestamp DEFAULT now() NOT NULL,
	"updated_at" timestamp DEFAULT now() NOT NULL
);
--> statement-breakpoint
ALTER TABLE "merchants" ADD CONSTRAINT "merchants_user_id_users_id_fk" FOREIGN KEY ("user_id") REFERENCES "public"."users"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "merchant_menus" ADD CONSTRAINT "merchant_menus_merchantId_merchants_id_fk" FOREIGN KEY ("merchantId") REFERENCES "public"."merchants"("id") ON DELETE cascade ON UPDATE no action;