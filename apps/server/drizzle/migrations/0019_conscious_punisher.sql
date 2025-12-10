CREATE TABLE "am_banner" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"title" varchar(255) NOT NULL,
	"description" text,
	"image_url" varchar(512) NOT NULL,
	"action_type" varchar(20) DEFAULT 'NONE' NOT NULL,
	"action_value" text,
	"placement" varchar(20) DEFAULT 'USER_HOME' NOT NULL,
	"target_audience" varchar(20) DEFAULT 'ALL' NOT NULL,
	"is_active" boolean DEFAULT true NOT NULL,
	"priority" integer DEFAULT 0 NOT NULL,
	"start_at" timestamp with time zone,
	"end_at" timestamp with time zone,
	"created_by_id" uuid NOT NULL,
	"updated_by_id" uuid,
	"created_at" timestamp NOT NULL,
	"updated_at" timestamp NOT NULL
);
--> statement-breakpoint
CREATE TABLE "am_order_status_history" (
	"id" serial PRIMARY KEY NOT NULL,
	"order_id" uuid NOT NULL,
	"previous_status" "am_order_status",
	"new_status" "am_order_status" NOT NULL,
	"changed_by" text,
	"changed_by_role" text,
	"reason" text,
	"metadata" jsonb,
	"changed_at" timestamp NOT NULL
);
--> statement-breakpoint
ALTER TABLE "am_order_status_history" ADD CONSTRAINT "am_order_status_history_order_id_am_orders_id_fk" FOREIGN KEY ("order_id") REFERENCES "public"."am_orders"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "am_order_status_history" ADD CONSTRAINT "am_order_status_history_changed_by_am_users_id_fk" FOREIGN KEY ("changed_by") REFERENCES "public"."am_users"("id") ON DELETE set null ON UPDATE no action;--> statement-breakpoint
CREATE INDEX "banner_is_active_idx" ON "am_banner" USING btree ("is_active");--> statement-breakpoint
CREATE INDEX "banner_placement_idx" ON "am_banner" USING btree ("placement");--> statement-breakpoint
CREATE INDEX "banner_target_audience_idx" ON "am_banner" USING btree ("target_audience");--> statement-breakpoint
CREATE INDEX "banner_priority_idx" ON "am_banner" USING btree ("priority");--> statement-breakpoint
CREATE INDEX "banner_start_at_idx" ON "am_banner" USING btree ("start_at");--> statement-breakpoint
CREATE INDEX "banner_end_at_idx" ON "am_banner" USING btree ("end_at");--> statement-breakpoint
CREATE INDEX "banner_active_placement_idx" ON "am_banner" USING btree ("is_active","placement");--> statement-breakpoint
CREATE INDEX "banner_created_at_idx" ON "am_banner" USING btree ("created_at");--> statement-breakpoint
CREATE INDEX "am_order_status_history_order_id_idx" ON "am_order_status_history" USING btree ("order_id");--> statement-breakpoint
CREATE INDEX "am_order_status_history_changed_at_idx" ON "am_order_status_history" USING btree ("changed_at");--> statement-breakpoint
CREATE INDEX "am_order_status_history_order_changed_at_idx" ON "am_order_status_history" USING btree ("order_id","changed_at");--> statement-breakpoint
CREATE INDEX "am_order_scheduled_matching_at_idx" ON "am_orders" USING btree ("status","scheduled_matching_at");--> statement-breakpoint
CREATE INDEX "am_order_status_requested_at_idx" ON "am_orders" USING btree ("status","requested_at");