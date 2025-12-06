import { m } from "@repo/i18n";
import { createFileRoute } from "@tanstack/react-router";
import { motion, useInView } from "framer-motion";
import {
	BookOpenIcon,
	GraduationCapIcon,
	HandshakeIcon,
	HeartIcon,
	LightbulbIcon,
	type LucideIcon,
	MailIcon,
	ShieldCheckIcon,
	SparklesIcon,
	TargetIcon,
	TrendingUpIcon,
	UsersIcon,
	ZapIcon,
} from "lucide-react";
import { useRef } from "react";
import { SignUpDialog } from "@/components/dialogs/sign-up-dialog";
import { LandingFooter } from "@/components/footer/landing-footer";
import { PublicHeader } from "@/components/header/public";
import { Button } from "@/components/ui/button";

export const Route = createFileRoute("/(company)/about")({
	component: AboutComponent,
});

// ==================== DATA CONSTANTS ====================

type CoreValue = {
	title: string;
	icon: LucideIcon;
	description: string;
	color: string;
};

const CORE_VALUES: CoreValue[] = [
	{
		title: m.about_value_trust_title(),
		icon: ShieldCheckIcon,
		description: m.about_value_trust_desc(),
		color: "blue",
	},
	{
		title: m.about_value_empowerment_title(),
		icon: GraduationCapIcon,
		description: m.about_value_empowerment_desc(),
		color: "green",
	},
	{
		title: m.about_value_community_title(),
		icon: HandshakeIcon,
		description: m.about_value_community_desc(),
		color: "purple",
	},
	{
		title: m.about_value_transparency_title(),
		icon: BookOpenIcon,
		description: m.about_value_transparency_desc(),
		color: "yellow",
	},
	{
		title: m.about_value_innovation_title(),
		icon: LightbulbIcon,
		description: m.about_value_innovation_desc(),
		color: "red",
	},
];

type ImpactStat = {
	value: string;
	label: string;
	icon: LucideIcon;
};

const IMPACT_STATS: ImpactStat[] = [
	{
		value: "2000+",
		label: m.about_impact_trips(),
		icon: TrendingUpIcon,
	},
	{
		value: "95%",
		label: m.about_impact_satisfaction(),
		icon: HeartIcon,
	},
	{
		value: "100+",
		label: m.about_impact_merchants(),
		icon: UsersIcon,
	},
	{
		value: "500+",
		label: m.about_impact_drivers(),
		icon: ZapIcon,
	},
];

type FeatureSegment = {
	title: string;
	icon: LucideIcon;
	features: string[];
};

const FEATURE_SEGMENTS: FeatureSegment[] = [
	{
		title: m.about_benefits_students_title(),
		icon: UsersIcon,
		features: [
			m.about_benefits_students_1(),
			m.about_benefits_students_2(),
			m.about_benefits_students_3(),
			m.about_benefits_students_4(),
			m.about_benefits_students_5(),
		],
	},
	{
		title: m.about_benefits_drivers_title(),
		icon: GraduationCapIcon,
		features: [
			m.about_benefits_drivers_1(),
			m.about_benefits_drivers_2(),
			m.about_benefits_drivers_3(),
			m.about_benefits_drivers_4(),
			m.about_benefits_drivers_5(),
		],
	},
	{
		title: m.about_benefits_merchants_title(),
		icon: HandshakeIcon,
		features: [
			m.about_benefits_merchants_1(),
			m.about_benefits_merchants_2(),
			m.about_benefits_merchants_3(),
			m.about_benefits_merchants_4(),
			m.about_benefits_merchants_5(),
		],
	},
];

type TeamMember = {
	name: string;
	role: string;
	bio: string;
	avatar: string;
};

