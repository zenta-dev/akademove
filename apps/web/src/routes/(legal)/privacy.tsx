import { m } from "@repo/i18n";
import { createFileRoute } from "@tanstack/react-router";
import {
	LegalLayout,
	LegalSection,
	type LegalSection as LegalSectionType,
} from "@/components/legal/legal-layout";
import { APP_NAME } from "@/lib/constants";
import { LegalContentRenderer } from "@/lib/legal/legal-content-renderer";
import {
	changesToPolicy,
	childrenPrivacy,
	contactUs,
	dataRetention,
	dataSecurity,
	howWeUseInformation,
	informationSharing,
	informationWeCollect,
	internationalTransfers,
	privacyIntro,
	yourRights,
} from "@/lib/legal/privacy-content";

export const Route = createFileRoute("/(legal)/privacy")({
	component: PrivacyPolicyComponent,
	head: () => ({
		meta: [
			{
				title: `Privacy Policy - ${APP_NAME}`,
			},
			{
				name: "description",
				content:
					"Learn how AkadeMove collects, uses, and protects your personal information in compliance with Indonesian data protection laws.",
			},
		],
	}),
});

const sections: LegalSectionType[] = [
	{ id: "introduction", title: privacyIntro().title },
	{
		id: "information-collection",
		title: informationWeCollect().title,
	},
	{
		id: "how-we-use",
		title: howWeUseInformation().title,
	},
	{
		id: "data-sharing",
		title: informationSharing().title,
	},
	{
		id: "data-security",
		title: dataSecurity().title,
	},
	{
		id: "your-rights",
		title: yourRights().title,
	},
	{
		id: "data-retention",
		title: dataRetention().title,
	},
	{
		id: "international-transfers",
		title: internationalTransfers().title,
	},
	{
		id: "childrens-privacy",
		title: childrenPrivacy().title,
	},
	{
		id: "changes",
		title: changesToPolicy().title,
	},
	{
		id: "contact",
		title: contactUs().title,
	},
];

function PrivacyPolicyComponent() {
	const lastUpdated = "December 1, 2025";

	return (
		<LegalLayout
			title={m.privacy_policy()}
			lastUpdated={lastUpdated}
			sections={sections}
		>
			<LegalSection id="introduction" title={privacyIntro().title}>
				<LegalContentRenderer content={privacyIntro()} />
			</LegalSection>

			<LegalSection
				id="information-collection"
				title={informationWeCollect().title}
			>
				<LegalContentRenderer content={informationWeCollect()} />
			</LegalSection>

			<LegalSection id="how-we-use" title={howWeUseInformation().title}>
				<LegalContentRenderer content={howWeUseInformation()} />
			</LegalSection>

			<LegalSection id="data-sharing" title={informationSharing().title}>
				<LegalContentRenderer content={informationSharing()} />
			</LegalSection>

			<LegalSection id="data-security" title={dataSecurity().title}>
				<LegalContentRenderer content={dataSecurity()} />
			</LegalSection>

			<LegalSection id="your-rights" title={yourRights().title}>
				<LegalContentRenderer content={yourRights()} />
			</LegalSection>

			<LegalSection id="data-retention" title={dataRetention().title}>
				<LegalContentRenderer content={dataRetention()} />
			</LegalSection>

			<LegalSection
				id="international-transfers"
				title={internationalTransfers().title}
			>
				<LegalContentRenderer content={internationalTransfers()} />
			</LegalSection>

			<LegalSection id="childrens-privacy" title={childrenPrivacy().title}>
				<LegalContentRenderer content={childrenPrivacy()} />
			</LegalSection>

			<LegalSection id="changes" title={changesToPolicy().title}>
				<LegalContentRenderer content={changesToPolicy()} />
			</LegalSection>

			<LegalSection id="contact" title={contactUs().title}>
				<LegalContentRenderer content={contactUs()} />
			</LegalSection>
		</LegalLayout>
	);
}
