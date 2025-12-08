/** @jsxImportSource react */
import { Button, Heading, Hr, Section, Text } from "@react-email/components";
import { BaseLayout } from "./components/base-layout";

interface MerchantApprovalStatusEmailProps {
	merchantName: string;
	status: "APPROVED" | "REJECTED";
	reason?: string;
	rejectionDetails?: {
		businessDocument?: string;
	};
}

export const MerchantApprovalStatusEmail = ({
	merchantName,
	status,
	reason,
	rejectionDetails,
}: MerchantApprovalStatusEmailProps) => {
	const isApproved = status === "APPROVED";

	return (
		<BaseLayout
			preview={
				isApproved
					? "Your AkadeMove Merchant Application Approved"
					: "Action Required: Your AkadeMove Merchant Application"
			}
		>
			<Section>
				{isApproved ? (
					<>
						<Heading style={h1}>Your Merchant Application is Approved!</Heading>
						<Text style={text}>Dear {merchantName},</Text>
						<Text style={text}>
							Congratulations! Your merchant application has been approved by
							the AkadeMove team. All your documents have been verified
							successfully.
						</Text>

						<Section style={checklistBox}>
							<Text style={checklistTitle}>Verification Summary:</Text>
							<Text style={checklistItem}>Business Document - Verified</Text>
						</Section>

						<Text style={text}>You can now:</Text>
						<ul style={bulletList}>
							<li style={bulletItem}>
								Set up your store profile and add your products/menu items
							</li>
							<li style={bulletItem}>
								Configure your operating hours and delivery settings
							</li>
							<li style={bulletItem}>Start accepting orders from customers</li>
							<li style={bulletItem}>
								View your sales dashboard and analytics
							</li>
						</ul>

						<Section style={ctaSection}>
							<Button
								style={ctaButton}
								href="https://akademove.com/dash/merchant"
							>
								Go to Merchant Dashboard
							</Button>
						</Section>

						<Hr style={hr} />

						<Text style={nextSteps}>
							<strong>Next Steps:</strong>
						</Text>
						<ul style={bulletList}>
							<li style={bulletItem}>
								Set up your bank account for earnings withdrawal
							</li>
							<li style={bulletItem}>Add your menu items and set prices</li>
							<li style={bulletItem}>
								Configure your store availability and operating hours
							</li>
						</ul>
					</>
				) : (
					<>
						<Heading style={h1}>
							Application Update: Documents Need Revision
						</Heading>
						<Text style={text}>Dear {merchantName},</Text>
						<Text style={text}>
							Thank you for applying to be an AkadeMove merchant. We've reviewed
							your application and found that some documents need adjustments.
							Please review the details below and resubmit the required
							documents.
						</Text>

						{rejectionDetails && (
							<Section style={rejectionBox}>
								<Text style={rejectionTitle}>
									Documents Requiring Revision:
								</Text>

								{rejectionDetails.businessDocument && (
									<Section style={documentItem}>
										<Text style={documentLabel}>Business Document</Text>
										<Text style={documentReason}>
											Reason: {rejectionDetails.businessDocument}
										</Text>
									</Section>
								)}
							</Section>
						)}

						{reason && (
							<Section style={reasonBox}>
								<Text style={reasonLabel}>General Notes:</Text>
								<Text style={reasonContent}>{reason}</Text>
							</Section>
						)}

						<Text style={text}>
							<strong>What to do next:</strong>
						</Text>
						<ol style={bulletList}>
							<li style={bulletItem}>
								Review the feedback provided above carefully
							</li>
							<li style={bulletItem}>
								Prepare corrected or new documents as needed
							</li>
							<li style={bulletItem}>
								Resubmit your application through your merchant account
							</li>
							<li style={bulletItem}>
								We'll review your updated application within 1-2 business days
							</li>
						</ol>

						<Section style={ctaSection}>
							<Button
								style={ctaButton}
								href="https://akademove.com/dash/merchant"
							>
								Review &amp; Resubmit Application
							</Button>
						</Section>

						<Hr style={hr} />

						<Text style={text}>
							If you have questions about the feedback or need clarification,
							please don't hesitate to contact our support team.
						</Text>
					</>
				)}

				<Hr style={hr} />

				<Text style={footerNote}>
					Questions? Our support team is ready to help:{" "}
					<a href="mailto:support@akademove.com" style={link}>
						support@akademove.com
					</a>
				</Text>

				<Text style={footerNote}>
					We're excited to welcome you to the AkadeMove merchant community!
				</Text>
			</Section>
		</BaseLayout>
	);
};

