import { m } from "@repo/i18n";
import { createFileRoute } from "@tanstack/react-router";
import {
	LegalLayout,
	LegalSection,
	type LegalSection as LegalSectionType,
	LegalSubsection,
} from "@/components/legal/legal-layout";
import { APP_NAME } from "@/lib/constants";
import { LegalContentRenderer } from "@/lib/legal/legal-content-renderer";
import {
	acceptanceOfTerms,
	accountRegistration,
	accountTermination,
	cancellationPolicy,
	changesToTerms,
	commissionStructure,
	contactInformation,
	disputeResolution,
	driverAvailability,
	driverDocuments,
	driverRequirements,
	driverSchedule,
	driversEligibility,
	foodDelivery,
	genderPreference,
	intellectualProperty,
	limitationLiability,
	merchantsEligibility,
	operatorsEligibility,
	orderManagement,
	packageDelivery,
	passengersEligibility,
	pricingPayments,
	pricingStructure,
	prohibitedConduct,
	ratingSystem,
	rideHailing,
	safetyReporting,
	serviceDescription,
	userEligibility,
	walletSystem,
	withdrawals,
} from "@/lib/legal/terms-content";

export const Route = createFileRoute("/(legal)/terms")({
	component: TermsOfServiceComponent,
	head: () => ({
		meta: [
			{
				title: `Terms of Service - ${APP_NAME}`,
			},
			{
				name: "description",
				content:
					"Read the terms and conditions for using AkadeMove's campus mobility and delivery services.",
			},
		],
	}),
});

const sections: LegalSectionType[] = [
	{ id: "acceptance", title: acceptanceOfTerms().title },
	{ id: "service-description", title: serviceDescription().title },
	{
		id: "eligibility",
		title: userEligibility().title,
		subsections: [
			{ id: "passengers", title: passengersEligibility().title },
			{ id: "drivers", title: driversEligibility().title },
			{ id: "merchants", title: merchantsEligibility().title },
			{ id: "operators", title: operatorsEligibility().title },
		],
	},
	{ id: "registration", title: accountRegistration().title },
	{
		id: "driver-requirements",
		title: driverRequirements().title,
		subsections: [
			{ id: "driver-docs", title: driverDocuments().title },
			{ id: "driver-schedule", title: driverSchedule().title },
			{ id: "driver-availability", title: driverAvailability().title },
		],
	},
	{
		id: "pricing-payments",
		title: pricingPayments().title,
		subsections: [
			{ id: "pricing-structure", title: pricingStructure().title },
			{ id: "commission", title: commissionStructure().title },
			{ id: "wallet-system", title: walletSystem().title },
			{ id: "withdrawals", title: withdrawals().title },
		],
	},
	{
		id: "order-management",
		title: orderManagement().title,
		subsections: [
			{ id: "ride-hailing", title: rideHailing().title },
			{ id: "delivery", title: packageDelivery().title },
			{ id: "food-delivery", title: foodDelivery().title },
		],
	},
	{
		id: "cancellation",
		title: cancellationPolicy().title,
	},
	{
		id: "ratings",
		title: ratingSystem().title,
	},
	{
		id: "safety",
		title: safetyReporting().title,
	},
	{
		id: "gender-preference",
		title: genderPreference().title,
	},
	{
		id: "prohibited-conduct",
		title: prohibitedConduct().title,
	},
	{
		id: "intellectual-property",
		title: intellectualProperty().title,
	},
	{
		id: "limitation-liability",
		title: limitationLiability().title,
	},
	{
		id: "dispute-resolution",
		title: disputeResolution().title,
	},
	{
		id: "changes-terms",
		title: changesToTerms().title,
	},
	{
		id: "termination",
		title: accountTermination().title,
	},
	{
		id: "contact-terms",
		title: contactInformation().title,
	},
];

