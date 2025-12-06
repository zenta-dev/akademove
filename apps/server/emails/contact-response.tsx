/** @jsxImportSource react */
import { Heading, Hr, Section, Text } from "@react-email/components";
import { BaseLayout } from "./components/base-layout";

interface ContactResponseEmailProps {
	userName: string;
	subject: string;
	originalMessage: string;
	response: string;
	respondedBy: string;
}

export const ContactResponseEmail = ({
	userName,
	subject,
	originalMessage,
	response,
	respondedBy,
}: ContactResponseEmailProps) => {
	return (
		<BaseLayout preview={`Response to your inquiry: ${subject}`}>
			<Section>
				<Heading style={h1}>We've Responded to Your Inquiry</Heading>
				<Text style={text}>Dear {userName},</Text>
				<Text style={text}>
					Thank you for reaching out to us. Our team has reviewed your inquiry
					and provided a response below.
				</Text>

				<Section style={messageBox}>
					<Text style={messageLabel}>Your Original Message:</Text>
					<Text style={messageSubject}>{subject}</Text>
					<Text style={messageContent}>{originalMessage}</Text>
				</Section>

				<Section style={responseBox}>
					<Text style={responseLabel}>Our Response:</Text>
					<Text style={responseContent}>{response}</Text>
					<Text style={respondedByText}>— {respondedBy}, AkadeMove Team</Text>
				</Section>

				<Hr style={hr} />

				<Text style={text}>
					If you have any further questions or need additional assistance,
					please don't hesitate to reach out to us again through our contact
					form or reply to this email.
				</Text>

				<Text style={footerNote}>
					Thank you for being part of the AkadeMove community. We're here to
					help make your campus mobility experience better!
				</Text>
			</Section>
		</BaseLayout>
	);
};

export default ContactResponseEmail;

const h1 = {
	color: "#1f2937",
	fontSize: "28px",
	fontWeight: "700",
	margin: "0 0 24px 0",
	lineHeight: "1.3",
};

const text = {
	color: "#374151",
	fontSize: "16px",
	lineHeight: "1.6",
	margin: "0 0 16px 0",
};

const messageBox = {
	backgroundColor: "#f9fafb",
	border: "2px solid #e5e7eb",
	borderRadius: "8px",
	padding: "24px",
	margin: "24px 0",
};

const messageLabel = {
	color: "#6b7280",
	fontSize: "13px",
	fontWeight: "600",
	textTransform: "uppercase" as const,
	letterSpacing: "0.5px",
	margin: "0 0 8px 0",
};

const messageSubject = {
	color: "#1f2937",
	fontSize: "18px",
	fontWeight: "600",
	margin: "0 0 12px 0",
};

const messageContent = {
	color: "#4b5563",
	fontSize: "14px",
	lineHeight: "1.6",
	margin: "0",
	whiteSpace: "pre-wrap" as const,
};

const responseBox = {
	backgroundColor: "#eff6ff",
	border: "2px solid #667eea",
	borderRadius: "8px",
	padding: "24px",
	margin: "24px 0",
};

const responseLabel = {
	color: "#667eea",
	fontSize: "13px",
	fontWeight: "600",
	textTransform: "uppercase" as const,
	letterSpacing: "0.5px",
	margin: "0 0 12px 0",
};

const responseContent = {
	color: "#1f2937",
	fontSize: "15px",
	lineHeight: "1.7",
	margin: "0 0 16px 0",
	whiteSpace: "pre-wrap" as const,
};

const respondedByText = {
	color: "#6b7280",
	fontSize: "14px",
	fontStyle: "italic" as const,
	margin: "0",
	textAlign: "right" as const,
};

const hr = {
	borderColor: "#e5e7eb",
	margin: "32px 0",
};

const footerNote = {
	color: "#6b7280",
	fontSize: "14px",
	lineHeight: "1.6",
	margin: "0",
};
