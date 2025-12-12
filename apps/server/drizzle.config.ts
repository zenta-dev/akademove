import { defineConfig } from "drizzle-kit";

export default defineConfig({
	schema: "./src/core/tables",
	out: "./drizzle/migrations",
	dialect: "postgresql",
	dbCredentials: {
		url: process.env.DATABASE_URL || "",
	},
	extensionsFilters: ["postgis"],
});
