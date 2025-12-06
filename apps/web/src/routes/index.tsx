/** biome-ignore-all lint/suspicious/noArrayIndexKey: since data is static i didnt provide array index as key */

import { m } from "@repo/i18n";
import { createFileRoute } from "@tanstack/react-router";
import { motion, useInView, useScroll, useTransform } from "framer-motion";
import {
	ArrowRight,
	BadgeCentIcon,
	BlocksIcon,
	Clock,
	type LucideIcon,
	PhoneIcon,
	Shield,
	Sparkles,
	Star,
	TrendingUp,
	Users,
	VerifiedIcon,
	Zap,
} from "lucide-react";
import type React from "react";
import { memo, useEffect, useRef, useState } from "react";
import accessories1 from "@/assets/landing/accessories-1.svg";
import accessories2 from "@/assets/landing/accessories-2.svg";
import accessories3 from "@/assets/landing/accessories-3.svg";
import accessories4 from "@/assets/landing/accessories-4.svg";
import char1 from "@/assets/landing/char-1.svg";
import char2 from "@/assets/landing/char-2.svg";
import char3 from "@/assets/landing/char-3.svg";
import char4 from "@/assets/landing/char-4.svg";
import hero1 from "@/assets/landing/hero-1.png";
import mobileShowcaseUrl from "@/assets/landing/mobile-showcase.png";
import { SignUpDialog } from "@/components/dialogs/sign-up-dialog";
import { LandingFooter } from "@/components/footer/landing-footer";
import { PublicHeader } from "@/components/header/public";
import { Badge } from "@/components/ui/badge";
import { Button } from "@/components/ui/button";
import { cn } from "@/utils/cn";

export const Route = createFileRoute("/")({
	component: HomeComponent,
});

type Trouble = {
	desc: string;
	imageUrl: string;
};

const getTroubles = (): Trouble[] => [
	{
		desc: m.landing_trouble_1(),
		imageUrl: char1,
	},
	{
		desc: m.landing_trouble_2(),
		imageUrl: char2,
	},
	{
		desc: m.landing_trouble_3(),
		imageUrl: char3,
	},
	{
		desc: m.landing_trouble_4(),
		imageUrl: char4,
	},
];

type Solution = {
	desc: string;
	color: string;
	icon: LucideIcon;
};

const getSolutions = (): Solution[] => [
	{
		desc: m.landing_solution_1(),
		color: "blue",
		icon: VerifiedIcon,
	},
	{
		desc: m.landing_solution_2(),
		color: "green",
		icon: PhoneIcon,
	},
	{
		desc: m.landing_solution_3(),
		color: "yellow",
		icon: BadgeCentIcon,
	},
	{
		desc: m.landing_solution_4(),
		color: "red",
		icon: BlocksIcon,
	},
];

type Feature = {
	title: string;
	desc: string;
	icon: string;
};

const getFeatures = (): Feature[] => [
	{
		title: m.landing_feature_1_title(),
		desc: m.landing_feature_1_desc(),
		icon: "🚗",
	},
	{
		title: m.landing_feature_2_title(),
		desc: m.landing_feature_2_desc(),
		icon: "🍔",
	},
	{
		title: m.landing_feature_3_title(),
		desc: m.landing_feature_3_desc(),
		icon: "🛡",
	},
];

const getStats = () => [
	{
		title: m.landing_stat_1_title(),
		desc: m.landing_stat_1_desc(),
	},
	{
		title: m.landing_stat_2_title(),
		desc: m.landing_stat_2_desc(),
	},
	{
		title: m.landing_stat_3_title(),
		desc: m.landing_stat_3_desc(),
	},
];

const getTestimonials = () => [
	{
		quote: m.landing_testimonial_1_quote(),
		by: m.landing_testimonial_1_by(),
	},
	{
		quote: m.landing_testimonial_2_quote(),
		by: m.landing_testimonial_2_by(),
	},
	{
		quote: m.landing_testimonial_3_quote(),
		by: m.landing_testimonial_3_by(),
	},
];

