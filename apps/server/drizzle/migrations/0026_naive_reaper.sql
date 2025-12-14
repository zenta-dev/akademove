CREATE TYPE "public"."am_support_ticket_category" AS ENUM('GENERAL', 'ORDER_ISSUE', 'PAYMENT_ISSUE', 'DRIVER_COMPLAINT', 'MERCHANT_COMPLAINT', 'ACCOUNT_ISSUE', 'TECHNICAL_ISSUE', 'FEATURE_REQUEST', 'OTHER');--> statement-breakpoint
CREATE TYPE "public"."am_support_ticket_priority" AS ENUM('LOW', 'MEDIUM', 'HIGH', 'URGENT');--> statement-breakpoint
CREATE TYPE "public"."am_support_ticket_status" AS ENUM('OPEN', 'IN_PROGRESS', 'WAITING_USER', 'RESOLVED', 'CLOSED');--> statement-breakpoint
CREATE TABLE "am_support_chat_message" (
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
CREATE TABLE "am_support_ticket" (
	"id" uuid PRIMARY KEY NOT NULL,
	"user_id" text NOT NULL,
	"assigned_to_id" text,
	"subject" text NOT NULL,
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
ALTER TABLE "am_support_chat_message" ADD CONSTRAINT "am_support_chat_message_ticket_id_am_support_ticket_id_fk" FOREIGN KEY ("ticket_id") REFERENCES "public"."am_support_ticket"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "am_support_chat_message" ADD CONSTRAINT "am_support_chat_message_sender_id_am_users_id_fk" FOREIGN KEY ("sender_id") REFERENCES "public"."am_users"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "am_support_ticket" ADD CONSTRAINT "am_support_ticket_user_id_am_users_id_fk" FOREIGN KEY ("user_id") REFERENCES "public"."am_users"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "am_support_ticket" ADD CONSTRAINT "am_support_ticket_assigned_to_id_am_users_id_fk" FOREIGN KEY ("assigned_to_id") REFERENCES "public"."am_users"("id") ON DELETE set null ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "am_support_ticket" ADD CONSTRAINT "am_support_ticket_order_id_am_orders_id_fk" FOREIGN KEY ("order_id") REFERENCES "public"."am_orders"("id") ON DELETE set null ON UPDATE no action;--> statement-breakpoint
CREATE INDEX "am_support_chat_ticket_idx" ON "am_support_chat_message" USING btree ("ticket_id");--> statement-breakpoint
CREATE INDEX "am_support_chat_sender_idx" ON "am_support_chat_message" USING btree ("sender_id");--> statement-breakpoint
CREATE INDEX "am_support_chat_ticket_sent_idx" ON "am_support_chat_message" USING btree ("ticket_id","sent_at");--> statement-breakpoint
CREATE INDEX "am_support_chat_sent_at_idx" ON "am_support_chat_message" USING btree ("sent_at");--> statement-breakpoint
CREATE INDEX "am_support_chat_unread_idx" ON "am_support_chat_message" USING btree ("ticket_id","read_at");--> statement-breakpoint
CREATE INDEX "am_support_ticket_status_idx" ON "am_support_ticket" USING btree ("status");--> statement-breakpoint
CREATE INDEX "am_support_ticket_user_idx" ON "am_support_ticket" USING btree ("user_id");--> statement-breakpoint
CREATE INDEX "am_support_ticket_assigned_idx" ON "am_support_ticket" USING btree ("assigned_to_id");--> statement-breakpoint
CREATE INDEX "am_support_ticket_category_idx" ON "am_support_ticket" USING btree ("category");--> statement-breakpoint
CREATE INDEX "am_support_ticket_priority_idx" ON "am_support_ticket" USING btree ("priority");--> statement-breakpoint
CREATE INDEX "am_support_ticket_status_created_idx" ON "am_support_ticket" USING btree ("status","created_at");--> statement-breakpoint
CREATE INDEX "am_support_ticket_order_idx" ON "am_support_ticket" USING btree ("order_id");