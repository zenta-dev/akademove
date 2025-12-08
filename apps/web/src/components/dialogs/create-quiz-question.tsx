import { m } from "@repo/i18n";
import { Plus } from "lucide-react";
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

export const CreateQuizQuestionDialog = () => {
	const [open, setOpen] = useState(false);

	const handleSuccess = () => {
		setOpen(false);
	};

	return (
		<Dialog open={open} onOpenChange={setOpen}>
			<DialogTrigger asChild>
				<Button>
					<Plus className="mr-2 h-4 w-4" />
					{m.create_quiz_question()}
				</Button>
			</DialogTrigger>
			<DialogContent className="max-h-[90vh] max-w-2xl overflow-y-auto">
				<DialogHeader>
					<DialogTitle>{m.create_quiz_question()}</DialogTitle>
					<DialogDescription>{m.quiz_question_form_desc()}</DialogDescription>
				</DialogHeader>
				<QuizQuestionForm
					onSuccess={handleSuccess}
					onCancel={() => setOpen(false)}
				/>
			</DialogContent>
		</Dialog>
	);
};
