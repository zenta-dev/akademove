import { m } from "@repo/i18n";
import { UnifiedPaginationQuerySchema } from "@repo/schema/pagination";
import {
	createFileRoute,
	Link,
	redirect,
	useNavigate,
} from "@tanstack/react-router";
import { PlusIcon } from "lucide-react";
import { CouponTable } from "@/components/tables/coupon/table";
import { buttonVariants } from "@/components/ui/button";
import { Card, CardContent } from "@/components/ui/card";
import { hasAccess } from "@/lib/actions";
import { SUB_ROUTE_TITLES } from "@/lib/constants";

export const Route = createFileRoute("/dash/operator/coupons/")({
	validateSearch: (values) => {
		const search = UnifiedPaginationQuerySchema.parse(values);
		if (!values.limit) return { ...search, page: 1, limit: 15 };
		return search;
	},
	head: () => ({ meta: [{ title: SUB_ROUTE_TITLES.OPERATOR.COUPONS }] }),
	beforeLoad: async () => {
		const ok = await hasAccess(["OPERATOR"]);
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

	if (!allowed) navigate({ to: "/" });
	return (
		<>
			<div className="flex items-center justify-between">
				<div>
					<h2 className="font-medium text-xl">{m.coupons()}</h2>
					<p className="text-muted-foreground">{m.admin_dash_desc()}</p>
				</div>
				<Link to="/dash/operator/coupons/new" className={buttonVariants()}>
					<PlusIcon />
					{m.create_coupon()}
				</Link>
			</div>
			<Card className="p-0">
				<CardContent className="p-0">
					<CouponTable search={search} to="/dash/operator/coupons" />
				</CardContent>
			</Card>
		</>
	);
}
