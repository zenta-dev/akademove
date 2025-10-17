CREATE TABLE "configurations" (
	"key" varchar(255) PRIMARY KEY NOT NULL,
	"name" varchar(255) NOT NULL,
	"value" jsonb NOT NULL,
	"description" text,
	"updatedById" text NOT NULL,
	"updated_at" timestamp DEFAULT now() NOT NULL
);
--> statement-breakpoint
ALTER TABLE "configurations" ADD CONSTRAINT "configurations_updatedById_users_id_fk" FOREIGN KEY ("updatedById") REFERENCES "public"."users"("id") ON DELETE no action ON UPDATE no action;