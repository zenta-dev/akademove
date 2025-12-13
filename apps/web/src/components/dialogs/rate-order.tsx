import { m } from "@repo/i18n";
import {
	type InsertReview,
	InsertReviewSchema,
	type ReviewCategory,
} from "@repo/schema/review";
import { useMutation } from "@tanstack/react-query";
import {
	Car,
	Clock,
	Heart,
	MessageCircle,
	MessageSquare,
	ShieldCheck,
	Star,
} from "lucide-react";
import { useState } from "react";
import { useForm } from "react-hook-form";
import { toast } from "sonner";
import { Button } from "@/components/ui/button";
import {
	Dialog,
	DialogContent,
	DialogDescription,
	DialogFooter,
	DialogHeader,
	DialogTitle,
} from "@/components/ui/dialog";
import {
	Form,
	FormControl,
	FormDescription,
	FormField,
	FormItem,
	FormLabel,
	FormMessage,
} from "@/components/ui/form";
import { Label } from "@/components/ui/label";
import { RadioGroup, RadioGroupItem } from "@/components/ui/radio-group";
import { Textarea } from "@/components/ui/textarea";
import { orpcClient, orpcQuery, queryClient } from "@/lib/orpc";
import { cn } from "@/utils/cn";

type RateOrderDialogProps = {
	open: boolean;
	onOpenChange: (open: boolean) => void;
	orderId: string;
	driverId: string;
	driverName?: string;
};

const categoryIcons: Record<ReviewCategory, typeof Heart> = {
	CLEANLINESS: Car,
	COURTESY: Heart,
	PUNCTUALITY: Clock,
	SAFETY: ShieldCheck,
	COMMUNICATION: MessageCircle,
	OTHER: MessageSquare,
};

const getCategoryLabels = (): Record<ReviewCategory, string> => ({
	CLEANLINESS: m.rate_order_cleanliness(),
	COURTESY: m.rate_order_courtesy(),
	PUNCTUALITY: m.rate_order_punctuality(),
	SAFETY: m.rate_order_safety(),
	COMMUNICATION: m.rate_order_communication(),
	OTHER: m.rate_order_other(),
});

export function RateOrderDialog({
	open,
	onOpenChange,
	orderId,
	driverId,
	driverName,
}: RateOrderDialogProps) {
	const [hoveredStar, setHoveredStar] = useState(0);

	const form = useForm<InsertReview>({
		defaultValues: {
			orderId,
			toUserId: driverId,
			fromUserId: "", // Will be set by backend from context.user.id
			category: "COURTESY",
			score: 0,
			comment: "",
		},
	});

	const createReviewMutation = useMutation(
		orpcQuery.review.create.mutationOptions({
			mutationFn: async (data: unknown) => {
				const parsed = InsertReviewSchema.parse(data);
				const result = await orpcClient.review.create({
					body: parsed,
				});
				if (result.status !== 200) throw new Error(result.body.message);
				return result;
			},
			onSuccess: () => {
				queryClient.invalidateQueries();
				toast.success(m.rate_order_success());
				onOpenChange(false);
				form.reset();
			},
			onError: (error) => {
				toast.error(error.message || m.rate_order_error());
			},
		}),
	);

	const onSubmit = (values: InsertReview) => {
		if (values.score === 0) {
			toast.error(m.rate_order_select_rating());
			return;
		}
		createReviewMutation.mutate({ body: values });
	};

	const currentScore = form.watch("score");

	return (
		<Dialog open={open} onOpenChange={onOpenChange}>
			<DialogContent className="sm:max-w-[500px]">
				<DialogHeader>
					<DialogTitle>{m.rate_order_title()}</DialogTitle>
					<DialogDescription>
						{m.rate_order_desc({
							driverName: driverName || m.tracking_driver(),
						})}
					</DialogDescription>
				</DialogHeader>

				<Form {...form}>
					<form onSubmit={form.handleSubmit(onSubmit)} className="space-y-6">
						{/* Star Rating */}
						<FormField
							control={form.control}
							name="score"
							render={({ field }) => (
								<FormItem>
									<FormLabel>{m.rate_order_overall()}</FormLabel>
									<FormControl>
										<div className="flex items-center justify-center gap-2 py-4">
											{Array.from({ length: 5 }).map((_, i) => {
												const starValue = i + 1;
												const isActive =
													starValue <= (hoveredStar || currentScore);

												return (
													<button
														key={`star-${
															// biome-ignore lint/suspicious/noArrayIndexKey: static array
															i
														}`}
														type="button"
														onClick={() => field.onChange(starValue)}
														onMouseEnter={() => setHoveredStar(starValue)}
														onMouseLeave={() => setHoveredStar(0)}
														className="transition-transform hover:scale-110"
													>
														<Star
															className={cn(
																"h-10 w-10 transition-colors",
																isActive
																	? "fill-yellow-400 text-yellow-400"
																	: "text-gray-300",
															)}
														/>
													</button>
												);
											})}
										</div>
									</FormControl>
									<FormDescription className="text-center">
										{currentScore === 0 && m.rate_order_select_rating()}
										{currentScore === 1 && m.rate_order_poor()}
										{currentScore === 2 && m.rate_order_fair()}
										{currentScore === 3 && m.rate_order_good()}
										{currentScore === 4 && m.rate_order_very_good()}
										{currentScore === 5 && m.rate_order_excellent()}
									</FormDescription>
									<FormMessage />
								</FormItem>
							)}
						/>

						{/* Category */}
						<FormField
							control={form.control}
							name="category"
							render={({ field }) => (
								<FormItem>
									<FormLabel>{m.rate_order_aspect()}</FormLabel>
									<FormControl>
										<RadioGroup
											value={field.value}
											onValueChange={field.onChange}
											className="flex flex-col space-y-2"
										>
											{(
												Object.keys(
													getCategoryLabels(),
												) as Array<ReviewCategory>
											).map((category) => {
												const Icon = categoryIcons[category];
												const labels = getCategoryLabels();
												return (
													<div
														key={category}
														className="flex items-center space-x-2"
													>
														<RadioGroupItem value={category} id={category} />
														<Label
															htmlFor={category}
															className="flex cursor-pointer items-center gap-2 font-normal"
														>
															<Icon className="h-4 w-4 text-muted-foreground" />
															{labels[category]}
														</Label>
													</div>
												);
											})}
										</RadioGroup>
									</FormControl>
									<FormMessage />
								</FormItem>
							)}
						/>

						{/* Comment */}
						<FormField
							control={form.control}
							name="comment"
							render={({ field }) => (
								<FormItem>
									<FormLabel>{m.rate_order_comments()}</FormLabel>
									<FormControl>
										<Textarea
											{...field}
											placeholder={m.rate_order_comments_placeholder()}
											rows={4}
											maxLength={500}
										/>
									</FormControl>
									<FormDescription>
										{m.rate_order_comments_count({
											length: field.value?.length || 0,
										})}
									</FormDescription>
									<FormMessage />
								</FormItem>
							)}
						/>

						<DialogFooter>
							<Button
								type="button"
								variant="outline"
								onClick={() => onOpenChange(false)}
								disabled={createReviewMutation.isPending}
							>
								{m.cancel()}
							</Button>
							<Button type="submit" disabled={createReviewMutation.isPending}>
								{createReviewMutation.isPending
									? m.submitting()
									: m.rate_order_submit()}
							</Button>
						</DialogFooter>
					</form>
				</Form>
			</DialogContent>
		</Dialog>
	);
}
