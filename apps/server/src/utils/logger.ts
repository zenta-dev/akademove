import pino from "pino";

const ANSI = {
	Reset: "\x1B[0m",
	Bright: "\x1B[1m",
	FgWhite: "\x1B[37m",
	FgRed: "\x1B[31m",
	FgGreen: "\x1B[32m",
	FgYellow: "\x1B[33m",
	FgMagenta: "\x1B[35m",
	FgCyan: "\x1B[36m",
	FgGray: "\x1B[90m",
	BgGray: "\x1B[100m",
} as const;

const formatTime = (time: number): string => {
	return new Date(time * 1000).toISOString().slice(11, 19);
};

/**
 * Serializes an Error object to a plain object with its properties
 * Error properties (message, stack, name) are non-enumerable by default,
 * so JSON.stringify returns {} for Error objects
 */
const serializeError = (error: unknown): unknown => {
	if (error instanceof Error) {
		const serialized: Record<string, unknown> = {
			name: error.name,
			message: error.message,
			stack: error.stack,
		};
		// Include any custom properties (e.g., code, cause) via Object.getOwnPropertyNames
		for (const key of Object.getOwnPropertyNames(error)) {
			if (!(key in serialized)) {
				serialized[key] = (error as unknown as Record<string, unknown>)[key];
			}
		}
		return serialized;
	}
	return error;
};

/**
 * Recursively processes an object to serialize any Error instances
 */
const processErrorsInObject = (
	obj: Record<string, unknown>,
): Record<string, unknown> => {
	const result: Record<string, unknown> = {};
	for (const [key, value] of Object.entries(obj)) {
		if (value instanceof Error) {
			result[key] = serializeError(value);
		} else if (value && typeof value === "object" && !Array.isArray(value)) {
			result[key] = processErrorsInObject(value as Record<string, unknown>);
		} else {
			result[key] = value;
		}
	}
	return result;
};

const formatObject = (obj: Record<string, unknown>, indent = 2): string => {
	const processed = processErrorsInObject(obj);
	return JSON.stringify(processed, null, indent)
		.split("\n")
		.map((line, i) => (i === 0 ? line : " ".repeat(indent) + line))
		.join("\n");
};

const createLogHandler = (
	label: string,
	labelColor: string,
	msgColor: string = ANSI.FgWhite,
) => {
	return (o: Record<string, any>) => {
		const { time, level, msg, hostname, pid, ...rest } = o;

		const timeStr = `${ANSI.FgGray}${formatTime(time)}${ANSI.Reset}`;
		const labelStr = `${labelColor}[${label}]${ANSI.Reset}`;
		const msgStr = `${msgColor}${msg}${ANSI.Reset}`;

		// Build output
		const parts = [timeStr, labelStr, msgStr];

		if (Object.keys(rest).length > 0) {
			const formattedRest = `\n${ANSI.FgCyan}${formatObject(rest)}${ANSI.Reset}`;
			parts.push(formattedRest);
		}

		console.log(parts.join(" "));
	};
};

export const logger = pino({
	level: "trace",
	timestamp: pino.stdTimeFunctions.unixTime,
	browser: {
		write: {
			info: createLogHandler("INFO", ANSI.FgCyan),
			error: createLogHandler("ERROR", ANSI.FgRed, ANSI.FgRed),
			warn: createLogHandler("WARN", ANSI.FgYellow, ANSI.FgYellow),
			debug: createLogHandler("DEBUG", ANSI.FgMagenta),
			trace: createLogHandler("TRACE", ANSI.FgGray, ANSI.FgGray),
		},
	},
});