function TermsOfServiceComponent() {
	const lastUpdated = "December 1, 2025";

	return (
		<LegalLayout
			title={m.terms_of_service()}
			lastUpdated={lastUpdated}
			sections={sections}
		>
			<LegalSection id="acceptance" title={acceptanceOfTerms().title}>
				<LegalContentRenderer content={acceptanceOfTerms()} />
			</LegalSection>

			<LegalSection id="service-description" title={serviceDescription().title}>
				<LegalContentRenderer content={serviceDescription()} />
			</LegalSection>

			<LegalSection id="eligibility" title={userEligibility().title}>
				<LegalSubsection id="passengers" title={passengersEligibility().title}>
					<LegalContentRenderer content={passengersEligibility()} />
				</LegalSubsection>

				<LegalSubsection id="drivers" title={driversEligibility().title}>
					<LegalContentRenderer content={driversEligibility()} />
				</LegalSubsection>

				<LegalSubsection id="merchants" title={merchantsEligibility().title}>
					<LegalContentRenderer content={merchantsEligibility()} />
				</LegalSubsection>

				<LegalSubsection id="operators" title={operatorsEligibility().title}>
					<LegalContentRenderer content={operatorsEligibility()} />
				</LegalSubsection>
			</LegalSection>

			<LegalSection id="registration" title={accountRegistration().title}>
				<LegalContentRenderer content={accountRegistration()} />
			</LegalSection>

			<LegalSection id="driver-requirements" title={driverRequirements().title}>
				<LegalSubsection id="driver-docs" title={driverDocuments().title}>
					<LegalContentRenderer content={driverDocuments()} />
				</LegalSubsection>

				<LegalSubsection id="driver-schedule" title={driverSchedule().title}>
					<LegalContentRenderer content={driverSchedule()} />
				</LegalSubsection>

				<LegalSubsection
					id="driver-availability"
					title={driverAvailability().title}
				>
					<LegalContentRenderer content={driverAvailability()} />
				</LegalSubsection>
			</LegalSection>

			<LegalSection id="pricing-payments" title={pricingPayments().title}>
				<LegalSubsection
					id="pricing-structure"
					title={pricingStructure().title}
				>
					<LegalContentRenderer content={pricingStructure()} />
				</LegalSubsection>

				<LegalSubsection id="commission" title={commissionStructure().title}>
					<LegalContentRenderer content={commissionStructure()} />
				</LegalSubsection>

				<LegalSubsection id="wallet-system" title={walletSystem().title}>
					<LegalContentRenderer content={walletSystem()} />
				</LegalSubsection>

				<LegalSubsection id="withdrawals" title={withdrawals().title}>
					<LegalContentRenderer content={withdrawals()} />
				</LegalSubsection>
			</LegalSection>

			<LegalSection id="order-management" title={orderManagement().title}>
				<LegalSubsection id="ride-hailing" title={rideHailing().title}>
					<LegalContentRenderer content={rideHailing()} />
				</LegalSubsection>

				<LegalSubsection id="delivery" title={packageDelivery().title}>
					<LegalContentRenderer content={packageDelivery()} />
				</LegalSubsection>

				<LegalSubsection id="food-delivery" title={foodDelivery().title}>
					<LegalContentRenderer content={foodDelivery()} />
				</LegalSubsection>
			</LegalSection>

			<LegalSection id="cancellation" title={cancellationPolicy().title}>
				<LegalContentRenderer content={cancellationPolicy()} />
			</LegalSection>

			<LegalSection id="ratings" title={ratingSystem().title}>
				<LegalContentRenderer content={ratingSystem()} />
			</LegalSection>

			<LegalSection id="safety" title={safetyReporting().title}>
				<LegalContentRenderer content={safetyReporting()} />
			</LegalSection>

			<LegalSection id="gender-preference" title={genderPreference().title}>
				<LegalContentRenderer content={genderPreference()} />
			</LegalSection>

			<LegalSection id="prohibited-conduct" title={prohibitedConduct().title}>
				<LegalContentRenderer content={prohibitedConduct()} />
			</LegalSection>

			<LegalSection
				id="intellectual-property"
				title={intellectualProperty().title}
			>
				<LegalContentRenderer content={intellectualProperty()} />
			</LegalSection>

			<LegalSection
				id="limitation-liability"
				title={limitationLiability().title}
			>
				<LegalContentRenderer content={limitationLiability()} />
			</LegalSection>

			<LegalSection id="dispute-resolution" title={disputeResolution().title}>
				<LegalContentRenderer content={disputeResolution()} />
			</LegalSection>

			<LegalSection id="changes-terms" title={changesToTerms().title}>
				<LegalContentRenderer content={changesToTerms()} />
			</LegalSection>

			<LegalSection id="termination" title={accountTermination().title}>
				<LegalContentRenderer content={accountTermination()} />
			</LegalSection>

			<LegalSection id="contact-terms" title={contactInformation().title}>
				<LegalContentRenderer content={contactInformation()} />
			</LegalSection>
		</LegalLayout>
	);
}
