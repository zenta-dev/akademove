CREATE INDEX "schedule_driver_id_idx" ON "schedules" USING btree ("driver_id");--> statement-breakpoint
CREATE INDEX "schedule_day_of_week_idx" ON "schedules" USING btree ("dayOfWeek");--> statement-breakpoint
CREATE INDEX "schedule_is_active_idx" ON "schedules" USING btree ("is_active");--> statement-breakpoint
CREATE INDEX "schedule_is_recurring_idx" ON "schedules" USING btree ("is_recurring");--> statement-breakpoint
CREATE INDEX "schedule_specific_date_idx" ON "schedules" USING btree ("specific_date");--> statement-breakpoint
CREATE INDEX "schedule_driver_active_idx" ON "schedules" USING btree ("driver_id","is_active");--> statement-breakpoint
CREATE INDEX "schedule_driver_day_idx" ON "schedules" USING btree ("driver_id","dayOfWeek");--> statement-breakpoint
CREATE INDEX "schedule_driver_day_active_idx" ON "schedules" USING btree ("driver_id","dayOfWeek","is_active");--> statement-breakpoint
CREATE INDEX "schedule_driver_recurring_idx" ON "schedules" USING btree ("driver_id","is_recurring");--> statement-breakpoint
CREATE INDEX "schedule_created_at_idx" ON "schedules" USING btree ("created_at");