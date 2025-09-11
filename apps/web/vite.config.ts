import tailwindcss from "@tailwindcss/vite";
import { tanstackStart } from "@tanstack/react-start/plugin/vite";
import viteReact from "@vitejs/plugin-react";
import alchemy from "alchemy/cloudflare/tanstack-start";
import { defineConfig } from "vite";
import tsconfigPaths from "vite-tsconfig-paths";

function simpleHash(str: string) {
	let hash = 0;
	const len = str.length;
	if (len === 0) return "0";

	for (let i = 0; i < len; i++) {
		hash = ((hash << 5) - hash + str.charCodeAt(i)) | 0;
	}
	return (hash >>> 0).toString(36);
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

						if (id.includes("zod")) return simpleHash("z");
						if (id.includes("lucide")) return simpleHash("l");
						if (id.includes("sonner")) return simpleHash("s");
						if (parts[idx + 1] === "@tanstack") {
							if (parts[idx + 2] === "react-query-devtools")
								return simpleHash("tsrqd");
							if (parts[idx + 2] === "react-router-devtools")
								return simpleHash("tsrrd");
							if (parts[idx + 2] === "react-start-client")
								return simpleHash("tsrsc");
							if (parts[idx + 2] === "react-store") return simpleHash("tsrs");
							if (parts[idx + 2] === "query-devtools")
								return simpleHash("tsqd");
							if (parts[idx + 2] === "react-query") return simpleHash("tsrq");
							if (parts[idx + 2] === "store") return simpleHash("tss");
							if (parts[idx + 2] === "history") return simpleHash("tsh");
							if (parts[idx + 2] === "react-router") return simpleHash("tsrr");
							if (parts[idx + 2] === "query-core") return simpleHash("tsqc");
							if (parts[idx + 2] === "router-core") return simpleHash("tsrc");
							return simpleHash("ts/i");
						}
						return simpleHash("v");
					}
					if (id.includes("packages")) {
						const parts = id.split("/");
						const fileName = parts[parts.length - 1]?.replace(
							/\.(ts|tsx|js|jsx)$/,
							"",
						);
						return simpleHash(`p${fileName}`);
					}
					return undefined;
				},
			},
		},
	},
});
