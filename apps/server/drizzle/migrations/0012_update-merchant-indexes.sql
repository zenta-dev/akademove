ALTER TABLE "merchants" ALTER COLUMN "phone" SET DATA TYPE jsonb;--> statement-breakpoint
CREATE UNIQUE INDEX "merchant_user_id_idx" ON "merchants" USING btree ("user_id");--> statement-breakpoint
CREATE UNIQUE INDEX "merchant_email_idx" ON "merchants" USING btree ("email");--> statement-breakpoint
CREATE UNIQUE INDEX "merchant_phone_idx" ON "merchants" USING btree ("phone");--> statement-breakpoint
CREATE INDEX "merchant_type_idx" ON "merchants" USING btree ("type");--> statement-breakpoint
CREATE INDEX "merchant_is_active_idx" ON "merchants" USING btree ("is_active");--> statement-breakpoint
CREATE INDEX "merchant_rating_idx" ON "merchants" USING btree ("rating");--> statement-breakpoint
CREATE INDEX "merchant_type_active_idx" ON "merchants" USING btree ("type","is_active");--> statement-breakpoint
CREATE INDEX "merchant_created_at_idx" ON "merchants" USING btree ("created_at");--> statement-breakpoint
CREATE INDEX "merchant_menu_merchant_id_idx" ON "merchant_menus" USING btree ("merchantId");--> statement-breakpoint
CREATE INDEX "merchant_menu_category_idx" ON "merchant_menus" USING btree ("category");--> statement-breakpoint
CREATE INDEX "merchant_menu_stock_idx" ON "merchant_menus" USING btree ("stock");--> statement-breakpoint
CREATE INDEX "merchant_menu_merchant_category_idx" ON "merchant_menus" USING btree ("merchantId","category");--> statement-breakpoint
CREATE INDEX "merchant_menu_price_idx" ON "merchant_menus" USING btree ("base_price");--> statement-breakpoint
CREATE INDEX "merchant_menu_created_at_idx" ON "merchant_menus" USING btree ("created_at");--> statement-breakpoint
ALTER TABLE "merchants" ADD CONSTRAINT "merchants_user_id_unique" UNIQUE("user_id");