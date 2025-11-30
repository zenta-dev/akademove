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

// Driver Requirements Section
export const driverRequirements = (): LegalSectionContent =>
	getLegalContent({
		en: {
			title: "Driver Requirements",
			paragraphs: [],
		},
		id: undefined,
	});

export const driverDocuments = (): LegalSectionContent =>
	getLegalContent({
		en: {
			title: "Required Documents",
			paragraphs: ["All drivers must submit and maintain current:"],
			lists: [
				{
					items: [
						{
							label: "Student ID Card (KTM)",
							content: "Valid proof of current enrollment",
						},
						{
							label: "Driver's License (SIM)",
							content:
								"Valid SIM C (motorcycle) or SIM A (car) from Indonesian authorities",
						},
						{
							label: "Vehicle Registration (STNK)",
							content:
								"Current vehicle registration matching the vehicle used for services",
						},
						{
							label: "Vehicle Photos",
							content: "Clear photos of your vehicle from multiple angles",
						},
						{
							label: "Selfie Photo",
							content: "Recent photo for identity verification",
						},
					],
				},
			],
			additionalParagraphs: [
				"Documents must be clearly readable and not expired. You must update documents before expiration to maintain active driver status.",
			],
		},
		id: undefined,
	});

export const driverSchedule = (): LegalSectionContent =>
	getLegalContent({
		en: {
			title: "Class Schedule Management",
			paragraphs: [
				"One of AkadeMove's unique features is class schedule integration:",
			],
			lists: [
				{
					items: [
						{
							content:
								"Drivers can input their class schedules (manual entry or calendar import when available)",
						},
						{
							content:
								'The system automatically sets drivers to "offline" status during scheduled class times',
						},
						{
							content: "Schedules can be one-time or recurring weekly",
						},
						{
							content:
								"Drivers can override automatic offline status if their schedule changes",
						},
					],
				},
			],
			additionalParagraphs: [
				"This feature helps drivers balance their academic responsibilities with earning opportunities. However, you remain responsible for managing your own schedule and ensuring you do not accept orders during times you are unavailable.",
			],
		},
		id: undefined,
	});

export const driverAvailability = (): LegalSectionContent =>
	getLegalContent({
		en: {
			title: "Availability and Online Status",
			paragraphs: ["As a driver, you control your availability:"],
			lists: [
				{
					items: [
						{
							content:
								'Toggle between "online" (available for orders) and "offline" (not available)',
						},
						{
							content:
								"When online, you will receive order requests based on your location and rider preferences",
						},
						{
							content: "You have the right to accept or reject order requests",
						},
						{
							content:
								"However, excessive rejection rates may affect your priority in the matching algorithm",
						},
						{
							content:
								"Repeated cancellations after accepting orders may result in warnings or suspension",
						},
					],
				},
			],
		},
		id: undefined,
	});

// Pricing and Payments Sections
export const pricingPayments = (): LegalSectionContent =>
	getLegalContent({
		en: {
			title: "Pricing and Payments",
			paragraphs: [],
		},
		id: undefined,
	});

export const pricingStructure = (): LegalSectionContent =>
	getLegalContent({
		en: {
			title: "Pricing Structure",
			paragraphs: [
				"Pricing for rides and delivery services is calculated using the following formula:",
				"**Total Price = Base Price + (Distance in KM × Price per KM) + Tip - Coupon Discount**",
			],
			lists: [
				{
					items: [
						{
							label: "Base Price",
							content: "Minimum charge for any order, set by campus operators",
						},
						{
							label: "Price per KM",
							content: "Rate per kilometer traveled, configurable by operators",
						},
						{
							label: "Distance Calculation",
							content:
								"Calculated using Google Maps API for the shortest route",
						},
						{
							label: "Tips",
							content: "Optional gratuity added by passengers",
						},
						{
							label: "Coupons",
							content: "Promotional discounts applied at checkout",
						},
					],
				},
			],
			additionalParagraphs: [
				"**Food Orders:** Food prices are set by merchants. A delivery fee based on distance applies separately.",
				"You will see the estimated fare before confirming your order. The final fare is calculated based on the actual route taken.",
			],
		},
		id: undefined,
	});

