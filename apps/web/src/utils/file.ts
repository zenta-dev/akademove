export const createPhotoPreviewUrl = (
	files: File[],
	opts: { onSuccess: (str: string) => void },
) => {
	if (files.length > 0) {
		const reader = new FileReader();
		reader.onload = (e) => {
			if (typeof e.target?.result === "string") {
				opts.onSuccess(e.target.result);
			}
		};
		reader.readAsDataURL(files[0]);
	}
};
