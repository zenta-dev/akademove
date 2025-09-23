import { defineNitroConfig } from "nitropack/config";

export default defineNitroConfig({
	preset: "cloudflare-module",
	cloudflare: {
		nodeCompat: true,
	},
	sourceMap: process.env.NODE_ENV === "development",
	minify: true,
	compressPublicAssets: {
		gzip: true,
		brotli: true,
	},
	rollupConfig: {
		treeshake: {
			preset: "smallest",
			moduleSideEffects: false,
			propertyReadSideEffects: false,
		},
	},
});
