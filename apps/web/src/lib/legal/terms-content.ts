/**
 * Terms of Service Content
 *
 * This file contains all content for the Terms of Service page.
 * Indonesian translations can be added to the `id` property of each content object.
 *
 * NOTE: This file contains a subset of sections as a demonstration.
 * Additional sections can be added following the same pattern.
 */

import type { LegalSectionContent } from "../legal-i18n";
import { getLegalContent } from "../legal-i18n";

export const acceptanceOfTerms = (): LegalSectionContent =>
	getLegalContent({
		en: {
			title: "Acceptance of Terms",
			paragraphs: [
				'Welcome to AkadeMove. These Terms of Service ("Terms") govern your access to and use of our campus mobility and delivery platform, including our mobile application and website (collectively, the "Services").',
				"By creating an account, accessing, or using our Services, you agree to be bound by these Terms and our Privacy Policy. If you do not agree to these Terms, you may not use our Services.",
				"These Terms constitute a legally binding agreement between you and AkadeMove. Please read them carefully.",
			],
		},
		id: undefined, // Indonesian translation to be added
	});

export const serviceDescription = (): LegalSectionContent =>
	getLegalContent({
		en: {
			title: "Service Description",
			paragraphs: [
				"AkadeMove is a campus-specific platform that connects students, faculty, and authorized campus community members for:",
			],
			lists: [
				{
					items: [
						{
							label: "Ride-Hailing Services",
							content:
								"Transportation services within and around campus areas, connecting passengers with student drivers",
						},
						{
							label: "Package Delivery",
							content:
								"Delivery of documents, parcels, laundry, and other goods within campus boundaries",
						},
						{
							label: "Food Delivery",
							content:
								"Ordering and delivery of food and beverages from campus merchants and tenants (canteens, cafes, restaurants)",
						},
					],
				},
			],
			additionalParagraphs: [
				"AkadeMove acts as a technology platform connecting users with service providers (drivers and merchants). We are not a transportation company or food delivery company. Drivers and merchants are independent contractors, not employees of AkadeMove.",
			],
		},
		id: undefined,
	});

export const userEligibility = (): LegalSectionContent =>
	getLegalContent({
		en: {
			title: "User Roles and Eligibility",
			paragraphs: [],
		},
		id: undefined,
	});

export const passengersEligibility = (): LegalSectionContent =>
	getLegalContent({
		en: {
			title: "Passengers/Users",
			paragraphs: ["To use our services as a passenger, you must:"],
			lists: [
				{
					items: [
						{
							label: "Age",
							content: "Be at least 17 years of age",
						},
						{
							label: "Campus Affiliation",
							content:
								"Be a current student, faculty member, or authorized campus community member",
						},
						{
							label: "Contact Information",
							content: "Provide a valid email address and phone number",
						},
						{
							label: "Verification",
							content:
								"Verify your campus affiliation (Student ID/KTM when required)",
						},
						{
							label: "Account Maintenance",
							content: "Maintain accurate and up-to-date account information",
						},
					],
				},
			],
		},
		id: undefined,
	});

export const driversEligibility = (): LegalSectionContent =>
	getLegalContent({
		en: {
			title: "Drivers",
			paragraphs: ["To provide services as a driver, you must:"],
			lists: [
				{
					items: [
						{
							label: "Age",
							content: "Be at least 18 years of age",
						},
						{
							label: "Student Status",
							content: "Be a currently enrolled student",
						},
						{
							label: "Driver's License",
							content:
								"Possess a valid Indonesian driver's license (SIM C for motorcycles or SIM A for cars)",
						},
						{
							label: "Vehicle Access",
							content: "Own or have legal access to a registered vehicle",
						},
						{
							label: "Vehicle Registration",
							content: "Provide valid vehicle registration documents (STNK)",
						},
						{
							label: "Student ID",
							content: "Submit a clear photo of your Student ID (KTM)",
						},
						{
							label: "Verification Process",
							content: "Pass our driver verification and onboarding process",
						},
						{
							label: "Safety Training",
							content:
								"Complete any required safety training or knowledge assessment",
						},
						{
							label: "Insurance",
							content:
								"Maintain vehicle insurance as required by Indonesian law",
						},
					],
				},
			],
		},
		id: undefined,
	});

