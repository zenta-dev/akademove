CREATE TYPE "public"."am_driver_answer_status" AS ENUM('IN_PROGRESS', 'COMPLETED', 'PASSED', 'FAILED');--> statement-breakpoint
CREATE TYPE "public"."am_driver_quiz_question_category" AS ENUM('SAFETY', 'NAVIGATION', 'CUSTOMER_SERVICE', 'PLATFORM_RULES', 'EMERGENCY_PROCEDURES', 'VEHICLE_MAINTENANCE', 'GENERAL');--> statement-breakpoint
CREATE TYPE "public"."am_driver_quiz_question_type" AS ENUM('MULTIPLE_CHOICE', 'TRUE_FALSE');--> statement-breakpoint
CREATE TYPE "public"."am_newsletter_status" AS ENUM('ACTIVE', 'UNSUBSCRIBED');--> statement-breakpoint
CREATE TYPE "public"."am_support_ticket_category" AS ENUM('GENERAL', 'ORDER_ISSUE', 'PAYMENT_ISSUE', 'DRIVER_COMPLAINT', 'MERCHANT_COMPLAINT', 'ACCOUNT_ISSUE', 'TECHNICAL_ISSUE', 'FEATURE_REQUEST', 'OTHER');--> statement-breakpoint
CREATE TYPE "public"."am_support_ticket_priority" AS ENUM('LOW', 'MEDIUM', 'HIGH', 'URGENT');--> statement-breakpoint
CREATE TYPE "public"."am_support_ticket_status" AS ENUM('OPEN', 'IN_PROGRESS', 'WAITING_USER', 'RESOLVED', 'CLOSED');--> statement-breakpoint
ALTER TYPE "public"."am_allowed_logged_table" ADD VALUE 'newsletter' BEFORE 'report';--> statement-breakpoint
CREATE TABLE "am_driver_answers" (
	"id" uuid PRIMARY KEY NOT NULL,
	"driver_id" text NOT NULL,
	"status" "am_driver_answer_status" DEFAULT 'IN_PROGRESS' NOT NULL,
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
CREATE TABLE "am_driver_quiz_questions" (
	"id" uuid PRIMARY KEY NOT NULL,
	"question" text NOT NULL,
	"type" "am_driver_quiz_question_type" NOT NULL,
	"category" "am_driver_quiz_question_category" NOT NULL,
	"options" jsonb NOT NULL,
	"explanation" text,
	"points" integer DEFAULT 10 NOT NULL,
	"is_active" boolean DEFAULT true NOT NULL,
	"display_order" integer DEFAULT 0 NOT NULL,
	"created_at" timestamp NOT NULL,
	"updated_at" timestamp NOT NULL
);
--> statement-breakpoint
CREATE TABLE "am_newsletters" (
	"id" uuid PRIMARY KEY NOT NULL,
	"email" varchar(255) NOT NULL,
	"status" "am_newsletter_status" DEFAULT 'ACTIVE' NOT NULL,
	"user_id" text,
	"created_at" timestamp NOT NULL,
	"updated_at" timestamp NOT NULL,
	CONSTRAINT "am_newsletters_email_unique" UNIQUE("email")
);
--> statement-breakpoint
CREATE TABLE "am___newsletter_audit_log" (
	"id" serial PRIMARY KEY NOT NULL,
	"table_name" "am_allowed_logged_table" NOT NULL,
	"record_id" text NOT NULL,
	"operation" "am_operation" NOT NULL,
	"old_data" jsonb,
	"new_data" jsonb,
	"updated_by_id" text,
	"ip_address" text,
	"user_agent" text,
	"session_id" text,
	"reason" text,
	"updated_at" timestamp NOT NULL
);
--> statement-breakpoint
CREATE TABLE "am_support_chat_messages" (
	"id" uuid PRIMARY KEY NOT NULL,
	"ticket_id" uuid NOT NULL,
	"sender_id" text NOT NULL,
	"message" text NOT NULL,
	"is_from_support" boolean DEFAULT false NOT NULL,
	"read_at" timestamp,
	"sent_at" timestamp NOT NULL,
	"created_at" timestamp NOT NULL,
	"updated_at" timestamp NOT NULL
);
--> statement-breakpoint
CREATE TABLE "am_support_tickets" (
	"id" uuid PRIMARY KEY NOT NULL,
	"user_id" text NOT NULL,
	"assigned_to_id" text,
	"subject" varchar(255) NOT NULL,
	"category" "am_support_ticket_category" DEFAULT 'GENERAL' NOT NULL,
	"priority" "am_support_ticket_priority" DEFAULT 'MEDIUM' NOT NULL,
	"status" "am_support_ticket_status" DEFAULT 'OPEN' NOT NULL,
	"order_id" uuid,
	"last_message_at" timestamp,
	"resolved_at" timestamp,
	"created_at" timestamp NOT NULL,
	"updated_at" timestamp NOT NULL
);
--> statement-breakpoint
ALTER TABLE "am_newsletters" ADD CONSTRAINT "am_newsletters_user_id_am_users_id_fk" FOREIGN KEY ("user_id") REFERENCES "public"."am_users"("id") ON DELETE set null ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "am_support_chat_messages" ADD CONSTRAINT "am_support_chat_messages_ticket_id_am_support_tickets_id_fk" FOREIGN KEY ("ticket_id") REFERENCES "public"."am_support_tickets"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "am_support_chat_messages" ADD CONSTRAINT "am_support_chat_messages_sender_id_am_users_id_fk" FOREIGN KEY ("sender_id") REFERENCES "public"."am_users"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "am_support_tickets" ADD CONSTRAINT "am_support_tickets_user_id_am_users_id_fk" FOREIGN KEY ("user_id") REFERENCES "public"."am_users"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "am_support_tickets" ADD CONSTRAINT "am_support_tickets_assigned_to_id_am_users_id_fk" FOREIGN KEY ("assigned_to_id") REFERENCES "public"."am_users"("id") ON DELETE set null ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "am_support_tickets" ADD CONSTRAINT "am_support_tickets_order_id_am_orders_id_fk" FOREIGN KEY ("order_id") REFERENCES "public"."am_orders"("id") ON DELETE set null ON UPDATE no action;--> statement-breakpoint
CREATE INDEX "am_driver_answer_driver_id_idx" ON "am_driver_answers" USING btree ("driver_id");--> statement-breakpoint
CREATE INDEX "am_driver_answer_status_idx" ON "am_driver_answers" USING btree ("status");--> statement-breakpoint
CREATE INDEX "am_driver_answer_started_at_idx" ON "am_driver_answers" USING btree ("started_at");--> statement-breakpoint
CREATE INDEX "am_driver_answer_completed_at_idx" ON "am_driver_answers" USING btree ("completed_at");--> statement-breakpoint
CREATE INDEX "am_driver_answer_driver_status_idx" ON "am_driver_answers" USING btree ("driver_id","status");--> statement-breakpoint
CREATE INDEX "am_driver_answer_score_idx" ON "am_driver_answers" USING btree ("score_percentage");--> statement-breakpoint
CREATE INDEX "am_driver_quiz_question_type_idx" ON "am_driver_quiz_questions" USING btree ("type");--> statement-breakpoint
CREATE INDEX "am_driver_quiz_question_category_idx" ON "am_driver_quiz_questions" USING btree ("category");--> statement-breakpoint
CREATE INDEX "am_driver_quiz_question_is_active_idx" ON "am_driver_quiz_questions" USING btree ("is_active");--> statement-breakpoint
CREATE INDEX "am_driver_quiz_question_display_order_idx" ON "am_driver_quiz_questions" USING btree ("display_order");--> statement-breakpoint
CREATE INDEX "am_driver_quiz_question_filter_idx" ON "am_driver_quiz_questions" USING btree ("category","type","is_active");--> statement-breakpoint
CREATE INDEX "am_newsletter_email_idx" ON "am_newsletters" USING btree ("email");--> statement-breakpoint
CREATE INDEX "am_newsletter_user_id_idx" ON "am_newsletters" USING btree ("user_id");--> statement-breakpoint
CREATE INDEX "am_newsletter_status_idx" ON "am_newsletters" USING btree ("status");--> statement-breakpoint
CREATE INDEX "am_newsletter_created_at_idx" ON "am_newsletters" USING btree ("created_at");--> statement-breakpoint
CREATE INDEX "am_newsletter_status_created_at_idx" ON "am_newsletters" USING btree ("status","created_at");--> statement-breakpoint
CREATE INDEX "am_newsletter_user_status_idx" ON "am_newsletters" USING btree ("user_id","status");--> statement-breakpoint
CREATE INDEX "am_newsletter_audit_record_idx" ON "am___newsletter_audit_log" USING btree ("record_id");--> statement-breakpoint
CREATE INDEX "am_newsletter_audit_updated_at_idx" ON "am___newsletter_audit_log" USING btree ("updated_at");--> statement-breakpoint
CREATE INDEX "am_newsletter_audit_updated_by_idx" ON "am___newsletter_audit_log" USING btree ("updated_by_id");--> statement-breakpoint
CREATE INDEX "am_newsletter_audit_ip_address_idx" ON "am___newsletter_audit_log" USING btree ("ip_address");--> statement-breakpoint
CREATE INDEX "am_support_chat_ticket_id_idx" ON "am_support_chat_messages" USING btree ("ticket_id");--> statement-breakpoint
CREATE INDEX "am_support_chat_sender_id_idx" ON "am_support_chat_messages" USING btree ("sender_id");--> statement-breakpoint
CREATE INDEX "am_support_chat_ticket_sent_idx" ON "am_support_chat_messages" USING btree ("ticket_id","sent_at");--> statement-breakpoint
CREATE INDEX "am_support_chat_ticket_read_idx" ON "am_support_chat_messages" USING btree ("ticket_id","read_at");--> statement-breakpoint
CREATE INDEX "am_support_chat_sent_at_idx" ON "am_support_chat_messages" USING btree ("sent_at");--> statement-breakpoint
CREATE INDEX "am_support_ticket_user_id_idx" ON "am_support_tickets" USING btree ("user_id");--> statement-breakpoint
CREATE INDEX "am_support_ticket_assigned_to_id_idx" ON "am_support_tickets" USING btree ("assigned_to_id");--> statement-breakpoint
CREATE INDEX "am_support_ticket_status_idx" ON "am_support_tickets" USING btree ("status");--> statement-breakpoint
CREATE INDEX "am_support_ticket_priority_idx" ON "am_support_tickets" USING btree ("priority");--> statement-breakpoint
CREATE INDEX "am_support_ticket_category_idx" ON "am_support_tickets" USING btree ("category");--> statement-breakpoint
CREATE INDEX "am_support_ticket_order_id_idx" ON "am_support_tickets" USING btree ("order_id");--> statement-breakpoint
CREATE INDEX "am_support_ticket_user_status_idx" ON "am_support_tickets" USING btree ("user_id","status");--> statement-breakpoint
CREATE INDEX "am_support_ticket_assigned_status_idx" ON "am_support_tickets" USING btree ("assigned_to_id","status");--> statement-breakpoint
CREATE INDEX "am_support_ticket_last_message_at_idx" ON "am_support_tickets" USING btree ("last_message_at");--> statement-breakpoint
CREATE INDEX "am_support_ticket_created_at_idx" ON "am_support_tickets" USING btree ("created_at");