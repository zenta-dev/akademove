import type { EmergencyContact } from "@repo/schema/emergency-contact";
import { useMutation } from "@tanstack/react-query";
import { toast } from "sonner";
import { Alert, AlertDescription } from "@/components/ui/alert";
import { Button } from "@/components/ui/button";
import {
	Dialog,
	DialogContent,
	DialogDescription,
	DialogFooter,
	DialogHeader,
	DialogTitle,
} from "@/components/ui/dialog";
import { orpcQuery, queryClient } from "@/lib/orpc";

interface DeleteEmergencyContactDialogProps {
	open: boolean;
	onOpenChange: (open: boolean) => void;
	contact: EmergencyContact;
}

export const DeleteEmergencyContactDialog = ({
	open,
	onOpenChange,
	contact,
}: DeleteEmergencyContactDialogProps) => {
	const deleteMutation = useMutation(
		orpcQuery.emergencyContact.delete.mutationOptions({
			onSuccess: async () => {
				await queryClient.invalidateQueries();
				toast.success("Emergency contact deleted successfully");
				onOpenChange(false);
			},
			onError: (error: Error) => {
				toast.error("Failed to delete emergency contact", {
					description: error.message || "An unexpected error occurred",
				});
			},
		}),
	);

	const handleDelete = () => {
		deleteMutation.mutate({ params: { id: contact.id } });
	};

	return (
		<Dialog open={open} onOpenChange={onOpenChange}>
			<DialogContent>
				<DialogHeader>
					<DialogTitle>Delete Emergency Contact</DialogTitle>
					<DialogDescription>
						This action cannot be undone. The emergency contact will be
						permanently removed.
					</DialogDescription>
				</DialogHeader>
				<div className="space-y-4">
					<Alert>
						<AlertDescription>
							Contact: <strong>{contact.name}</strong>
						</AlertDescription>
					</Alert>
				</div>
				<DialogFooter>
					<Button
						variant="outline"
						onClick={() => onOpenChange(false)}
						disabled={deleteMutation.isPending}
					>
						Cancel
					</Button>
					<Button
						variant="destructive"
						onClick={handleDelete}
						disabled={deleteMutation.isPending}
					>
						{deleteMutation.isPending ? "Deleting..." : "Delete"}
					</Button>
				</DialogFooter>
			</DialogContent>
		</Dialog>
	);
};