const getTrustBadges = () => [
	{ icon: Shield, label: m.landing_trust_secure() },
	{ icon: Users, label: m.landing_trust_verified() },
	{ icon: Zap, label: m.landing_trust_fast() },
	{ icon: Clock, label: m.landing_trust_support() },
];

// Optimized: Reduced animation complexity and will-change
const AnimatedGradientOrb = memo(
	({
		className,
		duration,
		delay = 0,
	}: {
		className: string;
		duration: number;
		delay?: number;
	}) => (
		<motion.div
			animate={{
				scale: [1, 1.15, 1],
				opacity: [0.3, 0.5, 0.3],
			}}
			transition={{
				duration,
				repeat: Number.POSITIVE_INFINITY,
				ease: "easeInOut",
				delay,
			}}
			className={cn(
				"absolute rounded-full blur-3xl will-change-transform",
				className,
			)}
		/>
	),
);
AnimatedGradientOrb.displayName = "AnimatedGradientOrb";

// Optimized: Memoized trust badge component
const TrustBadge = memo(
	({
		icon: Icon,
		label,
		index,
	}: {
		icon: LucideIcon;
		label: string;
		index: number;
	}) => (
		<motion.div
			initial={{ opacity: 0, y: 20 }}
			animate={{ opacity: 1, y: 0 }}
			transition={{ duration: 0.5, delay: 1.3 + index * 0.1 }}
			whileHover={{ scale: 1.1, y: -5 }}
			className="flex cursor-pointer flex-col items-center gap-2 rounded-lg border border-primary/20 bg-primary/5 p-3 backdrop-blur-sm transition-all hover:border-primary/40 hover:bg-primary/10"
		>
			<Icon className="size-6 text-primary" />
			<span className="text-center font-medium text-[10px] sm:text-xs">
				{label}
			</span>
		</motion.div>
	),
);
TrustBadge.displayName = "TrustBadge";

