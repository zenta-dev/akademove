CREATE INDEX "order_user_id_idx" ON "orders" USING btree ("user_id");--> statement-breakpoint
CREATE INDEX "order_driver_id_idx" ON "orders" USING btree ("driver_id");--> statement-breakpoint
CREATE INDEX "order_merchant_id_idx" ON "orders" USING btree ("merchant_id");--> statement-breakpoint
CREATE INDEX "order_type_idx" ON "orders" USING btree ("type");--> statement-breakpoint
CREATE INDEX "order_status_idx" ON "orders" USING btree ("status");--> statement-breakpoint
CREATE INDEX "order_status_driver_idx" ON "orders" USING btree ("status","driver_id");--> statement-breakpoint
CREATE INDEX "order_user_status_idx" ON "orders" USING btree ("user_id","status");--> statement-breakpoint
CREATE INDEX "order_driver_status_idx" ON "orders" USING btree ("driver_id","status");--> statement-breakpoint
CREATE INDEX "order_merchant_status_idx" ON "orders" USING btree ("merchant_id","status");--> statement-breakpoint
CREATE INDEX "order_type_status_idx" ON "orders" USING btree ("type","status");--> statement-breakpoint
CREATE INDEX "order_requested_at_idx" ON "orders" USING btree ("requested_at");--> statement-breakpoint
CREATE INDEX "order_created_at_idx" ON "orders" USING btree ("created_at");--> statement-breakpoint
CREATE INDEX "order_status_requested_at_idx" ON "orders" USING btree ("status","requested_at");