const TEAM_MEMBERS: TeamMember[] = [
	{
		name: m.about_team_member_1_name(),
		role: m.about_team_cofounder_ceo(),
		bio: m.about_team_member_1_bio(),
		avatar: "https://api.dicebear.com/7.x/avataaars/svg?seed=Ahmad",
	},
	{
		name: m.about_team_member_2_name(),
		role: m.about_team_cofounder_cto(),
		bio: m.about_team_member_2_bio(),
		avatar: "https://api.dicebear.com/7.x/avataaars/svg?seed=Siti",
	},
	{
		name: m.about_team_member_3_name(),
		role: m.about_team_head_operations(),
		bio: m.about_team_member_3_bio(),
		avatar: "https://api.dicebear.com/7.x/avataaars/svg?seed=Budi",
	},
	{
		name: m.about_team_member_4_name(),
		role: m.about_team_head_community(),
		bio: m.about_team_member_4_bio(),
		avatar: "https://api.dicebear.com/7.x/avataaars/svg?seed=Dewi",
	},
];

type Partnership = {
	name: string;
	location: string;
	description: string;
};

const PARTNERSHIPS: Partnership[] = [
	{
		name: m.about_partnership_1_name(),
		location: m.about_partnership_1_location(),
		description: m.about_partnership_1_desc(),
	},
	{
		name: m.about_partnership_2_name(),
		location: m.about_partnership_2_location(),
		description: m.about_partnership_2_desc(),
	},
	{
		name: m.about_partnership_3_name(),
		location: m.about_partnership_3_location(),
		description: m.about_partnership_3_desc(),
	},
];

type SocialImpact = {
	title: string;
	icon: LucideIcon;
	description: string;
	metric: string;
};

const SOCIAL_IMPACTS: SocialImpact[] = [
	{
		title: m.about_social_carbon_title(),
		icon: SparklesIcon,
		description: m.about_social_carbon_desc(),
		metric: m.about_social_carbon_metric(),
	},
	{
		title: m.about_social_welfare_title(),
		icon: HeartIcon,
		description: m.about_social_welfare_desc(),
		metric: m.about_social_welfare_metric(),
	},
	{
		title: m.about_social_economy_title(),
		icon: TrendingUpIcon,
		description: m.about_social_economy_desc(),
		metric: m.about_social_economy_metric(),
	},
];

// ==================== MAIN COMPONENT ====================

function AboutComponent() {
	return (
		<div className="min-h-screen">
			<PublicHeader className="fixed top-0 right-0 left-0 z-50 mx-auto mt-2 w-full max-w-3xl rounded-xl border p-4" />

			{/* Hero Section */}
			<HeroSection />

			{/* Story Section */}
			<StorySection />

			{/* Mission & Vision Section */}
			<MissionVisionSection />

			{/* Core Values Section */}
			<CoreValuesSection />

			{/* Impact Stats Section */}
			<ImpactStatsSection />

			{/* Feature Segments Section */}
			<FeatureSegmentsSection />

			{/* Team Section */}
			<TeamSection />

			{/* Partnerships Section */}
			<PartnershipsSection />

			{/* Social Impact Section */}
			<SocialImpactSection />

			{/* CTA Section */}
			<CTASection />

			<LandingFooter />
		</div>
	);
}

// ==================== SECTION COMPONENTS ====================

function HeroSection() {
	const ref = useRef<HTMLElement>(null);

	return (
		<section
			ref={ref}
			className="relative flex min-h-[60vh] w-full items-center justify-center overflow-hidden bg-linear-to-br from-primary/20 via-background to-secondary/30 px-4 py-20 sm:px-6 md:px-8 md:py-24 lg:px-16"
		>
			<div className="mx-auto w-full max-w-5xl text-center">
				<motion.div
					initial={{ opacity: 0, scale: 0.9 }}
					animate={{ opacity: 1, scale: 1 }}
					transition={{ duration: 0.8 }}
				>
					<motion.h1
						className="font-bold text-4xl leading-tight sm:text-5xl md:text-6xl lg:text-7xl"
						initial={{ opacity: 0, y: 30 }}
						animate={{ opacity: 1, y: 0 }}
						transition={{ duration: 0.6, delay: 0.2 }}
					>
						{m.about_page_title()}
					</motion.h1>
					<motion.p
						className="mx-auto mt-6 max-w-3xl text-lg text-muted-foreground sm:text-xl md:text-2xl"
						initial={{ opacity: 0, y: 20 }}
						animate={{ opacity: 1, y: 0 }}
						transition={{ duration: 0.6, delay: 0.4 }}
					>
						{m.about_page_subtitle()}
					</motion.p>
				</motion.div>
			</div>
		</section>
	);
}

