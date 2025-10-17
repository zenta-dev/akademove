CREATE UNIQUE INDEX "coupon_code_idx" ON "coupons" USING btree ("code");--> statement-breakpoint
CREATE INDEX "coupon_is_active_idx" ON "coupons" USING btree ("is_active");--> statement-breakpoint
CREATE INDEX "coupon_period_start_idx" ON "coupons" USING btree ("period_start");--> statement-breakpoint
CREATE INDEX "coupon_period_end_idx" ON "coupons" USING btree ("period_end");--> statement-breakpoint
CREATE INDEX "coupon_active_period_idx" ON "coupons" USING btree ("is_active","period_start","period_end");--> statement-breakpoint
CREATE INDEX "coupon_created_by_id_idx" ON "coupons" USING btree ("created_by_id");--> statement-breakpoint
CREATE INDEX "coupon_used_count_idx" ON "coupons" USING btree ("used_count");--> statement-breakpoint
CREATE INDEX "coupon_created_at_idx" ON "coupons" USING btree ("created_at");--> statement-breakpoint
CREATE INDEX "coupon_usage_order_idx" ON "coupon_usages" USING btree ("order_id");--> statement-breakpoint
CREATE INDEX "coupon_usage_coupon_id_idx" ON "coupon_usages" USING btree ("coupon_id");--> statement-breakpoint
CREATE INDEX "coupon_usage_user_id_idx" ON "coupon_usages" USING btree ("user_id");--> statement-breakpoint
CREATE INDEX "coupon_usage_coupon_user_idx" ON "coupon_usages" USING btree ("coupon_id","user_id");--> statement-breakpoint
CREATE INDEX "coupon_usage_used_at_idx" ON "coupon_usages" USING btree ("used_at");--> statement-breakpoint
CREATE INDEX "coupon_usage_user_used_at_idx" ON "coupon_usages" USING btree ("user_id","used_at");