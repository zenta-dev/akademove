import tailwindcss from "@tailwindcss/vite";
import { tanstackStart } from "@tanstack/react-start/plugin/vite";
import viteReact from "@vitejs/plugin-react";
import alchemy from "alchemy/cloudflare/tanstack-start";
import { defineConfig } from "vite";
import tsconfigPaths from "vite-tsconfig-paths";

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
	assetsInclude: [
		"**/*.svg",
		"**/*.png",
		"**/*.jpg",
		"**/*.jpeg",
		"**/*.gif",
		"**/*.webp",
		"**/*.ico",
	],
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
				chunkFileNames: "assets/[name].js",
				entryFileNames: "assets/[name].js",
				assetFileNames: "assets/[name].[ext]",
				manualChunks(id) {
					if (id.includes("node_modules")) {
						const parts = id.split("/");
						const idx = parts.lastIndexOf("node_modules");
						if (parts[idx + 1] === "react-dom") {
							return "react-dom";
						}
						if (parts[idx + 1] === "react") {
							return "react";
						}
						if (parts[idx + 1] === "scheduler") {
							return "scheduler";
						}
						if (id.includes("zod")) {
							return "zod";
						}
						if (id.includes("next-themes")) {
							return "next-themes";
						}
						if (id.includes("react-hook-form")) {
							return "react-hook-form";
						}
						if (id.includes("class-variance-authority")) {
							return "class-variance-authority";
						}
						if (id.includes("clsx")) {
							return "clsx";
						}
						if (id.includes("tailwind-merge")) {
							return "tailwind-merge";
						}
						if (parts[idx + 1].includes("radix-ui")) {
							return `radix-ui-${parts[idx + 2]}`;
						}
						if (id.includes("lucide")) {
							return "lucide";
						}
						if (id.includes("sonner")) {
							return "sonner";
						}
						if (id.includes("framer-motion")) {
							return "framer-motion";
						}
						if (id.includes("date-fns")) {
							return "date-fns";
						}
						if (id.includes("react-day-picker")) {
							return "react-day-picker";
						}
						if (id.includes("@orpc")) {
							return "orpc";
						}
						if (id.includes("radash")) {
							return "radash";
						}
						if (id.includes("cmdk")) {
							return "cmdk";
						}
						if (id.includes("pino")) {
							return "pino";
						}
						if (id.includes("react-medium-image-zoom")) {
							return "react-medium-image-zoom";
						}
						// if (id.includes("react-phone-number-input")) {
						// 	return "react-phone-number-input";
						// }
					}
				},
			},
		},
	},
});
