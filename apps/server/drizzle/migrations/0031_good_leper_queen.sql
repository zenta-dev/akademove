CREATE INDEX "am_merchant_category_idx" ON "am_merchants" USING btree ("category");--> statement-breakpoint
CREATE INDEX "am_merchant_categories_idx" ON "am_merchants" USING gin ("categories");