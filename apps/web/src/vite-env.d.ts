/** biome-ignore-all lint/suspicious/noEmptyInterface: for infer */
/** biome-ignore-all lint/correctness/noUnusedVariables: for infer */

interface ViteTypeOptions {
	// By adding this line, you can make the type of ImportMetaEnv strict
	// to disallow unknown keys.
	// strictImportMetaEnv: unknown
}

interface ImportMetaEnv {
	readonly VITE_NODE_ENV: string;
	readonly VITE_WEB_URL: string;
	readonly VITE_SERVER_URL: string;
	readonly VITE_GOOGLE_MAPS_API_KEY: string;

	readonly VITE_FIREBASE_API_KEY: string;
	readonly VITE_FIREBASE_AUTH_DOMAIN: string;
	readonly VITE_FIREBASE_PROJECT_ID: string;
	readonly VITE_FIREBASE_STORAGE_BUCKET: string;
	readonly VITE_FIREBASE_MESSAGING_SENDER_ID: string;
	readonly VITE_FIREBASE_APP_ID: string;
	readonly VITE_FIREBASE_MEASUREMENT_ID: string;
	readonly VITE_FIREBASE_VAPID_KEY: string;
}

interface ImportMeta {
	readonly env: ImportMetaEnv;
}

declare global {
	namespace NodeJS {
		interface ProcessEnv {
			readonly LOG_SOURCE_TOKEN: string;
			readonly LOG_ENDPOINT: string;
		}
	}
}
