type DeviceType = "mobile" | "tablet" | "desktop";

export function detectDevice(userAgent: string | undefined): DeviceType {
	if (!userAgent) return "desktop";

	const ua = userAgent.toLowerCase();

	const isTablet = /ipad|tablet|(android(?!.*mobile))/i.test(ua);
	const isMobile = /iphone|ipod|android.*mobile|windows phone/i.test(ua);

	if (isTablet) return "tablet";
	if (isMobile) return "mobile";
	return "desktop";
}
