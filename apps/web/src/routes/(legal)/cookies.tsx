import { m } from "@repo/i18n";
import { createFileRoute } from "@tanstack/react-router";
import {
	LegalLayout,
	LegalSection,
	type LegalSection as LegalSectionType,
} from "@/components/legal/legal-layout";
import { APP_NAME } from "@/lib/constants";
import {
	changesToCookiePolicy,
	contactCookies,
	cookieIntro,
	cookiesWeUse,
	howWeUseCookies,
	managingCookies,
	specificCookies,
	thirdPartyServices,
	whatAreCookies,
} from "@/lib/legal/cookies-content";
import { LegalContentRenderer } from "@/lib/legal/legal-content-renderer";

export const Route = createFileRoute("/(legal)/cookies")({
	component: CookiePolicyComponent,
	head: () => ({
		meta: [
			{
				title: `Cookie Policy - ${APP_NAME}`,
			},
			{
				name: "description",
				content:
					"Learn about how AkadeMove uses cookies and similar technologies on our platform.",
			},
		],
	}),
});

const sections: LegalSectionType[] = [
	{ id: "introduction", title: "Introduction" },
	{ id: "what-are-cookies", title: whatAreCookies().title },
	{ id: "cookies-we-use", title: cookiesWeUse().title },
	{ id: "specific-cookies", title: specificCookies().title },
	{ id: "how-we-use", title: howWeUseCookies().title },
	{ id: "managing-cookies", title: managingCookies().title },
	{ id: "third-party", title: thirdPartyServices().title },
	{ id: "updates", title: changesToCookiePolicy().title },
	{ id: "contact", title: contactCookies().title },
];

function CookiePolicyComponent() {
	const lastUpdated = "December 1, 2025";

	return (
		<LegalLayout
			title={m.cookie_policy()}
			lastUpdated={lastUpdated}
			sections={sections}
		>
			<LegalSection id="introduction" title="Introduction">
				{cookieIntro().map((paragraph, index) => (
					// biome-ignore lint/suspicious/noArrayIndexKey: Static content
					<p key={index}>{paragraph}</p>
				))}
			</LegalSection>

			<LegalSection id="what-are-cookies" title={whatAreCookies().title}>
				<LegalContentRenderer content={whatAreCookies()} />
			</LegalSection>

			<LegalSection id="cookies-we-use" title={cookiesWeUse().title}>
				<LegalContentRenderer content={cookiesWeUse()} />
			</LegalSection>

			<LegalSection id="specific-cookies" title={specificCookies().title}>
				<LegalContentRenderer content={specificCookies()} />
			</LegalSection>

			<LegalSection id="how-we-use" title={howWeUseCookies().title}>
				<LegalContentRenderer content={howWeUseCookies()} />
			</LegalSection>

			<LegalSection id="managing-cookies" title={managingCookies().title}>
				<LegalContentRenderer content={managingCookies()} />
			</LegalSection>

			<LegalSection id="third-party" title={thirdPartyServices().title}>
				<LegalContentRenderer content={thirdPartyServices()} />
			</LegalSection>

			<LegalSection id="updates" title={changesToCookiePolicy().title}>
				<LegalContentRenderer content={changesToCookiePolicy()} />
			</LegalSection>

			<LegalSection id="contact" title={contactCookies().title}>
				<LegalContentRenderer content={contactCookies()} />
			</LegalSection>
		</LegalLayout>
	);
}
