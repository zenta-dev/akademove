import { zodResolver } from "@hookform/resolvers/zod";
import { m } from "@repo/i18n";
import {
	DRIVER_QUIZ_QUESTION_CATEGORIES,
	DRIVER_QUIZ_QUESTION_TYPES,
} from "@repo/schema/constants";
import type {
	DriverQuizQuestion,
	DriverQuizQuestionCategory,
	DriverQuizQuestionOption,
	DriverQuizQuestionType,
	InsertDriverQuizQuestion,
} from "@repo/schema/driver-quiz-question";
import { InsertDriverQuizQuestionSchema } from "@repo/schema/driver-quiz-question";
import { capitalizeFirstLetter } from "@repo/shared";
import { useMutation } from "@tanstack/react-query";
import { InfoIcon, Plus, Trash2 } from "lucide-react";
import { useCallback, useEffect } from "react";
import { useFieldArray, useForm } from "react-hook-form";
import { toast } from "sonner";
import { Submitting } from "@/components/misc/submitting";
import { Button } from "@/components/ui/button";
import { Checkbox } from "@/components/ui/checkbox";
import {
	Form,
	FormControl,
	FormField,
	FormItem,
	FormLabel,
	FormMessage,
} from "@/components/ui/form";
import { Input } from "@/components/ui/input";
import {
	Select,
	SelectContent,
	SelectItem,
	SelectTrigger,
	SelectValue,
} from "@/components/ui/select";
import { Textarea } from "@/components/ui/textarea";
import {
	Tooltip,
	TooltipContent,
	TooltipTrigger,
} from "@/components/ui/tooltip";
import { orpcQuery, queryClient } from "@/lib/orpc";

interface QuizQuestionFormProps {
	quizQuestion?: DriverQuizQuestion;
	onSuccess?: () => void;
	onCancel?: () => void;
}

const defaultOption: DriverQuizQuestionOption = {
	id: "",
	text: "",
	isCorrect: false,
};