function StorySection() {
	const ref = useRef<HTMLDivElement>(null);
	const isInView = useInView(ref, { once: true, margin: "-100px" });

	return (
		<section className="mx-auto w-full max-w-7xl px-4 py-12 sm:px-6 sm:py-16 md:px-8 md:py-20 lg:px-16 lg:py-24">
			<AnimatedTitle ref={ref}>{m.about_story_title()}</AnimatedTitle>

			<motion.div
				initial={{ opacity: 0, y: 50 }}
				animate={isInView ? { opacity: 1, y: 0 } : {}}
				transition={{ duration: 0.8, delay: 0.2 }}
				className="mt-8 space-y-6 text-center text-base text-muted-foreground md:text-lg lg:text-xl"
			>
				<p>{m.about_story_p1()}</p>
				<p>{m.about_story_p2()}</p>
				<p>{m.about_story_p3()}</p>
			</motion.div>
		</section>
	);
}

function MissionVisionSection() {
	const ref = useRef<HTMLDivElement>(null);
	const isInView = useInView(ref, { once: true, margin: "-100px" });

	return (
		<section className="bg-secondary/30">
			<div className="mx-auto w-full max-w-7xl px-4 py-12 sm:px-6 sm:py-16 md:px-8 md:py-20 lg:px-16 lg:py-24">
				<AnimatedTitle ref={ref}>
					{m.about_mission_vision_title()}
				</AnimatedTitle>

				<div className="mt-8 grid grid-cols-1 gap-8 md:grid-cols-2">
					{/* Mission Card */}
					<motion.div
						initial={{ opacity: 0, x: -50 }}
						animate={isInView ? { opacity: 1, x: 0 } : {}}
						transition={{ duration: 0.6, delay: 0.2 }}
						whileHover={{ y: -10 }}
						className="flex flex-col gap-4 rounded-xl border-2 border-primary/30 bg-primary/20 p-6 md:p-8"
					>
						<div className="flex items-center gap-3">
							<div className="rounded-full bg-primary/30 p-3">
								<TargetIcon className="size-6 text-primary md:size-8" />
							</div>
							<h3 className="font-semibold text-2xl md:text-3xl">
								{m.about_mission_title()}
							</h3>
						</div>
						<p className="text-base text-muted-foreground leading-relaxed md:text-lg">
							{m.about_mission_text()}
						</p>
					</motion.div>

					{/* Vision Card */}
					<motion.div
						initial={{ opacity: 0, x: 50 }}
						animate={isInView ? { opacity: 1, x: 0 } : {}}
						transition={{ duration: 0.6, delay: 0.4 }}
						whileHover={{ y: -10 }}
						className="flex flex-col gap-4 rounded-xl border-2 border-primary/30 bg-primary/20 p-6 md:p-8"
					>
						<div className="flex items-center gap-3">
							<div className="rounded-full bg-primary/30 p-3">
								<SparklesIcon className="size-6 text-primary md:size-8" />
							</div>
							<h3 className="font-semibold text-2xl md:text-3xl">
								{m.about_vision_title()}
							</h3>
						</div>
						<p className="text-base text-muted-foreground leading-relaxed md:text-lg">
							{m.about_vision_text()}
						</p>
					</motion.div>
				</div>
			</div>
		</section>
	);
}

