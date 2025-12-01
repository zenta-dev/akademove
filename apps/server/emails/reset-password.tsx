/** @jsxImportSource react */
import { Button, Heading, Hr, Section, Text } from "@react-email/components";
import { BaseLayout } from "./components/base-layout";

interface ResetPasswordEmailProps {
	userName: string;
	resetUrl: string;
}

export const ResetPasswordEmail = ({
	userName,
	resetUrl,
}: ResetPasswordEmailProps) => {
	return (
		<BaseLayout preview="Reset your AkadeMove password">
			<Section>
				<Heading style={h1}>Reset Your Password</Heading>
				<Text style={text}>Hi {userName},</Text>
				<Text style={text}>
					We received a request to reset your password for your AkadeMove
					account. Click the button below to create a new password:
				</Text>
				<Section style={buttonContainer}>
					<Button style={button} href={resetUrl}>
						Reset Password
					</Button>
				</Section>
				<Text style={text}>
					This link will expire in 1 hour for security reasons.
				</Text>
				<Hr style={hr} />
				<Text style={footerNote}>
					If you didn't request this password reset, please ignore this email.
					Your password will remain unchanged.
				</Text>
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