function HomeComponent() {
	const heroRef = useRef(null);
	const { scrollYProgress } = useScroll({
		target: heroRef,
		offset: ["start start", "end start"],
	});

	const y1 = useTransform(scrollYProgress, [0, 1], [0, 200]);
	const y2 = useTransform(scrollYProgress, [0, 1], [0, -100]);
	const opacity = useTransform(scrollYProgress, [0, 0.5], [1, 0]);

	const troubles = getTroubles();
	const solutions = getSolutions();
	const features = getFeatures();
	const stats = getStats();
	const testimonials = getTestimonials();
	const trustBadges = getTrustBadges();

	return (
		<div className="h-full">
			<PublicHeader className="fixed top-0 right-0 left-0 z-50 mx-auto mt-2 w-full max-w-3xl rounded-xl border p-4 backdrop-blur-xl" />

			{/* Hero Section */}
			<section
				ref={heroRef}
				className="relative flex min-h-svh w-full items-center justify-center overflow-hidden bg-landing-section-1 px-4 py-20 sm:px-6 md:px-8 md:py-24 lg:px-16"
			>
				{/* Optimized: Reduced number of gradient orbs and simplified animations */}
				<AnimatedGradientOrb
					className="top-0 right-0 h-96 w-96 bg-linear-to-br from-primary/30 to-amber-500/30"
					duration={10}
				/>
				<AnimatedGradientOrb
					className="bottom-0 left-0 h-96 w-96 bg-linear-to-tr from-blue-500/20 to-pink-500/20"
					duration={12}
					delay={1}
				/>

				{/* Scooter - bottom left */}
				<motion.div
					style={{ y: y1 }}
					className="absolute bottom-4 left-2 z-0 sm:bottom-6 sm:left-4 md:bottom-12 md:left-8 lg:bottom-16 lg:left-16"
				>
					<motion.img
						initial={{ x: -100, opacity: 0 }}
						animate={{ x: 0, opacity: 1 }}
						transition={{ duration: 0.8, delay: 0.2 }}
						src={hero1}
						alt="scooter"
						className="w-24 sm:w-28 md:w-40 lg:w-48 xl:w-auto"
						loading="eager"
					/>
				</motion.div>

				{/* Accessories - Optimized with lazy loading */}
				<motion.div
					style={{ y: y2 }}
					className="-translate-x-1/2 absolute top-4 left-1/2 z-0 sm:top-6 md:top-12 lg:top-16"
				>
					<motion.img
						initial={{ y: -50, opacity: 0 }}
						animate={{ y: 0, opacity: 1 }}
						transition={{ duration: 0.8, delay: 0.4 }}
						src={accessories1}
						alt="acc-1"
						className="w-20 sm:w-24 md:w-28 lg:w-32 xl:w-auto"
						loading="lazy"
					/>
				</motion.div>

				<motion.div
					style={{ y: y2 }}
					className="absolute top-4 left-[10%] z-0 sm:top-6 sm:left-[12%] md:top-12 md:left-[15%] lg:top-16 lg:left-[20%]"
				>
					<motion.img
						initial={{ x: -50, y: -50, opacity: 0 }}
						animate={{ x: 0, y: 0, opacity: 1 }}
						transition={{ duration: 0.8, delay: 0.3 }}
						src={accessories2}
						alt="acc-2"
						className="w-20 sm:w-24 md:w-28 lg:w-36 xl:w-[200px]"
						loading="lazy"
					/>
				</motion.div>

				<motion.div
					style={{ opacity }}
					className="-translate-x-1/2 absolute bottom-0 left-1/2 z-0"
				>
					<img
						src={accessories3}
						alt="acc-3"
						className="w-full max-w-xs sm:max-w-sm md:max-w-md lg:max-w-2xl xl:max-w-[1080px]"
						loading="lazy"
					/>
				</motion.div>

				<motion.div
					style={{ y: y1 }}
					className="-translate-y-1/2 absolute top-1/2 right-0 z-0"
				>
					<motion.img
						initial={{ x: 100, opacity: 0 }}
						animate={{ x: 0, opacity: 1 }}
						transition={{ duration: 0.8, delay: 0.5 }}
						src={accessories4}
						alt="acc-4"
						className="h-48 sm:h-56 md:h-72 lg:h-96 xl:h-[720px]"
						loading="lazy"
					/>
				</motion.div>

				{/* Content */}
				<div className="flex w-full flex-col items-center gap-8 lg:flex-row lg:items-center lg:justify-center xl:gap-16">
					{/* Text content */}
					<motion.div
						initial={{ opacity: 0, y: 30 }}
						animate={{ opacity: 1, y: 0 }}
						transition={{ duration: 0.8, delay: 0.6 }}
						className="z-10 flex w-full max-w-md flex-col gap-4 text-center sm:max-w-lg lg:max-w-xl lg:text-left xl:max-w-2xl"
					>
						{/* Trust Badge - Optimized animation */}
						<motion.div
							initial={{ opacity: 0, y: -10 }}
							animate={{ opacity: 1, y: 0 }}
							transition={{ duration: 0.6, delay: 0.7 }}
							className="mx-auto flex items-center gap-2 lg:mx-0"
						>
							<Badge
								variant="outline"
								className="flex items-center gap-1 border-primary/50 bg-primary/10 px-3 py-1"
							>
								<Sparkles className="size-3" />
								<span className="font-medium text-xs">
									Trusted by 2000+ Students
								</span>
							</Badge>
						</motion.div>

						<motion.h1
							initial={{ opacity: 0, y: 20 }}
							animate={{ opacity: 1, y: 0 }}
							transition={{ duration: 0.6, delay: 0.8 }}
							className="bg-linear-to-r from-foreground via-primary to-foreground bg-clip-text font-bold text-2xl text-transparent leading-tight sm:text-3xl md:text-4xl lg:text-5xl xl:text-6xl"
						>
							{m.landing_hero_title()}
						</motion.h1>
						<motion.p
							initial={{ opacity: 0, y: 20 }}
							animate={{ opacity: 1, y: 0 }}
							transition={{ duration: 0.6, delay: 0.9 }}
							className="text-muted-foreground text-sm sm:text-base md:text-lg lg:text-xl"
						>
							{m.landing_hero_subtitle()}
						</motion.p>
						<motion.div
							initial={{ opacity: 0, scale: 0.9 }}
							animate={{ opacity: 1, scale: 1 }}
							transition={{ duration: 0.5, delay: 1 }}
							className="flex flex-col gap-3 sm:flex-row sm:items-center"
						>
							<SignUpDialog asChild>
								<Button className="group relative mx-auto mt-2 w-full max-w-xs overflow-hidden bg-primary p-6 text-lg transition-all hover:scale-105 hover:shadow-2xl hover:shadow-primary/50 sm:max-w-sm lg:mx-0 lg:max-w-xs">
									<span className="relative z-10 flex items-center gap-2">
										{m.landing_hero_cta()}
										<ArrowRight className="size-5 transition-transform group-hover:translate-x-1" />
									</span>
									{/* Optimized: Simplified gradient animation */}
									<motion.div
										className="absolute inset-0 bg-linear-to-r from-primary via-amber-600 to-primary"
										animate={{
											x: ["-100%", "100%"],
										}}
										transition={{
											duration: 3,
											repeat: Number.POSITIVE_INFINITY,
											ease: "linear",
										}}
									/>
								</Button>
							</SignUpDialog>
						</motion.div>

						{/* Trust Indicators - Optimized with memo */}
						<motion.div
							initial={{ opacity: 0 }}
							animate={{ opacity: 1 }}
							transition={{ duration: 0.8, delay: 1.2 }}
							className="mx-auto mt-4 grid grid-cols-4 gap-2 lg:mx-0"
						>
							{trustBadges.map((badge, index) => (
								<TrustBadge
									key={index}
									icon={badge.icon}
									label={badge.label}
									index={index}
								/>
							))}
						</motion.div>
					</motion.div>

					{/* Spacer (only on large screens) */}
					<div className="hidden lg:block lg:w-8 xl:w-16" />

					{/* Mobile showcase - Optimized animation */}
					<motion.div
						initial={{ opacity: 0, x: 50 }}
						animate={{ opacity: 1, x: 0 }}
						transition={{ duration: 0.8, delay: 1.1 }}
						className="relative z-10 w-full max-w-xs sm:max-w-sm md:max-w-md lg:max-w-lg xl:max-w-xl"
					>
						{/* Optimized: Single glow effect */}
						<motion.div
							animate={{
								scale: [1, 1.1, 1],
								opacity: [0.5, 0.7, 0.5],
							}}
							transition={{
								duration: 4,
								repeat: Number.POSITIVE_INFINITY,
								ease: "easeInOut",
							}}
							className="-z-10 absolute inset-0 rounded-full bg-primary/30 blur-3xl will-change-transform"
						/>
						<motion.img
							animate={{ y: [0, -10, 0] }}
							transition={{
								duration: 3,
								repeat: Number.POSITIVE_INFINITY,
								ease: "easeInOut",
							}}
							src={mobileShowcaseUrl}
							alt="Mobile showcase"
							className="w-full drop-shadow-2xl"
							loading="eager"
						/>
					</motion.div>
				</div>
			</section>

			{/* Troubles & Solutions Section */}
			<section className="relative mx-auto w-full max-w-7xl px-4 py-12 sm:px-6 sm:py-16 md:px-8 md:py-20 lg:px-16 lg:py-24">
				<AnimatedTitle>{m.landing_troubles_title()}</AnimatedTitle>
				<div className="mt-8 grid grid-cols-1 gap-4 sm:grid-cols-2 sm:gap-6 lg:grid-cols-4 lg:gap-8">
					{troubles.map((trouble, index) => (
						<TroubleCard key={index} index={index} {...trouble} />
					))}
				</div>
				<AnimatedTitle delay={0.2}>{m.landing_solutions_title()}</AnimatedTitle>
				<div className="mt-8 grid grid-cols-1 gap-4 sm:grid-cols-2 sm:gap-6 lg:grid-cols-4 lg:gap-8">
					{solutions.map((solution, index) => (
						<SolutionCard key={index} index={index} {...solution} />
					))}
				</div>
			</section>

			{/* Features Section with enhanced cards */}
			<section className="relative overflow-hidden bg-secondary/30">
				{/* Optimized: Static decorative elements */}
				<div className="pointer-events-none absolute inset-0 overflow-hidden">
					<div className="absolute top-10 left-10 size-64 rounded-full bg-primary/5 blur-3xl" />
					<div className="absolute right-10 bottom-10 size-64 rounded-full bg-amber-500/5 blur-3xl" />
				</div>

				<div className="relative mx-auto w-full max-w-7xl px-4 py-12 sm:px-6 sm:py-16 md:px-8 md:py-20 lg:px-16 lg:py-24">
					<AnimatedTitle>{m.landing_features_title()}</AnimatedTitle>
					<div className="mt-8 grid grid-cols-1 gap-6 md:grid-cols-2 lg:grid-cols-3 lg:gap-8">
						{features.map((feature, index) => (
							<FeatureCard key={index} index={index} {...feature} />
						))}
					</div>
				</div>
			</section>

			{/* Stats Section with animated counters */}
			<section className="relative mx-auto w-full max-w-7xl px-4 py-12 sm:px-6 sm:py-16 md:px-8 md:py-20 lg:px-16 lg:py-24">
				<AnimatedTitle>{m.landing_stats_title()}</AnimatedTitle>
				<div className="mt-8 grid grid-cols-1 gap-6 sm:grid-cols-3 sm:gap-8">
					{stats.map((stat, index) => (
						<StatCard key={index} index={index} {...stat} />
					))}
				</div>
			</section>

			{/* Testimonials Section with enhanced styling */}
			<section className="relative overflow-hidden bg-secondary/30">
				<div className="absolute inset-0 opacity-5">
					<div
						className="h-full w-full"
						style={{
							backgroundImage:
								"radial-gradient(circle, currentColor 1px, transparent 1px)",
							backgroundSize: "30px 30px",
						}}
					/>
				</div>
				<div className="relative mx-auto w-full max-w-7xl px-4 py-12 sm:px-6 sm:py-16 md:px-8 md:py-20 lg:px-16 lg:py-24">
					<AnimatedTitle>{m.landing_testimonials_title()}</AnimatedTitle>
					<div className="mt-8 grid grid-cols-1 gap-6 md:grid-cols-2 lg:grid-cols-3 lg:gap-8">
						{testimonials.map((testimonial, index) => (
							<TestimonialCard key={index} index={index} {...testimonial} />
						))}
					</div>
				</div>
			</section>

			{/* Enhanced CTA Section */}
			<section className="relative mx-auto w-full max-w-7xl px-4 py-12 sm:px-6 sm:py-16 md:px-8 md:py-20 lg:px-16 lg:py-24">
				<AnimatedCTA />
			</section>
			<LandingFooter />
		</div>
	);
}

