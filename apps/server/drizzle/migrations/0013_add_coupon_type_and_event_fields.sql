-- Add coupon_type column with default 'GENERAL'
ALTER TABLE "coupons" ADD COLUMN IF NOT EXISTS "coupon_type" text NOT NULL DEFAULT 'GENERAL';

-- Add event-specific fields for EVENT type coupons
ALTER TABLE "coupons" ADD COLUMN IF NOT EXISTS "event_name" text;
ALTER TABLE "coupons" ADD COLUMN IF NOT EXISTS "event_description" text;

-- Add indexes for efficient querying by coupon type
CREATE INDEX IF NOT EXISTS "coupon_type_idx" ON "coupons" ("coupon_type");
CREATE INDEX IF NOT EXISTS "coupon_type_active_idx" ON "coupons" ("coupon_type", "is_active");
