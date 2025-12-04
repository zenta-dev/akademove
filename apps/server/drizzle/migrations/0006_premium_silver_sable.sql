CREATE TABLE "am_quick_message_templates" (
	"id" uuid PRIMARY KEY NOT NULL,
	"role" text NOT NULL,
	"message" text NOT NULL,
	"order_type" text,
	"locale" text DEFAULT 'en' NOT NULL,
	"is_active" boolean DEFAULT true NOT NULL,
	"display_order" integer DEFAULT 0 NOT NULL,
	"created_at" timestamp NOT NULL,
	"updated_at" timestamp NOT NULL
);
--> statement-breakpoint
CREATE INDEX "am_quick_message_role_idx" ON "am_quick_message_templates" USING btree ("role");--> statement-breakpoint
CREATE INDEX "am_quick_message_order_type_idx" ON "am_quick_message_templates" USING btree ("order_type");--> statement-breakpoint
CREATE INDEX "am_quick_message_locale_idx" ON "am_quick_message_templates" USING btree ("locale");--> statement-breakpoint
CREATE INDEX "am_quick_message_filter_idx" ON "am_quick_message_templates" USING btree ("role","order_type","locale","is_active");--> statement-breakpoint
CREATE INDEX "am_quick_message_display_order_idx" ON "am_quick_message_templates" USING btree ("display_order");