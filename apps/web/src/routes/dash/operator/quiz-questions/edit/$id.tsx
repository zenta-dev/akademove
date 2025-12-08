import { useQuery } from "@tanstack/react-query";
import { createFileRoute, redirect, useNavigate } from "@tanstack/react-router";
import { Loader2 } from "lucide-react";
import { QuizQuestionForm } from "@/components/forms/quiz-question-form";
import { hasAccess } from "@/lib/actions";
import { orpcQuery } from "@/lib/orpc";

export const Route = createFileRoute("/dash/operator/quiz-questions/edit/$id")({
	beforeLoad: async () => {
		const ok = await hasAccess(["OPERATOR"]);
		if (!ok) redirect({ to: "/", throw: true });
		return { allowed: ok };
	},
	loader: ({ context }) => {
		return { allowed: context.allowed };
	},
	component: QuizQuestionsEditPage,
});

function QuizQuestionsEditPage() {
	const { allowed } = Route.useLoaderData();
	const { id } = Route.useParams();
	const navigate = useNavigate();

	if (!allowed) navigate({ to: "/" });

	const quizQuestion = useQuery(
		orpcQuery.driverQuizQuestion.get.queryOptions({
			input: { params: { id } },
		}),
	);

	if (quizQuestion.isPending) {
		return (
			<div className="flex h-64 items-center justify-center">
				<Loader2 className="h-8 w-8 animate-spin" />
			</div>
		);
	}

	if (quizQuestion.isError || !quizQuestion.data?.body.data) {
		return (
			<div className="text-center text-red-600">
				Failed to load quiz question
			</div>
		);
	}

	const handleSuccess = () => {
		navigate({
			to: "/dash/operator/quiz-questions",
			search: { order: "desc", mode: "offset", page: 1, limit: 11 },
		});
	};

	const handleCancel = () => {
		navigate({
			to: "/dash/operator/quiz-questions",
			search: { order: "desc", mode: "offset", page: 1, limit: 11 },
		});
	};

	return (
		<div className="mx-auto max-w-2xl space-y-6">
			<div>
				<h1 className="font-bold text-2xl">Edit Quiz Question</h1>
				<p className="text-muted-foreground">
					Update the quiz question and its options
				</p>
			</div>

			<QuizQuestionForm
				quizQuestion={quizQuestion.data.body.data}
				onSuccess={handleSuccess}
				onCancel={handleCancel}
			/>
		</div>
	);
}
