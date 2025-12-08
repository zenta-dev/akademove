/** @jsxImportSource react */
import { Heading, Hr, Section, Text } from "@react-email/components";
import { BaseLayout } from "./components/base-layout";

interface EmailVerificationEmailProps {
	userName?: string;
	verificationCode: string;
}

export const EmailVerificationEmail = ({
	userName = "User",
	verificationCode,
}: EmailVerificationEmailProps) => {
	return (
		<BaseLayout preview="Your AkadeMove verification code">
			<Section>
				<Heading style={h1}>Verify Your Email Address</Heading>
				<Text style={text}>Hi {userName},</Text>
				<Text style={text}>
					Thank you for signing up for AkadeMove! To complete your registration
					and ensure the security of your account, please enter the verification
					code below in the app.
				</Text>
				<Section style={codeContainer}>
					<Text style={codeText}>{verificationCode}</Text>
				</Section>
				<Text style={text}>
					This verification code will expire in 15 minutes for security reasons.
					If you didn't create an account with AkadeMove, you can safely ignore
					this email.
				</Text>
				<Hr style={hr} />
				<Text style={footerNote}>
					For security reasons, never share this code with anyone.
				</Text>
			</Section>
		</BaseLayout>
	);
};

export default EmailVerificationEmail;

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

const codeContainer = {
	margin: "32px 0",
	textAlign: "center" as const,
	backgroundColor: "#f3f4f6",
	borderRadius: "8px",
	padding: "24px",
};

const codeText = {
	color: "#0d9488",
	fontSize: "36px",
	fontWeight: "700",
	letterSpacing: "8px",
	margin: "0",
	fontFamily: "monospace",
};

const hr = {
	borderColor: "#e5e7eb",
	margin: "32px 0",
};

const footerNote = {
	color: "#6b7280",
	fontSize: "14px",
	lineHeight: "1.6",
	margin: "0 0 8px 0",
};
