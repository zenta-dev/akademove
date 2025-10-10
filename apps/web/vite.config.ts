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
		tanstackStart({
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
		// minify: false,
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
						if (id.includes("next-themes")) {
							return encodeString("nt");
						}
						if (id.includes("react-hook-form")) {
							return encodeString("rhf");
						}
						if (id.includes("class-variance-authority")) {
							return encodeString("cva");
						}
						if (id.includes("clsx")) {
							return encodeString("clsx");
						}
						if (id.includes("tailwind-merge")) {
							return encodeString("twm");
						}
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
					}
					if (id.includes("packages")) {
						const parts = id.split("/");
						const fileName = parts[parts.length - 1]?.replace(
							/\.(ts|tsx|js|jsx)$/,
							"",
						);
						return encodeString(`p-${fileName}`);
					}
				},
			},
		},
	},
});
