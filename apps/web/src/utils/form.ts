export function scrollToField(fieldName: string) {
	const element = document.querySelector(`[name="${fieldName}"]`);
	if (element) {
		element.scrollIntoView({
			behavior: "smooth",
			block: "center",
		});
		if (element instanceof HTMLElement) {
			element.focus({ preventScroll: true });
		}
	}
}
