import { Link } from "@tanstack/react-router";
import { motion } from "framer-motion";
import {
	Facebook,
	Instagram,
	Linkedin,
	Mail,
	MapPin,
	Phone,
	Twitter,
} from "lucide-react";
import { LangToggle } from "../toggle/lang-toggle";
import { ThemeToggle } from "../toggle/theme-toggle";

export function LandingFooter({ className }: { className?: string }) {
	const currentYear = new Date().getFullYear();

	const footerLinks = {
		product: [
			{ label: "Transportasi", href: "/transport" },
			{ label: "Food Delivery", href: "/food" },
			{ label: "Goods Delivery", href: "/goods" },
			{ label: "Jadi Driver", href: "/driver" },
		],
		company: [
			{ label: "Tentang Kami", href: "/about" },
			{ label: "Karir", href: "/careers" },
			{ label: "Blog", href: "/blog" },
			{ label: "Press Kit", href: "/press" },
		],
		support: [
			{ label: "FAQ", href: "/faq" },
			{ label: "Bantuan", href: "/help" },
			{ label: "Kontak", href: "/contact" },
			{ label: "Status", href: "/status" },
		],
		legal: [
			{ label: "Privacy Policy", href: "/privacy" },
			{ label: "Terms of Service", href: "/terms" },
			{ label: "Cookie Policy", href: "/cookies" },
		],
	};

	const socialLinks = [
		{ icon: Instagram, href: "https://instagram.com", label: "Instagram" },
		{ icon: Twitter, href: "https://twitter.com", label: "Twitter" },
		{ icon: Facebook, href: "https://facebook.com", label: "Facebook" },
		{ icon: Linkedin, href: "https://linkedin.com", label: "LinkedIn" },
	];

	return (
		<footer className={className}>
			<div className="border-border/40 border-t bg-linear-to-b from-background to-primary/20">
				{/* Main Footer Content */}
				<div className="mx-auto max-w-7xl px-4 py-12 sm:px-6 lg:px-8 lg:py-16">
					<div className="grid grid-cols-1 gap-8 md:grid-cols-2 lg:grid-cols-6">
						{/* Brand Section */}
						<motion.div
							initial={{ opacity: 0, y: 20 }}
							whileInView={{ opacity: 1, y: 0 }}
							viewport={{ once: true }}
							transition={{ duration: 0.5 }}
							className="col-span-1 md:col-span-2 lg:col-span-2"
						>
							<Link to="/" className="inline-block">
								<motion.h3
									className="font-bold text-2xl text-primary"
									whileHover={{ scale: 1.05 }}
									transition={{ type: "spring", stiffness: 400 }}
								>
									AkadeMove
								</motion.h3>
							</Link>
							<p className="mt-4 max-w-xs text-muted-foreground text-sm leading-relaxed">
								Solusi mobilitas dan delivery terpercaya untuk mahasiswa. Dari
								mahasiswa, untuk mahasiswa.
							</p>

							{/* Contact Info */}
							<div className="mt-6 space-y-3">
								<motion.div
									className="flex items-center gap-2 text-muted-foreground text-sm"
									whileHover={{ x: 5, color: "hsl(var(--primary))" }}
									transition={{ duration: 0.2 }}
								>
									<MapPin className="size-4 shrink-0" />
									<span>Surabaya, Indonesia</span>
								</motion.div>
								<motion.a
									href="mailto:hello@akademove.com"
									className="flex items-center gap-2 text-muted-foreground text-sm"
									whileHover={{ x: 5, color: "hsl(var(--primary))" }}
									transition={{ duration: 0.2 }}
								>
									<Mail className="size-4 shrink-0" />
									<span>hello@akademove.com</span>
								</motion.a>
								<motion.a
									href="tel:+6281234567890"
									className="flex items-center gap-2 text-muted-foreground text-sm"
									whileHover={{ x: 5, color: "hsl(var(--primary))" }}
									transition={{ duration: 0.2 }}
								>
									<Phone className="size-4 shrink-0" />
									<span>+62 812-3456-7890</span>
								</motion.a>
							</div>
						</motion.div>

						{/* Product Links */}
						<FooterLinkSection
							title="Produk"
							links={footerLinks.product}
							delay={0.1}
						/>

						{/* Company Links */}
						<FooterLinkSection
							title="Perusahaan"
							links={footerLinks.company}
							delay={0.2}
						/>

						{/* Support Links */}
						<FooterLinkSection
							title="Bantuan"
							links={footerLinks.support}
							delay={0.3}
						/>

						{/* Legal Links */}
						<FooterLinkSection
							title="Legal"
							links={footerLinks.legal}
							delay={0.4}
						/>
					</div>

					{/* Newsletter Section */}
					<motion.div
						initial={{ opacity: 0, y: 20 }}
						whileInView={{ opacity: 1, y: 0 }}
						viewport={{ once: true }}
						transition={{ duration: 0.5, delay: 0.5 }}
						className="mt-12 border-border/40 border-t pt-8"
					>
						<div className="flex flex-col items-center gap-4 sm:flex-row sm:justify-between">
							<div className="text-center sm:text-left">
								<h4 className="font-semibold text-foreground text-lg">
									Subscribe ke Newsletter
								</h4>
								<p className="mt-1 text-muted-foreground text-sm">
									Dapatkan update promo dan fitur terbaru
								</p>
							</div>
							<motion.div
								className="flex w-full max-w-md gap-2 sm:w-auto"
								whileHover={{ scale: 1.02 }}
								transition={{ duration: 0.2 }}
							>
								<input
									type="email"
									placeholder="Email kamu"
									className="flex h-10 w-full rounded-md border border-input bg-background px-3 py-2 text-sm ring-offset-background placeholder:text-muted-foreground focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-ring focus-visible:ring-offset-2"
								/>
								<motion.button
									className="whitespace-nowrap rounded-md bg-primary px-6 py-2 font-medium text-primary-foreground text-sm"
									whileHover={{ scale: 1.05 }}
									whileTap={{ scale: 0.95 }}
								>
									Subscribe
								</motion.button>
							</motion.div>
						</div>
					</motion.div>
				</div>

				{/* Bottom Bar */}
				<div className="border-border/40 border-t bg-secondary/30">
					<div className="mx-auto max-w-7xl px-4 py-6 sm:px-6 lg:px-8">
						<div className="flex flex-col items-center justify-between gap-4 sm:flex-row">
							<motion.p
								initial={{ opacity: 0 }}
								whileInView={{ opacity: 1 }}
								viewport={{ once: true }}
								transition={{ duration: 0.5, delay: 0.6 }}
								className="text-center text-muted-foreground text-sm"
							>
								© {currentYear} AkadeMove. All rights reserved.
							</motion.p>

							{/* Social Links & Toggles */}
							<motion.div
								initial={{ opacity: 0 }}
								whileInView={{ opacity: 1 }}
								viewport={{ once: true }}
								transition={{ duration: 0.5, delay: 0.7 }}
								className="flex items-center gap-4"
							>
								{socialLinks.map((social, index) => (
									<motion.a
										key={social.label}
										href={social.href}
										target="_blank"
										rel="noopener noreferrer"
										aria-label={social.label}
										className="text-muted-foreground transition-colors hover:text-primary"
										whileHover={{ scale: 1.2, rotate: 5 }}
										whileTap={{ scale: 0.9 }}
										initial={{ opacity: 0, y: 10 }}
										whileInView={{ opacity: 1, y: 0 }}
										viewport={{ once: true }}
										transition={{ duration: 0.3, delay: 0.8 + index * 0.1 }}
									>
										<social.icon className="size-5" />
									</motion.a>
								))}

								<div className="ml-2 flex items-center gap-2 border-border/40 border-l pl-4">
									<LangToggle />
									<ThemeToggle />
								</div>
							</motion.div>
						</div>
					</div>
				</div>
			</div>
		</footer>
	);
}

function FooterLinkSection({
	title,
	links,
	delay,
}: {
	title: string;
	links: { label: string; href: string }[];
	delay: number;
}) {
	return (
		<motion.div
			initial={{ opacity: 0, y: 20 }}
			whileInView={{ opacity: 1, y: 0 }}
			viewport={{ once: true }}
			transition={{ duration: 0.5, delay }}
			className="col-span-1"
		>
			<h4 className="mb-4 font-semibold text-foreground text-sm uppercase tracking-wider">
				{title}
			</h4>
			<ul className="space-y-3">
				{links.map((link, index) => (
					<motion.li
						key={link.href}
						initial={{ opacity: 0, x: -10 }}
						whileInView={{ opacity: 1, x: 0 }}
						viewport={{ once: true }}
						transition={{ duration: 0.3, delay: delay + index * 0.05 }}
					>
						<Link
							to={link.href}
							className="text-muted-foreground text-sm transition-colors hover:text-primary"
						>
							<motion.span
								className="inline-block"
								whileHover={{ x: 5 }}
								transition={{ duration: 0.2 }}
							>
								{link.label}
							</motion.span>
						</Link>
					</motion.li>
				))}
			</ul>
		</motion.div>
	);
}
