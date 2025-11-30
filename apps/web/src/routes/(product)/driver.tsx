import { m } from "@repo/i18n";
import { createFileRoute, Link } from "@tanstack/react-router";
import {
	BadgeDollarSignIcon,
	CheckCircleIcon,
	ClockIcon,
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

export const Route = createFileRoute("/(product)/driver")({
	component: RouteComponent,
});

function RouteComponent() {
	return (
		<div className="min-h-screen">
			<PublicHeader className="fixed top-0 right-0 left-0 z-50 mx-auto mt-2 w-full max-w-3xl rounded-xl border p-4" />

			{/* Hero Section */}
			<section className="bg-gradient-to-b from-blue-500/10 to-background px-4 py-32 sm:px-6 md:px-8 lg:px-16">
				<div className="mx-auto max-w-7xl">
					<div className="grid gap-12 lg:grid-cols-2 lg:gap-16">
						<div className="flex flex-col justify-center">
							<h1 className="font-bold text-4xl tracking-tight sm:text-5xl md:text-6xl">
								{m.driver_hero_title()}
							</h1>
							<p className="mt-4 text-lg text-muted-foreground sm:text-xl">
								{m.driver_hero_desc()}
							</p>
							<div className="mt-8 flex flex-col gap-4 sm:flex-row">
								<Link to="/sign-up/driver">
									<Button size="lg" className="w-full sm:w-auto">
										{m.apply_now()}
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
							<div className="aspect-square overflow-hidden rounded-2xl bg-blue-500/5">
								<div className="flex h-full items-center justify-center">
									<BadgeDollarSignIcon className="size-32 text-blue-500/20" />
								</div>
							</div>
						</div>
					</div>
				</div>
			</section>

			{/* Benefits Section */}
			<section className="px-4 py-16 sm:px-6 md:px-8 lg:px-16">
				<div className="mx-auto max-w-7xl">
					<div className="text-center">
						<h2 className="font-bold text-3xl tracking-tight sm:text-4xl">
							{m.driver_page_subtitle()}
						</h2>
						<p className="mt-4 text-lg text-muted-foreground">
							{m.driver_page_desc()}
						</p>
					</div>
					<div className="mt-12 grid gap-8 sm:grid-cols-2 lg:grid-cols-4">
						<BenefitCard
							icon={<ClockIcon className="size-10 text-blue-600" />}
							title={m.driver_benefit_1_title()}
							description={m.driver_benefit_1_desc()}
						/>
						<BenefitCard
							icon={<TrendingUpIcon className="size-10 text-blue-600" />}
							title={m.driver_benefit_2_title()}
							description={m.driver_benefit_2_desc()}
						/>
						<BenefitCard
							icon={<BadgeDollarSignIcon className="size-10 text-blue-600" />}
							title={m.driver_benefit_3_title()}
							description={m.driver_benefit_3_desc()}
						/>
						<BenefitCard
							icon={<UsersIcon className="size-10 text-blue-600" />}
							title={m.driver_benefit_4_title()}
							description={m.driver_benefit_4_desc()}
						/>
					</div>
				</div>
			</section>

			{/* Requirements Section */}
			<section className="bg-secondary/30 px-4 py-16 sm:px-6 md:px-8 lg:px-16">
				<div className="mx-auto max-w-7xl">
					<div className="text-center">
						<h2 className="font-bold text-3xl tracking-tight sm:text-4xl">
							{m.driver_requirements()}
						</h2>
						<p className="mt-4 text-lg text-muted-foreground">
							{m.driver_page_desc()}
						</p>
					</div>
					<div className="mt-12 grid gap-6 sm:grid-cols-2 lg:grid-cols-4">
						<RequirementCard
							icon={<CheckCircleIcon className="size-8 text-blue-600" />}
							text={m.driver_req_1()}
						/>
						<RequirementCard
							icon={<CheckCircleIcon className="size-8 text-blue-600" />}
							text={m.driver_req_2()}
						/>
						<RequirementCard
							icon={<CheckCircleIcon className="size-8 text-blue-600" />}
							text={m.driver_req_3()}
						/>
						<RequirementCard
							icon={<CheckCircleIcon className="size-8 text-blue-600" />}
							text={m.driver_req_4()}
						/>
					</div>
				</div>
			</section>

			{/* Earnings Section */}
			<section className="px-4 py-16 sm:px-6 md:px-8 lg:px-16">
				<div className="mx-auto max-w-4xl">
					<Card className="border-blue-500/20 bg-blue-500/5">
						<CardHeader className="text-center">
							<CardTitle className="text-2xl sm:text-3xl">
								{m.driver_earnings_potential()}
							</CardTitle>
						</CardHeader>
						<CardContent>
							<div className="space-y-6">
								<div className="text-center">
									<p className="text-lg text-muted-foreground">
										{m.driver_earnings_desc()}
									</p>
								</div>
								<div className="grid gap-6 md:grid-cols-3">
									<div className="rounded-lg border bg-background p-6 text-center">
										<h3 className="mb-2 font-semibold text-lg">
											{m.base_fare()}
										</h3>
										<p className="font-bold text-2xl text-blue-600">Rp 5,000</p>
										<p className="mt-2 text-muted-foreground text-sm">
											Per trip
										</p>
									</div>
									<div className="rounded-lg border bg-background p-6 text-center">
										<h3 className="mb-2 font-semibold text-lg">
											{m.per_km_rate()}
										</h3>
										<p className="font-bold text-2xl text-blue-600">Rp 2,000</p>
										<p className="mt-2 text-muted-foreground text-sm">
											Per kilometer
										</p>
									</div>
									<div className="rounded-lg border bg-background p-6 text-center">
										<h3 className="mb-2 font-semibold text-lg">
											{m.commission()}
										</h3>
										<p className="font-bold text-2xl text-blue-600">15%</p>
										<p className="mt-2 text-muted-foreground text-sm">
											{m.driver_benefit_3_desc()}
										</p>
									</div>
								</div>
							</div>
						</CardContent>
					</Card>
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
						<StepCard
							number={1}
							title={m.sign_up()}
							description="Register with your student ID and documents"
						/>
						<StepCard
							number={2}
							title="Get Verified"
							description="Wait for approval (usually 1-2 days)"
						/>
						<StepCard
							number={3}
							title="Set Schedule"
							description="Add your class schedule and go online"
						/>
						<StepCard
							number={4}
							title="Start Earning"
							description="Accept orders and earn money"
						/>
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
						{m.driver_page_desc()}
					</p>
					<Link to="/sign-up/driver">
						<Button size="lg" className="mt-8">
							{m.apply_now()}
						</Button>
					</Link>
				</div>
			</section>

			<LandingFooter />
		</div>
	);
}

function BenefitCard({
	icon,
	title,
	description,
}: {
	icon: React.ReactNode;
	title: string;
	description: string;
}) {
	return (
		<Card className="border-blue-500/20">
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

function RequirementCard({
	icon,
	text,
}: {
	icon: React.ReactNode;
	text: string;
}) {
	return (
		<Card className="border-blue-500/20">
			<CardContent className="flex items-center gap-4 p-6">
				<div className="shrink-0">{icon}</div>
				<p className="font-medium">{text}</p>
			</CardContent>
		</Card>
	);
}

function StepCard({
	number,
	title,
	description,
}: {
	number: number;
	title: string;
	description: string;
}) {
	return (
		<div className="relative flex flex-col items-center text-center">
			<div className="mb-4 flex size-16 items-center justify-center rounded-full bg-blue-600 font-bold text-2xl text-white">
				{number}
			</div>
			<h3 className="mb-2 font-semibold text-lg">{title}</h3>
			<p className="text-muted-foreground text-sm">{description}</p>
			{number < 4 && (
				<div className="absolute top-8 left-[calc(50%+2rem)] hidden w-full lg:block">
					<div className="h-0.5 w-full bg-blue-500/20" />
				</div>
			)}
		</div>
	);
}
