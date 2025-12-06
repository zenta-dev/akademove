import { m } from "@repo/i18n";
import { createFileRoute } from "@tanstack/react-router";
import {
	Car,
	CreditCard,
	HelpCircle,
	Shield,
	ShoppingCart,
	User,
} from "lucide-react";
import {
	Accordion,
	AccordionContent,
	AccordionItem,
	AccordionTrigger,
} from "@/components/ui/accordion";
import { Card, CardContent } from "@/components/ui/card";
import { APP_NAME } from "@/lib/constants";

export const Route = createFileRoute("/(support)/faq")({
	component: FAQComponent,
	head: () => ({
		meta: [
			{
				title: `${m.faq()} - ${APP_NAME}`,
			},
			{
				name: "description",
				content: m.faq_page_desc(),
			},
		],
	}),
});

type FAQCategory = {
	id: string;
	title: string;
	icon: React.ReactNode;
	questions: Array<{
		question: string;
		answer: string;
	}>;
};

function FAQComponent() {
	const faqCategories: FAQCategory[] = [
		{
			id: "general",
			title: m.general(),
			icon: <HelpCircle className="h-5 w-5" />,
			questions: [
				{
					question: m.faq_general_q1(),
					answer: m.faq_general_a1(),
				},
				{
					question: m.faq_general_q2(),
					answer: m.faq_general_a2(),
				},
				{
					question: m.faq_general_q3(),
					answer: m.faq_general_a3(),
				},
			],
		},
		{
			id: "orders",
			title: m.orders_delivery(),
			icon: <ShoppingCart className="h-5 w-5" />,
			questions: [
				{
					question: m.faq_orders_q1(),
					answer: m.faq_orders_a1(),
				},
				{
					question: m.faq_orders_q2(),
					answer: m.faq_orders_a2(),
				},
				{
					question: m.faq_orders_q3(),
					answer: m.faq_orders_a3(),
				},
			],
		},
		{
			id: "payment",
			title: m.payments_wallet(),
			icon: <CreditCard className="h-5 w-5" />,
			questions: [
				{
					question: m.faq_payment_q1(),
					answer: m.faq_payment_a1(),
				},
				{
					question: m.faq_payment_q2(),
					answer: m.faq_payment_a2(),
				},
				{
					question: m.faq_payment_q3(),
					answer: m.faq_payment_a3(),
				},
			],
		},
		{
			id: "driver",
			title: m.driver(),
			icon: <Car className="h-5 w-5" />,
			questions: [
				{
					question: m.faq_driver_q1(),
					answer: m.faq_driver_a1(),
				},
				{
					question: m.faq_driver_q2(),
					answer: m.faq_driver_a2(),
				},
				{
					question: m.faq_driver_q3(),
					answer: m.faq_driver_a3(),
				},
			],
		},
		{
			id: "safety",
			title: m.safety_security(),
			icon: <Shield className="h-5 w-5" />,
			questions: [
				{
					question: m.faq_safety_q1(),
					answer: m.faq_safety_a1(),
				},
				{
					question: m.faq_safety_q2(),
					answer: m.faq_safety_a2(),
				},
				{
					question: m.faq_safety_q3(),
					answer: m.faq_safety_a3(),
				},
			],
		},
	];

	return (
		<div className="min-h-screen bg-background">
			{/* Hero Section */}
			<div className="border-b bg-muted/30 pt-24">
				<div className="container mx-auto px-4 py-16 sm:px-6 lg:px-8">
					<div className="mx-auto max-w-3xl text-center">
						<HelpCircle className="mx-auto mb-4 h-12 w-12 text-primary" />
						<h1 className="mb-4 font-bold text-4xl tracking-tight">
							{m.faq_page_title()}
						</h1>
						<p className="text-lg text-muted-foreground">{m.faq_page_desc()}</p>
					</div>
				</div>
			</div>

			{/* FAQ Content */}
			<div className="container mx-auto px-4 py-12 sm:px-6 lg:px-8">
				<div className="mx-auto max-w-4xl space-y-8">
					{faqCategories.map((category) => (
						<Card key={category.id}>
							<CardContent className="p-6">
								<div className="mb-4 flex items-center gap-3">
									<div className="flex h-10 w-10 items-center justify-center rounded-lg bg-primary/10 text-primary">
										{category.icon}
									</div>
									<h2 className="font-semibold text-2xl">{category.title}</h2>
								</div>
								<Accordion type="single" collapsible className="w-full">
									{category.questions.map((item, index) => (
										<AccordionItem
											key={`${category.id}-${index}`}
											value={`${category.id}-${index}`}
										>
											<AccordionTrigger className="text-left">
												{item.question}
											</AccordionTrigger>
											<AccordionContent className="text-muted-foreground">
												{item.answer}
											</AccordionContent>
										</AccordionItem>
									))}
								</Accordion>
							</CardContent>
						</Card>
					))}
				</div>

				{/* Still Have Questions Section */}
				<div className="mx-auto mt-12 max-w-4xl">
					<Card className="bg-primary/5">
						<CardContent className="p-8 text-center">
							<User className="mx-auto mb-4 h-12 w-12 text-primary" />
							<h3 className="mb-2 font-semibold text-xl">
								{m.help_page_title()}
							</h3>
							<p className="mb-6 text-muted-foreground">
								{m.contact_page_desc()}
							</p>
							<div className="flex flex-col items-center justify-center gap-4 sm:flex-row">
								<a
									href="/contact"
									className="inline-flex h-10 items-center justify-center rounded-md bg-primary px-8 font-medium text-primary-foreground text-sm transition-colors hover:bg-primary/90"
								>
									{m.contact_us()}
								</a>
								<a
									href="/help"
									className="inline-flex h-10 items-center justify-center rounded-md border border-input bg-background px-8 font-medium text-sm transition-colors hover:bg-accent hover:text-accent-foreground"
								>
									{m.help_center()}
								</a>
							</div>
						</CardContent>
					</Card>
				</div>
			</div>
		</div>
	);
}
