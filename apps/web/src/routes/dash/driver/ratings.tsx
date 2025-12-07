import { m } from "@repo/i18n";
import { UnifiedPaginationQuerySchema } from "@repo/schema/pagination";
import type { Review } from "@repo/schema/review";
import { useQuery } from "@tanstack/react-query";
import { createFileRoute, redirect, useNavigate } from "@tanstack/react-router";
import {
	Car,
	Heart,
	Loader2,
	MessageSquare,
	Shield,
	Star,
	TrendingUp,
	UserRound,
} from "lucide-react";
import { useMemo } from "react";
import { Avatar, AvatarFallback } from "@/components/ui/avatar";
import { Badge } from "@/components/ui/badge";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Progress } from "@/components/ui/progress";
import { Skeleton } from "@/components/ui/skeleton";
import { hasAccess } from "@/lib/actions";
import { SUB_ROUTE_TITLES } from "@/lib/constants";
import { orpcQuery } from "@/lib/orpc";
import { cn } from "@/utils/cn";

export const Route = createFileRoute("/dash/driver/ratings")({
	validateSearch: (values) => {
		const search = UnifiedPaginationQuerySchema.parse(values);
		if (!values.limit) return { ...search, page: 1, limit: 15 };
		return search;
	},
	head: () => ({ meta: [{ title: SUB_ROUTE_TITLES.DRIVER.RATINGS }] }),
	beforeLoad: async () => {
		const ok = await hasAccess(["DRIVER"]);
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
	const navigate = useNavigate();
	const search = Route.useSearch();

	if (!allowed) navigate({ to: "/" });

	// Fetch driver data
	const { data: driverResponse, isLoading: driverLoading } = useQuery(
		orpcQuery.driver.getMine.queryOptions({}),
	);

	const driverData = useMemo(() => {
		if (driverResponse?.status !== 200) return null;
		return driverResponse.body.data;
	}, [driverResponse]);

	// Fetch reviews for this driver
	const { data: reviewsResponse, isLoading: reviewsLoading } = useQuery(
		orpcQuery.review.list.queryOptions({ input: { query: search } }),
	);

	const reviewsResult = useMemo(() => {
		if (!reviewsResponse || !driverData) return null;
		return reviewsResponse.body.data.filter(
			(r: Review) => r.toUserId === driverData?.userId,
		);
	}, [reviewsResponse, driverData]);

	const formatDate = (date: Date | string | undefined) => {
		if (!date) return "N/A";
		return new Intl.DateTimeFormat("id-ID", {
			month: "short",
			day: "numeric",
			year: "numeric",
		}).format(new Date(date));
	};

	// Calculate rating distribution (score is 1-5)
	const ratingDistribution =
		reviewsResult?.reduce(
			(acc, review: Review) => {
				acc[review.score as number] = (acc[review.score as number] || 0) + 1;
				return acc;
			},
			{} as Record<number, number>,
		) ?? {};

	const totalReviews = reviewsResult?.length ?? 0;

	// Category breakdown
	const categoryBreakdown =
		reviewsResult?.reduce(
			(acc, review: Review) => {
				if (review.category) {
					acc[review.category] = (acc[review.category] || 0) + 1;
				}
				return acc;
			},
			{} as Record<string, number>,
		) ?? {};

	const categoryIcons: Record<string, typeof Heart> = {
		CLEANLINESS: Car,
		COURTESY: Heart,
		SAFETY: Shield,
		OTHER: MessageSquare,
	};

	if (driverLoading || reviewsLoading) {
		return (
			<div className="flex min-h-[50vh] items-center justify-center">
				<Loader2 className="h-8 w-8 animate-spin text-muted-foreground" />
			</div>
		);
	}

	return (
		<>
			<div>
				<h2 className="font-medium text-xl">{m.ratings()}</h2>
				<p className="text-muted-foreground">
					Your customer ratings and reviews
				</p>
			</div>

			{/* Rating Overview */}
			<div className="grid gap-4 md:grid-cols-4">
				<Card>
					<CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
						<CardTitle className="font-medium text-sm">
							Overall Rating
						</CardTitle>
						<Star className="h-4 w-4 text-muted-foreground" />
					</CardHeader>
					<CardContent>
						<div className="flex items-center gap-2">
							<div className="font-bold text-3xl">
								{driverData?.rating?.toFixed(2) ?? "0.00"}
							</div>
							<Star className="h-6 w-6 fill-yellow-400 text-yellow-400" />
						</div>
						<p className="mt-1 text-muted-foreground text-xs">
							From {totalReviews} reviews
						</p>
					</CardContent>
				</Card>

				<Card>
					<CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
						<CardTitle className="font-medium text-sm">Total Reviews</CardTitle>
						<MessageSquare className="h-4 w-4 text-muted-foreground" />
					</CardHeader>
					<CardContent>
						<div className="font-bold text-3xl">{totalReviews}</div>
						<p className="mt-1 text-muted-foreground text-xs">
							Customer feedback
						</p>
					</CardContent>
				</Card>

				<Card>
					<CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
						<CardTitle className="font-medium text-sm">
							5-Star Reviews
						</CardTitle>
						<TrendingUp className="h-4 w-4 text-muted-foreground" />
					</CardHeader>
					<CardContent>
						<div className="font-bold text-3xl">
							{ratingDistribution[5] ?? 0}
						</div>
						<p className="mt-1 text-muted-foreground text-xs">
							{totalReviews > 0
								? Math.round(
										((ratingDistribution[5] ?? 0) / totalReviews) * 100,
									)
								: 0}
							% of total
						</p>
					</CardContent>
				</Card>

				<Card>
					<CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
						<CardTitle className="font-medium text-sm">Satisfaction</CardTitle>
						<Heart className="h-4 w-4 text-muted-foreground" />
					</CardHeader>
					<CardContent>
						<div className="font-bold text-3xl">
							{totalReviews > 0
								? Math.round(((driverData?.rating ?? 0) / 5) * 100)
								: 0}
							%
						</div>
						<p className="mt-1 text-muted-foreground text-xs">
							Customer satisfaction
						</p>
					</CardContent>
				</Card>
			</div>

			{/* Rating Distribution & Categories */}
			<div className="grid gap-4 md:grid-cols-2">
				{/* Rating Distribution */}
				<Card>
					<CardHeader>
						<CardTitle>Rating Distribution</CardTitle>
					</CardHeader>
					<CardContent className="space-y-3">
						{[5, 4, 3, 2, 1].map((rating) => {
							const count = ratingDistribution[rating] ?? 0;
							const percentage =
								totalReviews > 0 ? (count / totalReviews) * 100 : 0;

							return (
								<div key={rating} className="flex items-center gap-3">
									<div className="flex w-16 items-center gap-1">
										<span className="font-medium text-sm">{rating}</span>
										<Star className="h-3 w-3 fill-yellow-400 text-yellow-400" />
									</div>
									<Progress value={percentage} className="h-2 flex-1" />
									<span className="w-12 text-right text-muted-foreground text-sm">
										{count}
									</span>
								</div>
							);
						})}
					</CardContent>
				</Card>

				{/* Category Breakdown */}
				<Card>
					<CardHeader>
						<CardTitle>Review Categories</CardTitle>
					</CardHeader>
					<CardContent className="space-y-3">
						{Object.entries(categoryBreakdown).map(([category, count]) => {
							const Icon = categoryIcons[category] || MessageSquare;
							const percentage =
								totalReviews > 0 ? (count / totalReviews) * 100 : 0;

							return (
								<div key={category} className="flex items-center gap-3">
									<div className="flex w-32 items-center gap-2">
										<Icon className="h-4 w-4 text-muted-foreground" />
										<span className="font-medium text-sm">{category}</span>
									</div>
									<Progress value={percentage} className="h-2 flex-1" />
									<span className="w-12 text-right text-muted-foreground text-sm">
										{count}
									</span>
								</div>
							);
						})}
						{Object.keys(categoryBreakdown).length === 0 && (
							<p className="py-4 text-center text-muted-foreground text-sm">
								No category data available yet
							</p>
						)}
					</CardContent>
				</Card>
			</div>

			{/* Recent Reviews */}
			<Card>
				<CardHeader>
					<CardTitle>Recent Reviews</CardTitle>
				</CardHeader>
				<CardContent>
					{reviewsLoading ? (
						<div className="space-y-4">
							<Skeleton className="h-24 w-full" />
							<Skeleton className="h-24 w-full" />
							<Skeleton className="h-24 w-full" />
						</div>
					) : !reviewsResult || reviewsResult.length === 0 ? (
						<div className="flex flex-col items-center justify-center py-12 text-center">
							<Star className="mb-4 h-12 w-12 text-muted-foreground" />
							<h3 className="mb-2 font-semibold text-lg">No reviews yet</h3>
							<p className="text-muted-foreground text-sm">
								Complete orders to receive customer feedback
							</p>
						</div>
					) : (
						<div className="space-y-4">
							{reviewsResult.map((review: Review) => (
								<div
									key={review.id}
									className="flex gap-4 rounded-lg border p-4"
								>
									<Avatar className="h-10 w-10">
										<AvatarFallback>
											<UserRound className="h-5 w-5" />
										</AvatarFallback>
									</Avatar>
									<div className="flex-1 space-y-2">
										<div className="flex items-start justify-between">
											<div>
												<p className="font-semibold text-sm">Customer Review</p>
												<p className="text-muted-foreground text-xs">
													{formatDate(review.createdAt)}
												</p>
											</div>
											<div className="flex items-center gap-1">
												{Array.from({ length: 5 }).map((_, i) => (
													<Star
														key={`star-${review.id}-${i}`}
														className={cn(
															"h-4 w-4",
															i < review.score
																? "fill-yellow-400 text-yellow-400"
																: "text-gray-300",
														)}
													/>
												))}
											</div>
										</div>
										{review.comment && (
											<p className="text-sm">{review.comment}</p>
										)}
										{review.category && (
											<Badge variant="secondary" className="text-xs">
												{review.category}
											</Badge>
										)}
									</div>
								</div>
							))}
						</div>
					)}
				</CardContent>
			</Card>
		</>
	);
}
