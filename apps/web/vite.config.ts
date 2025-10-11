import { createHash } from "node:crypto";
import tailwindcss from "@tailwindcss/vite";
import { tanstackStart } from "@tanstack/react-start/plugin/vite";
import viteReact from "@vitejs/plugin-react";
import alchemy from "alchemy/cloudflare/tanstack-start";
import { defineConfig } from "vite";
import tsconfigPaths from "vite-tsconfig-paths";

const hashCache = new Map<string, string>();

function hashString(str: string): string {
	if (hashCache.has(str)) return hashCache.get(str) ?? "";

	const hash = createHash("sha256").update(str).digest("hex").slice(0, 5);
	hashCache.set(str, hash);
	return hash;
}

const prerender = {
	crawlLinks: true,
	retryCount: 2,
	retryDelay: 1000,
};
export default defineConfig({
	define: {
		"globalThis.Cloudflare.compatibilityFlags": {
			enable_nodejs_process_v2: true,
		},
	},
	plugins: [
		tsconfigPaths(),
		tailwindcss(),
		tanstackStart({
			prerender: {
				...prerender,
				enabled: true,
				autoSubfolderIndex: true,
				concurrency: 14,
				onSuccess: ({ page }) => {
					console.log(`Rendered ${page.path}!`);
				},
			},
			pages: [
				{ path: "/", prerender },
				{ path: "/sign-in", prerender },
				{ path: "/sign-up/driver", prerender },
				{ path: "/sign-up/merchant", prerender },
				{ path: "/sign-up/user", prerender },
				{ path: "/reset-password", prerender },
				{ path: "/forgot-password", prerender },
			],
			sitemap: {
				enabled: true,
				host: process.env.WEB_URL || "http://localhost:3001",
			},
		}),
		viteReact(),
		alchemy(),
	],
	optimizeDeps: {
		exclude: ["async_hooks"], // prevent pre-bundling
	},
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
							return hashString("rd");
						}
						if (parts[idx + 1] === "react") {
							return hashString("r");
						}
						if (parts[idx + 1] === "scheduler") {
							return hashString("rsc");
						}
						if (id.includes("zod")) {
							return hashString("z");
						}
						if (id.includes("next-themes")) {
							return hashString("nt");
						}
						if (id.includes("react-hook-form")) {
							return hashString("rhf");
						}
						if (id.includes("class-variance-authority")) {
							return hashString("cva");
						}
						if (id.includes("clsx")) {
							return hashString("clsx");
						}
						if (id.includes("tailwind-merge")) {
							return hashString("twm");
						}
						if (parts[idx + 1].includes("radix-ui")) {
							return hashString(`rdxui${parts[idx + 2]}`);
						}
						if (id.includes("lucide")) {
							return hashString("l");
						}
						if (id.includes("sonner")) {
							return hashString("s");
						}
						if (id.includes("framer-motion")) {
							return hashString("fm");
						}
						if (id.includes("date-fns")) {
							return hashString("df");
						}
						if (id.includes("react-day-picker")) {
							return hashString("rdp");
						}
						if (id.includes("@orpc")) {
							return hashString("orpc");
						}
						if (id.includes("radash")) {
							return hashString("radash");
						}
						if (id.includes("cmdk")) {
							return hashString("cmdk");
						}
						if (id.includes("pino")) {
							return hashString("pino");
						}
					}
					if (id.includes("apps")) {
						if (id.includes("ui")) {
							const parts = id.split("/");
							const fileName = parts[parts.length - 1]?.replace(
								/\.(ts|tsx|js|jsx)$/,
								"",
							);
							return hashString(`a-ui-${fileName}`);
						}
						if (id.includes("utils")) {
							const parts = id.split("/");
							const fileName = parts[parts.length - 1]?.replace(
								/\.(ts|tsx|js|jsx)$/,
								"",
							);
							return hashString(`a-ut-${fileName}`);
						}
						if (id.includes("hook")) {
							const parts = id.split("/");
							const fileName = parts[parts.length - 1]?.replace(
								/\.(ts|tsx|js|jsx)$/,
								"",
							);
							return hashString(`a-hook-${fileName}`);
						}
						if (id.includes("toggle")) {
							const parts = id.split("/");
							const fileName = parts[parts.length - 1]?.replace(
								/\.(ts|tsx|js|jsx)$/,
								"",
							);
							return hashString(`a-toggle-${fileName}`);
						}
						if (id.includes("misc")) {
							const parts = id.split("/");
							const fileName = parts[parts.length - 1]?.replace(
								/\.(ts|tsx|js|jsx)$/,
								"",
							);
							return hashString(`a-misc-${fileName}`);
						}
					}
					if (id.includes("packages")) {
						const parts = id.split("/");
						const fileName = parts[parts.length - 1]?.replace(
							/\.(ts|tsx|js|jsx)$/,
							"",
						);
						return hashString(`p-${fileName}`);
					}
				},
			},
		},
	},
});
