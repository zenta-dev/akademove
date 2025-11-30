import { m } from "@repo/i18n";
import { createFileRoute, Link } from "@tanstack/react-router";
import {
	CreditCardIcon,
	EyeIcon,
	MessageSquareIcon,
	StoreIcon,
	UtensilsIcon,
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

export const Route = createFileRoute("/(product)/food")({
	component: RouteComponent,
});

function RouteComponent() {
	return (
		<div className="min-h-screen">
			<PublicHeader className="fixed top-0 right-0 left-0 z-50 mx-auto mt-2 w-full max-w-3xl rounded-xl border p-4" />

			{/* Hero Section */}
			<section className="bg-gradient-to-b from-orange-500/10 to-background px-4 py-32 sm:px-6 md:px-8 lg:px-16">
				<div className="mx-auto max-w-7xl">
					<div className="grid gap-12 lg:grid-cols-2 lg:gap-16">
						<div className="flex flex-col justify-center">
							<h1 className="font-bold text-4xl tracking-tight sm:text-5xl md:text-6xl">
								{m.food_hero_title()}
							</h1>
							<p className="mt-4 text-lg text-muted-foreground sm:text-xl">
								{m.food_hero_desc()}
							</p>
							<div className="mt-8 flex flex-col gap-4 sm:flex-row">
								<Link to="/sign-up/user">
									<Button size="lg" className="w-full sm:w-auto">
										{m.order_now()}
									</Button>
								</Link>
								<Link to="/">
									<Button
										size="lg"
										variant="outline"
										className="w-full sm:w-auto"
									>
										{m.view_all_merchants()}
									</Button>
								</Link>
							</div>
						</div>
						<div className="relative">
							<div className="aspect-square overflow-hidden rounded-2xl bg-orange-500/5">
								<div className="flex h-full items-center justify-center">
									<UtensilsIcon className="size-32 text-orange-500/20" />
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
							{m.food_page_subtitle()}
						</h2>
						<p className="mt-4 text-lg text-muted-foreground">
							{m.food_page_desc()}
						</p>
					</div>
					<div className="mt-12 grid gap-8 sm:grid-cols-2 lg:grid-cols-4">
						<FeatureCard
							icon={<StoreIcon className="size-10 text-orange-600" />}
							title={m.food_feature_1_title()}
							description={m.food_feature_1_desc()}
						/>
						<FeatureCard
							icon={<EyeIcon className="size-10 text-orange-600" />}
							title={m.food_feature_2_title()}
							description={m.food_feature_2_desc()}
						/>
						<FeatureCard
							icon={<CreditCardIcon className="size-10 text-orange-600" />}
							title={m.food_feature_3_title()}
							description={m.food_feature_3_desc()}
						/>
						<FeatureCard
							icon={<MessageSquareIcon className="size-10 text-orange-600" />}
							title={m.food_feature_4_title()}
							description={m.food_feature_4_desc()}
						/>
					</div>
				</div>
			</section>

			{/* Popular Merchants Section */}
			<section className="bg-secondary/30 px-4 py-16 sm:px-6 md:px-8 lg:px-16">
				<div className="mx-auto max-w-7xl">
					<div className="text-center">
						<h2 className="font-bold text-3xl tracking-tight sm:text-4xl">
							{m.food_popular_merchants()}
						</h2>
						<p className="mt-4 text-lg text-muted-foreground">
							{m.food_feature_1_desc()}
						</p>
					</div>
					<div className="mt-12 grid gap-6 sm:grid-cols-2 lg:grid-cols-3">
						<MerchantCard
							name="Kantin Teknik"
							category="Indonesian Food"
							rating={4.8}
							image="🍜"
						/>
						<MerchantCard
							name="Warung Nasi Ibu Haji"
							category="Indonesian Food"
							rating={4.9}
							image="🍛"
						/>
						<MerchantCard
							name="Cafe Kampus"
							category="Coffee & Snacks"
							rating={4.7}
							image="☕"
						/>
						<MerchantCard
							name="Mie Ayam Pak Kumis"
							category="Noodles"
							rating={4.8}
							image="🍲"
						/>
						<MerchantCard
							name="Bakso Barokah"
							category="Meatball Soup"
							rating={4.6}
							image="🥘"
						/>
						<MerchantCard
							name="Toko Roti Segar"
							category="Bakery"
							rating={4.7}
							image="🍞"
						/>
					</div>
				</div>
			</section>

			{/* How to Order Section */}
			<section className="px-4 py-16 sm:px-6 md:px-8 lg:px-16">
				<div className="mx-auto max-w-4xl">
					<Card className="border-orange-500/20 bg-orange-500/5">
						<CardHeader className="text-center">
							<CardTitle className="text-2xl sm:text-3xl">
								{m.transport_how_it_works()}
							</CardTitle>
						</CardHeader>
						<CardContent>
							<div className="space-y-6">
								<OrderStep
									number={1}
									title={m.food_browse_menu()}
									description="Browse menus from campus merchants"
								/>
								<OrderStep
									number={2}
									title="Add to Cart"
									description="Select items and add special instructions"
								/>
								<OrderStep
									number={3}
									title={m.confirm_booking()}
									description="Review your order and choose payment method"
								/>
								<OrderStep
									number={4}
									title="Track Delivery"
									description="Watch your order being prepared and delivered"
								/>
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
						{m.food_page_desc()}
					</p>
					<Link to="/sign-up/user">
						<Button size="lg" className="mt-8">
							{m.order_now()}
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
		<Card className="border-orange-500/20">
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

function MerchantCard({
	name,
	category,
	rating,
	image,
}: {
	name: string;
	category: string;
	rating: number;
	image: string;
}) {
	return (
		<Card className="border-orange-500/20 transition-all hover:border-orange-500/40 hover:shadow-lg">
			<CardContent className="p-6">
				<div className="mb-4 flex items-center justify-center rounded-lg bg-orange-500/10 p-6">
					<span className="text-6xl">{image}</span>
				</div>
				<h3 className="mb-2 font-semibold text-lg">{name}</h3>
				<p className="mb-2 text-muted-foreground text-sm">{category}</p>
				<div className="flex items-center gap-1">
					<span className="text-orange-500">★</span>
					<span className="font-medium text-sm">{rating}</span>
				</div>
			</CardContent>
		</Card>
	);
}

function OrderStep({
	number,
	title,
	description,
}: {
	number: number;
	title: string;
	description: string;
}) {
	return (
		<div className="flex gap-4">
			<div className="flex size-10 shrink-0 items-center justify-center rounded-full bg-orange-500 font-bold text-white">
				{number}
			</div>
			<div>
				<h4 className="mb-1 font-semibold text-lg">{title}</h4>
				<p className="text-muted-foreground text-sm">{description}</p>
			</div>
		</div>
	);
}