function CoreValuesSection() {
	const ref = useRef<HTMLDivElement>(null);
	const isInView = useInView(ref, { once: true, margin: "-100px" });

	return (
		<section className="mx-auto w-full max-w-7xl px-4 py-12 sm:px-6 sm:py-16 md:px-8 md:py-20 lg:px-16 lg:py-24">
			<AnimatedTitle ref={ref}>{m.about_values_title()}</AnimatedTitle>

			<div className="mt-8 grid grid-cols-1 gap-6 md:grid-cols-2 lg:grid-cols-3 lg:gap-8">
				{CORE_VALUES.map((value, index) => (
					<ValueCard
						key={value.title}
						index={index}
						isInView={isInView}
						{...value}
					/>
				))}
			</div>
		</section>
	);
}

function ImpactStatsSection() {
	const ref = useRef<HTMLDivElement>(null);
	const isInView = useInView(ref, { once: true, margin: "-100px" });

	return (
		<section className="bg-secondary/30">
			<div className="mx-auto w-full max-w-7xl px-4 py-12 sm:px-6 sm:py-16 md:px-8 md:py-20 lg:px-16 lg:py-24">
				<AnimatedTitle ref={ref}>{m.about_impact_title()}</AnimatedTitle>

				<div className="mt-8 grid grid-cols-1 gap-6 sm:grid-cols-2 lg:grid-cols-4 lg:gap-8">
					{IMPACT_STATS.map((stat, index) => (
						<ImpactStatCard
							key={stat.label}
							index={index}
							isInView={isInView}
							{...stat}
						/>
					))}
				</div>
			</div>
		</section>
	);
}

function FeatureSegmentsSection() {
	const ref = useRef<HTMLDivElement>(null);
	const isInView = useInView(ref, { once: true, margin: "-100px" });

	return (
		<section className="mx-auto w-full max-w-7xl px-4 py-12 sm:px-6 sm:py-16 md:px-8 md:py-20 lg:px-16 lg:py-24">
			<AnimatedTitle ref={ref}>{m.about_benefits_title()}</AnimatedTitle>

			<div className="mt-8 grid grid-cols-1 gap-8 lg:grid-cols-3">
				{FEATURE_SEGMENTS.map((segment, index) => (
					<FeatureSegmentCard
						key={segment.title}
						index={index}
						isInView={isInView}
						{...segment}
					/>
				))}
			</div>
		</section>
	);
}

function TeamSection() {
	const ref = useRef<HTMLDivElement>(null);
	const isInView = useInView(ref, { once: true, margin: "-100px" });

	return (
		<section className="bg-secondary/30">
			<div className="mx-auto w-full max-w-7xl px-4 py-12 sm:px-6 sm:py-16 md:px-8 md:py-20 lg:px-16 lg:py-24">
				<AnimatedTitle ref={ref}>{m.about_team_title()}</AnimatedTitle>
				<motion.p
					initial={{ opacity: 0 }}
					animate={isInView ? { opacity: 1 } : {}}
					transition={{ duration: 0.6, delay: 0.2 }}
					className="mx-auto mt-4 max-w-3xl text-center text-base text-muted-foreground md:text-lg"
				>
					{m.about_team_subtitle()}
				</motion.p>

				<div className="mt-8 grid grid-cols-1 gap-8 md:grid-cols-2 lg:grid-cols-4">
					{TEAM_MEMBERS.map((member, index) => (
						<TeamMemberCard
							key={member.name}
							index={index}
							isInView={isInView}
							{...member}
						/>
					))}
				</div>
			</div>
		</section>
	);
}