export const commissionStructure = (): LegalSectionContent =>
	getLegalContent({
		en: {
			title: "Commission Structure",
			paragraphs: ["AkadeMove operates on a commission-based model:"],
			lists: [
				{
					items: [
						{
							label: "Rides and Package Delivery",
							content: "15% platform commission deducted from the total fare",
						},
						{
							label: "Food Delivery",
							content:
								"20% total commission (10% from merchant, 10% from driver earnings)",
						},
						{
							label: "Tips",
							content:
								"Tips go directly to drivers without commission deduction (configurable by operators)",
						},
					],
				},
			],
			additionalParagraphs: [
				"**Example Calculation:**\nRide Total: Rp 25,000\nPlatform Commission (15%): Rp 3,750\nDriver Earnings: Rp 21,250",
				"Commission rates are subject to change with advance notice. Drivers and merchants will be notified of any rate changes at least 14 days in advance.",
			],
		},
		id: undefined,
	});

export const walletSystem = (): LegalSectionContent =>
	getLegalContent({
		en: {
			title: "Wallet System",
			paragraphs: ["All users have an in-app wallet for managing funds:"],
			lists: [
				{
					items: [
						{
							label: "Top-Up",
							content:
								"Passengers can add funds via QRIS, bank transfer, or e-wallet through our payment partner Midtrans",
						},
						{
							label: "Payment",
							content:
								"Order payments are automatically deducted from wallet balance",
						},
						{
							label: "Earnings",
							content:
								"Driver and merchant earnings are credited to their wallets after order completion",
						},
						{
							label: "Balance Tracking",
							content: "View real-time wallet balance and transaction history",
						},
						{
							label: "Currency",
							content: "All transactions are in Indonesian Rupiah (IDR)",
						},
					],
				},
			],
			additionalParagraphs: [
				"Insufficient wallet balance will prevent order placement. Minimum top-up amounts and transaction limits may apply.",
			],
		},
		id: undefined,
	});

export const withdrawals = (): LegalSectionContent =>
	getLegalContent({
		en: {
			title: "Withdrawals",
			paragraphs: [
				"Drivers and merchants can withdraw earnings to their registered bank accounts:",
			],
			lists: [
				{
					items: [
						{ content: "Minimum withdrawal amount: Rp 50,000" },
						{ content: "Processing time: 1-3 business days" },
						{
							content: "Bank account must be in the driver/merchant's name",
						},
						{ content: "Transaction fees may apply depending on the bank" },
						{
							content:
								"Failed withdrawals due to incorrect bank information may incur fees",
						},
					],
				},
			],
		},
		id: undefined,
	});

// Order Management Sections
export const orderManagement = (): LegalSectionContent =>
	getLegalContent({
		en: {
			title: "Order Management",
			paragraphs: [],
		},
		id: undefined,
	});

export const rideHailing = (): LegalSectionContent =>
	getLegalContent({
		en: {
			title: "Ride-Hailing Services",
			paragraphs: [
				"**Passenger Responsibilities:**",
				"- Specify accurate pickup and dropoff locations\n- Be ready at the pickup location when the driver arrives\n- Treat drivers with respect and courtesy\n- Follow all safety guidelines\n- Ensure you have sufficient wallet balance",
				"",
				"**Driver Responsibilities:**",
				"- Accept orders you can fulfill\n- Navigate to pickup location promptly\n- Follow the designated route or a reasonable alternative\n- Maintain vehicle cleanliness and safety\n- Treat passengers with respect and ensure a comfortable journey\n- Complete orders as requested",
				"",
				"**Order Status Flow:**",
				"Requested → Matching → Accepted → Arriving → In-Trip → Completed",
			],
		},
		id: undefined,
	});

export const packageDelivery = (): LegalSectionContent =>
	getLegalContent({
		en: {
			title: "Package Delivery",
			paragraphs: ["For package delivery services:"],
			lists: [
				{
					items: [
						{
							label: "Sender Responsibilities",
							content:
								"Accurately describe package size, provide clear pickup/dropoff addresses, ensure package is ready for pickup",
						},
						{
							label: "Driver Responsibilities",
							content:
								"Handle packages with care, obtain proof of delivery (photo or OTP from recipient), do not open or inspect package contents",
						},
						{
							label: "Prohibited Items",
							content:
								"Illegal substances, weapons, hazardous materials, cash, perishable food without proper packaging, or items exceeding size/weight limits",
						},
					],
				},
			],
			additionalParagraphs: [
				"AkadeMove is not responsible for package contents. Users agree not to ship prohibited or illegal items through our platform.",
			],
		},
		id: undefined,
	});

