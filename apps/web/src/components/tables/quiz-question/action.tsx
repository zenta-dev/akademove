import { m } from "@repo/i18n";
import type { DriverQuizQuestion } from "@repo/schema/driver-quiz-question";
import { MoreHorizontal } from "lucide-react";
import { DeleteQuizQuestionDialog } from "@/components/dialogs/delete-quiz-question";
import { EditQuizQuestionDialog } from "@/components/dialogs/edit-quiz-question";
import { ToggleQuizQuestionActiveDialog } from "@/components/dialogs/toggle-quiz-question-active";
import { Button } from "@/components/ui/button";
import {
	DropdownMenu,
	DropdownMenuContent,
	DropdownMenuGroup,
	DropdownMenuItem,
	DropdownMenuLabel,
	DropdownMenuSeparator,
	DropdownMenuTrigger,
} from "@/components/ui/dropdown-menu";

export const QuizQuestionActionTable = ({
	val,
}: {
	val: DriverQuizQuestion;
}) => {
	return (
		<DropdownMenu>
			<DropdownMenuTrigger asChild>
				<Button variant="ghost" className="h-8 w-8 p-0">
					<span className="sr-only">
						{m.perform_quiz_question_action_placeholder({
							question: val.question,
						})}
					</span>
					<MoreHorizontal className="h-4 w-4" />
				</Button>
			</DropdownMenuTrigger>
			<DropdownMenuContent align="end">
				<DropdownMenuLabel>{m.actions()}</DropdownMenuLabel>
				<DropdownMenuGroup className="flex flex-1 flex-col gap-2">
					<DropdownMenuItem asChild>
						<EditQuizQuestionDialog quizQuestion={val} />
					</DropdownMenuItem>
					<DropdownMenuItem asChild>
						<ToggleQuizQuestionActiveDialog quizQuestion={val} />
					</DropdownMenuItem>
				</DropdownMenuGroup>
				<DropdownMenuSeparator />
				<DropdownMenuGroup className="flex flex-1 flex-col gap-2">
					<DropdownMenuItem asChild>
						<DeleteQuizQuestionDialog quizQuestion={val} />
					</DropdownMenuItem>
				</DropdownMenuGroup>
			</DropdownMenuContent>
		</DropdownMenu>
	);
};
