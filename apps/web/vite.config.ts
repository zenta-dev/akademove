import tailwindcss from "@tailwindcss/vite";
import { tanstackStart } from "@tanstack/react-start/plugin/vite";
import viteReact from "@vitejs/plugin-react";
import alchemy from "alchemy/cloudflare/tanstack-start";
import { defineConfig } from "vite";
import tsconfigPaths from "vite-tsconfig-paths";

function simpleHash(str: string) {
	const result = str
		.split("")
		.map((char) => String.fromCharCode(char.charCodeAt(0) + 5))
		.join("");

	return result.replace(/[-_~]/g, () => {
		const chars =
			"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
		return chars.charAt(Math.floor(Math.random() * chars.length));
	});
}

export default defineConfig({
	plugins: [
		tsconfigPaths(),
		tailwindcss(),
		tanstackStart({ customViteReactPlugin: true, target: "cloudflare-module" }),
		viteReact(),
		alchemy(),
	],
	build: {
		target: "esnext",
		rollupOptions: {
			external: ["node:async_hooks", "cloudflare:workers"],
			output: {
				manualChunks(id) {
					if (id.includes("node_modules")) {
						const parts = id.split("/");
						const idx = parts.lastIndexOf("node_modules");

						if (parts[idx + 1] === "react-dom") {
							return simpleHash("rd");
						}
						if (parts[idx + 1] === "react") {
							return simpleHash("r");
						}
						if (parts[idx + 1] === "scheduler") {
							return simpleHash("rsc");
						}

						if (id.includes("zod")) {
							return simpleHash("z");
						}
						// if (id.includes("better-auth")) {
						// 	return simpleHash("ba");
						// }
						if (id.includes("radix-ui")) {
							return simpleHash("rdxui");
						}
						if (id.includes("lucide")) {
							return simpleHash("l");
						}
						if (id.includes("sonner")) {
							return simpleHash("s");
						}
						if (id.includes("framer-motion")) {
							return simpleHash("fm");
						}
						if (id.includes("date-fns")) {
							return simpleHash("df");
						}
						if (id.includes("react-day-picker")) {
							return simpleHash("rdp");
						}
						if (id.includes("@orpc")) {
							return simpleHash("orpc");
						}
						if (parts[idx + 1] === "@tanstack") {
							if (parts[idx + 2] === "start-server-functions-client") {
								return simpleHash("tssfc");
							}
							if (parts[idx + 2] === "start-server-functions-fetcher") {
								return simpleHash("tssff");
							}
							if (parts[idx + 2] === "react-start-client") {
								return simpleHash("trsc");
							}
							if (parts[idx + 2] === "start-client-core") {
								return simpleHash("tscc");
							}
							if (parts[idx + 2] === "router-core") {
								return simpleHash("trc");
							}
							if (parts[idx + 2] === "react-router") {
								return simpleHash("trr");
							}
							if (parts[idx + 2] === "react-query") {
								return simpleHash("trq");
							}
							if (parts[idx + 2] === "react-table") {
								return simpleHash("trt");
							}
							if (parts[idx + 2] === "react-store") {
								return simpleHash("trs");
							}
							if (parts[idx + 2] === "query-core") {
								return simpleHash("tqc");
							}
							if (parts[idx + 2] === "table-core") {
								return simpleHash("ttc");
							}
							if (parts[idx + 2] === "history") {
								return simpleHash("th");
							}
							if (parts[idx + 2] === "query") {
								return simpleHash("tq");
							}
							if (parts[idx + 2] === "start") {
								return simpleHash("ts");
							}
							return simpleHash("t");
						}
					}

					if (id.includes("packages")) {
						const parts = id.split("/");
						const fileName = parts[parts.length - 1]?.replace(
							/\.(ts|tsx|js|jsx)$/,
							"",
						);

						return simpleHash(`p${fileName}`);
					}
				},
			},
		},
	},
});
