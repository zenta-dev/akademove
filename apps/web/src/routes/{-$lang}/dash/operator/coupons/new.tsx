import { m } from "@repo/i18n";
import { createFileRoute, redirect, useNavigate } from "@tanstack/react-router";
import { CouponForm } from "@/components/foms/coupon";
import { Card, CardContent } from "@/components/ui/card";
import { hasAccess } from "@/lib/actions";
import { SUB_ROUTE_TITLES } from "@/lib/constants";

export const Route = createFileRoute("/{-$lang}/dash/operator/coupons/new")({
	head: () => ({ meta: [{ title: SUB_ROUTE_TITLES.OPERATOR.COUPONS }] }),
	beforeLoad: async () => {
		const ok = await hasAccess({
			coupon: ["create"],
		});
		if (!ok) redirect({ to: "/{-$lang}", throw: true });
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
	if (!allowed) navigate({ to: "/{-$lang}" });

	return (
		<div className="mx-auto w-full max-w-3xl">
			<div className="flex items-center justify-between">
				<div>
					<h2 className="font-medium text-xl">{m.coupons()}</h2>
					<p className="text-muted-foreground">{m.admin_dash_desc()}</p>
				</div>
			</div>
			<Card className="mt-4">
				<CardContent>
					<CouponForm kind="new" />
				</CardContent>
			</Card>
		</div>
	);
}
