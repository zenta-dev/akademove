import { m } from "@repo/i18n";
import { useQuery } from "@tanstack/react-query";
import { createFileRoute, redirect, useNavigate } from "@tanstack/react-router";
import { Loader2 } from "lucide-react";
import { CouponForm } from "@/components/forms/coupon-form";
import { Card, CardContent } from "@/components/ui/card";
import { hasAccess } from "@/lib/actions";
import { SUB_ROUTE_TITLES } from "@/lib/constants";
import { orpcQuery } from "@/lib/orpc";

export const Route = createFileRoute("/dash/admin/coupons/$id")({
	head: () => ({ meta: [{ title: SUB_ROUTE_TITLES.ADMIN.COUPONS }] }),
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
	const { id } = Route.useParams();
	const navigate = useNavigate();

	if (!allowed) navigate({ to: "/" });

	const coupon = useQuery(
		orpcQuery.coupon.get.queryOptions({
			input: { params: { id } },
		}),
	);

	if (coupon.isPending) {
		return (
			<div className="flex h-64 items-center justify-center">
				<Loader2 className="h-8 w-8 animate-spin" />
			</div>
		);
	}

	if (coupon.isError || !coupon.data?.body.data) {
		return (
			<div className="text-center text-red-600">
				{m.an_unexpected_error_occurred()}
			</div>
		);
	}

	return (
		<div className="mx-auto w-full max-w-3xl">
			<div className="flex items-center justify-between">
				<div>
					<h2 className="font-medium text-xl">{m.edit_coupon()}</h2>
					<p className="text-muted-foreground">{m.admin_dash_desc()}</p>
				</div>
			</div>
			<Card className="mt-4">
				<CardContent>
					<CouponForm
						kind="edit"
						coupon={coupon.data.body.data}
						redirectPath="/dash/admin/coupons"
					/>
				</CardContent>
			</Card>
		</div>
	);
}