const AnimatedTitle = memo(
	({ children, delay = 0 }: { children: React.ReactNode; delay?: number }) => {
		const ref = useRef(null);
		const isInView = useInView(ref, { once: true, margin: "-100px" });

		return (
			<motion.h2
				ref={ref}
				initial={{ opacity: 0, y: 30 }}
				animate={isInView ? { opacity: 1, y: 0 } : {}}
				transition={{ duration: 0.6, delay }}
				className="mt-12 text-center font-semibold text-xl first:mt-0 sm:text-2xl md:text-3xl lg:text-4xl"
			>
				{children}
			</motion.h2>
		);
	},
);
AnimatedTitle.displayName = "AnimatedTitle";

const TroubleCard = memo(({ index, ...item }: Trouble & { index: number }) => {
	const ref = useRef(null);
	const isInView = useInView(ref, { once: true, margin: "-50px" });

	return (
		<motion.div
			ref={ref}
			initial={{ opacity: 0, y: 50 }}
			animate={isInView ? { opacity: 1, y: 0 } : {}}
			transition={{ duration: 0.5, delay: index * 0.1 }}
			whileHover={{ scale: 1.05, y: -5 }}
			className="group relative flex flex-col items-center gap-3 overflow-hidden rounded-lg border-2 border-primary/30 bg-primary/20 p-4 shadow-lg transition-shadow hover:shadow-xl sm:p-5 md:p-6"
		>
			{/* Hover gradient */}
			<div className="absolute inset-0 bg-linear-to-br from-primary/0 via-primary/5 to-primary/10 opacity-0 transition-opacity group-hover:opacity-100" />
			<motion.img
				initial={{ scale: 0.8, opacity: 0 }}
				animate={isInView ? { scale: 1, opacity: 1 } : {}}
				transition={{ duration: 0.5, delay: index * 0.1 + 0.2 }}
				src={item.imageUrl}
				alt={item.desc}
				className="relative z-10 h-20 w-auto transition-transform group-hover:scale-110 sm:h-24 md:h-28 lg:h-32"
				loading="lazy"
			/>
			<p className="relative z-10 text-center font-medium text-sm sm:text-base md:text-lg">
				{item.desc}
			</p>
		</motion.div>
	);
});
TroubleCard.displayName = "TroubleCard";

