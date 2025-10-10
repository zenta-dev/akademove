export function capitalizeFirstLetter(string: string): string {
	return string.charAt(0).toUpperCase() + string.slice(1);
}

export function getFileExtension(file: File): string {
	const match = file.name.match(/\.([^.]+)$/);
	return match ? (match[1] ?? "png").toLowerCase() : "";
}
