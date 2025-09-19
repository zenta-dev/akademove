import tailwindcss from "@tailwindcss/vite";
import { tanstackStart } from "@tanstack/react-start/plugin/vite";
import viteReact from "@vitejs/plugin-react";
import alchemy from "alchemy/cloudflare/tanstack-start";
import { defineConfig } from "vite";
import tsconfigPaths from "vite-tsconfig-paths";

function encodeString(str: string) {
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
							return encodeString("rd");
						}
						if (parts[idx + 1] === "react") {
							return encodeString("r");
						}
						if (parts[idx + 1] === "scheduler") {
							return encodeString("rsc");
						}

						if (id.includes("zod")) {
							return encodeString("z");
						}
						// if (id.includes("better-auth")) {
						// 	return simpleHash("ba");
						// }
						if (id.includes("radix-ui")) {
							return encodeString("rdxui");
						}
						if (id.includes("lucide")) {
							return encodeString("l");
						}
						if (id.includes("sonner")) {
							return encodeString("s");
						}
						if (id.includes("framer-motion")) {
							return encodeString("fm");
						}
						if (id.includes("date-fns")) {
							return encodeString("df");
						}
						if (id.includes("react-day-picker")) {
							return encodeString("rdp");
						}
						if (id.includes("@orpc")) {
							return encodeString("orpc");
						}
						if (parts[idx + 1] === "@tanstack") {
							if (parts[idx + 2] === "start-server-functions-client") {
								return encodeString("tssfc");
							}
							if (parts[idx + 2] === "start-server-functions-fetcher") {
								return encodeString("tssff");
							}
							if (parts[idx + 2] === "react-start-client") {
								return encodeString("trsc");
							}
							if (parts[idx + 2] === "start-client-core") {
								return encodeString("tscc");
							}
							if (parts[idx + 2] === "router-core") {
								return encodeString("trc");
							}
							if (parts[idx + 2] === "react-router") {
								return encodeString("trr");
							}
							if (parts[idx + 2] === "react-query") {
								return encodeString("trq");
							}
							if (parts[idx + 2] === "react-table") {
								return encodeString("trt");
							}
							if (parts[idx + 2] === "react-store") {
								return encodeString("trs");
							}
							if (parts[idx + 2] === "query-core") {
								return encodeString("tqc");
							}
							if (parts[idx + 2] === "table-core") {
								return encodeString("ttc");
							}
							if (parts[idx + 2] === "history") {
								return encodeString("th");
							}
							if (parts[idx + 2] === "query") {
								return encodeString("tq");
							}
							if (parts[idx + 2] === "start") {
								return encodeString("ts");
							}
							return encodeString("t");
						}
					}

					if (id.includes("packages")) {
						const parts = id.split("/");
						const fileName = parts[parts.length - 1]?.replace(
							/\.(ts|tsx|js|jsx)$/,
							"",
						);

						return encodeString(`p${fileName}`);
					}
				},
			},
		},
	},
});