export const merchantsEligibility = (): LegalSectionContent =>
	getLegalContent({
		en: {
			title: "Merchants/Tenants",
			paragraphs: ["To operate as a merchant on our platform, you must:"],
			lists: [
				{
					items: [
						{
							label: "Authorization",
							content: "Be an authorized campus food vendor or tenant",
						},
						{
							label: "Documentation",
							content: "Provide valid business documentation and permits",
						},
						{
							label: "Food Safety",
							content: "Maintain food safety and hygiene standards",
						},
						{
							label: "Campus Compliance",
							content:
								"Comply with campus regulations for food service operations",
						},
						{
							label: "Menu Information",
							content:
								"Provide accurate menu information, pricing, and availability",
						},
					],
				},
			],
		},
		id: undefined,
	});

export const operatorsEligibility = (): LegalSectionContent =>
	getLegalContent({
		en: {
			title: "Operators",
			paragraphs: [
				"Operators are authorized campus administrators who manage platform configuration, pricing, promotions, and monitoring. Operator access is granted by AkadeMove administrators only.",
			],
		},
		id: undefined,
	});

export const accountRegistration = (): LegalSectionContent =>
	getLegalContent({
		en: {
			title: "Account Registration and Verification",
			paragraphs: [
				"To use AkadeMove, you must create an account by providing:",
			],
			lists: [
				{
					items: [
						{ label: "Name", content: "Full legal name" },
						{ label: "Email", content: "Valid email address" },
						{
							label: "Phone",
							content: "Phone number (verified via OTP)",
						},
						{
							label: "Password",
							content: "Password (securely hashed and stored)",
						},
						{
							label: "Personal Details",
							content: "Date of birth and gender",
						},
						{
							label: "Photo",
							content:
								"Profile photo (optional for passengers, required for drivers)",
						},
					],
				},
			],
			additionalParagraphs: [
				"You are responsible for maintaining the confidentiality of your account credentials and for all activities that occur under your account. You must notify us immediately of any unauthorized use of your account.",
				"**Driver and Merchant Verification:** Driver and merchant accounts require additional verification. Your account will have limited functionality until verification is complete. Verification typically takes 1-3 business days. We reserve the right to reject verification applications that do not meet our standards.",
				"**Account Accuracy:** You agree to provide accurate, current, and complete information and to update it as necessary to maintain its accuracy.",
			],
		},
		id: undefined,
	});

export const cancellationPolicy = (): LegalSectionContent =>
	getLegalContent({
		en: {
			title: "Cancellation and Refund Policy",
			paragraphs: [
				"**User Cancellations:**",
				"- Free cancellation within 2 minutes of booking",
				"- Cancellation fee (configurable by operator) applies after 2 minutes",
				"- If driver has arrived or order is being prepared, full cancellation fee applies",
				"",
				"**Driver Cancellations:**",
				"- Drivers can cancel without penalty if passenger is unresponsive or violates terms",
				"- Excessive cancellations may result in account suspension",
				"",
				"**Refunds:**",
				"- Refunds for service issues are processed within 5-7 business days",
				"- Refunds are issued to the original payment method or wallet",
				"- Disputes must be raised within 24 hours of order completion",
			],
		},
		id: undefined,
	});

export const ratingSystem = (): LegalSectionContent =>
	getLegalContent({
		en: {
			title: "Rating and Review System",
			paragraphs: [
				"Both users and drivers can rate each other on a 5-star scale. Ratings contribute to overall user/driver scores and affect service quality and opportunities.",
			],
			lists: [
				{
					items: [
						{
							label: "Fairness",
							content:
								"Ratings should reflect actual service quality and behavior",
						},
						{
							label: "Prohibition",
							content:
								"Do not manipulate ratings or leave false/malicious reviews",
						},
						{
							label: "Disputes",
							content:
								"Rating disputes can be reported to customer support for review",
						},
						{
							label: "Consequences",
							content:
								"Consistently low ratings may result in account review or suspension",
						},
					],
				},
			],
		},
		id: undefined,
	});