export const QuizQuestionForm = ({
	quizQuestion,
	onSuccess,
	onCancel,
}: QuizQuestionFormProps) => {
	const isEdit = !!quizQuestion;

	const form = useForm({
		resolver: zodResolver(InsertDriverQuizQuestionSchema),
		defaultValues: quizQuestion
			? {
					question: quizQuestion.question,
					type: quizQuestion.type,
					category: quizQuestion.category,
					options: quizQuestion.options,
					explanation: quizQuestion.explanation,
					points: quizQuestion.points,
					isActive: quizQuestion.isActive,
					displayOrder: quizQuestion.displayOrder,
				}
			: {
					question: "",
					type: "MULTIPLE_CHOICE" as DriverQuizQuestionType,
					category: "GENERAL" as DriverQuizQuestionCategory,
					options: [defaultOption, defaultOption],
					explanation: null,
					points: 10,
					isActive: true,
					displayOrder: 0,
				},
	});

	const { fields, append, remove } = useFieldArray({
		control: form.control,
		name: "options",
	});

	const watchedType = form.watch("type");

	// Adjust options when type changes
	useEffect(() => {
		if (watchedType === "TRUE_FALSE" && fields.length > 2) {
			// Remove extra options for true/false
			form.setValue(
				"options",
				fields.slice(0, 2).map((option, index) => ({
					...option,
					text: index === 0 ? "True" : "False",
				})),
			);
		} else if (watchedType === "MULTIPLE_CHOICE" && fields.length < 2) {
			// Ensure at least 2 options for multiple choice
			while (fields.length < 2) {
				append({ ...defaultOption, id: crypto.randomUUID() });
			}
		}
	}, [watchedType, fields.length, append, form, fields.slice]);

	const createMutation = useMutation(
		orpcQuery.driverQuizQuestion.create.mutationOptions({
			onSuccess: async () => {
				await queryClient.invalidateQueries();
				toast.success(m.server_driver_quiz_question_created());
				form.reset();
				onSuccess?.();
			},
			onError: (error: Error) => {
				toast.error(
					m.failed_placeholder({ action: m.create_quiz_question() }),
					{
						description: error.message || m.an_unexpected_error_occurred(),
					},
				);
			},
		}),
	);

	const updateMutation = useMutation(
		orpcQuery.driverQuizQuestion.update.mutationOptions({
			onSuccess: async () => {
				await queryClient.invalidateQueries();
				toast.success(m.server_driver_quiz_question_updated());
				onSuccess?.();
			},
			onError: (error: Error) => {
				toast.error(
					m.failed_placeholder({ action: m.update_quiz_question() }),
					{
						description: error.message || m.an_unexpected_error_occurred(),
					},
				);
			},
		}),
	);

	const onSubmit = useCallback(
		(values: InsertDriverQuizQuestion) => {
			// Validate that at least one option is correct
			const hasCorrectAnswer = values.options.some(
				(option) => option.isCorrect,
			);
			if (!hasCorrectAnswer) {
				toast.error(m.at_least_one_correct_answer_required());
				return;
			}

			if (isEdit && quizQuestion) {
				updateMutation.mutate({
					params: { id: quizQuestion.id },
					body: values,
				});
			} else {
				createMutation.mutate({ body: values });
			}
		},
		[isEdit, quizQuestion, createMutation, updateMutation],
	);

	const addOption = useCallback(() => {
		if (fields.length < 6) {
			append({ ...defaultOption, id: crypto.randomUUID() });
		}
	}, [append, fields.length]);

	const removeOption = useCallback(
		(index: number) => {
			if (fields.length > 2) {
				remove(index);
			}
		},
		[remove, fields.length],
	);

	const isPending = createMutation.isPending || updateMutation.isPending;

	return (
		<Form {...form}>
			<form onSubmit={form.handleSubmit(onSubmit)} className="space-y-6">
				<FormField
					control={form.control}
					name="question"
					render={({ field }) => (
						<FormItem>
							<FormLabel>{m.question()}</FormLabel>
							<FormControl>
								<Textarea
									placeholder={m.enter_question_placeholder()}
									disabled={isPending}
									{...field}
								/>
							</FormControl>
							<FormMessage />
						</FormItem>
					)}
				/>

				<div className="grid grid-cols-1 gap-4 md:grid-cols-2">
					<FormField
						control={form.control}
						name="type"
						render={({ field }) => (
							<FormItem>
								<FormLabel>{m.type()}</FormLabel>
								<Select
									onValueChange={field.onChange}
									defaultValue={field.value}
								>
									<FormControl>
										<SelectTrigger disabled={isPending} className="w-full">
											<SelectValue placeholder={m.select_type()} />
										</SelectTrigger>
									</FormControl>
									<SelectContent className="w-full">
										{DRIVER_QUIZ_QUESTION_TYPES.map((type) => (
											<SelectItem key={type} value={type}>
												{capitalizeFirstLetter(
													type.toLowerCase().replace("_", " "),
												)}
											</SelectItem>
										))}
									</SelectContent>
								</Select>
								<FormMessage />
							</FormItem>
						)}
					/>

					<FormField
						control={form.control}
						name="category"
						render={({ field }) => (
							<FormItem>
								<FormLabel>{m.category()}</FormLabel>
								<Select
									onValueChange={field.onChange}
									defaultValue={field.value}
								>
									<FormControl>
										<SelectTrigger disabled={isPending} className="w-full">
											<SelectValue placeholder={m.select_category()} />
										</SelectTrigger>
									</FormControl>
									<SelectContent className="w-full">
										{DRIVER_QUIZ_QUESTION_CATEGORIES.map((category) => (
											<SelectItem key={category} value={category}>
												{capitalizeFirstLetter(
													category.toLowerCase().replace("_", " "),
												)}
											</SelectItem>
										))}
									</SelectContent>
								</Select>
								<FormMessage />
							</FormItem>
						)}
					/>
				</div>

				<div className="space-y-4">
					<div className="flex items-center justify-between">
						<div className="flex items-center gap-2">
							<FormLabel>{m.options()}</FormLabel>
							<Tooltip>
								<TooltipTrigger>
									<InfoIcon className="h-4 w-4 text-muted-foreground" />
								</TooltipTrigger>
								<TooltipContent side="top">
									{m.checklist_for_marking_correct_answer()}
								</TooltipContent>
							</Tooltip>
						</div>
						{watchedType === "MULTIPLE_CHOICE" && (
							<Button
								type="button"
								variant="outline"
								size="sm"
								onClick={addOption}
								disabled={isPending || fields.length >= 6}
							>
								<Plus className="mr-2 h-4 w-4" />
								{m.add_option()}
							</Button>
						)}
					</div>

					{fields.map((field, index) => (
						<div key={field.id} className="flex items-center gap-2">
							<FormField
								control={form.control}
								name={`options.${index}.isCorrect`}
								render={({ field }) => (
									<FormItem>
										<FormControl>
											<Checkbox
												checked={field.value}
												onCheckedChange={field.onChange}
												disabled={isPending}
											/>
										</FormControl>
									</FormItem>
								)}
							/>
							<FormField
								control={form.control}
								name={`options.${index}.text`}
								render={({ field }) => (
									<FormItem className="flex-1">
										<FormControl>
											<Input
												placeholder={`${m.option()} ${index + 1}`}
												disabled={isPending}
												{...field}
											/>
										</FormControl>
										<FormMessage />
									</FormItem>
								)}
							/>
							{watchedType === "MULTIPLE_CHOICE" && fields.length > 2 && (
								<Button
									type="button"
									variant="outline"
									size="sm"
									onClick={() => removeOption(index)}
									disabled={isPending}
								>
									<Trash2 className="h-4 w-4" />
								</Button>
							)}
						</div>
					))}
				</div>

				<FormField
					control={form.control}
					name="explanation"
					render={({ field }) => (
						<FormItem>
							<FormLabel>{m.explanation()}</FormLabel>
							<FormControl>
								<Textarea
									placeholder={m.enter_explanation_placeholder()}
									disabled={isPending}
									{...field}
									value={field.value || ""}
								/>
							</FormControl>
							<FormMessage />
						</FormItem>
					)}
				/>

				<div className="grid grid-cols-1 gap-4 md:grid-cols-3">
					<FormField
						control={form.control}
						name="points"
						render={({ field }) => (
							<FormItem>
								<FormLabel>{m.points()}</FormLabel>
								<FormControl>
									<Input
										type="number"
										min="1"
										max="1000"
										placeholder="10"
										disabled={isPending}
										{...field}
										onChange={(e) =>
											field.onChange(Number.parseInt(e.target.value, 10) || 0)
										}
									/>
								</FormControl>
								<FormMessage />
							</FormItem>
						)}
					/>

					<FormField
						control={form.control}
						name="displayOrder"
						render={({ field }) => (
							<FormItem>
								<FormLabel>{m.display_order()}</FormLabel>
								<FormControl>
									<Input
										type="number"
										min="0"
										placeholder="0"
										disabled={isPending}
										{...field}
										onChange={(e) =>
											field.onChange(Number.parseInt(e.target.value, 10) || 0)
										}
									/>
								</FormControl>
								<FormMessage />
							</FormItem>
						)}
					/>

					<FormField
						control={form.control}
						name="isActive"
						render={({ field }) => (
							<FormItem className="flex flex-row items-start space-x-3 space-y-0 rounded-md border p-4">
								<FormControl>
									<Checkbox
										checked={field.value}
										onCheckedChange={field.onChange}
										disabled={isPending}
									/>
								</FormControl>
								<div className="space-y-1 leading-none">
									<FormLabel>{m.active()}</FormLabel>
								</div>
							</FormItem>
						)}
					/>
				</div>

				<div className="flex justify-end gap-2">
					{onCancel && (
						<Button
							type="button"
							variant="outline"
							onClick={onCancel}
							disabled={isPending}
						>
							{m.cancel()}
						</Button>
					)}
					<Button type="submit" disabled={isPending}>
						{isPending && <Submitting />}
						{isEdit ? m.update() : m.create()}
					</Button>
				</div>
			</form>
		</Form>
	);
};
