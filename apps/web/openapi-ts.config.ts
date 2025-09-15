import { defineConfig } from "@hey-api/openapi-ts";

export default defineConfig({
	input: "https://akademove-server.zenta.dev/openapi.json",
	output: "src/api",
	plugins: ["@tanstack/react-query"],
});
