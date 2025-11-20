/** biome-ignore-all lint/suspicious/noArrayIndexKey: since data is static i didnt provide array index as key */
import { createFileRoute } from "@tanstack/react-router";
import { motion, useInView, useScroll, useTransform } from "framer-motion";
import {
	BadgeCentIcon,
	BlocksIcon,
	type LucideIcon,
	PhoneIcon,
	VerifiedIcon,
} from "lucide-react";
import type React from "react";
import { useRef } from "react";
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
import { Button } from "@/components/ui/button";
import { cn } from "@/utils/cn";

export const Route = createFileRoute("/")({
	component: HomeComponent,
});

type Trouble = {
	desc: string;
	imageUrl: string;
};

const TROUBLES: Trouble[] = [
	{
		desc: "Jalan kaki jauh antar fakultas.",
		imageUrl: char1,
	},
	{
		desc: "Susah cari driver aman di sekitar kampus.",
		imageUrl: char2,
	},
	{
		desc: "Pesanan makanan antri lama di kantin.",
		imageUrl: char3,
	},
	{
		desc: "Kurir eksternal sering mahal & telat.",
		imageUrl: char4,
	},
];

type Solution = {
	desc: string;
	color: string;
	icon: LucideIcon;
};

const SOLUTIONS: Solution[] = [
	{
		desc: "Driver mahasiswa terverifikasi, Bisa pilih gender",
		color: "blue",
		icon: VerifiedIcon,
	},
	{
		desc: "Pesan makanan & barang langsung via aplikasi",
		color: "green",
		icon: PhoneIcon,
	},
	{
		desc: "Tarif lebih transparan & lebih hemat",
		color: "yellow",
		icon: BadgeCentIcon,
	},
	{
		desc: "Integrasi jadwal kuliah untuk driver lebih fleksibel.",
		color: "red",
		icon: BlocksIcon,
	},
];

type Feature = {
	title: string;
	desc: string;
	icon: string;
};

const FEATURES: Feature[] = [
	{
		title: "Tranportasi Kampus",
		desc: "Antar jemput fleksibel, driver mahasiswa, tarif per km transparan.",
		icon: "🚗",
	},
	{
		title: "Food & Goods Delivery",
		desc: "Pesan makanan, laundry, dokumen, atau paket dengan sekali klik.",
		icon: "🍔",
	},
	{
		title: "Keamanan & Privasi",
		desc: "Filter gender, tombol darurat, chat tanpa nomor telepon.",
		icon: "🛡",
	},
];

const STATS = [
	{
		title: "2000+",
		desc: "Perjalanan dalam 1 minggu pertama",
	},
	{
		title: "95%",
		desc: "Pengguna puas dengan layanan",
	},
	{
		title: "100+",
		desc: "Merchant kampus sudah bergabung",
	},
];

const TESTIMONIALS = [
	{
		quote:
			"Lebih aman karena driver juga mahasiswa. Saya bisa pilih driver perempuan.",
		by: "Rani, Mahasiswi",
	},
	{
		quote:
			"Lumayan banget buat tambahan uang jajan, jadwal kuliah tetap bisa diatur.",
		by: "Bima, Driver",
	},
	{
		quote:
			"Warung saya lebih rame, karena anak-anak dapat memesan online lewat aplikasi.",
		by: "Bu Sari, Merchant",
	},
];

