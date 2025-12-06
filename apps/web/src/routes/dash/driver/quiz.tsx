import { m } from "@repo/i18n";
import type { DriverQuizAnswerStatus } from "@repo/schema/driver-quiz-answer";
import { useMutation, useQuery } from "@tanstack/react-query";
import { createFileRoute, redirect, useNavigate } from "@tanstack/react-router";
import {
	AlertCircle,
	ArrowRight,
	CheckCircle2,
	ClipboardList,
	Loader2,
	RefreshCw,
	XCircle,
} from "lucide-react";
import { useCallback, useState } from "react";
import { toast } from "sonner";
import { Alert, AlertDescription, AlertTitle } from "@/components/ui/alert";
import { Badge } from "@/components/ui/badge";
import { Button } from "@/components/ui/button";
import {
	Card,
	CardContent,
	CardDescription,
	CardFooter,
	CardHeader,
	CardTitle,
} from "@/components/ui/card";
import { Label } from "@/components/ui/label";
import { Progress } from "@/components/ui/progress";
import { RadioGroup, RadioGroupItem } from "@/components/ui/radio-group";
import { hasAccess } from "@/lib/actions";
import { SUB_ROUTE_TITLES } from "@/lib/constants";
import { orpcClient, queryClient } from "@/lib/orpc";
import { cn } from "@/utils/cn";

export const Route = createFileRoute("/dash/driver/quiz")({
	head: () => ({
		meta: [{ title: SUB_ROUTE_TITLES.DRIVER.QUIZ ?? "Driver Quiz" }],
	}),
	beforeLoad: async () => {
		const ok = await hasAccess({
			driver: ["get"],
		});
		if (!ok) redirect({ to: "/", throw: true });
		return { allowed: ok };
	},
	component: RouteComponent,
});

interface QuizQuestion {
	id: string;
	question: string;
	type: string;
	category: string;
	points: number;
	displayOrder: number;
	options: Array<{
		id: string;
		text: string;
	}>;
}

interface QuizAttempt {
	attemptId: string;
	questions: QuizQuestion[];
	totalQuestions: number;
	totalPoints: number;
	passingScore: number;
}

interface QuizResult {
	attemptId: string;
	status: DriverQuizAnswerStatus;
	totalQuestions: number;
	correctAnswers: number;
	scorePercentage: number;
	passed: boolean;
	earnedPoints: number;
	totalPoints: number;
	completedAt: Date | null;
}

