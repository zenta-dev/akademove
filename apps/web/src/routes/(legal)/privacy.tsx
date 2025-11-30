import { m } from "@repo/i18n";
import { createFileRoute } from "@tanstack/react-router";
import {
	LegalLayout,
	LegalSection,
	type LegalSection as LegalSectionType,
	LegalSubsection,
} from "@/components/legal/legal-layout";
import { APP_NAME } from "@/lib/constants";
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
import { LegalContentRenderer } from "@/lib/legal/legal-content-renderer";

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
	{ id: "introduction", title: m.privacy_policy() },
	{
		id: "information-collection",
		title: informationWeCollect().title,
		subsections: [
			{ id: "personal-info", title: "Personal Information" },
			{ id: "location-data", title: "Location Data" },
			{ id: "verification-docs", title: "Verification Documents" },
			{ id: "transaction-data", title: "Transaction Data" },
			{ id: "usage-data", title: "Usage Data" },
		],
	},
	{
		id: "how-we-use",
		title: howWeUseInformation().title,
		subsections: [
			{ id: "service-provision", title: "Service Provision" },
			{ id: "safety-security", title: "Safety and Security" },
			{ id: "analytics", title: "Analytics and Improvements" },
			{ id: "communications", title: "Communications" },
		],
	},
	{
		id: "data-sharing",
		title: informationSharing().title,
		subsections: [
			{ id: "within-platform", title: "Within the Platform" },
			{ id: "third-party", title: "Third-Party Services" },
			{ id: "legal-requirements", title: "Legal Requirements" },
		],
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
			<LegalSection id="introduction" title="Introduction">
				{privacyIntro().map((paragraph, index) => (
					// biome-ignore lint/suspicious/noArrayIndexKey: Static content
					<p key={index}>{paragraph}</p>
				))}
			</LegalSection>

			<LegalSection id="information-collection" title="Information We Collect">
				<LegalSubsection id="personal-info" title="Personal Information">
					<p>
						We collect personal information that you voluntarily provide to us
						when you register on the platform, including:
					</p>
					<ul>
						<li>
							<strong>Basic Information:</strong> Full name, email address,
							phone number, date of birth, and gender
						</li>
						<li>
							<strong>Profile Information:</strong> Profile photo, preferred
							language, and user preferences
						</li>
						<li>
							<strong>Student Verification:</strong> Student ID (KTM) for campus
							community verification
						</li>
						<li>
							<strong>Driver-Specific Information:</strong> Driver's license
							(SIM), vehicle registration (STNK), license plate number, and
							vehicle type
						</li>
						<li>
							<strong>Merchant Information:</strong> Business name, address,
							contact details, and business documentation
						</li>
						<li>
							<strong>Banking Information:</strong> Bank account details for
							withdrawals and payments
						</li>
					</ul>
				</LegalSubsection>

				<LegalSubsection id="location-data" title="Location Data">
					<p>
						We collect and process location data to provide our core services:
					</p>
					<ul>
						<li>
							<strong>Real-Time Location:</strong> When you use our services as
							a passenger or driver, we collect precise GPS location data to
							facilitate ride matching, navigation, and delivery
						</li>
						<li>
							<strong>Location Storage:</strong> Location data is stored using
							PostGIS (PostgreSQL geographic extension) with geometry points in
							SRID 4326 format
						</li>
						<li>
							<strong>Pickup and Dropoff Locations:</strong> We store the
							coordinates of your pickup and dropoff points for order history
							and dispute resolution
						</li>
						<li>
							<strong>Merchant Locations:</strong> Static location data for
							merchant outlets to enable food and goods delivery services
						</li>
					</ul>
					<p className="mt-3">
						Location tracking can be controlled through your device settings and
						is only active when you are using the app. Drivers can toggle their
						availability status to stop location tracking when offline.
					</p>
				</LegalSubsection>

				<LegalSubsection id="verification-docs" title="Verification Documents">
					<p>
						For safety and compliance purposes, we collect and verify the
						following documents:
					</p>
					<ul>
						<li>
							<strong>Student ID Card (KTM):</strong> To verify campus community
							membership
						</li>
						<li>
							<strong>Driver's License (SIM):</strong> To verify driver
							eligibility and compliance with transportation regulations
						</li>
						<li>
							<strong>Vehicle Registration (STNK):</strong> To verify vehicle
							ownership and legality
						</li>
						<li>
							<strong>Selfie Photos:</strong> For identity verification and
							fraud prevention
						</li>
						<li>
							<strong>Merchant Documents:</strong> Business permits and outlet
							verification documents
						</li>
					</ul>
					<p className="mt-3">
						All documents are reviewed by our verification team and stored
						securely with encryption. Access to these documents is restricted to
						authorized personnel only.
					</p>
				</LegalSubsection>

				<LegalSubsection id="transaction-data" title="Transaction Data">
					<p>We collect transaction and financial information, including:</p>
					<ul>
						<li>Payment method information (QRIS, e-wallet, bank transfer)</li>
						<li>Transaction amounts, dates, and status</li>
						<li>Wallet balance and transaction history</li>
						<li>Commission calculations and payouts</li>
						<li>Coupon and promotion usage</li>
						<li>Refund and dispute records</li>
					</ul>
					<p className="mt-3">
						Payment processing is handled by our third-party payment provider,
						Midtrans. We do not store complete credit card or bank account
						numbers on our servers.
					</p>
				</LegalSubsection>

				<LegalSubsection id="usage-data" title="Usage Data">
					<p>We automatically collect information about your app usage:</p>
					<ul>
						<li>
							Device information (model, operating system, unique identifiers)
						</li>
						<li>App usage statistics and interaction patterns</li>
						<li>Order history and service preferences</li>
						<li>Driver schedules and availability patterns</li>
						<li>Rating and review data</li>
						<li>In-app chat messages (for quality and safety purposes)</li>
						<li>Report submissions and safety incidents</li>
					</ul>
				</LegalSubsection>
			</LegalSection>

			<LegalSection id="how-we-use" title="How We Use Your Information">
				<LegalSubsection id="service-provision" title="Service Provision">
					<p>
						We use your information to provide, maintain, and improve our
						services:
					</p>
					<ul>
						<li>
							<strong>Matching and Routing:</strong> Connect passengers with
							nearby available drivers based on location, gender preferences,
							and driver ratings
						</li>
						<li>
							<strong>Distance Calculation:</strong> Calculate trip distances
							using Google Maps API for accurate pricing
						</li>
						<li>
							<strong>Dynamic Pricing:</strong> Apply pricing formula (base
							price + distance × rate per km + tip - coupon discount)
						</li>
						<li>
							<strong>Schedule Management:</strong> Automatically adjust driver
							availability based on their class schedules
						</li>
						<li>
							<strong>Payment Processing:</strong> Process payments and manage
							wallet balances
						</li>
						<li>
							<strong>Commission Calculation:</strong> Automatically deduct
							platform commission (15% for rides/delivery, 20% for food orders)
						</li>
						<li>
							<strong>Order Management:</strong> Track order status through all
							stages (requested → matching → accepted → arriving → in-trip →
							completed)
						</li>
					</ul>
				</LegalSubsection>

				<LegalSubsection id="safety-security" title="Safety and Security">
					<p>
						We process your information to maintain a safe and secure platform:
					</p>
					<ul>
						<li>
							<strong>Gender Preference Matching:</strong> Honor your gender
							preference settings for driver matching to enhance safety and
							comfort
						</li>
						<li>
							<strong>Phone Number Masking:</strong> Protect privacy by masking
							phone numbers in all communications between users
						</li>
						<li>
							<strong>Identity Verification:</strong> Verify driver and merchant
							identities through document review
						</li>
						<li>
							<strong>Rating and Reputation System:</strong> Track user ratings
							to promote good behavior and identify problematic users
						</li>
						<li>
							<strong>Report Investigation:</strong> Review and respond to user
							reports of misconduct, harassment, or safety concerns
						</li>
						<li>
							<strong>Fraud Detection:</strong> Monitor for suspicious activity,
							duplicate accounts, GPS spoofing, and other fraudulent behavior
						</li>
						<li>
							<strong>Account Suspension:</strong> Temporarily or permanently
							ban users who violate platform policies
						</li>
					</ul>
				</LegalSubsection>

				<LegalSubsection id="analytics" title="Analytics and Improvements">
					<p>We analyze usage data to improve our platform:</p>
					<ul>
						<li>Monitor service performance and reliability</li>
						<li>Understand usage patterns and trends</li>
						<li>Optimize driver matching algorithms</li>
						<li>Improve route efficiency and ETA accuracy</li>
						<li>Develop new features based on user needs</li>
						<li>Generate insights for campus administration</li>
						<li>Measure promotion effectiveness</li>
					</ul>
				</LegalSubsection>

				<LegalSubsection id="communications" title="Communications">
					<p>We use your contact information to send:</p>
					<ul>
						<li>
							<strong>Transactional Notifications:</strong> Order updates,
							payment confirmations, and service alerts via push notifications
							and email
						</li>
						<li>
							<strong>Promotional Communications:</strong> Information about
							promotions, coupons, and special events (with opt-out option)
						</li>
						<li>
							<strong>Operator Broadcasts:</strong> Important announcements from
							campus operators
						</li>
						<li>
							<strong>Safety Alerts:</strong> Emergency notifications and safety
							information
						</li>
						<li>
							<strong>Administrative Messages:</strong> Account updates, policy
							changes, and verification status
						</li>
					</ul>
				</LegalSubsection>
			</LegalSection>

			<LegalSection id="data-sharing" title="Data Sharing and Disclosure">
				<LegalSubsection id="within-platform" title="Within the Platform">
					<p>
						We share limited information between users to facilitate services:
					</p>
					<ul>
						<li>
							<strong>Driver-Passenger Matching:</strong> When a ride is
							accepted, drivers see passenger name, pickup location, and
							destination; passengers see driver name, photo, vehicle details,
							and rating
						</li>
						<li>
							<strong>Merchant Orders:</strong> Merchants receive customer name
							and delivery address for food orders
						</li>
						<li>
							<strong>Masked Communication:</strong> Phone numbers are masked in
							all in-app chat communications
						</li>
						<li>
							<strong>Public Profiles:</strong> Driver ratings, badge status,
							and leaderboard rankings are visible to users
						</li>
						<li>
							<strong>Reviews:</strong> Your ratings and comments may be visible
							to other users (username only, no full profile)
						</li>
					</ul>
				</LegalSubsection>

				<LegalSubsection id="third-party" title="Third-Party Services">
					<p>
						We share data with trusted third-party service providers who assist
						in operating our platform:
					</p>
					<ul>
						<li>
							<strong>Firebase (Google):</strong> Authentication services, push
							notifications (FCM), and cloud messaging
						</li>
						<li>
							<strong>Google Maps API:</strong> Mapping, routing, geocoding, and
							distance calculation services
						</li>
						<li>
							<strong>Midtrans:</strong> Payment processing for QRIS, e-wallet,
							and bank transfer transactions
						</li>
						<li>
							<strong>Cloudflare:</strong> Infrastructure hosting, edge
							computing, and DDoS protection
						</li>
						<li>
							<strong>AWS S3:</strong> Secure storage for uploaded documents and
							images
						</li>
					</ul>
					<p className="mt-3">
						These service providers are contractually obligated to protect your
						data and use it only for the purposes we specify.
					</p>
				</LegalSubsection>

				<LegalSubsection id="legal-requirements" title="Legal Requirements">
					<p>
						We may disclose your information if required to do so by law or in
						response to:
					</p>
					<ul>
						<li>Valid legal processes (subpoenas, court orders)</li>
						<li>Government or regulatory requests</li>
						<li>Protection of our rights, property, or safety</li>
						<li>Investigation of fraud or security issues</li>
						<li>Campus security emergencies</li>
						<li>Compliance with Indonesian laws and regulations</li>
					</ul>
				</LegalSubsection>
			</LegalSection>

			<LegalSection id="data-security" title="Data Security">
				<p>
					We implement comprehensive security measures to protect your personal
					information:
				</p>
				<ul>
					<li>
						<strong>Encryption in Transit:</strong> All data transmission uses
						TLS 1.3 encryption
					</li>
					<li>
						<strong>Encryption at Rest:</strong> Sensitive data is encrypted in
						our databases
					</li>
					<li>
						<strong>Password Security:</strong> Passwords are hashed using
						bcrypt with a cost factor of 12
					</li>
					<li>
						<strong>Token Management:</strong> JWT tokens with 1-hour expiration
						for session management
					</li>
					<li>
						<strong>Access Control:</strong> Role-based access control (RBAC)
						limits data access to authorized personnel only
					</li>
					<li>
						<strong>Rate Limiting:</strong> 100 requests per minute per IP to
						prevent abuse
					</li>
					<li>
						<strong>Audit Logs:</strong> All administrative actions and
						configuration changes are logged
					</li>
					<li>
						<strong>OWASP Compliance:</strong> Protection against OWASP Top 10
						vulnerabilities including SQL injection and XSS attacks
					</li>
					<li>
						<strong>Database Backups:</strong> Automated backups every 6 hours
						with secure storage
					</li>
					<li>
						<strong>Security Monitoring:</strong> Continuous monitoring for
						suspicious activity and security threats
					</li>
				</ul>
				<p className="mt-3">
					While we implement strong security measures, no system is completely
					secure. We cannot guarantee absolute security but continuously work to
					improve our protections.
				</p>
			</LegalSection>

			<LegalSection id="your-rights" title={yourRights().title}>
				<LegalContentRenderer content={yourRights()} />
			</LegalSection>

			<LegalSection id="data-retention" title={dataRetention().title}>
				<LegalContentRenderer content={dataRetention()} />
			</LegalSection>

			<LegalSection id="childrens-privacy" title="Children's Privacy">
				<p>
					{APP_NAME} is designed for use by university students and adults. Our
					services are not intended for children under 17 years of age. We do
					not knowingly collect personal information from children under 17.
				</p>
				<p>
					If you are a parent or guardian and believe your child has provided us
					with personal information, please contact us immediately at{" "}
					<a href="mailto:privacy@akademove.com" className="text-primary">
						privacy@akademove.com
					</a>
					. We will take steps to delete such information from our systems.
				</p>
			</LegalSection>

			<LegalSection id="changes" title="Changes to This Policy">
				<p>
					We may update this Privacy Policy from time to time to reflect changes
					in our practices, technology, legal requirements, or other factors. We
					will notify you of any material changes by:
				</p>
				<ul>
					<li>Posting the updated policy on our website and mobile app</li>
					<li>Updating the "Last Updated" date at the top of this policy</li>
					<li>Sending a notification through the app or via email</li>
					<li>
						Requiring acceptance of the updated policy for continued use (for
						significant changes)
					</li>
				</ul>
				<p className="mt-3">
					We encourage you to review this Privacy Policy periodically to stay
					informed about how we protect your information.
				</p>
			</LegalSection>

			<LegalSection id="contact" title="Contact Information">
				<p>
					If you have questions, concerns, or requests regarding this Privacy
					Policy or our data practices, please contact us:
				</p>
				<div className="mt-4 rounded-lg bg-secondary/30 p-4">
					<p className="font-semibold">{APP_NAME} Data Protection Officer</p>
					<p className="mt-2">Email: privacy@akademove.com</p>
					<p>Support: hello@akademove.com</p>
					<p>Phone: +62 812-3456-7890</p>
					<p className="mt-2">Address: Surabaya, Indonesia</p>
				</div>
				<p className="mt-4">
					For complaints about data protection matters, you may also contact the
					Indonesian Ministry of Communication and Informatics or other relevant
					regulatory authorities.
				</p>
			</LegalSection>
		</LegalLayout>
	);
}
