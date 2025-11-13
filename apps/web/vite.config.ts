import { createHash } from "node:crypto";
import { readFileSync, writeFileSync } from "node:fs";
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
	enabled: true,
	crawlLinks: true,
	retryCount: 2,
	retryDelay: 1000,
	autoSubfolderIndex: true,
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
			pages: [
				{ path: "/", prerender },
				{ path: "/sign-in", prerender },
				{ path: "/sign-up/driver", prerender },
				{ path: "/sign-up/merchant", prerender },
				{ path: "/sign-up/user", prerender },
				{ path: "/reset-password", prerender },
				{ path: "/forgot-password", prerender },
				{ path: "/id", prerender },
				{ path: "/id/sign-in", prerender },
				{ path: "/id/sign-up/driver", prerender },
				{ path: "/id/sign-up/merchant", prerender },
				{ path: "/id/sign-up/user", prerender },
				{ path: "/id/reset-password", prerender },
				{ path: "/id/forgot-password", prerender },
			],
			sitemap: {
				enabled: true,
				host: process.env.VITE_WEB_URL || "http://localhost:3001",
			},
		}),
		viteReact(),
		alchemy(),
	],
	optimizeDeps: {
		exclude: ["async_hooks"], // prevent pre-bundling
	},
	build: {
		minify: true,
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
						if (id.includes("react-medium-image-zoom")) {
							return hashString("pmiz");
						}
						// if (id.includes("react-phone-number-input")) {
						// 	return hashString("rpni");
						// }
					}
				},
			},
		},
	},
});