const SolutionCard = memo(
	({ index, ...item }: Solution & { index: number }) => {
		const ref = useRef(null);
		const isInView = useInView(ref, { once: true, margin: "-50px" });

		return (
			<motion.div
				ref={ref}
				initial={{ opacity: 0, scale: 0.9 }}
				animate={isInView ? { opacity: 1, scale: 1 } : {}}
				transition={{ duration: 0.5, delay: index * 0.1 }}
				whileHover={{ scale: 1.05, rotate: 1 }}
				className="group relative flex flex-col items-center gap-4 overflow-hidden rounded-lg border-2 border-primary/30 bg-primary/20 p-4 shadow-lg transition-all hover:shadow-2xl sm:p-5 md:p-6 lg:p-8"
			>
				{/* Optimized: Removed animated background */}
				<div className="absolute inset-0 bg-linear-to-br from-primary/0 via-primary/10 to-primary/0 opacity-0 transition-opacity group-hover:opacity-100" />
				<motion.div
					initial={{ scale: 0, rotate: -180 }}
					animate={isInView ? { scale: 1, rotate: 0 } : {}}
					transition={{
						duration: 0.6,
						delay: index * 0.1 + 0.2,
						type: "spring",
					}}
					className={cn(
						"relative z-10 rounded-xl border-2 p-3 transition-transform group-hover:scale-110 sm:p-4",
						`bg-${item.color}-500/20 border-${item.color}-500/30`,
					)}
				>
					<item.icon
						className={cn(
							"size-6 transition-colors sm:size-7 md:size-8 lg:size-10",
							`text-${item.color}-500`,
						)}
					/>
				</motion.div>
				<p className="relative z-10 text-center font-medium text-sm sm:text-base md:text-lg">
					{item.desc}
				</p>
			</motion.div>
		);
	},
);
SolutionCard.displayName = "SolutionCard";

