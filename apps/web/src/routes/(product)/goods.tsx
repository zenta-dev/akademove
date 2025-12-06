import { m } from "@repo/i18n";
import { createFileRoute, Link } from "@tanstack/react-router";
import {
	BellRingIcon,
	ClockIcon,
	FileTextIcon,
	PackageIcon,
	ShieldCheckIcon,
	ShirtIcon,
	WeightIcon,
} from "lucide-react";
import { LandingFooter } from "@/components/footer/landing-footer";
import { PublicHeader } from "@/components/header/public";
import { Button } from "@/components/ui/button";
import {
	Card,
	CardContent,
	CardDescription,
	CardHeader,
	CardTitle,
} from "@/components/ui/card";

export const Route = createFileRoute("/(product)/goods")({
	component: RouteComponent,
});

function RouteComponent() {
	return (
		<div className="min-h-screen">
			<PublicHeader className="fixed top-0 right-0 left-0 z-50 mx-auto mt-2 w-full max-w-3xl rounded-xl border p-4" />

			{/* Hero Section */}
			<section className="bg-linear-to-b from-green-500/10 to-background px-4 py-32 sm:px-6 md:px-8 lg:px-16">
				<div className="mx-auto max-w-7xl">
					<div className="grid gap-12 lg:grid-cols-2 lg:gap-16">
						<div className="flex flex-col justify-center">
							<h1 className="font-bold text-4xl tracking-tight sm:text-5xl md:text-6xl">
								{m.goods_hero_title()}
							</h1>
							<p className="mt-4 text-lg text-muted-foreground sm:text-xl">
								{m.goods_hero_desc()}
							</p>
							<div className="mt-8 flex flex-col gap-4 sm:flex-row">
								<Link to="/sign-up/user">
									<Button size="lg" className="w-full sm:w-auto">
										{m.start_delivery()}
									</Button>
								</Link>
								<Link to="/">
									<Button
										size="lg"
										variant="outline"
										className="w-full sm:w-auto"
									>
										{m.learn_more()}
									</Button>
								</Link>
							</div>
						</div>
						<div className="relative">
							<div className="aspect-square overflow-hidden rounded-2xl bg-green-500/5">
								<div className="flex h-full items-center justify-center">
									<PackageIcon className="size-32 text-green-500/20" />
								</div>
							</div>
						</div>
					</div>
				</div>
			</section>

			{/* Features Section */}
			<section className="px-4 py-16 sm:px-6 md:px-8 lg:px-16">
				<div className="mx-auto max-w-7xl">
					<div className="text-center">
						<h2 className="font-bold text-3xl tracking-tight sm:text-4xl">
							{m.goods_page_subtitle()}
						</h2>
						<p className="mt-4 text-lg text-muted-foreground">
							{m.goods_page_desc()}
						</p>
					</div>
					<div className="mt-12 grid gap-8 sm:grid-cols-2 lg:grid-cols-4">
						<FeatureCard
							icon={<ClockIcon className="size-10 text-green-600" />}
							title={m.goods_feature_1_title()}
							description={m.goods_feature_1_desc()}
						/>
						<FeatureCard
							icon={<ShieldCheckIcon className="size-10 text-green-600" />}
							title={m.goods_feature_2_title()}
							description={m.goods_feature_2_desc()}
						/>
						<FeatureCard
							icon={<WeightIcon className="size-10 text-green-600" />}
							title={m.goods_feature_3_title()}
							description={m.goods_feature_3_desc()}
						/>
						<FeatureCard
							icon={<BellRingIcon className="size-10 text-green-600" />}
							title={m.goods_feature_4_title()}
							description={m.goods_feature_4_desc()}
						/>
					</div>
				</div>
			</section>

			{/* What You Can Send Section */}
			<section className="bg-secondary/30 px-4 py-16 sm:px-6 md:px-8 lg:px-16">
				<div className="mx-auto max-w-7xl">
					<div className="text-center">
						<h2 className="font-bold text-3xl tracking-tight sm:text-4xl">
							{m.goods_what_you_can_send()}
						</h2>
					</div>
					<div className="mt-12 grid gap-8 sm:grid-cols-2 lg:grid-cols-4">
						<ItemCard
							icon={<FileTextIcon className="size-12 text-green-600" />}
							title={m.goods_documents()}
						/>
						<ItemCard
							icon={<PackageIcon className="size-12 text-green-600" />}
							title={m.goods_packages()}
						/>
						<ItemCard
							icon={<ShirtIcon className="size-12 text-green-600" />}
							title={m.goods_laundry()}
						/>
						<ItemCard
							icon={<PackageIcon className="size-12 text-green-600" />}
							title={m.goods_food_items()}
						/>
					</div>
				</div>
			</section>

			{/* Pricing Info Section */}
			<section className="px-4 py-16 sm:px-6 md:px-8 lg:px-16">
				<div className="mx-auto max-w-4xl">
					<Card className="border-green-500/20 bg-green-500/5">
						<CardHeader className="text-center">
							<CardTitle className="text-2xl sm:text-3xl">
								{m.transport_feature_4_title()}
							</CardTitle>
							<CardDescription className="text-base">
								{m.transport_feature_4_desc()}
							</CardDescription>
						</CardHeader>
						<CardContent>
							<div className="grid gap-6 md:grid-cols-2">
								<div className="rounded-lg border bg-background p-6">
									<h3 className="mb-2 font-semibold text-lg">
										{m.base_fare()}
									</h3>
									<p className="font-bold text-2xl text-green-600">Rp 5,000</p>
									<p className="mt-2 text-muted-foreground text-sm">
										{m.per_km_rate()}: Rp 2,000
									</p>
								</div>
								<div className="rounded-lg border bg-background p-6">
									<h3 className="mb-2 font-semibold text-lg">
										{m.maximum_weight()}
									</h3>
									<p className="font-bold text-2xl text-green-600">20 kg</p>
									<p className="mt-2 text-muted-foreground text-sm">
										{m.weight_must_be_between()}
									</p>
								</div>
							</div>
						</CardContent>
					</Card>
				</div>
			</section>

			{/* CTA Section */}
			<section className="px-4 py-16 sm:px-6 md:px-8 lg:px-16">
				<div className="mx-auto max-w-4xl text-center">
					<h2 className="font-bold text-3xl tracking-tight sm:text-4xl">
						{m.get_started_now()}
					</h2>
					<p className="mt-4 text-lg text-muted-foreground">
						{m.goods_page_desc()}
					</p>
					<Link to="/sign-up/user">
						<Button size="lg" className="mt-8">
							{m.start_delivery()}
						</Button>
					</Link>
				</div>
			</section>

			<LandingFooter />
		</div>
	);
}

function FeatureCard({
	icon,
	title,
	description,
}: {
	icon: React.ReactNode;
	title: string;
	description: string;
}) {
	return (
		<Card className="border-green-500/20">
			<CardHeader>
				<div className="mb-4">{icon}</div>
				<CardTitle className="text-xl">{title}</CardTitle>
			</CardHeader>
			<CardContent>
				<CardDescription className="text-base">{description}</CardDescription>
			</CardContent>
		</Card>
	);
}

function ItemCard({ icon, title }: { icon: React.ReactNode; title: string }) {
	return (
		<Card className="border-green-500/20 transition-colors hover:border-green-500/40">
			<CardContent className="flex flex-col items-center justify-center p-8 text-center">
				<div className="mb-4">{icon}</div>
				<h3 className="font-semibold text-lg">{title}</h3>
			</CardContent>
		</Card>
	);
}
