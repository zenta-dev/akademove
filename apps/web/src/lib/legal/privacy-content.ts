/**
 * Privacy Policy Content
 *
 * This file contains all content for the Privacy Policy page.
 * Indonesian translations can be added to the `id` property of each content object.
 */

import type { LegalSectionContent } from "../legal-i18n";
import { getLegalContent } from "../legal-i18n";

export const privacyIntro = () =>
	getLegalContent({
		en: [
			"At AkadeMove, we are committed to protecting your privacy and ensuring the security of your personal information. This Privacy Policy explains how we collect, use, disclose, and safeguard your data when you use our platform and services.",
			"This policy complies with Indonesian data protection regulations, including Undang-Undang Nomor 27 Tahun 2022 tentang Pelindungan Data Pribadi (UU PDP 27/2022) and related regulations. By using our services, you consent to the data practices described in this policy.",
		],
		id: undefined, // Indonesian translation to be added
	});

export const informationWeCollect = (): LegalSectionContent =>
	getLegalContent({
		en: {
			title: "Information We Collect",
			paragraphs: [
				"We collect various types of information to provide and improve our services:",
			],
			lists: [
				{
					title: "Personal Information",
					items: [
						{
							label: "Account Information",
							content:
								"Name, email address, phone number, date of birth, and profile picture",
						},
						{
							label: "Identity Verification",
							content:
								"For drivers: ID card (KTP), driver's license (SIM), vehicle registration (STNK)",
						},
						{
							label: "Payment Information",
							content:
								"Bank account details, payment card information, transaction history",
						},
						{
							label: "Location Data",
							content:
								"Real-time GPS location, pickup and drop-off addresses, route information",
						},
					],
				},
				{
					title: "Usage Information",
					items: [
						{
							label: "Device Information",
							content:
								"Device type, operating system, unique device identifiers, mobile network information",
						},
						{
							label: "Log Data",
							content:
								"IP address, access times, app features used, pages viewed, crashes and system activity",
						},
						{
							label: "Communication Data",
							content:
								"Messages between users and drivers, customer support interactions, feedback and ratings",
						},
					],
				},
				{
					title: "Information from Third Parties",
					items: [
						{
							label: "Social Media",
							content:
								"Profile information if you choose to connect via social media accounts",
						},
						{
							label: "Payment Processors",
							content: "Transaction verification and payment processing data",
						},
						{
							label: "Background Checks",
							content:
								"For driver verification, we may receive information from screening services",
						},
					],
				},
			],
		},
		id: undefined, // Indonesian translation to be added
	});

export const howWeUseInformation = (): LegalSectionContent =>
	getLegalContent({
		en: {
			title: "How We Use Your Information",
			paragraphs: [
				"We use the collected information for the following purposes:",
			],
			lists: [
				{
					items: [
						{
							label: "Service Delivery",
							content:
								"Facilitate ride-hailing and delivery services, connect users with drivers, process payments, and manage bookings",
						},
						{
							label: "Safety and Security",
							content:
								"Verify driver identity, monitor suspicious activity, prevent fraud, ensure passenger safety",
						},
						{
							label: "Communication",
							content:
								"Send booking confirmations, service updates, promotional offers, and customer support responses",
						},
						{
							label: "Improvement and Analytics",
							content:
								"Analyze usage patterns, improve app functionality, optimize routes, develop new features",
						},
						{
							label: "Legal Compliance",
							content:
								"Comply with Indonesian laws, respond to legal requests, resolve disputes, enforce our terms of service",
						},
						{
							label: "Personalization",
							content:
								"Customize user experience, provide relevant recommendations, display targeted content",
						},
					],
				},
			],
		},
		id: undefined,
	});

export const informationSharing = (): LegalSectionContent =>
	getLegalContent({
		en: {
			title: "Information Sharing and Disclosure",
			paragraphs: [
				"We may share your information in the following circumstances:",
			],
			lists: [
				{
					items: [
						{
							label: "Between Users and Drivers",
							content:
								"Name, profile picture, location, and contact information necessary for service completion",
						},
						{
							label: "With Merchants",
							content:
								"Delivery address and contact information for food and package delivery services",
						},
						{
							label: "Service Providers",
							content:
								"Third-party vendors who assist with payment processing, cloud storage, customer support, and analytics",
						},
						{
							label: "Business Transfers",
							content:
								"In connection with mergers, acquisitions, or asset sales, subject to confidentiality agreements",
						},
						{
							label: "Legal Requirements",
							content:
								"When required by Indonesian law, court orders, or government authorities",
						},
						{
							label: "Safety and Protection",
							content:
								"To protect the rights, property, or safety of AkadeMove, our users, or others",
						},
						{
							label: "With Your Consent",
							content: "In any other circumstances with your explicit consent",
						},
					],
				},
			],
		},
		id: undefined,
	});