export default MerchantApprovalStatusEmail;

// Styles
const h1 = {
	color: "#000",
	fontSize: "24px",
	fontWeight: "bold",
	margin: "20px 0 10px",
} as const;

const text = {
	color: "#555",
	fontSize: "14px",
	lineHeight: "1.6",
	margin: "10px 0",
} as const;

const checklistBox = {
	backgroundColor: "#f0f7ff",
	border: "1px solid #d0e4ff",
	borderRadius: "8px",
	padding: "16px",
	margin: "20px 0",
} as const;

const checklistTitle = {
	color: "#000",
	fontSize: "14px",
	fontWeight: "bold",
	margin: "0 0 12px",
} as const;

const checklistItem = {
	color: "#1e7a34",
	fontSize: "13px",
	margin: "6px 0",
	fontWeight: "500",
} as const;

const rejectionBox = {
	backgroundColor: "#fff3cd",
	border: "1px solid #ffeaa7",
	borderRadius: "8px",
	padding: "16px",
	margin: "20px 0",
} as const;

const rejectionTitle = {
	color: "#000",
	fontSize: "14px",
	fontWeight: "bold",
	margin: "0 0 12px",
} as const;

const documentItem = {
	backgroundColor: "#fff",
	border: "1px solid #ffeaa7",
	borderRadius: "6px",
	padding: "12px",
	margin: "10px 0",
} as const;

const documentLabel = {
	color: "#d63031",
	fontSize: "13px",
	fontWeight: "bold",
	margin: "0 0 6px",
} as const;

const documentReason = {
	color: "#555",
	fontSize: "12px",
	lineHeight: "1.5",
	margin: "0",
} as const;

const reasonBox = {
	backgroundColor: "#f8f9fa",
	border: "1px solid #dee2e6",
	borderRadius: "6px",
	padding: "12px",
	margin: "20px 0",
} as const;

const reasonLabel = {
	color: "#000",
	fontSize: "13px",
	fontWeight: "bold",
	margin: "0 0 8px",
} as const;

const reasonContent = {
	color: "#555",
	fontSize: "13px",
	lineHeight: "1.5",
	margin: "0",
	whiteSpace: "pre-wrap",
} as const;

const bulletList = {
	paddingLeft: "20px",
	margin: "12px 0",
} as const;

const bulletItem = {
	color: "#555",
	fontSize: "13px",
	margin: "6px 0",
	lineHeight: "1.5",
} as const;

const ctaSection = {
	textAlign: "center" as const,
	margin: "24px 0",
} as const;

const ctaButton = {
	backgroundColor: "#2980b9",
	color: "#fff",
	fontSize: "14px",
	fontWeight: "bold",
	borderRadius: "6px",
	textDecoration: "none",
	display: "inline-block",
} as const;

const hr = {
	borderColor: "#ddd",
	borderTop: "1px solid #ddd",
	margin: "24px 0",
} as const;

const nextSteps = {
	color: "#000",
	fontSize: "14px",
	margin: "16px 0 8px",
} as const;

const footerNote = {
	color: "#888",
	fontSize: "12px",
	lineHeight: "1.5",
	margin: "8px 0",
} as const;

const link = {
	color: "#2980b9",
	textDecoration: "none",
	fontSize: "12px",
} as const;
