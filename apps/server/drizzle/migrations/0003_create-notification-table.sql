CREATE TYPE "public"."am_status" AS ENUM('success', 'failed');--> statement-breakpoint
CREATE TABLE "am_fcm_notification_logs" (
	"id" uuid PRIMARY KEY NOT NULL,
	"user_id" text NOT NULL,
	"token" text,
	"topic" text,
	"title" text NOT NULL,
	"body" text NOT NULL,
	"data" jsonb,
	"message_id" text,
	"status" "am_status" NOT NULL,
	"error" text,
	"sent_at" timestamp NOT NULL
);
--> statement-breakpoint
CREATE TABLE "am_fcm_tokens" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"user_id" text NOT NULL,
	"token" text NOT NULL,
	"created_at" timestamp NOT NULL,
	"updated_at" timestamp NOT NULL,
	CONSTRAINT "am_fcm_tokens_token_unique" UNIQUE("token")
);
--> statement-breakpoint
CREATE TABLE "am_fcm_topic_subscriptions" (
	"id" uuid PRIMARY KEY NOT NULL,
	"user_id" text NOT NULL,
	"token" text NOT NULL,
	"topic" text NOT NULL,
	"created_at" timestamp NOT NULL
);
--> statement-breakpoint
CREATE TABLE "am_user_notifications" (
	"id" uuid PRIMARY KEY NOT NULL,
	"user_id" text NOT NULL,
	"title" text NOT NULL,
	"body" text NOT NULL,
	"data" jsonb,
	"message_id" text,
	"is_read" boolean DEFAULT false NOT NULL,
	"created_at" timestamp NOT NULL,
	"read_at" timestamp
);
--> statement-breakpoint
CREATE TABLE "am_order_items" (
	"id" serial PRIMARY KEY NOT NULL,
	"orderId" uuid NOT NULL,
	"menuId" uuid NOT NULL,
	"quantity" integer NOT NULL,
	"unit_price" numeric(18, 2) NOT NULL
);
--> statement-breakpoint
ALTER TABLE "am_payments" ALTER COLUMN "transaction_id" SET NOT NULL;--> statement-breakpoint
ALTER TABLE "am_drivers" ADD COLUMN "is_taking_order" boolean DEFAULT false NOT NULL;--> statement-breakpoint
ALTER TABLE "am_driver_schedules" ADD COLUMN "name" text NOT NULL;--> statement-breakpoint
ALTER TABLE "am_fcm_notification_logs" ADD CONSTRAINT "am_fcm_notification_logs_user_id_am_users_id_fk" FOREIGN KEY ("user_id") REFERENCES "public"."am_users"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "am_fcm_tokens" ADD CONSTRAINT "am_fcm_tokens_user_id_am_users_id_fk" FOREIGN KEY ("user_id") REFERENCES "public"."am_users"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "am_fcm_topic_subscriptions" ADD CONSTRAINT "am_fcm_topic_subscriptions_user_id_am_users_id_fk" FOREIGN KEY ("user_id") REFERENCES "public"."am_users"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "am_user_notifications" ADD CONSTRAINT "am_user_notifications_user_id_am_users_id_fk" FOREIGN KEY ("user_id") REFERENCES "public"."am_users"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "am_order_items" ADD CONSTRAINT "am_order_items_orderId_am_orders_id_fk" FOREIGN KEY ("orderId") REFERENCES "public"."am_orders"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "am_order_items" ADD CONSTRAINT "am_order_items_menuId_am_merchant_menus_id_fk" FOREIGN KEY ("menuId") REFERENCES "public"."am_merchant_menus"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
CREATE INDEX "fcm_notification_logs_user_id_idx" ON "am_fcm_notification_logs" USING btree ("user_id");--> statement-breakpoint
CREATE INDEX "fcm_notification_logs_sent_at_idx" ON "am_fcm_notification_logs" USING btree ("sent_at");--> statement-breakpoint
CREATE INDEX "fcm_token_user_id_idx" ON "am_fcm_tokens" USING btree ("user_id");--> statement-breakpoint
CREATE INDEX "fcm_token_token_id_idx" ON "am_fcm_tokens" USING btree ("token");--> statement-breakpoint
CREATE INDEX "fcm_topic_subscriptions_user_id_topic_idx" ON "am_fcm_topic_subscriptions" USING btree ("user_id","topic");--> statement-breakpoint
CREATE INDEX "fcm_topic_subscriptions_token_topic_idx" ON "am_fcm_topic_subscriptions" USING btree ("token","topic");--> statement-breakpoint
CREATE INDEX "user_notifications_user_id_idx" ON "am_user_notifications" USING btree ("user_id");--> statement-breakpoint
CREATE INDEX "user_notifications_is_read_idx" ON "am_user_notifications" USING btree ("is_read");--> statement-breakpoint
CREATE INDEX "user_notifications_created_at_idx" ON "am_user_notifications" USING btree ("created_at");