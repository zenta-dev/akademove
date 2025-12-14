import type { EmergencyContact } from "@repo/schema/emergency-contact";
import { useQueryClient } from "@tanstack/react-query";
import { useState } from "react";
import { toast } from "sonner";
import { Button } from "@/components/ui/button";
import {
	Dialog,
	DialogContent,
	DialogDescription,
	DialogFooter,
	DialogHeader,
	DialogTitle,
} from "@/components/ui/dialog";
import { orpcClient } from "@/lib/orpc";

interface ToggleEmergencyContactActiveDialogProps {
	open: boolean;
	onOpenChange: (open: boolean) => void;
	contact: EmergencyContact;
}

export const ToggleEmergencyContactActiveDialog = ({
	open,
	onOpenChange,
	contact,
}: ToggleEmergencyContactActiveDialogProps) => {
	const [isLoading, setIsLoading] = useState(false);
	const queryClient = useQueryClient();
	const isActivating = !contact.isActive;

	const handleToggle = async () => {
		setIsLoading(true);
		try {
			const result = await orpcClient.emergencyContact.toggleActive({
				params: { id: contact.id },
			});
			if (result.status === 200) {
				toast.success(
					isActivating
						? "Emergency contact activated successfully"
						: "Emergency contact deactivated successfully",
				);
				queryClient.invalidateQueries();
				onOpenChange(false);
			} else {
				toast.error("An unexpected error occurred");
			}
		} catch (error) {
			toast.error("An unexpected error occurred");
			console.error("Failed to toggle emergency contact status:", error);
		} finally {
			setIsLoading(false);
		}
	};

	return (
		<Dialog open={open} onOpenChange={onOpenChange}>
			<DialogContent>
				<DialogHeader>
					<DialogTitle>
						{isActivating ? "Activate Contact" : "Deactivate Contact"}
					</DialogTitle>
					<DialogDescription>
						{isActivating
							? "Activate this emergency contact to make it available for users."
							: "Deactivate this emergency contact. Users will not see it until reactivated."}
					</DialogDescription>
				</DialogHeader>
				<div className="py-4">
					<p className="text-muted-foreground text-sm">
						Are you absolutely sure about this?
					</p>
					<p className="mt-2 font-medium text-sm">{contact.name}</p>
				</div>
				<DialogFooter>
					<Button
						variant="outline"
						onClick={() => onOpenChange(false)}
						disabled={isLoading}
					>
						Cancel
					</Button>
					<Button
						variant={isActivating ? "default" : "destructive"}
						onClick={handleToggle}
						disabled={isLoading}
					>
						{isLoading
							? "Just a moment..."
							: isActivating
								? "Activate"
								: "Deactivate"}
					</Button>
				</DialogFooter>
			</DialogContent>
		</Dialog>
	);
};