function HomeComponent() {
	const heroRef = useRef(null);
	const { scrollYProgress } = useScroll({
		target: heroRef,
		offset: ["start start", "end start"],
	});

	const y1 = useTransform(scrollYProgress, [0, 1], [0, 200]);
	const y2 = useTransform(scrollYProgress, [0, 1], [0, -100]);
	const opacity = useTransform(scrollYProgress, [0, 0.5], [1, 0]);

	return (
		<div className="h-full">
			<PublicHeader className="fixed top-0 right-0 left-0 z-50 mx-auto mt-2 w-full max-w-3xl rounded-xl border p-4" />

			{/* Hero Section */}
			<section
				ref={heroRef}
				className="relative flex min-h-svh w-full items-center justify-center overflow-hidden bg-landing-section-1 px-4 py-20 sm:px-6 md:px-8 md:py-24 lg:px-16"
			>
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
					/>
				</motion.div>

				{/* Accessories 1 - top center */}
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
					/>
				</motion.div>

				{/* Accessories 2 - top left area */}
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
					/>
				</motion.div>

				{/* Accessories 3 - bottom center */}
				<motion.div
					style={{ opacity }}
					className="-translate-x-1/2 absolute bottom-0 left-1/2 z-0"
				>
					<img
						src={accessories3}
						alt="acc-3"
						className="w-full max-w-xs sm:max-w-sm md:max-w-md lg:max-w-2xl xl:max-w-[1080px]"
					/>
				</motion.div>

				{/* Accessories 4 - right side */}
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
						<motion.h1
							initial={{ opacity: 0, y: 20 }}
							animate={{ opacity: 1, y: 0 }}
							transition={{ duration: 0.6, delay: 0.7 }}
							className="font-bold text-2xl leading-tight sm:text-3xl md:text-4xl lg:text-5xl xl:text-6xl"
						>
							Mobilitas & Delivery Khusus Kampus
						</motion.h1>
						<motion.p
							initial={{ opacity: 0, y: 20 }}
							animate={{ opacity: 1, y: 0 }}
							transition={{ duration: 0.6, delay: 0.8 }}
							className="text-muted-foreground text-sm sm:text-base md:text-lg lg:text-xl"
						>
							Dari mahasiswa untuk mahasiswa: transportasi, pesan makanan, dan
							antar paket jadi lebih mudah, aman, dan nyaman.
						</motion.p>
						<motion.div
							initial={{ opacity: 0, scale: 0.9 }}
							animate={{ opacity: 1, scale: 1 }}
							transition={{ duration: 0.5, delay: 0.9 }}
						>
							<SignUpDialog asChild>
								<Button className="mx-auto mt-2 w-full max-w-xs bg-white p-6 text-black text-lg transition-transform hover:scale-105 sm:max-w-sm md:text-xl lg:mx-0 lg:max-w-xs">
									Get started
								</Button>
							</SignUpDialog>
						</motion.div>
					</motion.div>

					{/* Spacer (only on large screens) */}
					<div className="hidden lg:block lg:w-8 xl:w-16" />

					{/* Mobile showcase */}
					<motion.div
						initial={{ opacity: 0, x: 50 }}
						animate={{ opacity: 1, x: 0 }}
						transition={{ duration: 0.8, delay: 1 }}
						className="z-10 w-full max-w-xs sm:max-w-sm md:max-w-md lg:max-w-lg xl:max-w-xl"
					>
						<motion.img
							animate={{ y: [0, -10, 0] }}
							transition={{
								duration: 3,
								repeat: Number.POSITIVE_INFINITY,
								ease: "easeInOut",
							}}
							src={mobileShowcaseUrl}
							alt="Mobile showcase"
							className="w-full"
						/>
					</motion.div>
				</div>
			</section>

			{/* Troubles & Solutions Section */}
			<section className="mx-auto w-full max-w-7xl px-4 py-12 sm:px-6 sm:py-16 md:px-8 md:py-20 lg:px-16 lg:py-24">
				<AnimatedTitle>Masalah Sehari-hari Mahasiswa</AnimatedTitle>
				<div className="mt-8 grid grid-cols-1 gap-4 sm:grid-cols-2 sm:gap-6 lg:grid-cols-4 lg:gap-8">
					{TROUBLES.map((trouble, index) => (
						<TroubleCard key={index} index={index} {...trouble} />
					))}
				</div>
				<AnimatedTitle delay={0.2}>Solusi dari AkadeMove</AnimatedTitle>
				<div className="mt-8 grid grid-cols-1 gap-4 sm:grid-cols-2 sm:gap-6 lg:grid-cols-4 lg:gap-8">
					{SOLUTIONS.map((solution, index) => (
						<SolutionCard key={index} index={index} {...solution} />
					))}
				</div>
			</section>

			{/* Features Section */}
			<section className="bg-secondary/30">
				<div className="mx-auto w-full max-w-7xl px-4 py-12 sm:px-6 sm:py-16 md:px-8 md:py-20 lg:px-16 lg:py-24">
					<AnimatedTitle>Fitur Unggulan</AnimatedTitle>
					<div className="mt-8 grid grid-cols-1 gap-6 md:grid-cols-2 lg:grid-cols-3 lg:gap-8">
						{FEATURES.map((feature, index) => (
							<FeatureCard key={index} index={index} {...feature} />
						))}
					</div>
				</div>
			</section>

			{/* Stats Section */}
			<section className="mx-auto w-full max-w-7xl px-4 py-12 sm:px-6 sm:py-16 md:px-8 md:py-20 lg:px-16 lg:py-24">
				<AnimatedTitle>Dampak Nyata</AnimatedTitle>
				<div className="mt-8 grid grid-cols-1 gap-6 sm:grid-cols-3 sm:gap-8">
					{STATS.map((stat, index) => (
						<StatCard key={index} index={index} {...stat} />
					))}
				</div>
			</section>

			{/* Testimonials Section */}
			<section className="bg-secondary/30">
				<div className="mx-auto w-full max-w-7xl px-4 py-12 sm:px-6 sm:py-16 md:px-8 md:py-20 lg:px-16 lg:py-24">
					<AnimatedTitle>Kata Mereka</AnimatedTitle>
					<div className="mt-8 grid grid-cols-1 gap-6 md:grid-cols-2 lg:grid-cols-3 lg:gap-8">
						{TESTIMONIALS.map((testimonial, index) => (
							<TestimonialCard key={index} index={index} {...testimonial} />
						))}
					</div>
				</div>
			</section>

			{/* CTA Section */}
			<section className="mx-auto w-full max-w-7xl px-4 py-12 sm:px-6 sm:py-16 md:px-8 md:py-20 lg:px-16 lg:py-24">
				<AnimatedCTA />
			</section>
			<LandingFooter />
		</div>
	);
}

