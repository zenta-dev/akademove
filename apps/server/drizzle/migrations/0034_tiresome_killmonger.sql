CREATE TABLE "am_merchant_menu_categories" (
	"id" uuid PRIMARY KEY NOT NULL,
	"merchantId" uuid NOT NULL,
	"name" varchar(255) NOT NULL,
	"description" text,
	"sort_order" integer DEFAULT 0 NOT NULL,
	"created_at" timestamp NOT NULL,
	"updated_at" timestamp NOT NULL
);
--> statement-breakpoint
ALTER TABLE "am_merchant_menus" ADD COLUMN "category_id" uuid;--> statement-breakpoint
ALTER TABLE "am_merchant_menu_categories" ADD CONSTRAINT "am_merchant_menu_categories_merchantId_am_merchants_id_fk" FOREIGN KEY ("merchantId") REFERENCES "public"."am_merchants"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
CREATE INDEX "am_merchant_menu_category_merchant_id_idx" ON "am_merchant_menu_categories" USING btree ("merchantId");--> statement-breakpoint
CREATE INDEX "am_merchant_menu_category_name_idx" ON "am_merchant_menu_categories" USING btree ("name");--> statement-breakpoint
CREATE INDEX "am_merchant_menu_category_sort_order_idx" ON "am_merchant_menu_categories" USING btree ("sort_order");--> statement-breakpoint
CREATE UNIQUE INDEX "am_merchant_menu_category_merchant_name_idx" ON "am_merchant_menu_categories" USING btree ("merchantId","name");--> statement-breakpoint
CREATE INDEX "am_merchant_menu_category_created_at_idx" ON "am_merchant_menu_categories" USING btree ("created_at");--> statement-breakpoint
ALTER TABLE "am_merchant_menus" ADD CONSTRAINT "am_merchant_menus_category_id_am_merchant_menu_categories_id_fk" FOREIGN KEY ("category_id") REFERENCES "public"."am_merchant_menu_categories"("id") ON DELETE set null ON UPDATE no action;--> statement-breakpoint
CREATE INDEX "am_merchant_menu_category_id_idx" ON "am_merchant_menus" USING btree ("category_id");--> statement-breakpoint
CREATE INDEX "am_merchant_menu_merchant_category_id_idx" ON "am_merchant_menus" USING btree ("merchantId","category_id");