export const dataRetention = (): LegalSectionContent =>
	getLegalContent({
		en: {
			title: "Data Retention",
			paragraphs: [
				"We retain your personal information for as long as necessary to provide our services and comply with legal obligations:",
			],
			lists: [
				{
					items: [
						{
							label: "Active Accounts",
							content:
								"Information is retained while your account is active and for a reasonable period afterward",
						},
						{
							label: "Transaction Records",
							content:
								"Financial records are retained for 10 years as required by Indonesian tax laws",
						},
						{
							label: "Legal Requirements",
							content:
								"Data required for legal compliance or dispute resolution is retained as necessary",
						},
						{
							label: "Deleted Accounts",
							content:
								"Most data is deleted within 90 days of account deletion, except where retention is legally required",
						},
					],
				},
			],
		},
		id: undefined,
	});

export const yourRights = (): LegalSectionContent =>
	getLegalContent({
		en: {
			title: "Your Rights",
			paragraphs: [
				"Under Indonesian data protection law (UU PDP 27/2022), you have the following rights:",
			],
			lists: [
				{
					items: [
						{
							label: "Access",
							content:
								"Request access to your personal information that we hold",
						},
						{
							label: "Correction",
							content:
								"Request correction of inaccurate or incomplete information",
						},
						{
							label: "Deletion",
							content:
								"Request deletion of your personal information, subject to legal retention requirements",
						},
						{
							label: "Objection",
							content:
								"Object to processing of your information for certain purposes",
						},
						{
							label: "Data Portability",
							content:
								"Request a copy of your data in a structured, machine-readable format",
						},
						{
							label: "Withdrawal of Consent",
							content:
								"Withdraw consent for data processing where consent is the legal basis",
						},
						{
							label: "Complaint",
							content:
								"Lodge a complaint with the Indonesian data protection authority",
						},
					],
				},
			],
		},
		id: undefined,
	});

export const dataSecurity = (): LegalSectionContent =>
	getLegalContent({
		en: {
			title: "Data Security",
			paragraphs: [
				"We implement appropriate technical and organizational measures to protect your personal information:",
			],
			lists: [
				{
					items: [
						{
							label: "Encryption",
							content:
								"Data in transit is encrypted using TLS/SSL protocols; sensitive data at rest is encrypted",
						},
						{
							label: "Access Controls",
							content:
								"Strict access controls limit employee access to personal information on a need-to-know basis",
						},
						{
							label: "Security Monitoring",
							content:
								"Continuous monitoring for security threats and vulnerabilities",
						},
						{
							label: "Regular Audits",
							content: "Periodic security assessments and compliance audits",
						},
						{
							label: "Incident Response",
							content:
								"Established procedures for detecting, reporting, and responding to data breaches",
						},
					],
				},
			],
			additionalParagraphs: [
				"Despite our efforts, no security system is impenetrable. We cannot guarantee the absolute security of your information.",
			],
		},
		id: undefined,
	});

export const internationalTransfers = (): LegalSectionContent =>
	getLegalContent({
		en: {
			title: "International Data Transfers",
			paragraphs: [
				"Your information may be transferred to and processed in countries other than Indonesia, including for cloud storage and data processing services. We ensure that such transfers comply with Indonesian data protection laws through:",
			],
			lists: [
				{
					items: [
						{
							label: "Adequacy Decisions",
							content:
								"Transfers to countries deemed to have adequate data protection",
						},
						{
							label: "Standard Contractual Clauses",
							content: "Use of approved data transfer agreements",
						},
						{
							label: "Data Processing Agreements",
							content:
								"Contracts with service providers that include data protection obligations",
						},
					],
				},
			],
		},
		id: undefined,
	});

export const childrenPrivacy = (): LegalSectionContent =>
	getLegalContent({
		en: {
			title: "Children's Privacy",
			paragraphs: [
				"Our services are not intended for children under 17 years of age. We do not knowingly collect personal information from children. If you are a parent or guardian and believe your child has provided us with personal information, please contact us, and we will delete such information.",
			],
		},
		id: undefined,
	});

export const changesToPolicy = (): LegalSectionContent =>
	getLegalContent({
		en: {
			title: "Changes to This Privacy Policy",
			paragraphs: [
				"We may update this Privacy Policy from time to time to reflect changes in our practices or legal requirements. We will notify you of material changes by:",
			],
			lists: [
				{
					items: [
						{
							label: "In-App Notification",
							content: "Push notifications or in-app messages",
						},
						{
							label: "Email",
							content: "Notification to your registered email address",
						},
						{
							label: "Website Notice",
							content: "Prominent notice on our website",
						},
					],
				},
			],
			additionalParagraphs: [
				"Continued use of our services after changes become effective constitutes acceptance of the updated policy.",
			],
		},
		id: undefined,
	});

export const contactUs = (): LegalSectionContent =>
	getLegalContent({
		en: {
			title: "Contact Us",
			paragraphs: [
				"For questions, concerns, or to exercise your rights regarding your personal information, please contact our Data Protection Officer:",
			],
			lists: [
				{
					items: [
						{
							label: "Email",
							content: "privacy@akademove.com",
						},
						{
							label: "Phone",
							content: "+62 21 1234 5678",
						},
						{
							label: "Address",
							content:
								"AkadeMove Indonesia, Jl. Sudirman No. 123, Jakarta Pusat, DKI Jakarta 10220, Indonesia",
						},
						{
							label: "Response Time",
							content:
								"We aim to respond to all requests within 14 business days",
						},
					],
				},
			],
		},
		id: undefined,
	});
