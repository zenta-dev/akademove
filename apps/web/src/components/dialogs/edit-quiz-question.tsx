import { m } from "@repo/i18n";
import type { DriverQuizQuestion } from "@repo/schema/driver-quiz-question";
import { Edit } from "lucide-react";
import { useState } from "react";
import { QuizQuestionForm } from "@/components/forms/quiz-question-form";
import { Button } from "@/components/ui/button";
import {
	Dialog,
	DialogContent,
	DialogDescription,
	DialogHeader,
	DialogTitle,
	DialogTrigger,
} from "@/components/ui/dialog";

interface EditQuizQuestionDialogProps {
	quizQuestion: DriverQuizQuestion;
}

export const EditQuizQuestionDialog = ({
	quizQuestion,
}: EditQuizQuestionDialogProps) => {
	const [open, setOpen] = useState(false);

	const handleSuccess = () => {
		setOpen(false);
	};

	return (
		<Dialog open={open} onOpenChange={setOpen}>
			<DialogTrigger asChild>
				<Button variant="ghost" size="sm">
					<Edit className="h-4 w-4" />
					{m.edit()}
				</Button>
			</DialogTrigger>
			<DialogContent className="max-h-[90vh] max-w-2xl overflow-y-auto">
				<DialogHeader>
					<DialogTitle>{m.update_quiz_question()}</DialogTitle>
					<DialogDescription>{m.quiz_question_form_desc()}</DialogDescription>
				</DialogHeader>
				<QuizQuestionForm
					quizQuestion={quizQuestion}
					onSuccess={handleSuccess}
					onCancel={() => setOpen(false)}
				/>
			</DialogContent>
		</Dialog>
	);
};
