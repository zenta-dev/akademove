import { Button } from "@/components/ui/button";
import {
	Dialog,
	DialogContent,
	DialogHeader,
	DialogTitle,
} from "@/components/ui/dialog";

interface DriverDocumentPreviewModalProps {
	isOpen: boolean;
	onOpenChange: (open: boolean) => void;
	document: "studentCard" | "driverLicense" | "vehicleRegistration";
	documentUrl: string;
}

const DOCUMENT_LABELS = {
	studentCard: "Student Card",
	driverLicense: "Driver License",
	vehicleRegistration: "Vehicle Registration",
};

export const DriverDocumentPreviewModal = ({
	isOpen,
	onOpenChange,
	document,
	documentUrl,
}: DriverDocumentPreviewModalProps) => {
	const isPdf = documentUrl.toLowerCase().endsWith(".pdf");

	return (
		<Dialog open={isOpen} onOpenChange={onOpenChange}>
			<DialogContent className="max-h-[90vh] max-w-4xl">
				<DialogHeader>
					<DialogTitle>{DOCUMENT_LABELS[document]}</DialogTitle>
				</DialogHeader>
				<div className="relative h-[70vh] w-full overflow-auto rounded-lg bg-gray-100">
					{isPdf ? (
						<iframe
							src={documentUrl}
							className="h-full w-full border-0"
							title={DOCUMENT_LABELS[document]}
						/>
					) : (
						<img
							src={documentUrl}
							alt={DOCUMENT_LABELS[document]}
							className="h-full w-full object-contain"
						/>
					)}
				</div>
				<div className="flex justify-end gap-2">
					<Button
						variant="outline"
						onClick={() => window.open(documentUrl, "_blank")}
					>
						Open Full Size
					</Button>
					<Button variant="outline" onClick={() => onOpenChange(false)}>
						Close
					</Button>
				</div>
			</DialogContent>
		</Dialog>
	);
};
