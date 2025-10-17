CREATE TYPE "public"."driver_status" AS ENUM('pending', 'approved', 'rejected', 'active', 'inactive', 'suspended');--> statement-breakpoint
CREATE TABLE "drivers" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"user_id" text NOT NULL,
	"student_id" text NOT NULL,
	"license_plate" text NOT NULL,
	"status" "driver_status" DEFAULT 'pending' NOT NULL,
	"rating" numeric(2, 1) DEFAULT 0 NOT NULL,
	"is_online" boolean DEFAULT false NOT NULL,
	"current_location" jsonb,
	"bank" jsonb NOT NULL,
	"last_location_update" timestamp,
	"student_card" text NOT NULL,
	"driver_license" text NOT NULL,
	"vehicle_certificate" text NOT NULL,
	"created_at" timestamp DEFAULT now() NOT NULL,
	CONSTRAINT "drivers_student_id_unique" UNIQUE("student_id"),
	CONSTRAINT "drivers_license_plate_unique" UNIQUE("license_plate")
);
--> statement-breakpoint
ALTER TABLE "drivers" ADD CONSTRAINT "drivers_user_id_users_id_fk" FOREIGN KEY ("user_id") REFERENCES "public"."users"("id") ON DELETE cascade ON UPDATE no action;