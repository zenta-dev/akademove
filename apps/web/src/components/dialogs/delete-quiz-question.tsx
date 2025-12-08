import { m } from "@repo/i18n";
import type { DriverQuizQuestion } from "@repo/schema/driver-quiz-question";
import { useMutation } from "@tanstack/react-query";
import { Trash2 } from "lucide-react";
import { useState } from "react";
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
	DialogTrigger,
} from "@/components/ui/dialog";
import { orpcQuery, queryClient } from "@/lib/orpc";

interface DeleteQuizQuestionDialogProps {
	quizQuestion: DriverQuizQuestion;
}

export const DeleteQuizQuestionDialog = ({
	quizQuestion,
}: DeleteQuizQuestionDialogProps) => {
	const [open, setOpen] = useState(false);

	const deleteMutation = useMutation(
		orpcQuery.driverQuizQuestion.remove.mutationOptions({
			onSuccess: async () => {
				await queryClient.invalidateQueries();
				toast.success(m.server_driver_quiz_question_deleted());
				setOpen(false);
			},
			onError: (error: Error) => {
				toast.error(
					m.failed_placeholder({ action: m.delete_quiz_question() }),
					{
						description: error.message || m.an_unexpected_error_occurred(),
					},
				);
			},
		}),
	);

	const handleDelete = () => {
		deleteMutation.mutate({ params: { id: quizQuestion.id } });
	};

	return (
		<Dialog open={open} onOpenChange={setOpen}>
			<DialogTrigger asChild>
				<Button variant="ghost" size="sm">
					<Trash2 className="h-4 w-4" />
					{m.delete()}
				</Button>
			</DialogTrigger>
			<DialogContent>
				<DialogHeader>
					<DialogTitle>{m.delete_quiz_question()}</DialogTitle>
					<DialogDescription>
						{m.this_action_cannot_be_undone()}
					</DialogDescription>
				</DialogHeader>
				<div className="space-y-4">
					<Alert>
						<AlertDescription>
							{m.quiz_question()}: <strong>{quizQuestion.question}</strong>
						</AlertDescription>
					</Alert>
				</div>
				<DialogFooter>
					<Button
						variant="outline"
						onClick={() => setOpen(false)}
						disabled={deleteMutation.isPending}
					>
						{m.cancel()}
					</Button>
					<Button
						variant="destructive"
						onClick={handleDelete}
						disabled={deleteMutation.isPending}
					>
						{(deleteMutation.isPending && m.deleting()) || m.delete()}
					</Button>
				</DialogFooter>
			</DialogContent>
		</Dialog>
	);
};
