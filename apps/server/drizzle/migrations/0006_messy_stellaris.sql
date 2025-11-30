CREATE TABLE "am_order_chat_messages" (
	"id" uuid PRIMARY KEY NOT NULL,
	"order_id" uuid NOT NULL,
	"sender_id" text NOT NULL,
	"message" text NOT NULL,
	"sent_at" timestamp NOT NULL,
	"created_at" timestamp NOT NULL,
	"updated_at" timestamp NOT NULL
);
--> statement-breakpoint
ALTER TABLE "am_order_chat_messages" ADD CONSTRAINT "am_order_chat_messages_order_id_am_orders_id_fk" FOREIGN KEY ("order_id") REFERENCES "public"."am_orders"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "am_order_chat_messages" ADD CONSTRAINT "am_order_chat_messages_sender_id_am_users_id_fk" FOREIGN KEY ("sender_id") REFERENCES "public"."am_users"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
CREATE INDEX "am_chat_order_id_idx" ON "am_order_chat_messages" USING btree ("order_id");--> statement-breakpoint
CREATE INDEX "am_chat_sender_id_idx" ON "am_order_chat_messages" USING btree ("sender_id");--> statement-breakpoint
CREATE INDEX "am_chat_order_sent_idx" ON "am_order_chat_messages" USING btree ("order_id","sent_at");--> statement-breakpoint
CREATE INDEX "am_chat_sent_at_idx" ON "am_order_chat_messages" USING btree ("sent_at");