const FeatureCard = memo(({ index, ...item }: Feature & { index: number }) => {
	const ref = useRef(null);
	const isInView = useInView(ref, { once: true, margin: "-50px" });

	return (
		<motion.div
			ref={ref}
			initial={{ opacity: 0, y: 50 }}
			animate={isInView ? { opacity: 1, y: 0 } : {}}
			transition={{ duration: 0.5, delay: index * 0.15 }}
			whileHover={{ y: -10, transition: { duration: 0.2 } }}
			className="group relative flex flex-col items-center gap-3 overflow-hidden rounded-lg border-2 border-primary/30 bg-primary/20 p-4 shadow-lg backdrop-blur-sm transition-all hover:border-primary/50 hover:shadow-2xl sm:p-5 md:p-6 lg:p-8"
		>
			{/* Optimized: Removed shimmer effect */}
			<motion.p
				initial={{ scale: 0 }}
				animate={isInView ? { scale: 1 } : {}}
				transition={{
					duration: 0.5,
					delay: index * 0.15 + 0.2,
					type: "spring",
					bounce: 0.5,
				}}
				className="text-3xl transition-transform group-hover:scale-125 sm:text-4xl md:text-5xl"
			>
				{item.icon}
			</motion.p>
			<p className="mt-2 text-center font-medium text-lg sm:text-xl md:text-2xl">
				{item.title}
			</p>
			<p className="text-center text-muted-foreground text-sm sm:text-base md:text-lg">
				{item.desc}
			</p>
		</motion.div>
	);
});
FeatureCard.displayName = "FeatureCard";

