CREATE TYPE "public"."am_leaderboard_category" AS ENUM('rating', 'volume', 'earnings', 'streak', 'on-time', 'completion-rate');--> statement-breakpoint
CREATE TYPE "public"."am_leaderboard_period" AS ENUM('daily', 'weekly', 'monthly', 'quarterly', 'yearly', 'all-time');--> statement-breakpoint
CREATE TABLE "am_leaderboards" (
	"id" uuid PRIMARY KEY NOT NULL,
	"user_id" text NOT NULL,
	"driver_id" uuid,
	"merchant_id" uuid,
	"category" "am_leaderboard_category" NOT NULL,
	"period" "am_leaderboard_period" NOT NULL,
	"rank" integer NOT NULL,
	"score" integer NOT NULL,
	"period_start" timestamp NOT NULL,
	"period_end" timestamp NOT NULL,
	"created_at" timestamp NOT NULL,
	"updated_at" timestamp NOT NULL
);
--> statement-breakpoint
ALTER TABLE "am_leaderboards" ADD CONSTRAINT "am_leaderboards_user_id_am_users_id_fk" FOREIGN KEY ("user_id") REFERENCES "public"."am_users"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "am_leaderboards" ADD CONSTRAINT "am_leaderboards_driver_id_am_drivers_id_fk" FOREIGN KEY ("driver_id") REFERENCES "public"."am_drivers"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "am_leaderboards" ADD CONSTRAINT "am_leaderboards_merchant_id_am_merchants_id_fk" FOREIGN KEY ("merchant_id") REFERENCES "public"."am_merchants"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
CREATE UNIQUE INDEX "am_leaderboard_unique_idx" ON "am_leaderboards" USING btree ("user_id","category","period","period_start");--> statement-breakpoint
CREATE INDEX "am_leaderboard_category_period_idx" ON "am_leaderboards" USING btree ("category","period");--> statement-breakpoint
CREATE INDEX "am_leaderboard_rank_idx" ON "am_leaderboards" USING btree ("rank");--> statement-breakpoint
CREATE INDEX "am_leaderboard_period_dates_idx" ON "am_leaderboards" USING btree ("period_start","period_end");