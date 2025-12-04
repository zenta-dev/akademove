import type { ChargeResponse } from "@erhahahaa/midtrans-client-typescript";
import type { BankProvider } from "@repo/schema/common";
import { type VANumber, VANumberSchema } from "@repo/schema/payment";
import { log } from "@/utils";

/**
 * Parses VA number from Midtrans charge response
 *
 * @param response - Midtrans charge response object
 * @param bank - Bank provider (optional, required for Permata)
 * @returns Parsed VANumber or undefined if not found/invalid
 *
 * @example
 * ```typescript
 * const vaNumber = parseVANumber(midtransResponse, "bca");
 * if (vaNumber) {
 *   console.log(`VA Number: ${vaNumber.va_number} for bank ${vaNumber.bank}`);
 * }
 * ```
 */
export function parseVANumber(
	response: ChargeResponse,
	bank?: BankProvider,
): VANumber | undefined {
	try {
		// Try parsing from va_numbers array (BCA, BNI, BRI, CIMB, etc.)
		const va_numbers = response.va_numbers;
		if (va_numbers && Array.isArray(va_numbers) && va_numbers.length > 0) {
			const first = va_numbers[0];
			const parsed = VANumberSchema.safeParse(first);
			if (parsed.success) {
				log.debug(
					{ vaNumber: parsed.data },
					"[parseVANumber] Parsed VA from va_numbers array",
				);
				return parsed.data;
			}
		}

		// Special handling for Permata (uses different field)
		if (bank?.toLowerCase() === "permata") {
			const permataVA = response.permata_va_number;
			if (permataVA) {
				const vaNumber: VANumber = {
					bank: "permata",
					va_number: permataVA,
				};
				log.debug(
					{ vaNumber },
					"[parseVANumber] Parsed VA from permata_va_number field",
				);
				return vaNumber;
			}
		}

		log.warn(
			{ response, bank },
			"[parseVANumber] No VA number found in response",
		);
		return undefined;
	} catch (error) {
		log.error(
			{ error, response, bank },
			"[parseVANumber] Failed to parse VA number",
		);
		return undefined;
	}
}

/**
 * Validates if a VA number string is in correct format
 *
 * @param vaNumber - VA number string to validate
 * @returns true if valid format, false otherwise
 */
export function isValidVANumber(vaNumber: string): boolean {
	// VA numbers are typically numeric and between 10-20 digits
	return /^\d{10,20}$/.test(vaNumber);
}

/**
 * Formats VA number for display (adds spaces every 4 digits)
 *
 * @param vaNumber - VA number string to format
 * @returns Formatted VA number (e.g., "1234 5678 9012")
 */
export function formatVANumber(vaNumber: string): string {
	return vaNumber.replace(/(\d{4})(?=\d)/g, "$1 ");
}
