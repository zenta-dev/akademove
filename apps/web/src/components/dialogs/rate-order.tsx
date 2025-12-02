import { zodResolver } from "@hookform/resolvers/zod";
import { InsertReviewSchema, type ReviewCategory } from "@repo/schema/review";
import { useMutation } from "@tanstack/react-query";
import { Car, Heart, MessageSquare, Star } from "lucide-react";
import { useState } from "react";
import { useForm } from "react-hook-form";
import { toast } from "sonner";
import type * as z from "zod";
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
	OTHER: MessageSquare,
};

const categoryLabels: Record<ReviewCategory, string> = {
	CLEANLINESS: "Cleanliness",
	COURTESY: "Courtesy & Service",
	OTHER: "Other",
};

export function RateOrderDialog({
	open,
	onOpenChange,
	orderId,
	driverId,
	driverName,
}: RateOrderDialogProps) {
	const [hoveredStar, setHoveredStar] = useState(0);

	const form = useForm({
		resolver: zodResolver(InsertReviewSchema),
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
				queryClient.invalidateQueries({ queryKey: ["reviews"] });
				queryClient.invalidateQueries({ queryKey: ["user", "orders"] });
				toast.success("Rating submitted successfully");
				onOpenChange(false);
				form.reset();
			},
			onError: (error) => {
				toast.error(error.message || "Failed to submit rating");
			},
		}),
	);

	const onSubmit = (values: unknown) => {
		const parsedValues = InsertReviewSchema.parse(values);

		if (parsedValues.score === 0) {
			toast.error("Please select a rating");
			return;
		}
		createReviewMutation.mutate({ body: parsedValues });
	};

	const currentScore = form.watch("score");

	return (
		<Dialog open={open} onOpenChange={onOpenChange}>
			<DialogContent className="sm:max-w-[500px]">
				<DialogHeader>
					<DialogTitle>Rate Your Experience</DialogTitle>
					<DialogDescription>
						How was your experience with {driverName || "the driver"}?
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
									<FormLabel>Overall Rating *</FormLabel>
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
										{currentScore === 0 && "Click a star to rate"}
										{currentScore === 1 && "Poor"}
										{currentScore === 2 && "Fair"}
										{currentScore === 3 && "Good"}
										{currentScore === 4 && "Very Good"}
										{currentScore === 5 && "Excellent"}
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
									<FormLabel>What aspect would you like to rate? *</FormLabel>
									<FormControl>
										<RadioGroup
											value={field.value}
											onValueChange={field.onChange}
											className="flex flex-col space-y-2"
										>
											{(
												Object.keys(categoryLabels) as Array<ReviewCategory>
											).map((category) => {
												const Icon = categoryIcons[category];
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
															{categoryLabels[category]}
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
									<FormLabel>Additional Comments (Optional)</FormLabel>
									<FormControl>
										<Textarea
											{...field}
											placeholder="Share more details about your experience..."
											rows={4}
											maxLength={500}
										/>
									</FormControl>
									<FormDescription>
										{field.value?.length || 0}/500 characters
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
								Cancel
							</Button>
							<Button type="submit" disabled={createReviewMutation.isPending}>
								{createReviewMutation.isPending
									? "Submitting..."
									: "Submit Rating"}
							</Button>
						</DialogFooter>
					</form>
				</Form>
			</DialogContent>
		</Dialog>
	);
}
