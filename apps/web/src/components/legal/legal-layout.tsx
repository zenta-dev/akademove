import { m } from "@repo/i18n";
import { Link } from "@tanstack/react-router";
import { motion, useInView } from "framer-motion";
import { ArrowLeft, Calendar } from "lucide-react";
import { useEffect, useRef, useState } from "react";
import { LandingFooter } from "../footer/landing-footer";
import { PublicHeader } from "../header/public";
import { Button } from "../ui/button";
import { Card } from "../ui/card";
import { Separator } from "../ui/separator";

export type LegalSection = {
	id: string;
	title: string;
	subsections?: { id: string; title: string }[];
};

type LegalLayoutProps = {
	title: string;
	lastUpdated: string;
	sections: LegalSection[];
	children: React.ReactNode;
};

export function LegalLayout({
	title,
	lastUpdated,
	sections,
	children,
}: LegalLayoutProps) {
	const [activeSection, setActiveSection] = useState<string>("");

	useEffect(() => {
		const handleScroll = () => {
			const sectionElements = sections.flatMap((section) => {
				const mainSection = document.getElementById(section.id);
				const subsectionElements =
					section.subsections?.map((sub) => ({
						id: sub.id,
						element: document.getElementById(sub.id),
					})) || [];

				return [
					{ id: section.id, element: mainSection },
					...subsectionElements,
				];
			});

			const scrollPosition = window.scrollY + 150;

			for (let i = sectionElements.length - 1; i >= 0; i--) {
				const { id, element } = sectionElements[i];
				if (element && element.offsetTop <= scrollPosition) {
					setActiveSection(id);
					break;
				}
			}
		};

		window.addEventListener("scroll", handleScroll);
		handleScroll();

		return () => window.removeEventListener("scroll", handleScroll);
	}, [sections]);

	const scrollToSection = (id: string) => {
		const element = document.getElementById(id);
		if (element) {
			const offset = 100;
			const elementPosition = element.getBoundingClientRect().top;
			const offsetPosition = elementPosition + window.pageYOffset - offset;

			window.scrollTo({
				top: offsetPosition,
				behavior: "smooth",
			});
		}
	};

	return (
		<div className="min-h-screen">
			<PublicHeader className="fixed top-0 right-0 left-0 z-50 mx-auto mt-2 w-full max-w-3xl rounded-xl border p-4" />

			<div className="mx-auto max-w-7xl px-4 pt-24 sm:px-6 lg:px-8">
				{/* Back Button */}
				<motion.div
					initial={{ opacity: 0, x: -20 }}
					animate={{ opacity: 1, x: 0 }}
					transition={{ duration: 0.5 }}
				>
					<Link to="/">
						<Button variant="ghost" className="mb-6 gap-2">
							<ArrowLeft className="size-4" />
							{m.legal_back_to_home()}
						</Button>
					</Link>
				</motion.div>

				{/* Hero Section */}
				<motion.div
					initial={{ opacity: 0, y: 20 }}
					animate={{ opacity: 1, y: 0 }}
					transition={{ duration: 0.6 }}
					className="mb-12 text-center"
				>
					<h1 className="mb-4 font-bold text-3xl sm:text-4xl md:text-5xl">
						{title}
					</h1>
					<div className="flex items-center justify-center gap-2 text-muted-foreground text-sm">
						<Calendar className="size-4" />
						<span>
							{m.legal_last_updated()}: {lastUpdated}
						</span>
					</div>
				</motion.div>

				{/* Main Content */}
				<div className="grid grid-cols-1 gap-8 pb-16 lg:grid-cols-4">
					{/* Table of Contents - Desktop */}
					<motion.div
						initial={{ opacity: 0, x: -20 }}
						animate={{ opacity: 1, x: 0 }}
						transition={{ duration: 0.6, delay: 0.2 }}
						className="hidden lg:block"
					>
						<Card className="sticky top-24 p-6">
							<h3 className="mb-4 font-semibold text-lg">
								{m.legal_table_of_contents()}
							</h3>
							<nav className="space-y-2">
								{sections.map((section) => (
									<div key={section.id}>
										<button
											type="button"
											onClick={() => scrollToSection(section.id)}
											className={`w-full text-left text-sm transition-colors hover:text-primary ${
												activeSection === section.id
													? "font-semibold text-primary"
													: "text-muted-foreground"
											}`}
										>
											{section.title}
										</button>
										{section.subsections && (
											<div className="mt-1 ml-4 space-y-1">
												{section.subsections.map((sub) => (
													<button
														key={sub.id}
														type="button"
														onClick={() => scrollToSection(sub.id)}
														className={`w-full text-left text-xs transition-colors hover:text-primary ${
															activeSection === sub.id
																? "font-semibold text-primary"
																: "text-muted-foreground"
														}`}
													>
														{sub.title}
													</button>
												))}
											</div>
										)}
									</div>
								))}
							</nav>
						</Card>
					</motion.div>

					{/* Content */}
					<motion.div
						initial={{ opacity: 0, y: 20 }}
						animate={{ opacity: 1, y: 0 }}
						transition={{ duration: 0.6, delay: 0.3 }}
						className="lg:col-span-3"
					>
						<Card className="p-6 sm:p-8 md:p-10">
							<div className="prose prose-slate dark:prose-invert max-w-none">
								{children}
							</div>
						</Card>
					</motion.div>
				</div>
			</div>

			<LandingFooter />
		</div>
	);
}

export function LegalSection({
	id,
	title,
	children,
}: {
	id: string;
	title: string;
	children: React.ReactNode;
}) {
	const ref = useRef(null);
	const isInView = useInView(ref, { once: true, margin: "-100px" });

	return (
		<motion.section
			ref={ref}
			id={id}
			initial={{ opacity: 0, y: 20 }}
			animate={isInView ? { opacity: 1, y: 0 } : {}}
			transition={{ duration: 0.5 }}
			className="mb-8 scroll-mt-24"
		>
			<h2 className="mb-4 font-bold text-2xl">{title}</h2>
			<div className="space-y-4">{children}</div>
			<Separator className="mt-8" />
		</motion.section>
	);
}

export function LegalSubsection({
	id,
	title,
	children,
}: {
	id: string;
	title: string;
	children: React.ReactNode;
}) {
	return (
		<div id={id} className="scroll-mt-24">
			<h3 className="mb-3 font-semibold text-xl">{title}</h3>
			<div className="space-y-3">{children}</div>
		</div>
	);
}
