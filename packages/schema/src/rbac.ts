import * as z from "zod/v4";

export function createStatementSchema<T extends object>(statement: T) {
	return z.object(
		Object.fromEntries(
			Object.entries(statement).map(([key, actions]) => [
				key,
				z.array(z.enum(actions as unknown as [string, ...string[]])),
			]),
		),
	);
}
