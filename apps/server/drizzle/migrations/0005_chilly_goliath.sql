CREATE INDEX "am_payment_transaction_id_idx" ON "am_payments" USING btree ("transaction_id");--> statement-breakpoint
CREATE INDEX "am_payment_status_idx" ON "am_payments" USING btree ("status");--> statement-breakpoint
CREATE INDEX "am_payment_method_idx" ON "am_payments" USING btree ("method");--> statement-breakpoint
CREATE INDEX "am_payment_provider_idx" ON "am_payments" USING btree ("provider");--> statement-breakpoint
CREATE INDEX "am_payment_created_at_idx" ON "am_payments" USING btree ("created_at");--> statement-breakpoint
CREATE INDEX "am_payment_expires_at_idx" ON "am_payments" USING btree ("expires_at");--> statement-breakpoint
CREATE INDEX "am_transaction_status_idx" ON "am_transactions" USING btree ("status");--> statement-breakpoint
CREATE INDEX "am_transaction_wallet_status_idx" ON "am_transactions" USING btree ("wallet_id","status");--> statement-breakpoint
CREATE INDEX "am_transaction_wallet_status_date_idx" ON "am_transactions" USING btree ("wallet_id","status","created_at");--> statement-breakpoint
CREATE INDEX "am_transaction_created_at_idx" ON "am_transactions" USING btree ("created_at");--> statement-breakpoint
CREATE INDEX "am_transaction_reference_id_idx" ON "am_transactions" USING btree ("reference_id");