ALTER TABLE "am___configurations_audit_log" ADD COLUMN "ip_address" text;--> statement-breakpoint
ALTER TABLE "am___configurations_audit_log" ADD COLUMN "user_agent" text;--> statement-breakpoint
ALTER TABLE "am___configurations_audit_log" ADD COLUMN "session_id" text;--> statement-breakpoint
ALTER TABLE "am___configurations_audit_log" ADD COLUMN "reason" text;--> statement-breakpoint
ALTER TABLE "am___contact_audit_log" ADD COLUMN "ip_address" text;--> statement-breakpoint
ALTER TABLE "am___contact_audit_log" ADD COLUMN "user_agent" text;--> statement-breakpoint
ALTER TABLE "am___contact_audit_log" ADD COLUMN "session_id" text;--> statement-breakpoint
ALTER TABLE "am___contact_audit_log" ADD COLUMN "reason" text;--> statement-breakpoint
ALTER TABLE "am___coupon_audit_log" ADD COLUMN "ip_address" text;--> statement-breakpoint
ALTER TABLE "am___coupon_audit_log" ADD COLUMN "user_agent" text;--> statement-breakpoint
ALTER TABLE "am___coupon_audit_log" ADD COLUMN "session_id" text;--> statement-breakpoint
ALTER TABLE "am___coupon_audit_log" ADD COLUMN "reason" text;--> statement-breakpoint
ALTER TABLE "am___report_audit_log" ADD COLUMN "ip_address" text;--> statement-breakpoint
ALTER TABLE "am___report_audit_log" ADD COLUMN "user_agent" text;--> statement-breakpoint
ALTER TABLE "am___report_audit_log" ADD COLUMN "session_id" text;--> statement-breakpoint
ALTER TABLE "am___report_audit_log" ADD COLUMN "reason" text;--> statement-breakpoint
CREATE INDEX "am_configurations_audit_updated_by_idx" ON "am___configurations_audit_log" USING btree ("updated_by_id");--> statement-breakpoint
CREATE INDEX "am_configurations_audit_ip_address_idx" ON "am___configurations_audit_log" USING btree ("ip_address");--> statement-breakpoint
CREATE INDEX "am_contact_audit_updated_by_idx" ON "am___contact_audit_log" USING btree ("updated_by_id");--> statement-breakpoint
CREATE INDEX "am_contact_audit_ip_address_idx" ON "am___contact_audit_log" USING btree ("ip_address");--> statement-breakpoint
CREATE INDEX "am_coupon_audit_updated_by_idx" ON "am___coupon_audit_log" USING btree ("updated_by_id");--> statement-breakpoint
CREATE INDEX "am_coupon_audit_ip_address_idx" ON "am___coupon_audit_log" USING btree ("ip_address");--> statement-breakpoint
CREATE INDEX "am_report_audit_updated_by_idx" ON "am___report_audit_log" USING btree ("updated_by_id");--> statement-breakpoint
CREATE INDEX "am_report_audit_ip_address_idx" ON "am___report_audit_log" USING btree ("ip_address");