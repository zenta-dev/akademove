import { m } from "@repo/i18n";
import { useMutation } from "@tanstack/react-query";
import { createFileRoute } from "@tanstack/react-router";
import { Clock, Mail, MapPin, Phone } from "lucide-react";
import { useState } from "react";
import { toast } from "sonner";
import { Button } from "@/components/ui/button";
import { Card, CardContent } from "@/components/ui/card";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Textarea } from "@/components/ui/textarea";
import { APP_NAME } from "@/lib/constants";
import { orpcClient } from "@/lib/orpc";

export const Route = createFileRoute("/(support)/contact")({
	component: ContactComponent,
	head: () => ({
		meta: [
			{
				title: `${m.contact_us()} - ${APP_NAME}`,
			},
			{
				name: "description",
				content: m.contact_page_desc(),
			},
		],
	}),
});

function ContactComponent() {
	const [formData, setFormData] = useState({
		name: "",
		email: "",
		subject: "",
		message: "",
	});
	const [submitted, setSubmitted] = useState(false);

	const submitContactMutation = useMutation({
		mutationFn: async (data: typeof formData) => {
			const result = await orpcClient.contact.submit({
				body: data,
			});

			if (result.status !== 201) {
				throw new Error(result.body.message || m.contact_submit_error());
			}

			return result;
		},
		onSuccess: () => {
			setSubmitted(true);
			toast.success(m.message_sent_successfully());

			// Reset form after 3 seconds
			setTimeout(() => {
				setSubmitted(false);
				setFormData({ name: "", email: "", subject: "", message: "" });
			}, 3000);
		},
		onError: (error: Error) => {
			toast.error(error.message || m.contact_submit_error());
		},
	});

	const handleSubmit = async (e: React.FormEvent) => {
		e.preventDefault();
		submitContactMutation.mutate(formData);
	};

	const handleChange = (
		e: React.ChangeEvent<HTMLInputElement | HTMLTextAreaElement>,
	) => {
		setFormData((prev) => ({
			...prev,
			[e.target.name]: e.target.value,
		}));
	};

	const contactInfo = [
		{
			icon: <Mail className="h-5 w-5" />,
			label: m.contact_email(),
			value: m.contact_email_value(),
			href: `mailto:${m.contact_email_value()}`,
		},
		{
			icon: <Phone className="h-5 w-5" />,
			label: m.contact_phone(),
			value: m.contact_phone_value(),
			href: `tel:${m.contact_phone_value()}`,
		},
		{
			icon: <MapPin className="h-5 w-5" />,
			label: m.contact_office(),
			value: m.contact_office_value(),
		},
		{
			icon: <Clock className="h-5 w-5" />,
			label: m.contact_hours(),
			value: m.contact_hours_value(),
		},
	];

	return (
		<div className="min-h-screen bg-background">
			{/* Hero Section */}
			<div className="border-b bg-linear-to-b from-primary/5 to-background pt-24">
				<div className="container mx-auto px-4 py-16 sm:px-6 lg:px-8">
					<div className="mx-auto max-w-3xl text-center">
						<Mail className="mx-auto mb-4 h-12 w-12 text-primary" />
						<h1 className="mb-4 font-bold text-4xl tracking-tight">
							{m.contact_page_title()}
						</h1>
						<p className="text-lg text-muted-foreground">
							{m.contact_page_desc()}
						</p>
					</div>
				</div>
			</div>

			{/* Content */}
			<div className="container mx-auto px-4 py-12 sm:px-6 lg:px-8">
				<div className="mx-auto grid max-w-6xl gap-8 lg:grid-cols-2">
					{/* Contact Form */}
					<Card>
						<CardContent className="p-6">
							<h2 className="mb-2 font-semibold text-2xl">
								{m.contact_form_title()}
							</h2>
							<p className="mb-6 text-muted-foreground text-sm">
								{m.contact_form_desc()}
							</p>

							{submitted ? (
								<div className="rounded-lg bg-green-50 p-6 text-center dark:bg-green-950/20">
									<div className="mx-auto mb-3 flex h-12 w-12 items-center justify-center rounded-full bg-green-100 dark:bg-green-900/30">
										<Mail className="h-6 w-6 text-green-600 dark:text-green-400" />
									</div>
									<h3 className="mb-1 font-semibold text-green-900 text-lg dark:text-green-100">
										{m.message_sent_successfully()}
									</h3>
								</div>
							) : (
								<form onSubmit={handleSubmit} className="space-y-4">
									<div className="space-y-2">
										<Label htmlFor="name">{m.your_name()}</Label>
										<Input
											id="name"
											name="name"
											type="text"
											required
											value={formData.name}
											onChange={handleChange}
											placeholder={m.name()}
										/>
									</div>

									<div className="space-y-2">
										<Label htmlFor="email">{m.your_email()}</Label>
										<Input
											id="email"
											name="email"
											type="email"
											required
											value={formData.email}
											onChange={handleChange}
											placeholder={m.email_address()}
										/>
									</div>

									<div className="space-y-2">
										<Label htmlFor="subject">{m.subject()}</Label>
										<Input
											id="subject"
											name="subject"
											type="text"
											required
											value={formData.subject}
											onChange={handleChange}
											placeholder={m.subject()}
										/>
									</div>

									<div className="space-y-2">
										<Label htmlFor="message">{m.your_message()}</Label>
										<Textarea
											id="message"
											name="message"
											required
											rows={6}
											value={formData.message}
											onChange={handleChange}
											placeholder={m.your_message()}
											className="resize-none"
										/>
									</div>

									<Button
										type="submit"
										className="w-full"
										disabled={submitContactMutation.isPending}
									>
										{submitContactMutation.isPending
											? m.submitting()
											: m.send_message()}
									</Button>
								</form>
							)}
						</CardContent>
					</Card>

					{/* Contact Information */}
					<div className="space-y-6">
						<Card>
							<CardContent className="p-6">
								<h2 className="mb-4 font-semibold text-2xl">
									{m.contact_info_title()}
								</h2>
								<div className="space-y-4">
									{contactInfo.map((info) => (
										<div key={info.label} className="flex items-start gap-4">
											<div className="flex h-10 w-10 shrink-0 items-center justify-center rounded-lg bg-primary/10 text-primary">
												{info.icon}
											</div>
											<div className="min-w-0 flex-1">
												<div className="font-medium text-sm">{info.label}</div>
												{info.href ? (
													<a
														href={info.href}
														className="text-muted-foreground text-sm hover:text-primary hover:underline"
													>
														{info.value}
													</a>
												) : (
													<div className="text-muted-foreground text-sm">
														{info.value}
													</div>
												)}
											</div>
										</div>
									))}
								</div>
							</CardContent>
						</Card>

						{/* Quick Links */}
						<Card className="bg-primary/5">
							<CardContent className="p-6">
								<h3 className="mb-4 font-semibold text-lg">
									{m.contact_quick_links()}
								</h3>
								<div className="space-y-2">
									<a
										href="/faq"
										className="block text-primary text-sm hover:underline"
									>
										→ {m.faq()}
									</a>
									<a
										href="/help"
										className="block text-primary text-sm hover:underline"
									>
										→ {m.help_center()}
									</a>
									<a
										href="/status"
										className="block text-primary text-sm hover:underline"
									>
										→ {m.system_status()}
									</a>
								</div>
							</CardContent>
						</Card>
					</div>
				</div>
			</div>
		</div>
	);
}
