-- Analytics Performance Indexes for Dashboard Queries
-- Created for comprehensive analytics and reporting feature

-- Composite index for driver earnings analytics (driver_id + requested_at + status)
-- Optimizes: "SELECT ... WHERE driver_id = ? AND requested_at BETWEEN ? AND ? AND status = 'COMPLETED'"
CREATE INDEX IF NOT EXISTS "am_order_driver_requested_status_idx" 
  ON "am_orders" USING btree ("driver_id", "requested_at", "status");
--> statement-breakpoint

-- Composite index for merchant analytics (merchant_id + requested_at + status)
-- Optimizes: "SELECT ... WHERE merchant_id = ? AND requested_at BETWEEN ? AND ? AND status = 'COMPLETED'"
CREATE INDEX IF NOT EXISTS "am_order_merchant_requested_status_idx" 
  ON "am_orders" USING btree ("merchant_id", "requested_at", "status");
--> statement-breakpoint

-- Composite index for platform-wide analytics (type + status + requested_at)
-- Optimizes: "SELECT ... WHERE type = ? AND status = ? AND requested_at BETWEEN ? AND ?"
CREATE INDEX IF NOT EXISTS "am_order_type_status_requested_idx" 
  ON "am_orders" USING btree ("type", "status", "requested_at");
--> statement-breakpoint

-- Composite index for transaction analytics (wallet_id + created_at + type)
-- Optimizes: wallet monthly summaries and earning/expense breakdowns
CREATE INDEX IF NOT EXISTS "am_transaction_wallet_created_type_idx" 
  ON "am_transactions" USING btree ("wallet_id", "created_at", "type");
--> statement-breakpoint

-- Index for driver performance ranking (rating DESC)
-- Optimizes: leaderboard and top performer queries
CREATE INDEX IF NOT EXISTS "am_driver_rating_desc_idx" 
  ON "am_drivers" USING btree ("rating" DESC NULLS LAST);
--> statement-breakpoint

-- Composite index for driver online status analytics
-- Optimizes: active driver count queries
CREATE INDEX IF NOT EXISTS "am_driver_status_online_idx" 
  ON "am_drivers" USING btree ("status", "is_online");
--> statement-breakpoint

-- Index for user creation date (for growth analytics)
CREATE INDEX IF NOT EXISTS "am_user_created_at_idx" 
  ON "am_users" USING btree ("created_at");
--> statement-breakpoint

-- Composite index for completed orders by date (for revenue analytics)
-- Covers most common analytics query pattern
CREATE INDEX IF NOT EXISTS "am_order_status_completed_requested_idx" 
  ON "am_orders" USING btree ("status", "requested_at") 
  WHERE "status" = 'COMPLETED';
