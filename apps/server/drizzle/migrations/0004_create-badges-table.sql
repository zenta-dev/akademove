CREATE TYPE "public"."am_badge_level" AS ENUM('bronze', 'silver', 'gold', 'platinum', 'diamond');--> statement-breakpoint
CREATE TYPE "public"."am_badge_target_role" AS ENUM('driver', 'merchant', 'user');--> statement-breakpoint
CREATE TYPE "public"."am_badge_type" AS ENUM('achievement', 'performance', 'volume', 'streak', 'milestone', 'special');--> statement-breakpoint
CREATE TABLE "am_badges" (
	"id" uuid PRIMARY KEY NOT NULL,
	"code" varchar(100) NOT NULL,
	"name" varchar(255) NOT NULL,
	"description" text NOT NULL,
	"type" "am_badge_type" NOT NULL,
	"level" "am_badge_level" NOT NULL,
	"target_role" "am_badge_target_role" NOT NULL,
	"icon" text,
	"criteria" jsonb NOT NULL,
	"benefits" jsonb,
	"is_active" boolean DEFAULT true NOT NULL,
	"display_order" integer DEFAULT 0 NOT NULL,
	"created_at" timestamp NOT NULL,
	"updated_at" timestamp NOT NULL,
	CONSTRAINT "am_badges_code_unique" UNIQUE("code")
);
--> statement-breakpoint
CREATE TABLE "am_user_badges" (
	"id" uuid PRIMARY KEY NOT NULL,
	"user_id" text NOT NULL,
	"badge_id" uuid NOT NULL,
	"earned_at" timestamp NOT NULL,
	"metadata" jsonb,
	"created_at" timestamp NOT NULL,
	"updated_at" timestamp NOT NULL
);
--> statement-breakpoint
ALTER TABLE "am_user_badges" ADD CONSTRAINT "am_user_badges_user_id_am_users_id_fk" FOREIGN KEY ("user_id") REFERENCES "public"."am_users"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "am_user_badges" ADD CONSTRAINT "am_user_badges_badge_id_am_badges_id_fk" FOREIGN KEY ("badge_id") REFERENCES "public"."am_badges"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
CREATE UNIQUE INDEX "am_badge_code_idx" ON "am_badges" USING btree ("code");--> statement-breakpoint
CREATE INDEX "am_badge_type_idx" ON "am_badges" USING btree ("type");--> statement-breakpoint
CREATE INDEX "am_badge_level_idx" ON "am_badges" USING btree ("level");--> statement-breakpoint
CREATE INDEX "am_badge_target_role_idx" ON "am_badges" USING btree ("target_role");--> statement-breakpoint
CREATE INDEX "am_badge_is_active_idx" ON "am_badges" USING btree ("is_active");--> statement-breakpoint
CREATE UNIQUE INDEX "am_user_badge_unique_idx" ON "am_user_badges" USING btree ("user_id","badge_id");--> statement-breakpoint
CREATE INDEX "am_user_badge_user_id_idx" ON "am_user_badges" USING btree ("user_id");--> statement-breakpoint
CREATE INDEX "am_user_badge_badge_id_idx" ON "am_user_badges" USING btree ("badge_id");--> statement-breakpoint
CREATE INDEX "am_user_badge_earned_at_idx" ON "am_user_badges" USING btree ("earned_at");