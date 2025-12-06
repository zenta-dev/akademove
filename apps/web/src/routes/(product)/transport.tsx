import { m } from "@repo/i18n";
import { createFileRoute, Link } from "@tanstack/react-router";
import {
	MapPinIcon,
	ShieldCheckIcon,
	TrendingUpIcon,
	UsersIcon,
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

export const Route = createFileRoute("/(product)/transport")({
	component: RouteComponent,
});

function RouteComponent() {
	return (
		<div className="min-h-screen">
			<PublicHeader className="fixed top-0 right-0 left-0 z-50 mx-auto mt-2 w-full max-w-3xl rounded-xl border p-4" />

			{/* Hero Section */}
			<section className="bg-linear-to-b from-primary/10 to-background px-4 py-32 sm:px-6 md:px-8 lg:px-16">
				<div className="mx-auto max-w-7xl">
					<div className="grid gap-12 lg:grid-cols-2 lg:gap-16">
						<div className="flex flex-col justify-center">
							<h1 className="font-bold text-4xl tracking-tight sm:text-5xl md:text-6xl">
								{m.transport_hero_title()}
							</h1>
							<p className="mt-4 text-lg text-muted-foreground sm:text-xl">
								{m.transport_hero_desc()}
							</p>
							<div className="mt-8 flex flex-col gap-4 sm:flex-row">
								<Link to="/sign-up/user">
									<Button size="lg" className="w-full sm:w-auto">
										{m.book_now()}
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
							<div className="aspect-square overflow-hidden rounded-2xl bg-primary/5">
								<div className="flex h-full items-center justify-center">
									<MapPinIcon className="size-32 text-primary/20" />
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
							{m.transport_page_subtitle()}
						</h2>
						<p className="mt-4 text-lg text-muted-foreground">
							{m.transport_page_desc()}
						</p>
					</div>
					<div className="mt-12 grid gap-8 sm:grid-cols-2 lg:grid-cols-4">
						<FeatureCard
							icon={<ShieldCheckIcon className="size-10 text-primary" />}
							title={m.transport_feature_1_title()}
							description={m.transport_feature_1_desc()}
						/>
						<FeatureCard
							icon={<MapPinIcon className="size-10 text-primary" />}
							title={m.transport_feature_2_title()}
							description={m.transport_feature_2_desc()}
						/>
						<FeatureCard
							icon={<UsersIcon className="size-10 text-primary" />}
							title={m.transport_feature_3_title()}
							description={m.transport_feature_3_desc()}
						/>
						<FeatureCard
							icon={<TrendingUpIcon className="size-10 text-primary" />}
							title={m.transport_feature_4_title()}
							description={m.transport_feature_4_desc()}
						/>
					</div>
				</div>
			</section>

			{/* How It Works Section */}
			<section className="bg-secondary/30 px-4 py-16 sm:px-6 md:px-8 lg:px-16">
				<div className="mx-auto max-w-7xl">
					<div className="text-center">
						<h2 className="font-bold text-3xl tracking-tight sm:text-4xl">
							{m.transport_how_it_works()}
						</h2>
					</div>
					<div className="mt-12 grid gap-8 md:grid-cols-2 lg:grid-cols-4">
						<StepCard number={1} description={m.transport_step_1()} />
						<StepCard number={2} description={m.transport_step_2()} />
						<StepCard number={3} description={m.transport_step_3()} />
						<StepCard number={4} description={m.transport_step_4()} />
					</div>
				</div>
			</section>

			{/* CTA Section */}
			<section className="px-4 py-16 sm:px-6 md:px-8 lg:px-16">
				<div className="mx-auto max-w-4xl text-center">
					<h2 className="font-bold text-3xl tracking-tight sm:text-4xl">
						{m.get_started_now()}
					</h2>
					<p className="mt-4 text-lg text-muted-foreground">
						{m.transport_page_desc()}
					</p>
					<Link to="/sign-up/user">
						<Button size="lg" className="mt-8">
							{m.book_now()}
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
		<Card className="border-primary/20">
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

function StepCard({
	number,
	description,
}: {
	number: number;
	description: string;
}) {
	return (
		<div className="relative flex flex-col items-center text-center">
			<div className="mb-4 flex size-16 items-center justify-center rounded-full bg-primary font-bold text-2xl text-primary-foreground">
				{number}
			</div>
			<p className="font-medium text-lg">{description}</p>
			{number < 4 && (
				<div className="absolute top-8 left-[calc(50%+2rem)] hidden w-full lg:block">
					<div className="h-0.5 w-full bg-primary/20" />
				</div>
			)}
		</div>
	);
}
