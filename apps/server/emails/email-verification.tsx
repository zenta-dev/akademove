/** @jsxImportSource react */
import { Button, Heading, Hr, Section, Text } from "@react-email/components";
import { BaseLayout } from "./components/base-layout";

interface EmailVerificationEmailProps {
	userName?: string;
	verificationUrl: string;
}

export const EmailVerificationEmail = ({
	userName = "User",
	verificationUrl,
}: EmailVerificationEmailProps) => {
	return (
		<BaseLayout preview="Verify your email address for AkadeMove">
			<Section>
				<Heading style={h1}>Verify Your Email Address</Heading>
				<Text style={text}>Hi {userName},</Text>
				<Text style={text}>
					Thank you for signing up for AkadeMove! To complete your registration
					and ensure the security of your account, please verify your email
					address by clicking the button below.
				</Text>
				<Section style={buttonContainer}>
					<Button style={button} href={verificationUrl}>
						Verify Email Address
					</Button>
				</Section>
				<Text style={text}>
					This verification link will expire in 24 hours for security reasons.
					If you didn't create an account with AkadeMove, you can safely ignore
					this email.
				</Text>
				<Hr style={hr} />
				<Text style={footerNote}>
					If the button above doesn't work, you can copy and paste this link
					into your browser:
				</Text>
				<Text style={linkText}>{verificationUrl}</Text>
				<Text style={footerNote}>
					For security reasons, never share this link with anyone.
				</Text>
			</Section>
		</BaseLayout>
	);
};

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

const buttonContainer = {
	margin: "32px 0",
	textAlign: "center" as const,
};

const button = {
	backgroundColor: "#667eea",
	borderRadius: "8px",
	color: "#ffffff",
	fontSize: "16px",
	fontWeight: "600",
	textDecoration: "none",
	textAlign: "center" as const,
	display: "inline-block",
	padding: "14px 32px",
	lineHeight: "1",
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

const linkText = {
	color: "#667eea",
	fontSize: "12px",
	lineHeight: "1.6",
	margin: "0 0 8px 0",
	wordBreak: "break-all" as const,
};
