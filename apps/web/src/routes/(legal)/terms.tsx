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
	contactInformation,
	disputeResolution,
	limitationLiability,
	prohibitedConduct,
	ratingSystem,
	serviceDescription,
	userEligibility,
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
			{ id: "passengers", title: "Passengers/Users" },
			{ id: "drivers", title: "Drivers" },
			{ id: "merchants", title: "Merchants/Tenants" },
			{ id: "operators", title: "Operators" },
		],
	},
	{ id: "registration", title: accountRegistration().title },
	{
		id: "driver-requirements",
		title: "Driver Requirements",
		subsections: [
			{ id: "driver-docs", title: "Required Documents" },
			{ id: "driver-schedule", title: "Class Schedule Management" },
			{ id: "driver-availability", title: "Availability and Online Status" },
		],
	},
	{
		id: "pricing-payments",
		title: "Pricing and Payments",
		subsections: [
			{ id: "pricing-structure", title: "Pricing Structure" },
			{ id: "commission", title: "Commission Structure" },
			{ id: "wallet-system", title: "Wallet System" },
			{ id: "withdrawals", title: "Withdrawals" },
		],
	},
	{
		id: "order-management",
		title: "Order Management",
		subsections: [
			{ id: "ride-hailing", title: "Ride-Hailing Services" },
			{ id: "delivery", title: "Package Delivery" },
			{ id: "food-delivery", title: "Food Delivery" },
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
		title: "Safety and Reporting",
	},
	{
		id: "gender-preference",
		title: "Gender Preference Feature",
	},
	{
		id: "prohibited-conduct",
		title: prohibitedConduct().title,
	},
	{
		id: "intellectual-property",
		title: "Intellectual Property",
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

			<LegalSection id="eligibility" title="User Roles and Eligibility">
				<LegalSubsection id="passengers" title="Passengers/Users">
					<p>To use our services as a passenger, you must:</p>
					<ul>
						<li>Be at least 17 years of age</li>
						<li>
							Be a current student, faculty member, or authorized campus
							community member
						</li>
						<li>Provide a valid email address and phone number</li>
						<li>
							Verify your campus affiliation (Student ID/KTM when required)
						</li>
						<li>Maintain accurate and up-to-date account information</li>
					</ul>
				</LegalSubsection>

				<LegalSubsection id="drivers" title="Drivers">
					<p>To provide services as a driver, you must:</p>
					<ul>
						<li>Be at least 18 years of age</li>
						<li>Be a currently enrolled student</li>
						<li>
							Possess a valid Indonesian driver's license (SIM C for motorcycles
							or SIM A for cars)
						</li>
						<li>Own or have legal access to a registered vehicle</li>
						<li>Provide valid vehicle registration documents (STNK)</li>
						<li>Submit a clear photo of your Student ID (KTM)</li>
						<li>Pass our driver verification and onboarding process</li>
						<li>
							Complete any required safety training or knowledge assessment
						</li>
						<li>Maintain vehicle insurance as required by Indonesian law</li>
					</ul>
				</LegalSubsection>

				<LegalSubsection id="merchants" title="Merchants/Tenants">
					<p>To operate as a merchant on our platform, you must:</p>
					<ul>
						<li>Be an authorized campus food vendor or tenant</li>
						<li>Provide valid business documentation and permits</li>
						<li>Maintain food safety and hygiene standards</li>
						<li>Comply with campus regulations for food service operations</li>
						<li>
							Provide accurate menu information, pricing, and availability
						</li>
					</ul>
				</LegalSubsection>

				<LegalSubsection id="operators" title="Operators">
					<p>
						Operators are authorized campus administrators who manage platform
						configuration, pricing, promotions, and monitoring. Operator access
						is granted by {APP_NAME} administrators only.
					</p>
				</LegalSubsection>
			</LegalSection>

			<LegalSection id="registration" title={accountRegistration().title}>
				<LegalContentRenderer content={accountRegistration()} />
			</LegalSection>

			<LegalSection id="driver-requirements" title="Driver Requirements">
				<LegalSubsection id="driver-docs" title="Required Documents">
					<p>All drivers must submit and maintain current:</p>
					<ul>
						<li>
							<strong>Student ID Card (KTM):</strong> Valid proof of current
							enrollment
						</li>
						<li>
							<strong>Driver's License (SIM):</strong> Valid SIM C (motorcycle)
							or SIM A (car) from Indonesian authorities
						</li>
						<li>
							<strong>Vehicle Registration (STNK):</strong> Current vehicle
							registration matching the vehicle used for services
						</li>
						<li>
							<strong>Vehicle Photos:</strong> Clear photos of your vehicle from
							multiple angles
						</li>
						<li>
							<strong>Selfie Photo:</strong> Recent photo for identity
							verification
						</li>
					</ul>
					<p className="mt-3">
						Documents must be clearly readable and not expired. You must update
						documents before expiration to maintain active driver status.
					</p>
				</LegalSubsection>

				<LegalSubsection id="driver-schedule" title="Class Schedule Management">
					<p>
						One of {APP_NAME}'s unique features is class schedule integration:
					</p>
					<ul>
						<li>
							Drivers can input their class schedules (manual entry or calendar
							import when available)
						</li>
						<li>
							The system automatically sets drivers to "offline" status during
							scheduled class times
						</li>
						<li>Schedules can be one-time or recurring weekly</li>
						<li>
							Drivers can override automatic offline status if their schedule
							changes
						</li>
					</ul>
					<p className="mt-3">
						This feature helps drivers balance their academic responsibilities
						with earning opportunities. However, you remain responsible for
						managing your own schedule and ensuring you do not accept orders
						during times you are unavailable.
					</p>
				</LegalSubsection>

				<LegalSubsection
					id="driver-availability"
					title="Availability and Online Status"
				>
					<p>As a driver, you control your availability:</p>
					<ul>
						<li>
							Toggle between "online" (available for orders) and "offline" (not
							available)
						</li>
						<li>
							When online, you will receive order requests based on your
							location and rider preferences
						</li>
						<li>You have the right to accept or reject order requests</li>
						<li>
							However, excessive rejection rates may affect your priority in the
							matching algorithm
						</li>
						<li>
							Repeated cancellations after accepting orders may result in
							warnings or suspension
						</li>
					</ul>
				</LegalSubsection>
			</LegalSection>

			<LegalSection id="pricing-payments" title="Pricing and Payments">
				<LegalSubsection id="pricing-structure" title="Pricing Structure">
					<p>
						Pricing for rides and delivery services is calculated using the
						following formula:
					</p>
					<div className="my-4 rounded-lg bg-secondary/30 p-4 font-mono text-sm">
						Total Price = Base Price + (Distance in KM × Price per KM) + Tip -
						Coupon Discount
					</div>
					<ul>
						<li>
							<strong>Base Price:</strong> Minimum charge for any order, set by
							campus operators
						</li>
						<li>
							<strong>Price per KM:</strong> Rate per kilometer traveled,
							configurable by operators
						</li>
						<li>
							<strong>Distance Calculation:</strong> Calculated using Google
							Maps API for the shortest route
						</li>
						<li>
							<strong>Tips:</strong> Optional gratuity added by passengers
						</li>
						<li>
							<strong>Coupons:</strong> Promotional discounts applied at
							checkout
						</li>
					</ul>
					<p className="mt-3">
						<strong>Food Orders:</strong> Food prices are set by merchants. A
						delivery fee based on distance applies separately.
					</p>
					<p className="mt-3">
						You will see the estimated fare before confirming your order. The
						final fare is calculated based on the actual route taken.
					</p>
				</LegalSubsection>

				<LegalSubsection id="commission" title="Commission Structure">
					<p>{APP_NAME} operates on a commission-based model:</p>
					<ul>
						<li>
							<strong>Rides and Package Delivery:</strong> 15% platform
							commission deducted from the total fare
						</li>
						<li>
							<strong>Food Delivery:</strong> 20% total commission (10% from
							merchant, 10% from driver earnings)
						</li>
						<li>
							<strong>Tips:</strong> Tips go directly to drivers without
							commission deduction (configurable by operators)
						</li>
					</ul>
					<div className="my-4 rounded-lg bg-secondary/30 p-4">
						<p className="font-semibold">Example Calculation:</p>
						<p className="mt-2">Ride Total: Rp 25,000</p>
						<p>Platform Commission (15%): Rp 3,750</p>
						<p>Driver Earnings: Rp 21,250</p>
					</div>
					<p className="mt-3">
						Commission rates are subject to change with advance notice. Drivers
						and merchants will be notified of any rate changes at least 14 days
						in advance.
					</p>
				</LegalSubsection>

				<LegalSubsection id="wallet-system" title="Wallet System">
					<p>All users have an in-app wallet for managing funds:</p>
					<ul>
						<li>
							<strong>Top-Up:</strong> Passengers can add funds via QRIS, bank
							transfer, or e-wallet through our payment partner Midtrans
						</li>
						<li>
							<strong>Payment:</strong> Order payments are automatically
							deducted from wallet balance
						</li>
						<li>
							<strong>Earnings:</strong> Driver and merchant earnings are
							credited to their wallets after order completion
						</li>
						<li>
							<strong>Balance Tracking:</strong> View real-time wallet balance
							and transaction history
						</li>
						<li>
							<strong>Currency:</strong> All transactions are in Indonesian
							Rupiah (IDR)
						</li>
					</ul>
					<p className="mt-3">
						Insufficient wallet balance will prevent order placement. Minimum
						top-up amounts and transaction limits may apply.
					</p>
				</LegalSubsection>

				<LegalSubsection id="withdrawals" title="Withdrawals">
					<p>
						Drivers and merchants can withdraw earnings to their registered bank
						accounts:
					</p>
					<ul>
						<li>Minimum withdrawal amount: Rp 50,000</li>
						<li>Processing time: 1-3 business days</li>
						<li>Bank account must be in the driver/merchant's name</li>
						<li>Transaction fees may apply depending on the bank</li>
						<li>
							Failed withdrawals due to incorrect bank information may incur
							fees
						</li>
					</ul>
				</LegalSubsection>
			</LegalSection>

			<LegalSection id="order-management" title="Order Management">
				<LegalSubsection id="ride-hailing" title="Ride-Hailing Services">
					<p>
						<strong>Passenger Responsibilities:</strong>
					</p>
					<ul>
						<li>Specify accurate pickup and dropoff locations</li>
						<li>Be ready at the pickup location when the driver arrives</li>
						<li>Treat drivers with respect and courtesy</li>
						<li>Follow all safety guidelines</li>
						<li>Ensure you have sufficient wallet balance</li>
					</ul>
					<p className="mt-3">
						<strong>Driver Responsibilities:</strong>
					</p>
					<ul>
						<li>Accept orders you can fulfill</li>
						<li>Navigate to pickup location promptly</li>
						<li>Follow the designated route or a reasonable alternative</li>
						<li>Maintain vehicle cleanliness and safety</li>
						<li>
							Treat passengers with respect and ensure a comfortable journey
						</li>
						<li>Complete orders as requested</li>
					</ul>
					<p className="mt-3">
						<strong>Order Status Flow:</strong>
					</p>
					<p className="mt-2">
						Requested → Matching → Accepted → Arriving → In-Trip → Completed
					</p>
				</LegalSubsection>

				<LegalSubsection id="delivery" title="Package Delivery">
					<p>For package delivery services:</p>
					<ul>
						<li>
							<strong>Sender Responsibilities:</strong> Accurately describe
							package size, provide clear pickup/dropoff addresses, ensure
							package is ready for pickup
						</li>
						<li>
							<strong>Driver Responsibilities:</strong> Handle packages with
							care, obtain proof of delivery (photo or OTP from recipient), do
							not open or inspect package contents
						</li>
						<li>
							<strong>Prohibited Items:</strong> Illegal substances, weapons,
							hazardous materials, cash, perishable food without proper
							packaging, or items exceeding size/weight limits
						</li>
					</ul>
					<p className="mt-3">
						{APP_NAME} is not responsible for package contents. Users agree not
						to ship prohibited or illegal items through our platform.
					</p>
				</LegalSubsection>

				<LegalSubsection id="food-delivery" title="Food Delivery">
					<p>
						<strong>Order Workflow:</strong>
					</p>
					<ul>
						<li>Customer places order from merchant menu</li>
						<li>Merchant accepts and prepares order</li>
						<li>Driver is assigned to pick up from merchant</li>
						<li>Driver delivers to customer location</li>
					</ul>
					<p className="mt-3">
						<strong>Merchant Responsibilities:</strong>
					</p>
					<ul>
						<li>Maintain accurate menu, pricing, and availability</li>
						<li>Prepare orders within reasonable timeframes</li>
						<li>Package food securely for delivery</li>
						<li>Ensure food safety and quality standards</li>
						<li>Mark items as out of stock promptly</li>
					</ul>
					<p className="mt-3">
						<strong>Food Quality:</strong> {APP_NAME} is not responsible for
						food quality, preparation, or safety. Merchants are solely
						responsible for the food they provide.
					</p>
				</LegalSubsection>
			</LegalSection>

			<LegalSection id="cancellation" title={cancellationPolicy().title}>
				<LegalContentRenderer content={cancellationPolicy()} />
			</LegalSection>

			<LegalSection id="ratings" title={ratingSystem().title}>
				<LegalContentRenderer content={ratingSystem()} />
			</LegalSection>

			<LegalSection id="safety" title="Safety and Reporting">
				<p>
					Your safety is our priority. {APP_NAME} provides several safety
					features:
				</p>
				<ul>
					<li>
						<strong>In-App Chat:</strong> Communicate without sharing phone
						numbers (phone masking enabled)
					</li>
					<li>
						<strong>Driver Verification:</strong> All drivers undergo document
						verification before activation
					</li>
					<li>
						<strong>Real-Time Tracking:</strong> Share your trip with trusted
						contacts
					</li>
					<li>
						<strong>Emergency Button:</strong> Quick access to campus security
						or emergency services
					</li>
					<li>
						<strong>Report System:</strong> Report misconduct, harassment,
						fraud, or safety concerns
					</li>
				</ul>
				<p className="mt-3">
					<strong>Reporting Process:</strong>
				</p>
				<ul>
					<li>Submit report through the app with description and evidence</li>
					<li>Reports are reviewed by our safety team within 24-48 hours</li>
					<li>
						Investigation may include reviewing chat logs, order details, and
						GPS data
					</li>
					<li>
						Actions taken may include warnings, temporary suspension, or
						permanent ban
					</li>
					<li>
						Serious incidents may be reported to campus security or police
					</li>
				</ul>
				<p className="mt-3">
					<strong>User Responsibilities:</strong>
				</p>
				<ul>
					<li>Report any safety concerns immediately</li>
					<li>Do not share personal information unnecessarily</li>
					<li>Use only the in-app communication features</li>
					<li>Follow campus safety guidelines</li>
					<li>Do not engage in prohibited conduct</li>
				</ul>
			</LegalSection>

			<LegalSection id="gender-preference" title="Gender Preference Feature">
				<p>
					{APP_NAME} offers an optional gender preference feature for enhanced
					comfort and safety:
				</p>
				<ul>
					<li>Passengers can specify preference for same-gender drivers</li>
					<li>This preference is considered in the matching algorithm</li>
					<li>Availability depends on driver availability in your area</li>
					<li>
						Using this feature may increase wait times if same-gender drivers
						are not nearby
					</li>
					<li>Gender preference is optional and can be enabled/disabled</li>
				</ul>
				<p className="mt-3">
					This feature is designed to promote inclusivity and comfort,
					particularly for users who may feel more comfortable with same-gender
					service providers.
				</p>
			</LegalSection>

			<LegalSection id="prohibited-conduct" title={prohibitedConduct().title}>
				<LegalContentRenderer content={prohibitedConduct()} />
			</LegalSection>

			<LegalSection id="intellectual-property" title="Intellectual Property">
				<p>
					The {APP_NAME} platform, including its software, design, content,
					trademarks, and logos, is owned by {APP_NAME} and protected by
					Indonesian and international intellectual property laws.
				</p>
				<p>
					You are granted a limited, non-exclusive, non-transferable license to
					access and use the Services for personal, non-commercial purposes.
				</p>
				<p className="mt-3">
					<strong>User Content:</strong> You retain ownership of content you
					submit (photos, reviews, messages). By submitting content, you grant{" "}
					{APP_NAME} a worldwide, royalty-free license to use, display, and
					distribute your content for platform operations and marketing
					purposes.
				</p>
				<p className="mt-3">
					You represent that you have all necessary rights to submit content and
					that your content does not violate any third-party rights or laws.
				</p>
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
