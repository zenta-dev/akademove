CREATE INDEX "report_order_id_idx" ON "reports" USING btree ("order_id");--> statement-breakpoint
CREATE INDEX "report_reporter_id_idx" ON "reports" USING btree ("reporter_id");--> statement-breakpoint
CREATE INDEX "report_target_user_id_idx" ON "reports" USING btree ("target_user_id");--> statement-breakpoint
CREATE INDEX "report_handled_by_id_idx" ON "reports" USING btree ("handled_by_id");--> statement-breakpoint
CREATE INDEX "report_category_idx" ON "reports" USING btree ("category");--> statement-breakpoint
CREATE INDEX "report_status_idx" ON "reports" USING btree ("status");--> statement-breakpoint
CREATE INDEX "report_status_category_idx" ON "reports" USING btree ("status","category");--> statement-breakpoint
CREATE INDEX "report_target_status_idx" ON "reports" USING btree ("target_user_id","status");--> statement-breakpoint
CREATE INDEX "report_reporter_status_idx" ON "reports" USING btree ("reporter_id","status");--> statement-breakpoint
CREATE INDEX "report_reported_at_idx" ON "reports" USING btree ("reported_at");--> statement-breakpoint
CREATE INDEX "report_resolved_at_idx" ON "reports" USING btree ("resolved_at");--> statement-breakpoint
CREATE INDEX "report_status_reported_at_idx" ON "reports" USING btree ("status","reported_at");