export const foodDelivery = (): LegalSectionContent =>
	getLegalContent({
		en: {
			title: "Food Delivery",
			paragraphs: [
				"**Order Workflow:**",
				"- Customer places order from merchant menu\n- Merchant accepts and prepares order\n- Driver is assigned to pick up from merchant\n- Driver delivers to customer location",
				"",
				"**Merchant Responsibilities:**",
				"- Maintain accurate menu, pricing, and availability\n- Prepare orders within reasonable timeframes\n- Package food securely for delivery\n- Ensure food safety and quality standards\n- Mark items as out of stock promptly",
				"",
				"**Food Quality:** AkadeMove is not responsible for food quality, preparation, or safety. Merchants are solely responsible for the food they provide.",
			],
		},
		id: undefined,
	});

// Safety and Additional Sections
export const safetyReporting = (): LegalSectionContent =>
	getLegalContent({
		en: {
			title: "Safety and Reporting",
			paragraphs: [
				"Your safety is our priority. AkadeMove provides several safety features:",
			],
			lists: [
				{
					items: [
						{
							label: "In-App Chat",
							content:
								"Communicate without sharing phone numbers (phone masking enabled)",
						},
						{
							label: "Driver Verification",
							content:
								"All drivers undergo document verification before activation",
						},
						{
							label: "Real-Time Tracking",
							content: "Share your trip with trusted contacts",
						},
						{
							label: "Emergency Button",
							content: "Quick access to campus security or emergency services",
						},
						{
							label: "Report System",
							content:
								"Report misconduct, harassment, fraud, or safety concerns",
						},
					],
				},
			],
			additionalParagraphs: [
				"**Reporting Process:**\n- Submit report through the app with description and evidence\n- Reports are reviewed by our safety team within 24-48 hours\n- Investigation may include reviewing chat logs, order details, and GPS data\n- Actions taken may include warnings, temporary suspension, or permanent ban\n- Serious incidents may be reported to campus security or police",
				"**User Responsibilities:**\n- Report any safety concerns immediately\n- Do not share personal information unnecessarily\n- Use only the in-app communication features\n- Follow campus safety guidelines\n- Do not engage in prohibited conduct",
			],
		},
		id: undefined,
	});

export const genderPreference = (): LegalSectionContent =>
	getLegalContent({
		en: {
			title: "Gender Preference Feature",
			paragraphs: [
				"AkadeMove offers an optional gender preference feature for enhanced comfort and safety:",
			],
			lists: [
				{
					items: [
						{
							content:
								"Passengers can specify preference for same-gender drivers",
						},
						{
							content:
								"This preference is considered in the matching algorithm",
						},
						{
							content:
								"Availability depends on driver availability in your area",
						},
						{
							content:
								"Using this feature may increase wait times if same-gender drivers are not nearby",
						},
						{
							content:
								"Gender preference is optional and can be enabled/disabled",
						},
					],
				},
			],
			additionalParagraphs: [
				"This feature is designed to promote inclusivity and comfort, particularly for users who may feel more comfortable with same-gender service providers.",
			],
		},
		id: undefined,
	});

export const intellectualProperty = (): LegalSectionContent =>
	getLegalContent({
		en: {
			title: "Intellectual Property",
			paragraphs: [
				"The AkadeMove platform, including its software, design, content, trademarks, and logos, is owned by AkadeMove and protected by Indonesian and international intellectual property laws.",
				"You are granted a limited, non-exclusive, non-transferable license to access and use the Services for personal, non-commercial purposes.",
				"**User Content:** You retain ownership of content you submit (photos, reviews, messages). By submitting content, you grant AkadeMove a worldwide, royalty-free license to use, display, and distribute your content for platform operations and marketing purposes.",
				"You represent that you have all necessary rights to submit content and that your content does not violate any third-party rights or laws.",
			],
		},
		id: undefined,
	});
