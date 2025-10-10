import pino from "pino";

declare global {
	var window: unknown;
}
type Props = {
	nodeEnv: string;
	// log: {
	// 	sourceToken: string;
	// 	endpoint: string;
	// };
};

export function createBrowserLogger({ nodeEnv }: Props) {
	const isBrowser = typeof window !== "undefined";

	if (isBrowser) {
		return pino({
			level: "info",
			browser: {
				asObject: false,
				serialize: true,
				write: {
					info: (o: any) =>
						console.info("%c[INFO]", "color: blue", o.time, o.msg, o),
					error: (o: any) =>
						console.error("%c[ERROR]", "color: red", o.time, o.msg, o),
					warn: (o: any) =>
						console.warn("%c[WARN]", "color: orange", o.time, o.msg, o),
					debug: (o: any) =>
						console.debug("%c[DEBUG]", "color: gray", o.time, o.msg, o),
					trace: (o: any) =>
						console.trace("%c[TRACE]", "color: lightgray", o.time, o.msg, o),
				},
			},
		});
	}

	return pino({ level: "info" });
}

export function createLogger({ nodeEnv }: Props) {
	const isBrowser = typeof window !== "undefined";

	if (isBrowser) {
		return pino({
			level: "info",
			browser: {
				asObject: false,
				serialize: true,
				write: {
					info: (o: any) =>
						console.info("%c[INFO]", "color: blue", o.time, o.msg, o),
					error: (o: any) =>
						console.error("%c[ERROR]", "color: red", o.time, o.msg, o),
					warn: (o: any) =>
						console.warn("%c[WARN]", "color: orange", o.time, o.msg, o),
					debug: (o: any) =>
						console.debug("%c[DEBUG]", "color: gray", o.time, o.msg, o),
					trace: (o: any) =>
						console.trace("%c[TRACE]", "color: lightgray", o.time, o.msg, o),
				},
			},
		});
	}

	const isDev = nodeEnv === "development";

	if (isDev) {
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

	return pino({ level: "info" });
}