function AnimatedTitle({
	children,
	delay = 0,
}: {
	children: React.ReactNode;
	delay?: number;
}) {
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
}

function TroubleCard({ index, ...item }: Trouble & { index: number }) {
	const ref = useRef(null);
	const isInView = useInView(ref, { once: true, margin: "-50px" });

	return (
		<motion.div
			ref={ref}
			initial={{ opacity: 0, y: 50 }}
			animate={isInView ? { opacity: 1, y: 0 } : {}}
			transition={{ duration: 0.5, delay: index * 0.1 }}
			whileHover={{ scale: 1.05, y: -5 }}
			className="flex flex-col items-center gap-3 rounded-lg border-2 border-primary/30 bg-primary/20 p-4 sm:p-5 md:p-6"
		>
			<motion.img
				initial={{ scale: 0.8, opacity: 0 }}
				animate={isInView ? { scale: 1, opacity: 1 } : {}}
				transition={{ duration: 0.5, delay: index * 0.1 + 0.2 }}
				src={item.imageUrl}
				alt={item.desc}
				className="h-20 w-auto sm:h-24 md:h-28 lg:h-32"
			/>
			<p className="text-center font-medium text-sm sm:text-base md:text-lg">
				{item.desc}
			</p>
		</motion.div>
	);
}

function SolutionCard({ index, ...item }: Solution & { index: number }) {
	const ref = useRef(null);
	const isInView = useInView(ref, { once: true, margin: "-50px" });

	return (
		<motion.div
			ref={ref}
			initial={{ opacity: 0, scale: 0.9 }}
			animate={isInView ? { opacity: 1, scale: 1 } : {}}
			transition={{ duration: 0.5, delay: index * 0.1 }}
			whileHover={{ scale: 1.05, rotate: 1 }}
			className="flex flex-col items-center gap-4 rounded-lg border-2 border-primary/30 bg-primary/20 p-4 sm:p-5 md:p-6 lg:p-8"
		>
			<motion.div
				initial={{ scale: 0, rotate: -180 }}
				animate={isInView ? { scale: 1, rotate: 0 } : {}}
				transition={{ duration: 0.6, delay: index * 0.1 + 0.2, type: "spring" }}
				className={cn(
					"rounded-xl border-2 p-3 sm:p-4",
					`bg-${item.color}-500/20 border-${item.color}-500/30`,
				)}
			>
				<item.icon
					className={cn(
						"size-6 sm:size-7 md:size-8 lg:size-10",
						`text-${item.color}-500`,
					)}
				/>
			</motion.div>
			<p className="text-center font-medium text-sm sm:text-base md:text-lg">
				{item.desc}
			</p>
		</motion.div>
	);
}