const StatCard = memo(
	({ index, ...item }: { title: string; desc: string; index: number }) => {
		const ref = useRef(null);
		const isInView = useInView(ref, { once: true, margin: "-50px" });
		const [count, setCount] = useState(0);

		// Optimized: More efficient counter animation
		useEffect(() => {
			if (!isInView) return;

			const target =
				Number.parseInt(item.title.replace(/[^0-9]/g, ""), 10) || 0;
			if (target === 0) return;

			const duration = 2000;
			const steps = 30; // Reduced from 60 for better performance
			const increment = target / steps;
			let current = 0;

			const timer = setInterval(() => {
				current += increment;
				if (current >= target) {
					setCount(target);
					clearInterval(timer);
				} else {
					setCount(Math.floor(current));
				}
			}, duration / steps);

			return () => clearInterval(timer);
		}, [isInView, item.title]);

		const displayValue = item.title.replace(/[0-9]/g, "").includes("%")
			? `${count}%`
			: item.title.includes("+")
				? `${count}+`
				: item.title;

		return (
			<motion.div
				ref={ref}
				initial={{ opacity: 0, scale: 0.8 }}
				animate={isInView ? { opacity: 1, scale: 1 } : {}}
				transition={{ duration: 0.5, delay: index * 0.1 }}
				whileHover={{ scale: 1.08 }}
				className="group relative flex flex-col items-center gap-2 overflow-hidden rounded-lg border-2 border-primary/30 bg-primary/20 p-4 shadow-lg transition-all hover:border-primary/50 hover:shadow-2xl sm:p-5 md:p-6 lg:p-8"
			>
				{/* Icon decoration */}
				<motion.div
					className="absolute top-2 right-2 opacity-0 transition-opacity group-hover:opacity-100"
					initial={{ rotate: 0 }}
					whileHover={{ rotate: 360 }}
					transition={{ duration: 0.5 }}
				>
					<TrendingUp className="size-5 text-primary/50" />
				</motion.div>

				<motion.p
					initial={{ opacity: 0, scale: 0.5 }}
					animate={isInView ? { opacity: 1, scale: 1 } : {}}
					transition={{
						duration: 0.6,
						delay: index * 0.1 + 0.3,
						type: "spring",
					}}
					className="bg-linear-to-r from-primary via-amber-500 to-primary bg-clip-text font-bold text-3xl text-transparent sm:text-4xl md:text-5xl"
				>
					{count > 0 ? displayValue : item.title}
				</motion.p>
				<p className="text-center text-muted-foreground text-sm sm:text-base md:text-lg">
					{item.desc}
				</p>
			</motion.div>
		);
	},
);
StatCard.displayName = "StatCard";

// Optimized: Memoized star component
const StarRating = memo(
	({ index, itemIndex }: { index: number; itemIndex: number }) => {
		const ref = useRef(null);
		const isInView = useInView(ref, { once: true, margin: "-50px" });

		return (
			<motion.div
				ref={ref}
				initial={{ opacity: 0, scale: 0 }}
				animate={isInView ? { opacity: 1, scale: 1 } : {}}
				transition={{ duration: 0.3, delay: itemIndex * 0.1 + index * 0.05 }}
			>
				<Star className="size-4 fill-yellow-500 text-yellow-500" />
			</motion.div>
		);
	},
);
StarRating.displayName = "StarRating";

const TestimonialCard = memo(
	({ index, ...item }: { quote: string; by: string; index: number }) => {
		const ref = useRef(null);
		const isInView = useInView(ref, { once: true, margin: "-50px" });

		return (
			<motion.div
				ref={ref}
				initial={{ opacity: 0, x: index % 2 === 0 ? -50 : 50 }}
				animate={isInView ? { opacity: 1, x: 0 } : {}}
				transition={{ duration: 0.6, delay: index * 0.1 }}
				whileHover={{ scale: 1.03 }}
				className="group relative flex flex-col gap-3 overflow-hidden rounded-lg border-2 border-primary/30 bg-primary/20 p-4 shadow-lg transition-all hover:border-primary/50 hover:shadow-2xl sm:p-5 md:p-6 lg:p-8"
			>
				{/* Star rating - Optimized */}
				<div className="flex gap-1">
					{[...Array(5)].map((_, i) => (
						<StarRating key={i} index={i} itemIndex={index} />
					))}
				</div>

				<p className="text-sm italic sm:text-base md:text-lg">"{item.quote}"</p>
				<p className="font-medium text-primary text-sm sm:text-base md:text-lg">
					— {item.by}
				</p>
			</motion.div>
		);
	},
);
TestimonialCard.displayName = "TestimonialCard";

