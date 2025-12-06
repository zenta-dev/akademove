/** @jsxImportSource react */
import {
	Body,
	Container,
	Head,
	Heading,
	Html,
	Link,
	Preview,
	Section,
	Text,
} from "@react-email/components";
import type * as React from "react";

interface BaseLayoutProps {
	preview: string;
	children: React.ReactNode;
	footer?: React.ReactNode;
}

export const BaseLayout = ({ preview, children, footer }: BaseLayoutProps) => {
	return (
		<Html>
			<Head />
			<Preview>{preview}</Preview>
			<Body style={main}>
				<Container style={container}>
					{/* Header */}
					<Section style={header}>
						<Section style={logoSection}>
							<Heading style={logo}>
								<span style={logoGradient}>Akade</span>
								<span style={logoSecondary}>Move</span>
							</Heading>
							<Text style={tagline}>Your Smart Campus Mobility Solution</Text>
						</Section>
					</Section>

					{/* Main Content */}
					<Section style={content}>{children}</Section>

					{/* Footer */}
					<Section style={footerSection}>
						<Section style={divider} />
						{footer || (
							<>
								<Text style={footerText}>
									<strong>AkadeMove</strong> - Connecting Campus Communities
								</Text>
								<Text style={footerSubText}>
									Ride, Deliver, Dine - All in One Platform
								</Text>
								<Section style={socialLinks}>
									<Link href="https://akademove.com" style={socialLink}>
										Website
									</Link>
									<Text style={socialDivider}>•</Text>
									<Link href="https://akademove.com/support" style={socialLink}>
										Support
									</Link>
									<Text style={socialDivider}>•</Text>
									<Link href="https://akademove.com/privacy" style={socialLink}>
										Privacy
									</Link>
								</Section>
								<Text style={footerCopyright}>
									© {new Date().getFullYear()} AkadeMove. All rights reserved.
								</Text>
								<Text style={footerAddress}>
									Campus Innovation Hub, Universitas Indonesia
									<br />
									Depok, West Java 16424, Indonesia
								</Text>
							</>
						)}
					</Section>
				</Container>
			</Body>
		</Html>
	);
};

// Modern Styles with Tailwind-inspired design
const main = {
	backgroundColor: "#f9fafb",
	fontFamily:
		'-apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, "Helvetica Neue", Ubuntu, sans-serif',
};

const container = {
	backgroundColor: "#ffffff",
	margin: "0 auto",
	padding: "0",
	marginBottom: "64px",
	marginTop: "32px",
	borderRadius: "12px",
	boxShadow:
		"0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06)",
	maxWidth: "600px",
	overflow: "hidden",
};

const header = {
	background: "linear-gradient(135deg, #0d9488 0%, #0f766e 100%)",
	padding: "40px 32px",
	textAlign: "center" as const,
	borderRadius: "12px 12px 0 0",
};

const logoSection = {
	margin: "0 auto",
};

const logo = {
	color: "#ffffff",
	fontSize: "42px",
	fontWeight: "800",
	margin: "0",
	padding: "0",
	letterSpacing: "-0.5px",
	lineHeight: "1.2",
};

const logoGradient = {
	background: "linear-gradient(90deg, #ffffff 0%, #ccfbf1 100%)",
	WebkitBackgroundClip: "text",
	WebkitTextFillColor: "transparent",
	backgroundClip: "text",
	fontWeight: "900",
};

const logoSecondary = {
	color: "#fde047",
	fontWeight: "800",
};

const tagline = {
	color: "#ccfbf1",
	fontSize: "14px",
	fontWeight: "500",
	margin: "8px 0 0 0",
	letterSpacing: "0.5px",
};

const content = {
	padding: "48px 32px",
	backgroundColor: "#ffffff",
};

const footerSection = {
	backgroundColor: "#f9fafb",
	padding: "32px 32px 24px 32px",
	borderRadius: "0 0 12px 12px",
};

const divider = {
	borderTop: "2px solid #e5e7eb",
	marginBottom: "24px",
};

const footerText = {
	color: "#1f2937",
	fontSize: "16px",
	fontWeight: "600",
	margin: "0 0 8px 0",
	textAlign: "center" as const,
};

const footerSubText = {
	color: "#6b7280",
	fontSize: "14px",
	margin: "0 0 24px 0",
	textAlign: "center" as const,
};

const socialLinks = {
	textAlign: "center" as const,
	marginBottom: "24px",
};

const socialLink = {
	color: "#0d9488",
	fontSize: "14px",
	fontWeight: "600",
	textDecoration: "none",
	margin: "0 8px",
};

const socialDivider = {
	color: "#9ca3af",
	fontSize: "14px",
	margin: "0 4px",
	display: "inline-block",
};

const footerCopyright = {
	color: "#9ca3af",
	fontSize: "12px",
	margin: "16px 0 8px 0",
	textAlign: "center" as const,
};

const footerAddress = {
	color: "#9ca3af",
	fontSize: "11px",
	margin: "0",
	textAlign: "center" as const,
	lineHeight: "1.6",
};
