ALTER TABLE "drivers" ADD CONSTRAINT "drivers_user_id_unique" UNIQUE("user_id");--> statement-breakpoint
CREATE UNIQUE INDEX "driver_user_id_idx" ON "drivers" USING btree ("user_id");--> statement-breakpoint
CREATE UNIQUE INDEX "driver_student_id_idx" ON "drivers" USING btree ("student_id");--> statement-breakpoint
CREATE UNIQUE INDEX "driver_license_plate_idx" ON "drivers" USING btree ("license_plate");--> statement-breakpoint
CREATE INDEX "driver_status_idx" ON "drivers" USING btree ("status");--> statement-breakpoint
CREATE INDEX "driver_is_online_idx" ON "drivers" USING btree ("is_online");--> statement-breakpoint
CREATE INDEX "driver_rating_idx" ON "drivers" USING btree ("rating");--> statement-breakpoint
CREATE INDEX "driver_status_online_idx" ON "drivers" USING btree ("status","is_online");