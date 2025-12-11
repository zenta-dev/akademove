CREATE TABLE "am_merchant_operating_hours" (
	"id" uuid PRIMARY KEY NOT NULL,
	"merchant_id" uuid NOT NULL,
	"day_of_week" "am_day_of_week" NOT NULL,
	"is_open" boolean DEFAULT true NOT NULL,
	"is_24_hours" boolean DEFAULT false NOT NULL,
	"open_time" jsonb,
	"close_time" jsonb,
	"created_at" timestamp NOT NULL,
	"updated_at" timestamp NOT NULL
);
--> statement-breakpoint
ALTER TABLE "am_merchant_operating_hours" ADD CONSTRAINT "am_merchant_operating_hours_merchant_id_am_merchants_id_fk" FOREIGN KEY ("merchant_id") REFERENCES "public"."am_merchants"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
CREATE INDEX "am_merchant_operating_hours_merchant_id_idx" ON "am_merchant_operating_hours" USING btree ("merchant_id");--> statement-breakpoint
CREATE INDEX "am_merchant_operating_hours_day_idx" ON "am_merchant_operating_hours" USING btree ("day_of_week");--> statement-breakpoint
CREATE INDEX "am_merchant_operating_hours_is_open_idx" ON "am_merchant_operating_hours" USING btree ("is_open");--> statement-breakpoint
CREATE UNIQUE INDEX "am_merchant_operating_hours_merchant_day_idx" ON "am_merchant_operating_hours" USING btree ("merchant_id","day_of_week");--> statement-breakpoint
CREATE INDEX "am_merchant_operating_hours_created_at_idx" ON "am_merchant_operating_hours" USING btree ("created_at");