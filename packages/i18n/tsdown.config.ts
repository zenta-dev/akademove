import { paraglideVitePlugin } from "@inlang/paraglide-js";
import { defineConfig } from "tsdown";
import dts from "unplugin-dts/vite";

// used for build paraglide
export default defineConfig({
	entry: ["src/index.js"],
	unbundle: true,
	clean: false,
	dts: true,
	ignoreWatch:[".turbo"],
	plugins: [
		paraglideVitePlugin({
			project: "./project.inlang",
			outdir: "./src/paraglide",
			outputStructure:'message-modules',
			cookieName: "locale",
			localStorageKey: "locale",
			disableAsyncLocalStorage: false,
			cleanOutdir: false,
			strategy: ["url", "cookie", "preferredLanguage", "baseLocale"],
		}),
		dts({
			insertTypesEntry: true,
			outDirs: ["dist"],
		}),
	],
});
