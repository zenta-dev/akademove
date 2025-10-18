DROP INDEX "merchant_type_idx";--> statement-breakpoint
DROP INDEX "merchant_type_active_idx";--> statement-breakpoint
ALTER TABLE "users" ALTER COLUMN "gender" DROP NOT NULL;--> statement-breakpoint
ALTER TABLE "merchants" DROP COLUMN "type";--> statement-breakpoint
DROP TYPE "public"."merchant_type";