const AnimatedCTA = memo(() => {
	const ref = useRef(null);
	const isInView = useInView(ref, { once: true, margin: "-100px" });

	return (
		<motion.div
			ref={ref}
			initial={{ opacity: 0, y: 50 }}
			animate={isInView ? { opacity: 1, y: 0 } : {}}
			transition={{ duration: 0.8 }}
			className="relative overflow-hidden rounded-2xl border-2 border-primary/30 bg-linear-to-br from-primary/20 via-amber-500/10 to-primary/20 p-8 shadow-2xl md:p-12"
		>
			{/* Optimized: Simplified background pattern */}
			<div
				className="absolute inset-0 opacity-10"
				style={{
					backgroundImage: `linear-gradient(45deg, currentColor 25%, transparent 25%, transparent 75%, currentColor 75%, currentColor), 
					                   linear-gradient(45deg, currentColor 25%, transparent 25%, transparent 75%, currentColor 75%, currentColor)`,
					backgroundSize: "20px 20px",
					backgroundPosition: "0 0, 10px 10px",
				}}
			/>

			<div className="relative flex flex-col items-center gap-6 text-center">
				<motion.h2
					initial={{ opacity: 0, scale: 0.9 }}
					animate={isInView ? { opacity: 1, scale: 1 } : {}}
					transition={{ duration: 0.6, delay: 0.2 }}
					className="font-semibold text-xl sm:text-2xl md:text-3xl lg:text-4xl"
				>
					{m.landing_cta_title()}
				</motion.h2>
				<motion.p
					initial={{ opacity: 0 }}
					animate={isInView ? { opacity: 1 } : {}}
					transition={{ duration: 0.6, delay: 0.4 }}
					className="max-w-2xl text-muted-foreground text-sm sm:text-base md:text-lg"
				>
					{m.landing_cta_subtitle()}
				</motion.p>
				<motion.div
					initial={{ opacity: 0, y: 20 }}
					animate={isInView ? { opacity: 1, y: 0 } : {}}
					transition={{ duration: 0.6, delay: 0.6 }}
				>
					<SignUpDialog asChild>
						<Button className="group relative overflow-hidden bg-primary p-6 text-lg text-primary-foreground shadow-lg transition-all hover:scale-105 hover:shadow-2xl hover:shadow-primary/50 sm:text-xl">
							<span className="relative z-10 flex items-center gap-2">
								{m.landing_cta_button()}
								{/* Optimized: Simpler arrow animation */}
								<ArrowRight className="size-5 transition-transform group-hover:translate-x-1" />
							</span>
							<motion.div
								className="absolute inset-0 bg-linear-to-r from-amber-600 via-primary to-amber-600"
								animate={{
									x: ["-100%", "100%"],
								}}
								transition={{
									duration: 2,
									repeat: Number.POSITIVE_INFINITY,
									ease: "linear",
								}}
							/>
						</Button>
					</SignUpDialog>
				</motion.div>

				{/* Additional trust indicators */}
				<motion.div
					initial={{ opacity: 0 }}
					animate={isInView ? { opacity: 1 } : {}}
					transition={{ duration: 0.8, delay: 0.8 }}
					className="flex flex-wrap items-center justify-center gap-6 text-muted-foreground text-sm"
				>
					<div className="flex items-center gap-2">
						<Shield className="size-4" />
						<span>{m.landing_cta_secure()}</span>
					</div>
					<div className="flex items-center gap-2">
						<Users className="size-4" />
						<span>{m.landing_cta_users()}</span>
					</div>
					<div className="flex items-center gap-2">
						<Zap className="size-4" />
						<span>{m.landing_cta_fast()}</span>
					</div>
				</motion.div>
			</div>
		</motion.div>
	);
});
AnimatedCTA.displayName = "AnimatedCTA";
