/**
 * Cookie Policy Content
 *
 * This file contains all content for the Cookie Policy page.
 * Indonesian translations can be added to the `id` property of each content object.
 */

import type { LegalSectionContent } from "../legal-i18n";
import { getLegalContent } from "../legal-i18n";

export const cookieIntro = () =>
	getLegalContent({
		en: [
			"This Cookie Policy explains how AkadeMove uses cookies and similar tracking technologies on our website and mobile application. By using our Services, you consent to our use of cookies as described in this policy.",
			"We use cookies to provide, improve, and protect our Services, and to give you a better experience. This policy should be read in conjunction with our Privacy Policy.",
		],
		id: undefined, // Indonesian translation to be added
	});

export const whatAreCookies = (): LegalSectionContent =>
	getLegalContent({
		en: {
			title: "What Are Cookies?",
			paragraphs: [
				"Cookies are small text files stored on your device (computer, smartphone, or tablet) when you visit a website or use an application. They help websites remember information about your visit, making your experience more efficient and personalized.",
				'Cookies can be "persistent" (remaining on your device until deleted or expired) or "session" (deleted when you close your browser).',
			],
		},
		id: undefined,
	});

export const cookiesWeUse = (): LegalSectionContent =>
	getLegalContent({
		en: {
			title: "Types of Cookies We Use",
			paragraphs: [],
			lists: [
				{
					items: [
						{
							label: "Essential Cookies",
							content:
								"Required for the Services to function properly. These enable core functionality like security, authentication, and payment processing. Without these cookies, certain features cannot be provided.",
						},
						{
							label: "Performance Cookies",
							content:
								"Collect information about how you use our Services, such as which pages you visit most often. This data helps us improve performance and user experience. These cookies are aggregated and anonymous.",
						},
						{
							label: "Functionality Cookies",
							content:
								"Remember your preferences and settings, such as language selection, location, and customizations. These enhance your experience by providing personalized features.",
						},
						{
							label: "Analytics Cookies",
							content:
								"Help us understand user behavior, measure traffic, and analyze trends. We use Google Analytics and similar tools to gather insights that improve our Services.",
						},
						{
							label: "Advertising Cookies",
							content:
								"Used to deliver relevant advertisements and measure campaign effectiveness. These cookies track your browsing activity across websites to show personalized ads.",
						},
					],
				},
			],
		},
		id: undefined,
	});

export const specificCookies = (): LegalSectionContent =>
	getLegalContent({
		en: {
			title: "Specific Cookies We Use",
			paragraphs: [],
			lists: [
				{
					title: "First-Party Cookies",
					items: [
						{
							label: "session_id",
							content: "Maintains your login session (Essential, Session)",
						},
						{
							label: "auth_token",
							content: "Authenticates your requests (Essential, Persistent)",
						},
						{
							label: "locale",
							content:
								"Remembers your language preference (Functionality, Persistent)",
						},
						{
							label: "theme",
							content:
								"Stores your dark/light mode preference (Functionality, Persistent)",
						},
						{
							label: "consent",
							content:
								"Records your cookie consent choices (Essential, Persistent)",
						},
					],
				},
				{
					title: "Third-Party Cookies",
					items: [
						{
							label: "Google Analytics (_ga, _gid)",
							content:
								"Tracks usage statistics and user journeys (Analytics, Persistent)",
						},
						{
							label: "Google Maps",
							content:
								"Enables map functionality and location services (Functionality, Session)",
						},
						{
							label: "Payment Processors (Stripe, Xendit)",
							content:
								"Facilitates secure payment processing (Essential, Session)",
						},
						{
							label: "Social Media (Facebook, Instagram)",
							content:
								"Enables social sharing features (Functionality, Persistent)",
						},
					],
				},
			],
		},
		id: undefined,
	});

