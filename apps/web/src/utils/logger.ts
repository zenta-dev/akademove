import { createBrowserLogger, createLogger } from "@repo/shared";

export const log = createBrowserLogger({
	nodeEnv: import.meta.env.VITE_NODE_ENV,
});
