import { m } from "@repo/i18n";
import type { DriverQuizQuestion } from "@repo/schema/driver-quiz-question";
import { useMutation } from "@tanstack/react-query";
import { Power, PowerOff } from "lucide-react";
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
	DialogTrigger,
} from "@/components/ui/dialog";
import { orpcQuery, queryClient } from "@/lib/orpc";

interface ToggleQuizQuestionActiveDialogProps {
	quizQuestion: DriverQuizQuestion;
}

export const ToggleQuizQuestionActiveDialog = ({
	quizQuestion,
}: ToggleQuizQuestionActiveDialogProps) => {
	const [open, setOpen] = useState(false);

	const toggleMutation = useMutation(
		orpcQuery.driverQuizQuestion.update.mutationOptions({
			onSuccess: async () => {
				await queryClient.invalidateQueries();
				toast.success(m.server_driver_quiz_question_updated());
				setOpen(false);
			},
			onError: (error: Error) => {
				toast.error(
					m.failed_placeholder({ action: m.toggle_quiz_question_active() }),
					{
						description: error.message || m.an_unexpected_error_occurred(),
					},
				);
			},
		}),
	);

	const handleToggle = () => {
		toggleMutation.mutate({
			params: { id: quizQuestion.id },
			body: { isActive: !quizQuestion.isActive },
		});
	};

	const isActive = quizQuestion.isActive;

	return (
		<Dialog open={open} onOpenChange={setOpen}>
			<DialogTrigger asChild>
				<Button variant="ghost" size="sm">
					{isActive ? (
						<>
							<PowerOff className="h-4 w-4" /> {m.deactivate()}
						</>
					) : (
						<>
							<Power className="h-4 w-4" /> {m.activate()}
						</>
					)}
				</Button>
			</DialogTrigger>
			<DialogContent>
				<DialogHeader>
					<DialogTitle>{m.toggle_quiz_question_active()}</DialogTitle>
					<DialogDescription>
						{isActive
							? m.deactivate_quiz_question_desc()
							: m.activate_quiz_question_desc()}
					</DialogDescription>
				</DialogHeader>
				<div className="space-y-4">
					<div className="text-center">
						<p className="font-medium">{quizQuestion.question}</p>
						<p className="text-muted-foreground text-sm">
							{m.current_status()}:{" "}
							<strong>{isActive ? m.active() : m.inactive()}</strong>
						</p>
						<p className="text-muted-foreground text-sm">
							{m.new_status()}:{" "}
							<strong>{isActive ? m.inactive() : m.active()}</strong>
						</p>
					</div>
				</div>
				<DialogFooter>
					<Button
						variant="outline"
						onClick={() => setOpen(false)}
						disabled={toggleMutation.isPending}
					>
						{m.cancel()}
					</Button>
					<Button
						variant={isActive ? "destructive" : "default"}
						onClick={handleToggle}
						disabled={toggleMutation.isPending}
					>
						{(toggleMutation.isPending && m.updating()) ||
							(isActive ? m.deactivate() : m.activate())}
					</Button>
				</DialogFooter>
			</DialogContent>
		</Dialog>
	);
};
