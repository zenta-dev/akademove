CREATE TYPE "public"."am_user_gender" AS ENUM('male', 'female');--> statement-breakpoint
CREATE TYPE "public"."am_allowed_logged_table" AS ENUM('configurations', 'coupon', 'report');--> statement-breakpoint
CREATE TYPE "public"."am_operation" AS ENUM('INSERT', 'UPDATE', 'DELETE');--> statement-breakpoint
CREATE TYPE "public"."am_day_of_week" AS ENUM('sunday', 'monday', 'tuesday', 'wednesday', 'thursday', 'friday', 'saturday');--> statement-breakpoint
CREATE TYPE "public"."am_driver_status" AS ENUM('pending', 'approved', 'rejected', 'active', 'inactive', 'suspended');--> statement-breakpoint
CREATE TYPE "public"."am_order_status" AS ENUM('requested', 'matching', 'accepted', 'arriving', 'in_trip', 'completed', 'cancelled_by_user', 'cancelled_by_driver', 'cancelled_by_system');--> statement-breakpoint
CREATE TYPE "public"."am_order_type" AS ENUM('ride', 'delivery', 'food');--> statement-breakpoint
CREATE TYPE "public"."am_payment_method" AS ENUM('QRIS', 'VA', 'BANK_TRANSFER', 'WALLET');--> statement-breakpoint
CREATE TYPE "public"."am_payment_provider" AS ENUM('MIDTRANS', 'MANUAL');--> statement-breakpoint
CREATE TYPE "public"."am_report_category" AS ENUM('behavior', 'safety', 'fraud', 'other');--> statement-breakpoint
CREATE TYPE "public"."am_report_status" AS ENUM('pending', 'investigating', 'resolved', 'dismissed');--> statement-breakpoint
CREATE TYPE "public"."am_review_category" AS ENUM('cleanliness', 'courtesy', 'other');--> statement-breakpoint
CREATE TYPE "public"."am_transaction_status" AS ENUM('pending', 'success', 'failed', 'cancelled', 'expired', 'refunded');--> statement-breakpoint
CREATE TYPE "public"."am_transaction_type" AS ENUM('topup', 'withdraw', 'payment', 'refund', 'adjustment');--> statement-breakpoint
CREATE TYPE "public"."am_wallet_currency" AS ENUM('IDR');--> statement-breakpoint
CREATE TABLE "am_accounts" (
	"id" text PRIMARY KEY NOT NULL,
	"account_id" text NOT NULL,
	"provider_id" text NOT NULL,
	"user_id" text NOT NULL,
	"access_token" text,
	"refresh_token" text,
	"id_token" text,
	"access_token_expires_at" timestamp,
	"refresh_token_expires_at" timestamp,
	"scope" text,
	"password" text,
	"created_at" timestamp NOT NULL,
	"updated_at" timestamp NOT NULL
);
--> statement-breakpoint
CREATE TABLE "am_users" (
	"id" text PRIMARY KEY NOT NULL,
	"name" text NOT NULL,
	"email" text NOT NULL,
	"email_verified" boolean DEFAULT false NOT NULL,
	"image" text,
	"role" text DEFAULT 'user' NOT NULL,
	"banned" boolean DEFAULT false NOT NULL,
	"ban_reason" text,
	"gender" "am_user_gender",
	"phone" jsonb NOT NULL,
	"ban_expires" timestamp,
	"created_at" timestamp NOT NULL,
	"updated_at" timestamp NOT NULL,
	CONSTRAINT "am_users_email_unique" UNIQUE("email"),
	CONSTRAINT "am_users_phone_unique" UNIQUE("phone")
);
--> statement-breakpoint
CREATE TABLE "am_verifications" (
	"id" text PRIMARY KEY NOT NULL,
	"identifier" text NOT NULL,
	"value" text NOT NULL,
	"expires_at" timestamp NOT NULL,
	"created_at" timestamp NOT NULL,
	"updated_at" timestamp NOT NULL,
	CONSTRAINT "am_verifications_identifier_unique" UNIQUE("identifier")
);
--> statement-breakpoint
CREATE TABLE "am_configurations" (
	"key" varchar(255) PRIMARY KEY NOT NULL,
	"name" varchar(255) NOT NULL,
	"value" jsonb NOT NULL,
	"description" text,
	"updated_by_id" text NOT NULL,
	"created_at" timestamp NOT NULL,
	"updated_at" timestamp NOT NULL
);
--> statement-breakpoint
CREATE TABLE "am___configurations_audit_log" (
	"id" serial PRIMARY KEY NOT NULL,
	"table_name" "am_allowed_logged_table" NOT NULL,
	"record_id" text NOT NULL,
	"operation" "am_operation" NOT NULL,
	"old_data" jsonb,
	"new_data" jsonb,
	"updated_by_id" text,
	"updated_at" timestamp NOT NULL
);
--> statement-breakpoint
CREATE TABLE "am_coupons" (
	"id" uuid PRIMARY KEY NOT NULL,
	"name" text NOT NULL,
	"code" text NOT NULL,
	"rules" jsonb NOT NULL,
	"discount_amount" numeric(18, 2),
	"discount_percentage" numeric(5, 2),
	"usage_limit" integer NOT NULL,
	"used_count" integer NOT NULL,
	"period_start" timestamp NOT NULL,
	"period_end" timestamp NOT NULL,
	"is_active" boolean DEFAULT false NOT NULL,
	"created_by_id" text NOT NULL,
	"created_at" timestamp NOT NULL,
	"updated_at" timestamp NOT NULL
);
--> statement-breakpoint
CREATE TABLE "am___coupon_audit_log" (
	"id" serial PRIMARY KEY NOT NULL,
	"table_name" "am_allowed_logged_table" NOT NULL,
	"record_id" text NOT NULL,
	"operation" "am_operation" NOT NULL,
	"old_data" jsonb,
	"new_data" jsonb,
	"updated_by_id" text,
	"updated_at" timestamp NOT NULL
);
--> statement-breakpoint
CREATE TABLE "am_coupon_usages" (
	"id" uuid PRIMARY KEY NOT NULL,
	"coupon_id" uuid NOT NULL,
	"order_id" uuid NOT NULL,
	"user_id" text NOT NULL,
	"discount_applied" numeric(18, 2) NOT NULL,
	"used_at" timestamp NOT NULL
);
--> statement-breakpoint
CREATE TABLE "am_drivers" (
	"id" uuid PRIMARY KEY NOT NULL,
	"user_id" text NOT NULL,
	"student_id" integer NOT NULL,
	"license_plate" text NOT NULL,
	"status" "am_driver_status" DEFAULT 'pending' NOT NULL,
	"rating" numeric(2, 1) DEFAULT 0 NOT NULL,
	"is_online" boolean DEFAULT false NOT NULL,
	"current_location" geometry(point),
	"bank" jsonb NOT NULL,
	"last_location_update" timestamp,
	"student_card" text NOT NULL,
	"driver_license" text NOT NULL,
	"vehicle_certificate" text NOT NULL,
	"created_at" timestamp NOT NULL,
	"updated_at" timestamp NOT NULL,
	CONSTRAINT "am_drivers_user_id_unique" UNIQUE("user_id"),
	CONSTRAINT "am_drivers_student_id_unique" UNIQUE("student_id"),
	CONSTRAINT "am_drivers_license_plate_unique" UNIQUE("license_plate")
);
--> statement-breakpoint
CREATE TABLE "am_driver_schedules" (
	"id" uuid PRIMARY KEY NOT NULL,
	"driver_id" uuid NOT NULL,
	"dayOfWeek" "am_day_of_week" NOT NULL,
	"start_time" jsonb NOT NULL,
	"end_time" jsonb NOT NULL,
	"is_recurring" boolean DEFAULT true NOT NULL,
	"specific_date" timestamp,
	"is_active" boolean DEFAULT true NOT NULL,
	"created_at" timestamp NOT NULL,
	"updated_at" timestamp NOT NULL
);
--> statement-breakpoint
CREATE TABLE "am_merchants" (
	"id" uuid PRIMARY KEY NOT NULL,
	"user_id" text NOT NULL,
	"name" text NOT NULL,
	"email" text NOT NULL,
	"phone" jsonb NOT NULL,
	"address" text NOT NULL,
	"location" geometry(point),
	"bank" jsonb NOT NULL,
	"categories" text[],
	"is_active" boolean DEFAULT true NOT NULL,
	"rating" numeric(2, 1) DEFAULT 0 NOT NULL,
	"document" text,
	"image" text,
	"created_at" timestamp NOT NULL,
	"updated_at" timestamp NOT NULL,
	CONSTRAINT "am_merchants_user_id_unique" UNIQUE("user_id"),
	CONSTRAINT "am_merchants_email_unique" UNIQUE("email"),
	CONSTRAINT "am_merchants_phone_unique" UNIQUE("phone")
);
--> statement-breakpoint
CREATE TABLE "am_merchant_menus" (
	"id" uuid PRIMARY KEY NOT NULL,
	"merchantId" uuid NOT NULL,
	"name" varchar(255) NOT NULL,
	"category" varchar(255),
	"base_price" numeric(10, 2) NOT NULL,
	"stock" integer NOT NULL,
	"image" text,
	"created_at" timestamp NOT NULL,
	"updated_at" timestamp NOT NULL
);
--> statement-breakpoint
CREATE TABLE "am_orders" (
	"id" uuid PRIMARY KEY NOT NULL,
	"user_id" text NOT NULL,
	"driver_id" uuid,
	"merchant_id" uuid,
	"type" "am_order_type" NOT NULL,
	"status" "am_order_status" DEFAULT 'requested' NOT NULL,
	"pickup_location" geometry(point) NOT NULL,
	"dropoff_location" geometry(point) NOT NULL,
	"distance_km" numeric(10, 2) NOT NULL,
	"base_price" numeric(18, 2) NOT NULL,
	"tip" numeric(18, 2),
	"total_price" numeric(18, 2) NOT NULL,
	"note" jsonb,
	"requested_at" timestamp NOT NULL,
	"accepted_at" timestamp,
	"arrived_at" timestamp,
	"cancelReason" text,
	"created_at" timestamp NOT NULL,
	"updated_at" timestamp NOT NULL,
	"gender" "am_user_gender"
);
--> statement-breakpoint
CREATE TABLE "am_payments" (
	"id" uuid PRIMARY KEY NOT NULL,
	"transaction_id" uuid,
	"provider" "am_payment_provider" NOT NULL,
	"method" "am_payment_method" NOT NULL,
	"amount" numeric(18, 2) NOT NULL,
	"status" "am_transaction_status" DEFAULT 'pending' NOT NULL,
	"external_id" varchar(100),
	"payment_url" text,
	"metadata" jsonb,
	"expires_at" timestamp,
	"payload" jsonb,
	"response" jsonb,
	"created_at" timestamp NOT NULL,
	"updated_at" timestamp NOT NULL,
	CONSTRAINT "am_payments_external_id_unique" UNIQUE("external_id")
);
--> statement-breakpoint
CREATE TABLE "am_reports" (
	"id" uuid PRIMARY KEY NOT NULL,
	"order_id" uuid,
	"reporter_id" text NOT NULL,
	"target_user_id" text NOT NULL,
	"category" "am_report_category" DEFAULT 'other' NOT NULL,
	"description" text NOT NULL,
	"evidence_url" text,
	"status" "am_report_status" DEFAULT 'pending' NOT NULL,
	"handled_by_id" text,
	"resolution" text,
	"reported_at" timestamp NOT NULL,
	"resolved_at" timestamp
);
--> statement-breakpoint
CREATE TABLE "am___report_audit_log" (
	"id" serial PRIMARY KEY NOT NULL,
	"table_name" "am_allowed_logged_table" NOT NULL,
	"record_id" text NOT NULL,
	"operation" "am_operation" NOT NULL,
	"old_data" jsonb,
	"new_data" jsonb,
	"updated_by_id" text,
	"updated_at" timestamp NOT NULL
);
--> statement-breakpoint
CREATE TABLE "am_reviews" (
	"id" uuid PRIMARY KEY NOT NULL,
	"order_id" uuid NOT NULL,
	"from_user_id" text NOT NULL,
	"to_user_id" text NOT NULL,
	"category" "am_review_category" DEFAULT 'other' NOT NULL,
	"score" integer DEFAULT 0 NOT NULL,
	"comment" text DEFAULT '' NOT NULL,
	"created_at" timestamp NOT NULL,
	"updated_at" timestamp NOT NULL
);
--> statement-breakpoint
CREATE TABLE "am_transactions" (
	"id" uuid PRIMARY KEY NOT NULL,
	"wallet_id" uuid NOT NULL,
	"type" "am_transaction_type" NOT NULL,
	"amount" numeric(18, 2) NOT NULL,
	"balance_before" numeric(18, 2),
	"balance_after" numeric(18, 2),
	"status" "am_transaction_status" DEFAULT 'pending' NOT NULL,
	"description" text,
	"reference_id" text,
	"metadata" jsonb,
	"created_at" timestamp NOT NULL,
	"updated_at" timestamp NOT NULL
);
--> statement-breakpoint
CREATE TABLE "am_wallets" (
	"id" uuid PRIMARY KEY NOT NULL,
	"user_id" text NOT NULL,
	"balance" numeric(18, 2) DEFAULT '0' NOT NULL,
	"currency" "am_wallet_currency" DEFAULT 'IDR' NOT NULL,
	"is_active" boolean DEFAULT true NOT NULL,
	"created_at" timestamp NOT NULL,
	"updated_at" timestamp NOT NULL
);
--> statement-breakpoint
ALTER TABLE "am_accounts" ADD CONSTRAINT "am_accounts_user_id_am_users_id_fk" FOREIGN KEY ("user_id") REFERENCES "public"."am_users"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "am_configurations" ADD CONSTRAINT "am_configurations_updated_by_id_am_users_id_fk" FOREIGN KEY ("updated_by_id") REFERENCES "public"."am_users"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "am_coupons" ADD CONSTRAINT "am_coupons_created_by_id_am_users_id_fk" FOREIGN KEY ("created_by_id") REFERENCES "public"."am_users"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "am_coupon_usages" ADD CONSTRAINT "am_coupon_usages_coupon_id_am_coupons_id_fk" FOREIGN KEY ("coupon_id") REFERENCES "public"."am_coupons"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "am_coupon_usages" ADD CONSTRAINT "am_coupon_usages_order_id_am_orders_id_fk" FOREIGN KEY ("order_id") REFERENCES "public"."am_orders"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "am_coupon_usages" ADD CONSTRAINT "am_coupon_usages_user_id_am_users_id_fk" FOREIGN KEY ("user_id") REFERENCES "public"."am_users"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "am_drivers" ADD CONSTRAINT "am_drivers_user_id_am_users_id_fk" FOREIGN KEY ("user_id") REFERENCES "public"."am_users"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "am_driver_schedules" ADD CONSTRAINT "am_driver_schedules_driver_id_am_drivers_id_fk" FOREIGN KEY ("driver_id") REFERENCES "public"."am_drivers"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "am_merchants" ADD CONSTRAINT "am_merchants_user_id_am_users_id_fk" FOREIGN KEY ("user_id") REFERENCES "public"."am_users"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "am_merchant_menus" ADD CONSTRAINT "am_merchant_menus_merchantId_am_merchants_id_fk" FOREIGN KEY ("merchantId") REFERENCES "public"."am_merchants"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "am_orders" ADD CONSTRAINT "am_orders_user_id_am_users_id_fk" FOREIGN KEY ("user_id") REFERENCES "public"."am_users"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "am_orders" ADD CONSTRAINT "am_orders_driver_id_am_drivers_id_fk" FOREIGN KEY ("driver_id") REFERENCES "public"."am_drivers"("id") ON DELETE set null ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "am_orders" ADD CONSTRAINT "am_orders_merchant_id_am_merchants_id_fk" FOREIGN KEY ("merchant_id") REFERENCES "public"."am_merchants"("id") ON DELETE set null ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "am_payments" ADD CONSTRAINT "am_payments_transaction_id_am_transactions_id_fk" FOREIGN KEY ("transaction_id") REFERENCES "public"."am_transactions"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "am_reports" ADD CONSTRAINT "am_reports_order_id_am_orders_id_fk" FOREIGN KEY ("order_id") REFERENCES "public"."am_orders"("id") ON DELETE set null ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "am_reports" ADD CONSTRAINT "am_reports_reporter_id_am_users_id_fk" FOREIGN KEY ("reporter_id") REFERENCES "public"."am_users"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "am_reports" ADD CONSTRAINT "am_reports_target_user_id_am_users_id_fk" FOREIGN KEY ("target_user_id") REFERENCES "public"."am_users"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "am_reports" ADD CONSTRAINT "am_reports_handled_by_id_am_users_id_fk" FOREIGN KEY ("handled_by_id") REFERENCES "public"."am_users"("id") ON DELETE set null ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "am_reviews" ADD CONSTRAINT "am_reviews_order_id_am_orders_id_fk" FOREIGN KEY ("order_id") REFERENCES "public"."am_orders"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "am_reviews" ADD CONSTRAINT "am_reviews_from_user_id_am_users_id_fk" FOREIGN KEY ("from_user_id") REFERENCES "public"."am_users"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "am_reviews" ADD CONSTRAINT "am_reviews_to_user_id_am_users_id_fk" FOREIGN KEY ("to_user_id") REFERENCES "public"."am_users"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "am_transactions" ADD CONSTRAINT "am_transactions_wallet_id_am_wallets_id_fk" FOREIGN KEY ("wallet_id") REFERENCES "public"."am_wallets"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "am_wallets" ADD CONSTRAINT "am_wallets_user_id_am_users_id_fk" FOREIGN KEY ("user_id") REFERENCES "public"."am_users"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
CREATE INDEX "am_account_user_id_idx" ON "am_accounts" USING btree ("user_id");--> statement-breakpoint
CREATE INDEX "am_account_provider_idx" ON "am_accounts" USING btree ("provider_id","account_id");--> statement-breakpoint
CREATE UNIQUE INDEX "am_user_email_idx" ON "am_users" USING btree ("email");--> statement-breakpoint
CREATE UNIQUE INDEX "am_user_phone_idx" ON "am_users" USING btree ("phone");--> statement-breakpoint
CREATE UNIQUE INDEX "am_verification_identifier_idx" ON "am_verifications" USING btree ("identifier");--> statement-breakpoint
CREATE INDEX "am_verification_expires_at_idx" ON "am_verifications" USING btree ("expires_at");--> statement-breakpoint
CREATE INDEX "am_configurations_audit_record_idx" ON "am___configurations_audit_log" USING btree ("record_id");--> statement-breakpoint
CREATE INDEX "am_configurations_audit_updated_at_idx" ON "am___configurations_audit_log" USING btree ("updated_at");--> statement-breakpoint
CREATE UNIQUE INDEX "am_coupon_code_idx" ON "am_coupons" USING btree ("code");--> statement-breakpoint
CREATE INDEX "am_coupon_is_active_idx" ON "am_coupons" USING btree ("is_active");--> statement-breakpoint
CREATE INDEX "am_coupon_period_start_idx" ON "am_coupons" USING btree ("period_start");--> statement-breakpoint
CREATE INDEX "am_coupon_period_end_idx" ON "am_coupons" USING btree ("period_end");--> statement-breakpoint
CREATE INDEX "am_coupon_active_period_idx" ON "am_coupons" USING btree ("is_active","period_start","period_end");--> statement-breakpoint
CREATE INDEX "am_coupon_created_by_id_idx" ON "am_coupons" USING btree ("created_by_id");--> statement-breakpoint
CREATE INDEX "am_coupon_used_count_idx" ON "am_coupons" USING btree ("used_count");--> statement-breakpoint
CREATE INDEX "am_coupon_created_at_idx" ON "am_coupons" USING btree ("created_at");--> statement-breakpoint
CREATE INDEX "am_coupon_audit_record_idx" ON "am___coupon_audit_log" USING btree ("record_id");--> statement-breakpoint
CREATE INDEX "am_coupon_audit_updated_at_idx" ON "am___coupon_audit_log" USING btree ("updated_at");--> statement-breakpoint
CREATE INDEX "am_coupon_usage_order_idx" ON "am_coupon_usages" USING btree ("order_id");--> statement-breakpoint
CREATE INDEX "am_coupon_usage_coupon_id_idx" ON "am_coupon_usages" USING btree ("coupon_id");--> statement-breakpoint
CREATE INDEX "am_coupon_usage_user_id_idx" ON "am_coupon_usages" USING btree ("user_id");--> statement-breakpoint
CREATE INDEX "am_coupon_usage_coupon_user_idx" ON "am_coupon_usages" USING btree ("coupon_id","user_id");--> statement-breakpoint
CREATE INDEX "am_coupon_usage_used_at_idx" ON "am_coupon_usages" USING btree ("used_at");--> statement-breakpoint
CREATE INDEX "am_coupon_usage_user_used_at_idx" ON "am_coupon_usages" USING btree ("user_id","used_at");--> statement-breakpoint
CREATE INDEX "am_driver_status_idx" ON "am_drivers" USING btree ("status");--> statement-breakpoint
CREATE INDEX "am_driver_is_online_idx" ON "am_drivers" USING btree ("is_online");--> statement-breakpoint
CREATE INDEX "am_driver_rating_idx" ON "am_drivers" USING btree ("rating");--> statement-breakpoint
CREATE INDEX "am_driver_status_online_idx" ON "am_drivers" USING btree ("status","is_online");--> statement-breakpoint
CREATE INDEX "am_driver_current_location_idx" ON "am_drivers" USING gist ("current_location");--> statement-breakpoint
CREATE INDEX "am_driver_online_location_idx" ON "am_drivers" USING gist ("current_location") WHERE is_online = true;--> statement-breakpoint
CREATE INDEX "am_schedule_driver_id_idx" ON "am_driver_schedules" USING btree ("driver_id");--> statement-breakpoint
CREATE INDEX "am_schedule_day_of_week_idx" ON "am_driver_schedules" USING btree ("dayOfWeek");--> statement-breakpoint
CREATE INDEX "am_schedule_is_active_idx" ON "am_driver_schedules" USING btree ("is_active");--> statement-breakpoint
CREATE INDEX "am_schedule_is_recurring_idx" ON "am_driver_schedules" USING btree ("is_recurring");--> statement-breakpoint
CREATE INDEX "am_schedule_specific_date_idx" ON "am_driver_schedules" USING btree ("specific_date");--> statement-breakpoint
CREATE INDEX "am_schedule_driver_active_idx" ON "am_driver_schedules" USING btree ("driver_id","is_active");--> statement-breakpoint
CREATE INDEX "am_schedule_driver_day_idx" ON "am_driver_schedules" USING btree ("driver_id","dayOfWeek");--> statement-breakpoint
CREATE INDEX "am_schedule_driver_day_active_idx" ON "am_driver_schedules" USING btree ("driver_id","dayOfWeek","is_active");--> statement-breakpoint
CREATE INDEX "am_schedule_driver_recurring_idx" ON "am_driver_schedules" USING btree ("driver_id","is_recurring");--> statement-breakpoint
CREATE INDEX "am_schedule_created_at_idx" ON "am_driver_schedules" USING btree ("created_at");--> statement-breakpoint
CREATE UNIQUE INDEX "am_merchant_user_id_idx" ON "am_merchants" USING btree ("user_id");--> statement-breakpoint
CREATE UNIQUE INDEX "am_merchant_email_idx" ON "am_merchants" USING btree ("email");--> statement-breakpoint
CREATE UNIQUE INDEX "am_merchant_phone_idx" ON "am_merchants" USING btree ("phone");--> statement-breakpoint
CREATE INDEX "am_merchant_is_active_idx" ON "am_merchants" USING btree ("is_active");--> statement-breakpoint
CREATE INDEX "am_merchant_rating_idx" ON "am_merchants" USING btree ("rating");--> statement-breakpoint
CREATE INDEX "am_merchant_created_at_idx" ON "am_merchants" USING btree ("created_at");--> statement-breakpoint
CREATE INDEX "am_merchant_location_idx" ON "am_merchants" USING gist ("location");--> statement-breakpoint
CREATE INDEX "am_merchant_menu_merchant_id_idx" ON "am_merchant_menus" USING btree ("merchantId");--> statement-breakpoint
CREATE INDEX "am_merchant_menu_category_idx" ON "am_merchant_menus" USING btree ("category");--> statement-breakpoint
CREATE INDEX "am_merchant_menu_stock_idx" ON "am_merchant_menus" USING btree ("stock");--> statement-breakpoint
CREATE INDEX "am_merchant_menu_merchant_category_idx" ON "am_merchant_menus" USING btree ("merchantId","category");--> statement-breakpoint
CREATE INDEX "am_merchant_menu_price_idx" ON "am_merchant_menus" USING btree ("base_price");--> statement-breakpoint
CREATE INDEX "am_merchant_menu_created_at_idx" ON "am_merchant_menus" USING btree ("created_at");--> statement-breakpoint
CREATE INDEX "am_order_user_id_idx" ON "am_orders" USING btree ("user_id");--> statement-breakpoint
CREATE INDEX "am_order_driver_id_idx" ON "am_orders" USING btree ("driver_id");--> statement-breakpoint
CREATE INDEX "am_order_merchant_id_idx" ON "am_orders" USING btree ("merchant_id");--> statement-breakpoint
CREATE INDEX "am_payment_external_id_idx" ON "am_payments" USING btree ("external_id");--> statement-breakpoint
CREATE INDEX "am_report_order_id_idx" ON "am_reports" USING btree ("order_id");--> statement-breakpoint
CREATE INDEX "am_report_reporter_id_idx" ON "am_reports" USING btree ("reporter_id");--> statement-breakpoint
CREATE INDEX "am_report_target_user_id_idx" ON "am_reports" USING btree ("target_user_id");--> statement-breakpoint
CREATE INDEX "am_report_handled_by_id_idx" ON "am_reports" USING btree ("handled_by_id");--> statement-breakpoint
CREATE INDEX "am_report_category_idx" ON "am_reports" USING btree ("category");--> statement-breakpoint
CREATE INDEX "am_report_status_idx" ON "am_reports" USING btree ("status");--> statement-breakpoint
CREATE INDEX "am_report_status_category_idx" ON "am_reports" USING btree ("status","category");--> statement-breakpoint
CREATE INDEX "am_report_target_status_idx" ON "am_reports" USING btree ("target_user_id","status");--> statement-breakpoint
CREATE INDEX "am_report_reporter_status_idx" ON "am_reports" USING btree ("reporter_id","status");--> statement-breakpoint
CREATE INDEX "am_report_reported_at_idx" ON "am_reports" USING btree ("reported_at");--> statement-breakpoint
CREATE INDEX "am_report_resolved_at_idx" ON "am_reports" USING btree ("resolved_at");--> statement-breakpoint
CREATE INDEX "am_report_status_reported_at_idx" ON "am_reports" USING btree ("status","reported_at");--> statement-breakpoint
CREATE INDEX "am_report_audit_record_idx" ON "am___report_audit_log" USING btree ("record_id");--> statement-breakpoint
CREATE INDEX "am_report_audit_updated_at_idx" ON "am___report_audit_log" USING btree ("updated_at");--> statement-breakpoint
CREATE UNIQUE INDEX "am_review_order_from_user_idx" ON "am_reviews" USING btree ("order_id","from_user_id");--> statement-breakpoint
CREATE INDEX "am_review_order_id_idx" ON "am_reviews" USING btree ("order_id");--> statement-breakpoint
CREATE INDEX "am_review_from_user_id_idx" ON "am_reviews" USING btree ("from_user_id");--> statement-breakpoint
CREATE INDEX "am_review_to_user_id_idx" ON "am_reviews" USING btree ("to_user_id");--> statement-breakpoint
CREATE INDEX "am_review_category_idx" ON "am_reviews" USING btree ("category");--> statement-breakpoint
CREATE INDEX "am_review_score_idx" ON "am_reviews" USING btree ("score");--> statement-breakpoint
CREATE INDEX "am_review_to_user_score_idx" ON "am_reviews" USING btree ("to_user_id","score");--> statement-breakpoint
CREATE INDEX "am_review_to_user_category_idx" ON "am_reviews" USING btree ("to_user_id","category");--> statement-breakpoint
CREATE INDEX "am_review_created_at_idx" ON "am_reviews" USING btree ("created_at");--> statement-breakpoint
CREATE INDEX "am_review_to_user_created_at_idx" ON "am_reviews" USING btree ("to_user_id","created_at");--> statement-breakpoint
CREATE INDEX "am_transaction_wallet_id_idx" ON "am_transactions" USING btree ("wallet_id");