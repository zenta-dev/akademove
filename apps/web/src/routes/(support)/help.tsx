import { m } from "@repo/i18n";
import { createFileRoute, Link } from "@tanstack/react-router";
import {
	BookOpen,
	ChevronRight,
	CreditCard,
	Search,
	Settings,
	Shield,
	ShoppingCart,
	Wrench,
} from "lucide-react";
import { useState } from "react";
import { Card, CardContent } from "@/components/ui/card";
import { Input } from "@/components/ui/input";
import { APP_NAME } from "@/lib/constants";

export const Route = createFileRoute("/(support)/help")({
	component: HelpComponent,
	head: () => ({
		meta: [
			{
				title: `${m.help_center()} - ${APP_NAME}`,
			},
			{
				name: "description",
				content: m.help_page_desc(),
			},
		],
	}),
});

type HelpCategory = {
	id: string;
	title: string;
	icon: React.ReactNode;
	articles: Array<{
		title: string;
		description: string;
		link: string;
	}>;
};

function HelpComponent() {
	const [searchQuery, setSearchQuery] = useState("");

	const helpCategories: HelpCategory[] = [
		{
			id: "getting-started",
			title: m.getting_started(),
			icon: <BookOpen className="h-5 w-5" />,
			articles: [
				{
					title: m.faq_general_q1(),
					description: m.faq_general_a1(),
					link: "/faq#general",
				},
				{
					title: m.faq_general_q2(),
					description: m.faq_general_a2(),
					link: "/faq#general",
				},
				{
					title: m.faq_general_q3(),
					description: m.faq_general_a3(),
					link: "/faq#general",
				},
			],
		},
		{
			id: "account-settings",
			title: m.account_settings(),
			icon: <Settings className="h-5 w-5" />,
			articles: [
				{
					title: "How to update my profile?",
					description:
						"Learn how to update your personal information, photo, and contact details.",
					link: "/faq#account",
				},
				{
					title: "How to change my password?",
					description:
						"Step-by-step guide to reset or change your account password securely.",
					link: "/faq#account",
				},
				{
					title: "How to manage notifications?",
					description:
						"Control what notifications you receive and how you receive them.",
					link: "/faq#account",
				},
			],
		},
		{
			id: "payments-wallet",
			title: m.payments_wallet(),
			icon: <CreditCard className="h-5 w-5" />,
			articles: [
				{
					title: m.faq_payment_q1(),
					description: m.faq_payment_a1(),
					link: "/faq#payment",
				},
				{
					title: m.faq_payment_q2(),
					description: m.faq_payment_q2(),
					link: "/faq#payment",
				},
				{
					title: m.faq_payment_q3(),
					description: m.faq_payment_a3(),
					link: "/faq#payment",
				},
			],
		},
		{
			id: "orders-delivery",
			title: m.orders_delivery(),
			icon: <ShoppingCart className="h-5 w-5" />,
			articles: [
				{
					title: m.faq_orders_q1(),
					description: m.faq_orders_a1(),
					link: "/faq#orders",
				},
				{
					title: m.faq_orders_q2(),
					description: m.faq_orders_a2(),
					link: "/faq#orders",
				},
				{
					title: m.faq_orders_q3(),
					description: m.faq_orders_a3(),
					link: "/faq#orders",
				},
			],
		},
		{
			id: "safety-security",
			title: m.safety_security(),
			icon: <Shield className="h-5 w-5" />,
			articles: [
				{
					title: m.faq_safety_q1(),
					description: m.faq_safety_a1(),
					link: "/faq#safety",
				},
				{
					title: m.faq_safety_q2(),
					description: m.faq_safety_a2(),
					link: "/faq#safety",
				},
				{
					title: m.faq_safety_q3(),
					description: m.faq_safety_a3(),
					link: "/faq#safety",
				},
			],
		},
		{
			id: "troubleshooting",
			title: m.troubleshooting(),
			icon: <Wrench className="h-5 w-5" />,
			articles: [
				{
					title: "App is not loading",
					description:
						"Solutions for when the app won't load or is stuck on the loading screen.",
					link: "/faq#troubleshooting",
				},
				{
					title: "Location not accurate",
					description:
						"Fix GPS and location accuracy issues for better ride matching.",
					link: "/faq#troubleshooting",
				},
				{
					title: "Payment failed",
					description:
						"Common reasons for payment failures and how to resolve them.",
					link: "/faq#troubleshooting",
				},
			],
		},
	];

	const filteredCategories = helpCategories
		.map((category) => ({
			...category,
			articles: category.articles.filter(
				(article) =>
					article.title.toLowerCase().includes(searchQuery.toLowerCase()) ||
					article.description.toLowerCase().includes(searchQuery.toLowerCase()),
			),
		}))
		.filter((category) => category.articles.length > 0);

	return (
		<div className="min-h-screen bg-background">
			{/* Hero Section */}
			<div className="border-b bg-linear-to-b from-primary/5 to-background pt-24">
				<div className="container mx-auto px-4 py-16 sm:px-6 lg:px-8">
					<div className="mx-auto max-w-3xl text-center">
						<BookOpen className="mx-auto mb-4 h-12 w-12 text-primary" />
						<h1 className="mb-4 font-bold text-4xl tracking-tight">
							{m.help_page_title()}
						</h1>
						<p className="mb-8 text-lg text-muted-foreground">
							{m.help_page_desc()}
						</p>

						{/* Search Box */}
						<div className="relative mx-auto max-w-2xl">
							<Search className="absolute top-3 left-3 h-5 w-5 text-muted-foreground" />
							<Input
								type="text"
								placeholder={m.search_help_articles()}
								className="h-12 rounded-lg border-2 pr-4 pl-10 focus-visible:ring-2"
								value={searchQuery}
								onChange={(e) => setSearchQuery(e.target.value)}
							/>
						</div>
					</div>
				</div>
			</div>

			{/* Help Content */}
			<div className="container mx-auto px-4 py-12 sm:px-6 lg:px-8">
				<div className="mx-auto max-w-6xl">
					{filteredCategories.length === 0 ? (
						<Card>
							<CardContent className="p-12 text-center">
								<Search className="mx-auto mb-4 h-12 w-12 text-muted-foreground" />
								<h3 className="mb-2 font-semibold text-lg">
									{m.no_result_found()}
								</h3>
								<p className="text-muted-foreground text-sm">
									Try different keywords or browse all categories below
								</p>
							</CardContent>
						</Card>
					) : (
						<div className="grid gap-8 md:grid-cols-2 lg:grid-cols-3">
							{filteredCategories.map((category) => (
								<Card
									key={category.id}
									className="transition-shadow hover:shadow-lg"
								>
									<CardContent className="p-6">
										<div className="mb-4 flex items-center gap-3">
											<div className="flex h-10 w-10 items-center justify-center rounded-lg bg-primary/10 text-primary">
												{category.icon}
											</div>
											<h2 className="font-semibold text-lg">
												{category.title}
											</h2>
										</div>
										<ul className="space-y-3">
											{category.articles.map((article) => (
												<li key={article.title}>
													<Link
														to={article.link}
														className="group flex items-start gap-2 text-sm transition-colors hover:text-primary"
													>
														<ChevronRight className="mt-0.5 h-4 w-4 shrink-0 text-muted-foreground transition-transform group-hover:translate-x-1" />
														<div>
															<div className="font-medium">{article.title}</div>
															{searchQuery === "" && (
																<div className="text-muted-foreground text-xs">
																	{article.description.slice(0, 80)}...
																</div>
															)}
														</div>
													</Link>
												</li>
											))}
										</ul>
									</CardContent>
								</Card>
							))}
						</div>
					)}
				</div>

				{/* CTA Section */}
				<div className="mx-auto mt-12 max-w-4xl">
					<Card className="border-2 border-primary/20 bg-primary/5">
						<CardContent className="p-8 text-center">
							<h3 className="mb-2 font-semibold text-xl">
								{m.help_page_title()}
							</h3>
							<p className="mb-6 text-muted-foreground">
								{m.contact_page_desc()}
							</p>
							<div className="flex flex-col items-center justify-center gap-4 sm:flex-row">
								<Link
									to="/contact"
									className="inline-flex h-10 items-center justify-center rounded-md bg-primary px-8 font-medium text-primary-foreground text-sm transition-colors hover:bg-primary/90"
								>
									{m.contact_us()}
								</Link>
								<Link
									to="/faq"
									className="inline-flex h-10 items-center justify-center rounded-md border border-input bg-background px-8 font-medium text-sm transition-colors hover:bg-accent hover:text-accent-foreground"
								>
									{m.faq()}
								</Link>
							</div>
						</CardContent>
					</Card>
				</div>
			</div>
		</div>
	);
}
