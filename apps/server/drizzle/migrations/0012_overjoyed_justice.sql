CREATE TYPE "public"."am_driver_quiz_answer_status" AS ENUM('IN_PROGRESS', 'COMPLETED', 'PASSED', 'FAILED');--> statement-breakpoint
CREATE TYPE "public"."am_driver_quiz_status" AS ENUM('NOT_STARTED', 'IN_PROGRESS', 'PASSED', 'FAILED');--> statement-breakpoint
ALTER TYPE "public"."am_order_status" ADD VALUE 'NO_SHOW';--> statement-breakpoint
CREATE TABLE "broadcast" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"title" varchar(255) NOT NULL,
	"message" text NOT NULL,
	"type" varchar(20) NOT NULL,
	"status" varchar(20) DEFAULT 'PENDING' NOT NULL,
	"target_audience" varchar(20) DEFAULT 'ALL' NOT NULL,
	"target_ids" uuid[],
	"scheduled_at" timestamp with time zone,
	"sent_at" timestamp with time zone,
	"total_recipients" integer DEFAULT 0,
	"sent_count" integer DEFAULT 0,
	"failed_count" integer DEFAULT 0,
	"created_by" uuid NOT NULL,
	"created_at" timestamp with time zone DEFAULT now(),
	"updated_at" timestamp with time zone DEFAULT now()
);
--> statement-breakpoint
CREATE TABLE "am_driver_quiz_answers" (
	"id" uuid PRIMARY KEY NOT NULL,
	"driver_id" text NOT NULL,
	"status" "am_driver_quiz_answer_status" DEFAULT 'IN_PROGRESS' NOT NULL,
	"total_questions" integer NOT NULL,
	"correct_answers" integer DEFAULT 0 NOT NULL,
	"total_points" integer DEFAULT 0 NOT NULL,
	"earned_points" integer DEFAULT 0 NOT NULL,
	"passing_score" integer DEFAULT 70 NOT NULL,
	"score_percentage" integer DEFAULT 0 NOT NULL,
	"answers" jsonb DEFAULT '[]'::jsonb NOT NULL,
	"started_at" timestamp NOT NULL,
	"completed_at" timestamp,
	"created_at" timestamp NOT NULL,
	"updated_at" timestamp NOT NULL
);
--> statement-breakpoint
ALTER TABLE "am_driver_answers" DISABLE ROW LEVEL SECURITY;--> statement-breakpoint
ALTER TABLE "am_newsletters" DISABLE ROW LEVEL SECURITY;--> statement-breakpoint
ALTER TABLE "am___newsletter_audit_log" DISABLE ROW LEVEL SECURITY;--> statement-breakpoint
ALTER TABLE "am_support_chat_messages" DISABLE ROW LEVEL SECURITY;--> statement-breakpoint
ALTER TABLE "am_support_tickets" DISABLE ROW LEVEL SECURITY;--> statement-breakpoint
DROP TABLE "am_driver_answers" CASCADE;--> statement-breakpoint
DROP TABLE "am_newsletters" CASCADE;--> statement-breakpoint
DROP TABLE "am___newsletter_audit_log" CASCADE;--> statement-breakpoint
DROP TABLE "am_support_chat_messages" CASCADE;--> statement-breakpoint
DROP TABLE "am_support_tickets" CASCADE;--> statement-breakpoint
DROP INDEX "am_driver_quiz_question_filter_idx";--> statement-breakpoint
ALTER TABLE "am_users" ALTER COLUMN "phone" DROP NOT NULL;--> statement-breakpoint
ALTER TABLE "am_coupons" ADD COLUMN "coupon_type" text DEFAULT 'GENERAL' NOT NULL;--> statement-breakpoint
ALTER TABLE "am_coupons" ADD COLUMN "event_name" text;--> statement-breakpoint
ALTER TABLE "am_coupons" ADD COLUMN "event_description" text;--> statement-breakpoint
ALTER TABLE "am_drivers" ADD COLUMN "quiz_status" "am_driver_quiz_status" DEFAULT 'NOT_STARTED' NOT NULL;--> statement-breakpoint
ALTER TABLE "am_drivers" ADD COLUMN "quiz_attempt_id" text;--> statement-breakpoint
ALTER TABLE "am_drivers" ADD COLUMN "quiz_score" integer;--> statement-breakpoint
ALTER TABLE "am_drivers" ADD COLUMN "quiz_completed_at" timestamp;--> statement-breakpoint
CREATE INDEX "broadcast_status_index" ON "broadcast" USING btree ("status");--> statement-breakpoint
CREATE INDEX "broadcast_type_index" ON "broadcast" USING btree ("type");--> statement-breakpoint
CREATE INDEX "broadcast_target_audience_index" ON "broadcast" USING btree ("target_audience");--> statement-breakpoint
CREATE INDEX "broadcast_scheduled_at_index" ON "broadcast" USING btree ("scheduled_at");--> statement-breakpoint
CREATE INDEX "broadcast_created_by_index" ON "broadcast" USING btree ("created_by");--> statement-breakpoint
CREATE INDEX "broadcast_created_at_index" ON "broadcast" USING btree ("created_at");--> statement-breakpoint
CREATE INDEX "broadcast_status_type_index" ON "broadcast" USING btree ("status","type");--> statement-breakpoint
CREATE INDEX "broadcast_status_scheduled_at_index" ON "broadcast" USING btree ("status","scheduled_at");--> statement-breakpoint
CREATE INDEX "am_driver_quiz_answer_driver_id_idx" ON "am_driver_quiz_answers" USING btree ("driver_id");--> statement-breakpoint
CREATE INDEX "am_driver_quiz_answer_status_idx" ON "am_driver_quiz_answers" USING btree ("status");--> statement-breakpoint
CREATE INDEX "am_driver_quiz_answer_started_at_idx" ON "am_driver_quiz_answers" USING btree ("started_at");--> statement-breakpoint
CREATE INDEX "am_driver_quiz_answer_completed_at_idx" ON "am_driver_quiz_answers" USING btree ("completed_at");--> statement-breakpoint
CREATE INDEX "am_driver_quiz_answer_driver_status_idx" ON "am_driver_quiz_answers" USING btree ("driver_id","status");--> statement-breakpoint
CREATE INDEX "am_driver_quiz_answer_score_idx" ON "am_driver_quiz_answers" USING btree ("score_percentage");--> statement-breakpoint
CREATE INDEX "am_coupon_type_idx" ON "am_coupons" USING btree ("coupon_type");--> statement-breakpoint
CREATE INDEX "am_coupon_type_active_idx" ON "am_coupons" USING btree ("coupon_type","is_active");--> statement-breakpoint
CREATE INDEX "am_driver_quiz_question_category_active_idx" ON "am_driver_quiz_questions" USING btree ("category","is_active");--> statement-breakpoint
CREATE INDEX "am_driver_quiz_status_idx" ON "am_drivers" USING btree ("quiz_status");--> statement-breakpoint
CREATE INDEX "am_driver_status_quiz_idx" ON "am_drivers" USING btree ("status","quiz_status");--> statement-breakpoint
DROP TYPE "public"."am_driver_answer_status";--> statement-breakpoint
DROP TYPE "public"."am_newsletter_status";--> statement-breakpoint
DROP TYPE "public"."am_support_ticket_category";--> statement-breakpoint
DROP TYPE "public"."am_support_ticket_priority";--> statement-breakpoint
DROP TYPE "public"."am_support_ticket_status";