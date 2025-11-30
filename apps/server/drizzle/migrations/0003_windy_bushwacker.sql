CREATE INDEX "am_user_name_text_idx" ON "am_users" USING btree ("name" text_pattern_ops);--> statement-breakpoint
CREATE INDEX "am_user_role_idx" ON "am_users" USING btree ("role");--> statement-breakpoint
CREATE INDEX "am_merchant_name_text_idx" ON "am_merchants" USING btree ("name" text_pattern_ops);--> statement-breakpoint
CREATE INDEX "am_order_status_idx" ON "am_orders" USING btree ("status");--> statement-breakpoint
CREATE INDEX "am_order_user_status_idx" ON "am_orders" USING btree ("user_id","status");--> statement-breakpoint
CREATE INDEX "am_order_driver_status_idx" ON "am_orders" USING btree ("driver_id","status");--> statement-breakpoint
CREATE INDEX "am_order_merchant_status_idx" ON "am_orders" USING btree ("merchant_id","status");--> statement-breakpoint
CREATE INDEX "am_order_created_at_idx" ON "am_orders" USING btree ("created_at");--> statement-breakpoint
CREATE INDEX "am_order_requested_at_idx" ON "am_orders" USING btree ("requested_at");--> statement-breakpoint
CREATE INDEX "am_order_type_idx" ON "am_orders" USING btree ("type");--> statement-breakpoint
CREATE INDEX "am_order_id_created_at_idx" ON "am_orders" USING btree ("id","created_at");