function PartnershipsSection() {
	const ref = useRef<HTMLDivElement>(null);
	const isInView = useInView(ref, { once: true, margin: "-100px" });

	return (
		<section className="mx-auto w-full max-w-7xl px-4 py-12 sm:px-6 sm:py-16 md:px-8 md:py-20 lg:px-16 lg:py-24">
			<AnimatedTitle ref={ref}>{m.about_partnerships_title()}</AnimatedTitle>
			<motion.p
				initial={{ opacity: 0 }}
				animate={isInView ? { opacity: 1 } : {}}
				transition={{ duration: 0.6, delay: 0.2 }}
				className="mx-auto mt-4 max-w-3xl text-center text-base text-muted-foreground md:text-lg"
			>
				{m.about_partnerships_subtitle()}
			</motion.p>

			<div className="mt-8 grid grid-cols-1 gap-6 md:grid-cols-2 lg:grid-cols-3 lg:gap-8">
				{PARTNERSHIPS.map((partner, index) => (
					<PartnershipCard
						key={partner.name}
						index={index}
						isInView={isInView}
						{...partner}
					/>
				))}
			</div>
		</section>
	);
}

function SocialImpactSection() {
	const ref = useRef<HTMLDivElement>(null);
	const isInView = useInView(ref, { once: true, margin: "-100px" });

	return (
		<section className="bg-secondary/30">
			<div className="mx-auto w-full max-w-7xl px-4 py-12 sm:px-6 sm:py-16 md:px-8 md:py-20 lg:px-16 lg:py-24">
				<AnimatedTitle ref={ref}>{m.about_social_title()}</AnimatedTitle>
				<motion.p
					initial={{ opacity: 0 }}
					animate={isInView ? { opacity: 1 } : {}}
					transition={{ duration: 0.6, delay: 0.2 }}
					className="mx-auto mt-4 max-w-3xl text-center text-base text-muted-foreground md:text-lg"
				>
					{m.about_social_subtitle()}
				</motion.p>

				<div className="mt-8 grid grid-cols-1 gap-8 lg:grid-cols-3">
					{SOCIAL_IMPACTS.map((impact, index) => (
						<SocialImpactCard
							key={impact.title}
							index={index}
							isInView={isInView}
							{...impact}
						/>
					))}
				</div>
			</div>
		</section>
	);
}

function CTASection() {
	const ref = useRef<HTMLDivElement>(null);
	const isInView = useInView(ref, { once: true, margin: "-100px" });

	return (
		<section className="mx-auto w-full max-w-7xl px-4 py-12 sm:px-6 sm:py-16 md:px-8 md:py-20 lg:px-16 lg:py-24">
			<motion.div
				ref={ref}
				initial={{ opacity: 0, y: 50 }}
				animate={isInView ? { opacity: 1, y: 0 } : {}}
				transition={{ duration: 0.8 }}
				className="flex flex-col items-center gap-6 text-center"
			>
				<motion.h2
					initial={{ opacity: 0, scale: 0.9 }}
					animate={isInView ? { opacity: 1, scale: 1 } : {}}
					transition={{ duration: 0.6, delay: 0.2 }}
					className="font-semibold text-xl sm:text-2xl md:text-3xl lg:text-4xl"
				>
					{m.about_cta_title()}
				</motion.h2>
				<motion.p
					initial={{ opacity: 0 }}
					animate={isInView ? { opacity: 1 } : {}}
					transition={{ duration: 0.6, delay: 0.4 }}
					className="max-w-2xl text-base text-muted-foreground md:text-lg"
				>
					{m.about_cta_subtitle()}
				</motion.p>
				<motion.div
					initial={{ opacity: 0, y: 20 }}
					animate={isInView ? { opacity: 1, y: 0 } : {}}
					transition={{ duration: 0.6, delay: 0.6 }}
					className="flex flex-col gap-4 sm:flex-row"
				>
					<SignUpDialog asChild>
						<Button className="bg-primary p-6 text-lg text-primary-foreground transition-transform hover:scale-105 sm:text-xl">
							{m.about_cta_button()}
						</Button>
					</SignUpDialog>
					<Button
						variant="outline"
						className="p-6 text-lg transition-transform hover:scale-105 sm:text-xl"
						asChild
					>
						<a href="/contact">
							<MailIcon className="mr-2 size-5" />
							{m.about_cta_contact()}
						</a>
					</Button>
				</motion.div>
			</motion.div>
		</section>
	);
}

// ==================== CARD COMPONENTS ====================