export const howWeUseCookies = (): LegalSectionContent =>
	getLegalContent({
		en: {
			title: "How We Use Cookies",
			paragraphs: ["We use cookies for the following purposes:"],
			lists: [
				{
					items: [
						{
							label: "Authentication",
							content: "Keep you logged in and verify your identity",
						},
						{
							label: "Security",
							content:
								"Detect and prevent fraudulent activity and security threats",
						},
						{
							label: "Preferences",
							content:
								"Remember your settings, language, and customization choices",
						},
						{
							label: "Performance",
							content:
								"Monitor app performance, load times, and technical issues",
						},
						{
							label: "Analytics",
							content:
								"Understand usage patterns, popular features, and user journeys",
						},
						{
							label: "Advertising",
							content:
								"Deliver targeted promotions and measure marketing effectiveness",
						},
						{
							label: "Improvement",
							content: "Identify areas for enhancement and test new features",
						},
					],
				},
			],
		},
		id: undefined,
	});

export const managingCookies = (): LegalSectionContent =>
	getLegalContent({
		en: {
			title: "Managing Your Cookie Preferences",
			paragraphs: [
				"You have control over cookies and can manage them in several ways:",
			],
			lists: [
				{
					title: "Browser Settings",
					items: [
						{
							label: "Block Cookies",
							content:
								"Configure your browser to reject all cookies or specific types",
						},
						{
							label: "Delete Cookies",
							content: "Remove existing cookies from your browser at any time",
						},
						{
							label: "Notification",
							content: "Set your browser to notify you when cookies are set",
						},
					],
				},
				{
					title: "Our Cookie Consent Tool",
					items: [
						{
							label: "Preference Center",
							content:
								"Manage your cookie preferences through our in-app cookie settings",
						},
						{
							label: "Granular Control",
							content:
								"Choose which non-essential cookie categories to accept or reject",
						},
					],
				},
				{
					title: "Third-Party Opt-Outs",
					items: [
						{
							label: "Google Analytics",
							content: "Install the Google Analytics Opt-out Browser Add-on",
						},
						{
							label: "Advertising",
							content:
								"Use opt-out tools from advertising networks like NAI or DAA",
						},
					],
				},
			],
			additionalParagraphs: [
				"**Note:** Blocking essential cookies may prevent certain features from functioning properly. If you disable cookies, you may not be able to access all parts of our Services.",
			],
		},
		id: undefined,
	});

export const thirdPartyServices = (): LegalSectionContent =>
	getLegalContent({
		en: {
			title: "Third-Party Services",
			paragraphs: [
				"We use third-party services that may set their own cookies. These services have their own privacy policies:",
			],
			lists: [
				{
					items: [
						{
							label: "Google Analytics",
							content:
								"Web analytics service - https://policies.google.com/privacy",
						},
						{
							label: "Google Maps",
							content:
								"Mapping and location services - https://policies.google.com/privacy",
						},
						{
							label: "Stripe",
							content: "Payment processing - https://stripe.com/privacy",
						},
						{
							label: "Xendit",
							content: "Payment gateway - https://www.xendit.co/en/privacy",
						},
						{
							label: "Firebase",
							content:
								"Push notifications and analytics - https://firebase.google.com/support/privacy",
						},
						{
							label: "Cloudflare",
							content:
								"Content delivery and security - https://www.cloudflare.com/privacypolicy",
						},
					],
				},
			],
			additionalParagraphs: [
				"We are not responsible for the privacy practices of these third parties. We encourage you to review their policies.",
			],
		},
		id: undefined,
	});

export const changesToCookiePolicy = (): LegalSectionContent =>
	getLegalContent({
		en: {
			title: "Changes to This Cookie Policy",
			paragraphs: [
				"We may update this Cookie Policy from time to time to reflect changes in our practices or for operational, legal, or regulatory reasons. We will notify you of material changes by:",
				'- Updating the "Last Updated" date at the top of this policy',
				"- Providing notice through our Services or via email",
				"- Requesting renewed consent where required",
				"",
				"We encourage you to review this policy periodically.",
			],
		},
		id: undefined,
	});

export const contactCookies = (): LegalSectionContent =>
	getLegalContent({
		en: {
			title: "Contact Us About Cookies",
			paragraphs: [
				"If you have questions about our use of cookies or this Cookie Policy, please contact us:",
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
								"AkadeMove Indonesia, Jl. Sudirman No. 123, Jakarta Pusat, DKI Jakarta 10220",
						},
					],
				},
			],
		},
		id: undefined,
	});
