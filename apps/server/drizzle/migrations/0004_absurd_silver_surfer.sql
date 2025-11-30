CREATE TYPE "public"."am_merchant_category" AS ENUM('ATK', 'Printing', 'Food');--> statement-breakpoint
ALTER TABLE "am_merchants" ADD COLUMN "category" "am_merchant_category" NOT NULL;