function ValueCard({
	title,
	icon: Icon,
	description,
	index,
	isInView,
}: CoreValue & { index: number; isInView: boolean }) {
	return (
		<motion.div
			initial={{ opacity: 0, y: 50 }}
			animate={isInView ? { opacity: 1, y: 0 } : {}}
			transition={{ duration: 0.5, delay: index * 0.1 }}
			whileHover={{ y: -10, scale: 1.02 }}
			className="flex flex-col gap-4 rounded-xl border-2 border-primary/30 bg-primary/20 p-6 md:p-8"
		>
			<div className="flex items-center gap-3">
				<div className="rounded-full bg-primary/30 p-3">
					<Icon className="size-6 text-primary md:size-8" />
				</div>
			</div>
			<h3 className="font-semibold text-lg md:text-xl">{title}</h3>
			<p className="text-muted-foreground text-sm leading-relaxed md:text-base">
				{description}
			</p>
		</motion.div>
	);
}

function ImpactStatCard({
	value,
	label,
	icon: Icon,
	index,
	isInView,
}: ImpactStat & { index: number; isInView: boolean }) {
	return (
		<motion.div
			initial={{ opacity: 0, scale: 0.8 }}
			animate={isInView ? { opacity: 1, scale: 1 } : {}}
			transition={{ duration: 0.5, delay: index * 0.1 }}
			whileHover={{ scale: 1.08 }}
			className="flex flex-col items-center gap-4 rounded-xl border-2 border-primary/30 bg-primary/20 p-6 md:p-8"
		>
			<motion.div
				initial={{ scale: 0, rotate: -180 }}
				animate={isInView ? { scale: 1, rotate: 0 } : {}}
				transition={{ duration: 0.6, delay: index * 0.1 + 0.2, type: "spring" }}
				className="rounded-full bg-primary/30 p-4"
			>
				<Icon className="size-8 text-primary md:size-10" />
			</motion.div>
			<motion.p
				initial={{ opacity: 0, scale: 0.5 }}
				animate={isInView ? { opacity: 1, scale: 1 } : {}}
				transition={{ duration: 0.6, delay: index * 0.1 + 0.3, type: "spring" }}
				className="font-bold text-3xl text-primary md:text-4xl lg:text-5xl"
			>
				{value}
			</motion.p>
			<p className="text-center text-muted-foreground text-sm md:text-base">
				{label}
			</p>
		</motion.div>
	);
}

function FeatureSegmentCard({
	title,
	icon: Icon,
	features,
	index,
	isInView,
}: FeatureSegment & { index: number; isInView: boolean }) {
	return (
		<motion.div
			initial={{ opacity: 0, y: 50 }}
			animate={isInView ? { opacity: 1, y: 0 } : {}}
			transition={{ duration: 0.5, delay: index * 0.15 }}
			whileHover={{ y: -10 }}
			className="flex flex-col gap-4 rounded-xl border-2 border-primary/30 bg-primary/20 p-6 md:p-8"
		>
			<div className="flex items-center gap-3">
				<div className="rounded-full bg-primary/30 p-3">
					<Icon className="size-6 text-primary md:size-8" />
				</div>
				<h3 className="font-semibold text-xl md:text-2xl">{title}</h3>
			</div>
			<ul className="space-y-3">
				{features.map((feature, idx) => (
					<motion.li
						key={feature}
						initial={{ opacity: 0, x: -20 }}
						animate={isInView ? { opacity: 1, x: 0 } : {}}
						transition={{ duration: 0.4, delay: index * 0.15 + idx * 0.05 }}
						className="flex items-start gap-2 text-muted-foreground text-sm md:text-base"
					>
						<span className="mt-1 size-1.5 shrink-0 rounded-full bg-primary" />
						<span>{feature}</span>
					</motion.li>
				))}
			</ul>
		</motion.div>
	);
}

