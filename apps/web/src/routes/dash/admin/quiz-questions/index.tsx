import { UserListQuerySchema } from "@repo/schema/pagination";
import { createFileRoute, redirect, useNavigate } from "@tanstack/react-router";
import { Plus } from "lucide-react";
import { useState } from "react";
import { QuizQuestionForm } from "@/components/forms/quiz-question-form";
import { QuizQuestionTable } from "@/components/tables/quiz-question/table";
import { Button } from "@/components/ui/button";
import {
	Dialog,
	DialogContent,
	DialogDescription,
	DialogHeader,
	DialogTitle,
} from "@/components/ui/dialog";
import { hasAccess } from "@/lib/actions";

export const Route = createFileRoute("/dash/admin/quiz-questions/")({
	validateSearch: (values) => {
		const search = UserListQuerySchema.parse(values);
		if (!values.limit) return { ...search, page: 1, limit: 11 };
		return search;
	},
	head: () => ({ meta: [{ title: "Quiz Questions" }] }),
	beforeLoad: async () => {
		const ok = await hasAccess(["ADMIN"]);
		if (!ok) redirect({ to: "/", throw: true });
		return { allowed: ok };
	},
	loader: ({ context }) => {
		return { allowed: context.allowed };
	},
	component: RouteComponent,
});

function RouteComponent() {
	const { allowed } = Route.useLoaderData();
	const search = Route.useSearch();
	const navigate = useNavigate();
	const [isCreateDialogOpen, setIsCreateDialogOpen] = useState(false);

	if (!allowed) navigate({ to: "/" });

	const handleSuccess = () => {
		setIsCreateDialogOpen(false);
	};

	return (
		<div className="space-y-6">
			<div className="flex items-center justify-between">
				<div>
					<h1 className="font-bold text-2xl">Quiz Questions</h1>
					<p className="text-muted-foreground">
						Manage driver quiz questions and options
					</p>
				</div>
				<Button onClick={() => setIsCreateDialogOpen(true)}>
					<Plus className="mr-2 h-4 w-4" />
					Add Question
				</Button>
			</div>

			<QuizQuestionTable search={search} to="/dash/admin/quiz-questions" />

			<Dialog open={isCreateDialogOpen} onOpenChange={setIsCreateDialogOpen}>
				<DialogContent className="max-h-[90vh] max-w-2xl overflow-y-auto">
					<DialogHeader>
						<DialogTitle>Create Quiz Question</DialogTitle>
						<DialogDescription>
							Add a new question to the driver quiz
						</DialogDescription>
					</DialogHeader>
					<QuizQuestionForm
						onSuccess={handleSuccess}
						onCancel={() => setIsCreateDialogOpen(false)}
					/>
				</DialogContent>
			</Dialog>
		</div>
	);
}
