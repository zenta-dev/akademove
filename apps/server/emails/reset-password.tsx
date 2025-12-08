/** @jsxImportSource react */
import { Heading, Hr, Section, Text } from "@react-email/components";
import { BaseLayout } from "./components/base-layout";

interface ResetPasswordEmailProps {
	userName: string;
	verificationCode: string;
}

export const ResetPasswordEmail = ({
	userName,
	verificationCode,
}: ResetPasswordEmailProps) => {
	return (
		<BaseLayout preview="Your AkadeMove password reset code">
			<Section>
				<Heading style={h1}>Reset Your Password</Heading>
				<Text style={text}>Hi {userName},</Text>
				<Text style={text}>
					We received a request to reset your password for your AkadeMove
					account. Enter the verification code below in the app to create a new
					password:
				</Text>
				<Section style={codeContainer}>
					<Text style={codeText}>{verificationCode}</Text>
				</Section>
				<Text style={text}>
					This code will expire in 15 minutes for security reasons.
				</Text>
				<Hr style={hr} />
				<Text style={footerNote}>
					If you didn't request this password reset, please ignore this email.
					Your password will remain unchanged.
				</Text>
				<Text style={footerNote}>
					For security reasons, never share this code with anyone.
				</Text>
			</Section>
		</BaseLayout>
	);
};

export default ResetPasswordEmail;

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
