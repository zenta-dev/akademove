-- Create broadcast table
CREATE TABLE IF NOT EXISTS "broadcast" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"title" varchar(255) NOT NULL,
	"message" text NOT NULL,
	"type" varchar(20) NOT NULL,
	"status" varchar(20) DEFAULT 'PENDING' NOT NULL,
	"target_audience" varchar(20) DEFAULT 'ALL' NOT NULL,
	"target_user_ids" uuid[],
	"scheduled_at" timestamp with time zone,
	"sent_at" timestamp with time zone,
	"total_recipients" integer DEFAULT 0 NOT NULL,
	"sent_count" integer DEFAULT 0 NOT NULL,
	"failed_count" integer DEFAULT 0 NOT NULL,
	"created_by" uuid NOT NULL,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL,
	"updated_at" timestamp with time zone DEFAULT now() NOT NULL
);

-- Create indexes for broadcast table
CREATE INDEX IF NOT EXISTS "broadcast_status_idx" ON "broadcast" ("status");
CREATE INDEX IF NOT EXISTS "broadcast_type_idx" ON "broadcast" ("type");
CREATE INDEX IF NOT EXISTS "broadcast_target_audience_idx" ON "broadcast" ("target_audience");
CREATE INDEX IF NOT EXISTS "broadcast_scheduled_at_idx" ON "broadcast" ("scheduled_at");
CREATE INDEX IF NOT EXISTS "broadcast_created_by_idx" ON "broadcast" ("created_by");
CREATE INDEX IF NOT EXISTS "broadcast_created_at_idx" ON "broadcast" ("created_at");
CREATE INDEX IF NOT EXISTS "broadcast_status_type_idx" ON "broadcast" ("status", "type");
CREATE INDEX IF NOT EXISTS "broadcast_status_scheduled_at_idx" ON "broadcast" ("status", "scheduled_at");