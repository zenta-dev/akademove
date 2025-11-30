/** @jsxImportSource react */
import { Button, Heading, Hr, Section, Text } from "@react-email/components";
import { BaseLayout } from "../components/base-layout";

interface InvitationEmailProps {
	email: string;
	password: string;
	role: string;
	loginUrl: string;
}

export const InvitationEmail = ({
	email,
	password,
	role,
	loginUrl,
}: InvitationEmailProps) => {
	return (
		<BaseLayout preview="Welcome to AkadeMove Platform">
			<Section>
				<Heading style={h1}>Welcome to AkadeMove!</Heading>
				<Text style={text}>
					You've been invited to join the AkadeMove platform as a{" "}
					<strong style={highlight}>{role}</strong>.
				</Text>
				<Text style={text}>
					We're excited to have you on board! Your account has been created with
					the following credentials:
				</Text>

				<Section style={credentialsBox}>
					<Text style={credentialLabel}>Email Address:</Text>
					<Text style={credentialValue}>{email}</Text>
					<Text style={credentialLabel}>Temporary Password:</Text>
					<Text style={credentialValue}>{password}</Text>
				</Section>

				<Section style={warningBox}>
					<Text style={warningText}>
						⚠️ <strong>Important:</strong> For your security, please change your
						password immediately after your first login.
					</Text>
				</Section>

				<Section style={buttonContainer}>
					<Button style={button} href={loginUrl}>
						Sign In to Your Account
					</Button>
				</Section>

				<Hr style={hr} />

				<Text style={text}>
					<strong>Getting Started:</strong>
				</Text>
				<Text style={listItem}>1. Click the button above to sign in</Text>
				<Text style={listItem}>2. Use the temporary credentials provided</Text>
				<Text style={listItem}>3. Update your password in settings</Text>
				<Text style={listItem}>4. Complete your profile information</Text>

				<Hr style={hr} />

				<Text style={footerNote}>
					If you didn't expect this invitation or have any questions, please
					contact our support team.
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

const highlight = {
	color: "#667eea",
	fontWeight: "600",
};

const credentialsBox = {
	backgroundColor: "#f9fafb",
	border: "2px solid #e5e7eb",
	borderRadius: "8px",
	padding: "24px",
	margin: "24px 0",
};

const credentialLabel = {
	color: "#6b7280",
	fontSize: "13px",
	fontWeight: "600",
	textTransform: "uppercase" as const,
	letterSpacing: "0.5px",
	margin: "0 0 6px 0",
};

const credentialValue = {
	backgroundColor: "#ffffff",
	border: "1px solid #d1d5db",
	borderRadius: "4px",
	color: "#1f2937",
	fontSize: "15px",
	fontWeight: "600",
	padding: "10px 12px",
	display: "block",
	marginBottom: "16px",
	fontFamily: "monospace",
};

const warningBox = {
	backgroundColor: "#fef3c7",
	border: "2px solid #fbbf24",
	borderRadius: "8px",
	padding: "16px",
	margin: "24px 0",
};

const warningText = {
	color: "#78350f",
	fontSize: "14px",
	lineHeight: "1.6",
	margin: "0",
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

const listItem = {
	color: "#374151",
	fontSize: "15px",
	lineHeight: "1.6",
	margin: "0 0 8px 0",
	paddingLeft: "12px",
};

const footerNote = {
	color: "#6b7280",
	fontSize: "14px",
	lineHeight: "1.6",
	margin: "0",
};
