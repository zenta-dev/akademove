/// <reference types="vite/client" />

export interface ImportMetaEnv {
	// Client-side environment variables
	readonly VITE_NODE_ENV: string;
	readonly VITE_WEB_URL: string;
	readonly VITE_SERVER_URL: string;
	readonly VITE_GOOGLE_MAPS_API_KEY: string;
}

export interface ImportMeta {
	readonly env: ImportMetaEnv;
}

// Server-side environment variables
declare global {
	namespace NodeJS {
		interface ProcessEnv {
			readonly LOG_SOURCE_TOKEN: string;
			readonly LOG_ENDPOINT: string;
		}
	}
}
