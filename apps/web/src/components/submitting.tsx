import { m } from "@repo/i18n";
import { Loader2 } from "lucide-react";

export const Submitting = () => {
	return (
		<>
			<Loader2 className="animate-spin" />
			{m.submitting()}
		</>
	);
};
