import { paraglideVitePlugin } from "@inlang/paraglide-js";
import { defineConfig } from "tsdown";
import dts from "unplugin-dts/vite";

// used for build paraglide
export default defineConfig({
	entry: ["src/index.js"],
	unbundle: true,
	clean: false,
	dts: true,
	plugins: [
		paraglideVitePlugin({
			project: "./project.inlang",
			outdir: "./src/paraglide",
			cookieName: "locale",
			localStorageKey: "locale",
			disableAsyncLocalStorage: true,
			strategy: ["url", "cookie", "baseLocale", "globalVariable"],
		}),
		dts({
			insertTypesEntry: true,
			outDirs: ["dist"],
		}),
	],
});
