/** biome-ignore-all lint/suspicious/noExplicitAny: cant cast */
import pino from "pino";

export function createLogger() {
	return pino({
		level: "debug",
		transport: {
			target: "pino-pretty",
			options: {
				colorize: true,
				translateTime: "SYS:standard",
				ignore: "pid,hostname",
			},
		},
	});
}
