export function generateOrderCode(orderId: string): string {
	const clean = orderId.replace(/-/g, "");

	if (clean.length < 12) {
		throw new Error(`Invalid UUIDv7: ${orderId}`);
	}

	const tsHex = clean.substring(0, 12);
	const tsInt = Number.parseInt(tsHex, 16);

	const date = new Date(tsInt);

	const yyyy = date.getUTCFullYear().toString();
	const mm = String(date.getUTCMonth() + 1).padStart(2, "0");
	const dd = String(date.getUTCDate()).padStart(2, "0");

	const short = clean.substring(clean.length - 6);

	return `${yyyy}${mm}${dd}-${short}`;
}
