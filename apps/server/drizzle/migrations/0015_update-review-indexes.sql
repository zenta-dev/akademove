CREATE UNIQUE INDEX "review_order_from_user_idx" ON "reviews" USING btree ("order_id","from_user_id");--> statement-breakpoint
CREATE INDEX "review_order_id_idx" ON "reviews" USING btree ("order_id");--> statement-breakpoint
CREATE INDEX "review_from_user_id_idx" ON "reviews" USING btree ("from_user_id");--> statement-breakpoint
CREATE INDEX "review_to_user_id_idx" ON "reviews" USING btree ("to_user_id");--> statement-breakpoint
CREATE INDEX "review_category_idx" ON "reviews" USING btree ("category");--> statement-breakpoint
CREATE INDEX "review_score_idx" ON "reviews" USING btree ("score");--> statement-breakpoint
CREATE INDEX "review_to_user_score_idx" ON "reviews" USING btree ("to_user_id","score");--> statement-breakpoint
CREATE INDEX "review_to_user_category_idx" ON "reviews" USING btree ("to_user_id","category");--> statement-breakpoint
CREATE INDEX "review_created_at_idx" ON "reviews" USING btree ("created_at");--> statement-breakpoint
CREATE INDEX "review_to_user_created_at_idx" ON "reviews" USING btree ("to_user_id","created_at");