function FeatureCard({ index, ...item }: Feature & { index: number }) {
	const ref = useRef(null);
	const isInView = useInView(ref, { once: true, margin: "-50px" });

	return (
		<motion.div
			ref={ref}
			initial={{ opacity: 0, y: 50 }}
			animate={isInView ? { opacity: 1, y: 0 } : {}}
			transition={{ duration: 0.5, delay: index * 0.15 }}
			whileHover={{ y: -10, transition: { duration: 0.2 } }}
			className="flex flex-col items-center gap-3 rounded-lg border-2 border-primary/30 bg-primary/20 p-4 sm:p-5 md:p-6 lg:p-8"
		>
			<motion.p
				initial={{ scale: 0 }}
				animate={isInView ? { scale: 1 } : {}}
				transition={{
					duration: 0.5,
					delay: index * 0.15 + 0.2,
					type: "spring",
					bounce: 0.5,
				}}
				className="text-3xl sm:text-4xl md:text-5xl"
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
}

function StatCard({
	index,
	...item
}: {
	title: string;
	desc: string;
	index: number;
}) {
	const ref = useRef(null);
	const isInView = useInView(ref, { once: true, margin: "-50px" });

	return (
		<motion.div
			ref={ref}
			initial={{ opacity: 0, scale: 0.8 }}
			animate={isInView ? { opacity: 1, scale: 1 } : {}}
			transition={{ duration: 0.5, delay: index * 0.1 }}
			whileHover={{ scale: 1.08 }}
			className="flex flex-col items-center gap-2 rounded-lg border-2 border-primary/30 bg-primary/20 p-4 sm:p-5 md:p-6 lg:p-8"
		>
			<motion.p
				initial={{ opacity: 0, scale: 0.5 }}
				animate={isInView ? { opacity: 1, scale: 1 } : {}}
				transition={{ duration: 0.6, delay: index * 0.1 + 0.3, type: "spring" }}
				className="font-bold text-3xl text-primary sm:text-4xl md:text-5xl"
			>
				{item.title}
			</motion.p>
			<p className="text-center text-muted-foreground text-sm sm:text-base md:text-lg">
				{item.desc}
			</p>
		</motion.div>
	);
}

function TestimonialCard({
	index,
	...item
}: {
	quote: string;
	by: string;
	index: number;
}) {
	const ref = useRef(null);
	const isInView = useInView(ref, { once: true, margin: "-50px" });

	return (
		<motion.div
			ref={ref}
			initial={{ opacity: 0, x: index % 2 === 0 ? -50 : 50 }}
			animate={isInView ? { opacity: 1, x: 0 } : {}}
			transition={{ duration: 0.6, delay: index * 0.1 }}
			whileHover={{ scale: 1.03, boxShadow: "0 10px 30px rgba(0,0,0,0.1)" }}
			className="flex flex-col gap-3 rounded-lg border-2 border-primary/30 bg-primary/20 p-4 sm:p-5 md:p-6 lg:p-8"
		>
			<p className="text-sm italic sm:text-base md:text-lg">"{item.quote}"</p>
			<p className="font-medium text-primary text-sm sm:text-base md:text-lg">
				— {item.by}
			</p>
		</motion.div>
	);
}

function AnimatedCTA() {
	const ref = useRef(null);
	const isInView = useInView(ref, { once: true, margin: "-100px" });

	return (
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
				Siap untuk Pengalaman Kampus yang Lebih Baik?
			</motion.h2>
			<motion.p
				initial={{ opacity: 0 }}
				animate={isInView ? { opacity: 1 } : {}}
				transition={{ duration: 0.6, delay: 0.4 }}
				className="max-w-2xl text-muted-foreground text-sm sm:text-base md:text-lg"
			>
				Bergabunglah dengan ribuan mahasiswa yang sudah merasakan kemudahan
				mobilitas dan delivery di kampus.
			</motion.p>
			<motion.div
				initial={{ opacity: 0, y: 20 }}
				animate={isInView ? { opacity: 1, y: 0 } : {}}
				transition={{ duration: 0.6, delay: 0.6 }}
			>
				<SignUpDialog asChild>
					<Button className="bg-primary p-6 text-lg text-primary-foreground transition-transform hover:scale-105 sm:text-xl">
						Daftar Sekarang
					</Button>
				</SignUpDialog>
			</motion.div>
		</motion.div>
	);
}
