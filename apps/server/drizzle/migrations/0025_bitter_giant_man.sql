CREATE TABLE "am_order_chat_read_status" (
	"id" uuid PRIMARY KEY NOT NULL,
	"order_id" uuid NOT NULL,
	"user_id" text NOT NULL,
	"last_read_message_id" uuid,
	"last_read_at" timestamp,
	"created_at" timestamp NOT NULL,
	"updated_at" timestamp NOT NULL
);
--> statement-breakpoint
ALTER TABLE "am_order_chat_read_status" ADD CONSTRAINT "am_order_chat_read_status_order_id_am_orders_id_fk" FOREIGN KEY ("order_id") REFERENCES "public"."am_orders"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "am_order_chat_read_status" ADD CONSTRAINT "am_order_chat_read_status_user_id_am_users_id_fk" FOREIGN KEY ("user_id") REFERENCES "public"."am_users"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "am_order_chat_read_status" ADD CONSTRAINT "am_order_chat_read_status_last_read_message_id_am_order_chat_messages_id_fk" FOREIGN KEY ("last_read_message_id") REFERENCES "public"."am_order_chat_messages"("id") ON DELETE set null ON UPDATE no action;--> statement-breakpoint
CREATE INDEX "am_chat_read_status_order_user_idx" ON "am_order_chat_read_status" USING btree ("order_id","user_id");--> statement-breakpoint
CREATE INDEX "am_chat_read_status_user_idx" ON "am_order_chat_read_status" USING btree ("user_id");