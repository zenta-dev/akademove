ALTER TABLE "am_drivers" ADD COLUMN "cancellation_count" integer DEFAULT 0 NOT NULL;--> statement-breakpoint
ALTER TABLE "am_drivers" ADD COLUMN "last_cancellation_date" timestamp;--> statement-breakpoint
CREATE INDEX "am_driver_cancellation_idx" ON "am_drivers" USING btree ("last_cancellation_date");