function TeamMemberCard({
	name,
	role,
	bio,
	avatar,
	index,
	isInView,
}: TeamMember & { index: number; isInView: boolean }) {
	return (
		<motion.div
			initial={{ opacity: 0, scale: 0.9 }}
			animate={isInView ? { opacity: 1, scale: 1 } : {}}
			transition={{ duration: 0.5, delay: index * 0.1 }}
			whileHover={{ y: -10, scale: 1.02 }}
			className="flex flex-col items-center gap-4 rounded-xl border-2 border-primary/30 bg-primary/20 p-6 text-center"
		>
			<motion.img
				initial={{ scale: 0 }}
				animate={isInView ? { scale: 1 } : {}}
				transition={{
					duration: 0.5,
					delay: index * 0.1 + 0.2,
					type: "spring",
					bounce: 0.5,
				}}
				src={avatar}
				alt={name}
				className="size-24 rounded-full bg-secondary md:size-28"
			/>
			<div>
				<h4 className="font-semibold text-lg md:text-xl">{name}</h4>
				<p className="mt-1 text-primary text-sm md:text-base">{role}</p>
			</div>
			<p className="text-muted-foreground text-sm leading-relaxed md:text-base">
				{bio}
			</p>
		</motion.div>
	);
}

function PartnershipCard({
	name,
	location,
	description,
	index,
	isInView,
}: Partnership & { index: number; isInView: boolean }) {
	return (
		<motion.div
			initial={{ opacity: 0, y: 50 }}
			animate={isInView ? { opacity: 1, y: 0 } : {}}
			transition={{ duration: 0.5, delay: index * 0.1 }}
			whileHover={{ y: -10, scale: 1.02 }}
			className="flex flex-col gap-4 rounded-xl border-2 border-primary/30 bg-primary/20 p-6 md:p-8"
		>
			<div className="flex items-center gap-3">
				<div className="rounded-full bg-primary/30 p-3">
					<GraduationCapIcon className="size-6 text-primary md:size-8" />
				</div>
			</div>
			<h4 className="font-semibold text-lg md:text-xl">{name}</h4>
			<p className="text-primary text-sm md:text-base">{location}</p>
			<p className="text-muted-foreground text-sm leading-relaxed md:text-base">
				{description}
			</p>
		</motion.div>
	);
}

function SocialImpactCard({
	title,
	icon: Icon,
	description,
	metric,
	index,
	isInView,
}: SocialImpact & { index: number; isInView: boolean }) {
	return (
		<motion.div
			initial={{ opacity: 0, y: 50 }}
			animate={isInView ? { opacity: 1, y: 0 } : {}}
			transition={{ duration: 0.5, delay: index * 0.15 }}
			whileHover={{ y: -10, scale: 1.02 }}
			className="flex flex-col gap-4 rounded-xl border-2 border-primary/30 bg-primary/20 p-6 md:p-8"
		>
			<div className="flex items-center gap-3">
				<div className="rounded-full bg-primary/30 p-3">
					<Icon className="size-6 text-primary md:size-8" />
				</div>
				<h4 className="font-semibold text-lg md:text-xl">{title}</h4>
			</div>
			<p className="text-muted-foreground text-sm leading-relaxed md:text-base">
				{description}
			</p>
			<div className="mt-2 rounded-lg bg-primary/30 p-3">
				<p className="font-semibold text-primary text-sm md:text-base">
					{metric}
				</p>
			</div>
		</motion.div>
	);
}

// ==================== UTILITY COMPONENTS ====================

function AnimatedTitle({
	ref,
	children,
}: {
	ref: React.RefObject<HTMLDivElement | null>;
	children: React.ReactNode;
}) {
	const isInView = useInView(ref, { once: true, margin: "-100px" });

	return (
		<motion.h2
			ref={ref}
			initial={{ opacity: 0, y: 30 }}
			animate={isInView ? { opacity: 1, y: 0 } : {}}
			transition={{ duration: 0.6 }}
			className="text-center font-semibold text-2xl sm:text-3xl md:text-4xl lg:text-5xl"
		>
			{children}
		</motion.h2>
	);
}