function RouteComponent() {
	const navigate = useNavigate();
	const [currentQuestionIndex, setCurrentQuestionIndex] = useState(0);
	const [selectedAnswer, setSelectedAnswer] = useState<string | null>(null);
	const [quizAttempt, setQuizAttempt] = useState<QuizAttempt | null>(null);
	const [answeredQuestions, setAnsweredQuestions] = useState<Set<string>>(
		new Set(),
	);
	const [quizResult, setQuizResult] = useState<QuizResult | null>(null);

	// Fetch driver data to check quiz status
	const { data: driverData, isLoading: driverLoading } = useQuery({
		queryKey: ["driver", "mine"],
		queryFn: async () => {
			const result = await orpcClient.driver.getMine();
			if (result.status !== 200) throw new Error(result.body.message);
			return result.body.data;
		},
	});

	// Fetch latest quiz attempt
	const { data: latestAttempt, isLoading: attemptLoading } = useQuery({
		queryKey: ["driver-quiz", "latest"],
		queryFn: async () => {
			const result = await orpcClient.driverQuizAnswer.getMyLatestAttempt({});
			if (result.status !== 200) throw new Error(result.body.message);
			return result.body.data;
		},
	});

	// Start quiz mutation
	const startQuizMutation = useMutation({
		mutationFn: async () => {
			const result = await orpcClient.driverQuizAnswer.startQuiz({
				body: {},
			});
			if (result.status !== 201) throw new Error(result.body.message);
			return result.body.data;
		},
		onSuccess: (data) => {
			setQuizAttempt(data);
			setCurrentQuestionIndex(0);
			setSelectedAnswer(null);
			setAnsweredQuestions(new Set());
			setQuizResult(null);
			queryClient.invalidateQueries({ queryKey: ["driver-quiz", "latest"] });
			toast.success("Quiz started! Good luck!");
		},
		onError: (error) => {
			toast.error(`Failed to start quiz: ${error.message}`);
		},
	});

	// Submit answer mutation
	const submitAnswerMutation = useMutation({
		mutationFn: async ({
			questionId,
			optionId,
		}: {
			questionId: string;
			optionId: string;
		}) => {
			if (!quizAttempt) throw new Error("No active quiz attempt");
			const result = await orpcClient.driverQuizAnswer.submitAnswer({
				body: {
					attemptId: quizAttempt.attemptId,
					questionId,
					selectedOptionId: optionId,
				},
			});
			if (result.status !== 200) throw new Error(result.body.message);
			return result.body.data;
		},
		onSuccess: (data, variables) => {
			setAnsweredQuestions((prev) => new Set([...prev, variables.questionId]));
			if (data.isCorrect) {
				toast.success(`Correct! +${data.pointsEarned} points`);
			} else {
				toast.error("Incorrect answer");
			}
		},
		onError: (error) => {
			toast.error(`Failed to submit answer: ${error.message}`);
		},
	});

	// Complete quiz mutation
	const completeQuizMutation = useMutation({
		mutationFn: async () => {
			if (!quizAttempt) throw new Error("No active quiz attempt");
			const result = await orpcClient.driverQuizAnswer.completeQuiz({
				body: {
					attemptId: quizAttempt.attemptId,
				},
			});
			if (result.status !== 200) throw new Error(result.body.message);
			return result.body.data;
		},
		onSuccess: (data) => {
			setQuizResult(data);
			setQuizAttempt(null);
			queryClient.invalidateQueries({ queryKey: ["driver-quiz", "latest"] });
			queryClient.invalidateQueries({ queryKey: ["driver", "mine"] });
			if (data.passed) {
				toast.success("Congratulations! You passed the quiz!");
			} else {
				toast.error("You did not pass. Please try again.");
			}
		},
		onError: (error) => {
			toast.error(`Failed to complete quiz: ${error.message}`);
		},
	});

	const handleStartQuiz = useCallback(() => {
		startQuizMutation.mutate();
	}, [startQuizMutation]);

	const handleSubmitAnswer = useCallback(() => {
		if (!selectedAnswer || !quizAttempt) return;
		const currentQuestion = quizAttempt.questions[currentQuestionIndex];
		if (!currentQuestion) return;

		submitAnswerMutation.mutate({
			questionId: currentQuestion.id,
			optionId: selectedAnswer,
		});
	}, [selectedAnswer, quizAttempt, currentQuestionIndex, submitAnswerMutation]);

	const handleNextQuestion = useCallback(() => {
		if (!quizAttempt) return;

		if (currentQuestionIndex < quizAttempt.questions.length - 1) {
			setCurrentQuestionIndex((prev) => prev + 1);
			setSelectedAnswer(null);
		}
	}, [quizAttempt, currentQuestionIndex]);

	const handleCompleteQuiz = useCallback(() => {
		completeQuizMutation.mutate();
	}, [completeQuizMutation]);

	const handleGoToDashboard = useCallback(() => {
		navigate({ to: "/dash/driver" });
	}, [navigate]);

	if (driverLoading || attemptLoading) {
		return (
			<div className="flex min-h-[50vh] items-center justify-center">
				<Loader2 className="h-8 w-8 animate-spin text-muted-foreground" />
			</div>
		);
	}

	// If driver has passed the quiz, show success message
	if (driverData?.quizStatus === "PASSED") {
		return (
			<div className="mx-auto max-w-2xl py-8">
				<Card>
					<CardHeader className="text-center">
						<div className="mx-auto mb-4 flex h-16 w-16 items-center justify-center rounded-full bg-green-100">
							<CheckCircle2 className="h-10 w-10 text-green-600" />
						</div>
						<CardTitle className="text-2xl">Quiz Completed!</CardTitle>
						<CardDescription>
							You have already passed the driver knowledge quiz.
						</CardDescription>
					</CardHeader>
					<CardContent className="text-center">
						<div className="space-y-2">
							<p className="text-muted-foreground">
								Quiz Score:{" "}
								<span className="font-semibold text-foreground">
									{driverData.quizScore}%
								</span>
							</p>
							{driverData.quizCompletedAt && (
								<p className="text-muted-foreground text-sm">
									Completed on:{" "}
									{new Date(driverData.quizCompletedAt).toLocaleDateString()}
								</p>
							)}
						</div>
					</CardContent>
					<CardFooter className="justify-center">
						<Button onClick={handleGoToDashboard}>
							Go to Dashboard
							<ArrowRight className="ml-2 h-4 w-4" />
						</Button>
					</CardFooter>
				</Card>
			</div>
		);
	}

	// Show quiz result if just completed
	if (quizResult) {
		return (
			<div className="mx-auto max-w-2xl py-8">
				<Card>
					<CardHeader className="text-center">
						<div
							className={cn(
								"mx-auto mb-4 flex h-16 w-16 items-center justify-center rounded-full",
								quizResult.passed ? "bg-green-100" : "bg-red-100",
							)}
						>
							{quizResult.passed ? (
								<CheckCircle2 className="h-10 w-10 text-green-600" />
							) : (
								<XCircle className="h-10 w-10 text-red-600" />
							)}
						</div>
						<CardTitle className="text-2xl">
							{quizResult.passed ? "Congratulations!" : "Quiz Not Passed"}
						</CardTitle>
						<CardDescription>
							{quizResult.passed
								? "You have successfully passed the driver knowledge quiz."
								: "Don't worry, you can try again!"}
						</CardDescription>
					</CardHeader>
					<CardContent className="space-y-4">
						<div className="grid grid-cols-2 gap-4 text-center">
							<div className="rounded-lg bg-muted p-4">
								<p className="text-muted-foreground text-sm">Score</p>
								<p className="font-bold text-2xl">
									{quizResult.scorePercentage.toFixed(0)}%
								</p>
							</div>
							<div className="rounded-lg bg-muted p-4">
								<p className="text-muted-foreground text-sm">Correct Answers</p>
								<p className="font-bold text-2xl">
									{quizResult.correctAnswers}/{quizResult.totalQuestions}
								</p>
							</div>
							<div className="rounded-lg bg-muted p-4">
								<p className="text-muted-foreground text-sm">Points Earned</p>
								<p className="font-bold text-2xl">{quizResult.earnedPoints}</p>
							</div>
							<div className="rounded-lg bg-muted p-4">
								<p className="text-muted-foreground text-sm">Total Points</p>
								<p className="font-bold text-2xl">{quizResult.totalPoints}</p>
							</div>
						</div>

						{!quizResult.passed && (
							<Alert variant="destructive">
								<AlertCircle className="h-4 w-4" />
								<AlertTitle>Not Passed</AlertTitle>
								<AlertDescription>
									You need at least 70% to pass. Please review the material and
									try again.
								</AlertDescription>
							</Alert>
						)}
					</CardContent>
					<CardFooter className="flex justify-center gap-4">
						{quizResult.passed ? (
							<Button onClick={handleGoToDashboard}>
								Go to Dashboard
								<ArrowRight className="ml-2 h-4 w-4" />
							</Button>
						) : (
							<Button
								onClick={handleStartQuiz}
								disabled={startQuizMutation.isPending}
							>
								{startQuizMutation.isPending ? (
									<Loader2 className="mr-2 h-4 w-4 animate-spin" />
								) : (
									<RefreshCw className="mr-2 h-4 w-4" />
								)}
								Try Again
							</Button>
						)}
					</CardFooter>
				</Card>
			</div>
		);
	}

	// Active quiz in progress
	if (quizAttempt) {
		const currentQuestion = quizAttempt.questions[currentQuestionIndex];
		const isLastQuestion =
			currentQuestionIndex === quizAttempt.questions.length - 1;
		const isCurrentQuestionAnswered = currentQuestion
			? answeredQuestions.has(currentQuestion.id)
			: false;
		const allQuestionsAnswered =
			answeredQuestions.size === quizAttempt.questions.length;
		const progress =
			((currentQuestionIndex + 1) / quizAttempt.questions.length) * 100;

		return (
			<div className="mx-auto max-w-3xl py-8">
				{/* Progress Header */}
				<div className="mb-6 space-y-2">
					<div className="flex items-center justify-between text-sm">
						<span className="text-muted-foreground">
							Question {currentQuestionIndex + 1} of{" "}
							{quizAttempt.questions.length}
						</span>
						<Badge variant="outline">{answeredQuestions.size} answered</Badge>
					</div>
					<Progress value={progress} className="h-2" />
				</div>

				{currentQuestion && (
					<Card>
						<CardHeader>
							<div className="flex items-start justify-between">
								<Badge variant="secondary" className="mb-2">
									{currentQuestion.category.replace("_", " ")}
								</Badge>
								<Badge variant="outline">{currentQuestion.points} pts</Badge>
							</div>
							<CardTitle className="text-lg">
								{currentQuestion.question}
							</CardTitle>
						</CardHeader>
						<CardContent>
							<RadioGroup
								value={selectedAnswer ?? ""}
								onValueChange={setSelectedAnswer}
								disabled={
									isCurrentQuestionAnswered || submitAnswerMutation.isPending
								}
								className="space-y-3"
							>
								{currentQuestion.options.map((option) => (
									<div
										key={option.id}
										className={cn(
											"flex items-center space-x-3 rounded-lg border p-4 transition-colors",
											selectedAnswer === option.id && !isCurrentQuestionAnswered
												? "border-primary bg-primary/5"
												: "hover:bg-muted/50",
											isCurrentQuestionAnswered &&
												"cursor-not-allowed opacity-60",
										)}
									>
										<RadioGroupItem value={option.id} id={option.id} />
										<Label
											htmlFor={option.id}
											className={cn(
												"flex-1 cursor-pointer",
												isCurrentQuestionAnswered && "cursor-not-allowed",
											)}
										>
											{option.text}
										</Label>
									</div>
								))}
							</RadioGroup>
						</CardContent>
						<CardFooter className="flex justify-between">
							<Button
								variant="outline"
								onClick={() => {
									setCurrentQuestionIndex((prev) => Math.max(0, prev - 1));
									setSelectedAnswer(null);
								}}
								disabled={currentQuestionIndex === 0}
							>
								Previous
							</Button>

							<div className="flex gap-2">
								{!isCurrentQuestionAnswered && (
									<Button
										onClick={handleSubmitAnswer}
										disabled={!selectedAnswer || submitAnswerMutation.isPending}
									>
										{submitAnswerMutation.isPending ? (
											<Loader2 className="mr-2 h-4 w-4 animate-spin" />
										) : null}
										Submit Answer
									</Button>
								)}

								{isCurrentQuestionAnswered && !isLastQuestion && (
									<Button onClick={handleNextQuestion}>
										Next
										<ArrowRight className="ml-2 h-4 w-4" />
									</Button>
								)}

								{isLastQuestion && allQuestionsAnswered && (
									<Button
										onClick={handleCompleteQuiz}
										disabled={completeQuizMutation.isPending}
										className="bg-green-600 hover:bg-green-700"
									>
										{completeQuizMutation.isPending ? (
											<Loader2 className="mr-2 h-4 w-4 animate-spin" />
										) : (
											<CheckCircle2 className="mr-2 h-4 w-4" />
										)}
										Complete Quiz
									</Button>
								)}
							</div>
						</CardFooter>
					</Card>
				)}

				{/* Question Navigation */}
				<div className="mt-6">
					<p className="mb-2 text-muted-foreground text-sm">
						Jump to question:
					</p>
					<div className="flex flex-wrap gap-2">
						{quizAttempt.questions.map((q, index) => (
							<Button
								key={q.id}
								size="sm"
								variant={
									index === currentQuestionIndex
										? "default"
										: answeredQuestions.has(q.id)
											? "secondary"
											: "outline"
								}
								className={cn(
									"h-8 w-8 p-0",
									answeredQuestions.has(q.id) &&
										index !== currentQuestionIndex &&
										"bg-green-100 text-green-700",
								)}
								onClick={() => {
									setCurrentQuestionIndex(index);
									setSelectedAnswer(null);
								}}
							>
								{index + 1}
							</Button>
						))}
					</div>
				</div>
			</div>
		);
	}

	// Show start quiz screen or check for in-progress attempt
	const hasInProgressAttempt = latestAttempt?.status === "IN_PROGRESS";

	return (
		<div className="mx-auto max-w-2xl py-8">
			<Card>
				<CardHeader className="text-center">
					<div className="mx-auto mb-4 flex h-16 w-16 items-center justify-center rounded-full bg-primary/10">
						<ClipboardList className="h-10 w-10 text-primary" />
					</div>
					<CardTitle className="text-2xl">
						{m.driver()} Knowledge Quiz
					</CardTitle>
					<CardDescription>
						Complete this quiz to demonstrate your understanding of driver
						guidelines, safety protocols, and platform rules.
					</CardDescription>
				</CardHeader>
				<CardContent className="space-y-4">
					{driverData?.quizStatus === "FAILED" && (
						<Alert variant="destructive">
							<XCircle className="h-4 w-4" />
							<AlertTitle>Previous Attempt Failed</AlertTitle>
							<AlertDescription>
								Your previous quiz attempt did not pass. You can try again now.
							</AlertDescription>
						</Alert>
					)}

					{hasInProgressAttempt && (
						<Alert>
							<AlertCircle className="h-4 w-4" />
							<AlertTitle>Quiz In Progress</AlertTitle>
							<AlertDescription>
								You have an incomplete quiz attempt. Starting a new quiz will
								replace it.
							</AlertDescription>
						</Alert>
					)}

					<div className="rounded-lg bg-muted p-4">
						<h3 className="mb-2 font-semibold">Quiz Information</h3>
						<ul className="space-y-1 text-muted-foreground text-sm">
							<li>• You will be presented with multiple-choice questions</li>
							<li>
								• Cover topics: Safety, Navigation, Customer Service, Platform
								Rules
							</li>
							<li>• Passing score: 70%</li>
							<li>
								• You must pass this quiz to be eligible for driver approval
							</li>
							<li>• Take your time - there is no time limit</li>
						</ul>
					</div>
				</CardContent>
				<CardFooter className="justify-center">
					<Button
						size="lg"
						onClick={handleStartQuiz}
						disabled={startQuizMutation.isPending}
					>
						{startQuizMutation.isPending ? (
							<Loader2 className="mr-2 h-4 w-4 animate-spin" />
						) : null}
						{hasInProgressAttempt ? "Start New Quiz" : "Start Quiz"}
					</Button>
				</CardFooter>
			</Card>
		</div>
	);
}