export const prohibitedConduct = (): LegalSectionContent =>
	getLegalContent({
		en: {
			title: "Prohibited Conduct",
			paragraphs: ["Users of AkadeMove must not:"],
			lists: [
				{
					items: [
						{
							label: "Illegal Activity",
							content:
								"Use services for illegal purposes or transport illegal goods",
						},
						{
							label: "Harassment",
							content:
								"Harass, abuse, threaten, or discriminate against other users",
						},
						{
							label: "Fraud",
							content:
								"Engage in fraudulent activities, fake accounts, or payment fraud",
						},
						{
							label: "System Abuse",
							content:
								"Manipulate the platform, ratings, pricing, or promotions",
						},
						{
							label: "Safety Violations",
							content: "Operate vehicles unsafely or violate traffic laws",
						},
						{
							label: "Unauthorized Access",
							content:
								"Attempt to access accounts or data you are not authorized to access",
						},
						{
							label: "Intellectual Property",
							content:
								"Infringe on AkadeMove's or others' intellectual property",
						},
					],
				},
			],
			additionalParagraphs: [
				"Violation of these terms may result in immediate account suspension or termination, and potential legal action.",
			],
		},
		id: undefined,
	});

export const limitationLiability = (): LegalSectionContent =>
	getLegalContent({
		en: {
			title: "Limitation of Liability",
			paragraphs: [
				"**Platform Role:** AkadeMove is a technology platform connecting users with independent service providers. We do not provide transportation or delivery services directly.",
				'**No Warranty:** Services are provided "as is" without warranties of any kind, express or implied.',
				"**Limitation:** To the maximum extent permitted by Indonesian law, AkadeMove shall not be liable for indirect, incidental, special, or consequential damages.",
				"**Maximum Liability:** Our total liability shall not exceed the amount you paid to AkadeMove in the 12 months preceding the claim.",
				"**Third Parties:** We are not responsible for the actions of drivers, merchants, or other users.",
			],
		},
		id: undefined,
	});

export const disputeResolution = (): LegalSectionContent =>
	getLegalContent({
		en: {
			title: "Dispute Resolution",
			paragraphs: [
				"**Informal Resolution:** We encourage users to contact customer support first to resolve disputes informally.",
				"**Mediation:** If informal resolution fails, parties agree to attempt mediation before litigation.",
				"**Governing Law:** These Terms are governed by the laws of the Republic of Indonesia.",
				"**Jurisdiction:** Any disputes shall be resolved in the courts of Jakarta, Indonesia.",
				"**Arbitration:** Parties may agree to binding arbitration as an alternative to litigation.",
			],
		},
		id: undefined,
	});

export const changesToTerms = (): LegalSectionContent =>
	getLegalContent({
		en: {
			title: "Changes to Terms",
			paragraphs: [
				"We reserve the right to modify these Terms at any time. Material changes will be notified via:",
				"- In-app notification",
				"- Email to your registered address",
				"- Prominent notice on our website",
				"",
				"Continued use of services after changes become effective constitutes acceptance of the updated Terms. If you do not agree to changes, you must stop using our Services.",
			],
		},
		id: undefined,
	});

export const accountTermination = (): LegalSectionContent =>
	getLegalContent({
		en: {
			title: "Account Termination",
			paragraphs: [
				"**User Termination:** You may terminate your account at any time through app settings or by contacting customer support.",
				"**Platform Termination:** We reserve the right to suspend or terminate accounts that violate these Terms, engage in fraudulent activity, or pose safety risks.",
				"**Effect of Termination:** Upon termination, your access to Services will cease, and we may delete your account data subject to legal retention requirements.",
				"**Outstanding Obligations:** Termination does not relieve you of payment obligations or liabilities incurred before termination.",
			],
		},
		id: undefined,
	});

export const contactInformation = (): LegalSectionContent =>
	getLegalContent({
		en: {
			title: "Contact Information",
			paragraphs: ["For questions about these Terms or to report issues:"],
			lists: [
				{
					items: [
						{ label: "Email", content: "support@akademove.com" },
						{ label: "Phone", content: "+62 21 1234 5678" },
						{
							label: "Address",
							content:
								"AkadeMove Indonesia, Jl. Sudirman No. 123, Jakarta Pusat, DKI Jakarta 10220",
						},
						{
							label: "Customer Support",
							content: "Available 24/7 through in-app chat",
						},
					],
				},
			],
		},
		id: undefined,
	});

/**
 * NOTE: Additional sections from the Terms of Service can be added here following
 * the same pattern. Sections not yet migrated include:
 * - Driver Requirements (detailed)
 * - Pricing and Payments
 * - Order Management
 * - Safety and Reporting
 * - Gender Preference Feature
 * - Intellectual Property
 *
 * Each section should export a function that returns LegalSectionContent.
 */
