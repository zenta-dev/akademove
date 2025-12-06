/** @jsxImportSource react */
import {
	Button,
	Column,
	Heading,
	Hr,
	Row,
	Section,
	Text,
} from "@react-email/components";
import { BaseLayout } from "./components/base-layout";

interface OrderConfirmationEmailProps {
	userName: string;
	orderId: string;
	orderType: "RIDE" | "DELIVERY" | "FOOD";
	orderDate: string;
	totalAmount: string;
	pickupLocation?: string;
	dropoffLocation: string;
	driverName?: string;
	estimatedTime?: string;
	trackingUrl: string;
}

export const OrderConfirmationEmail = ({
	userName,
	orderId,
	orderType,
	orderDate,
	totalAmount,
	pickupLocation,
	dropoffLocation,
	driverName,
	estimatedTime,
	trackingUrl,
}: OrderConfirmationEmailProps) => {
	const orderTypeLabel =
		orderType === "RIDE"
			? "Ride"
			: orderType === "DELIVERY"
				? "Delivery"
				: "Food Order";

	return (
		<BaseLayout
			preview={`Your ${orderTypeLabel} is confirmed - Order #${orderId}`}
		>
			<Section>
				<Section style={statusBadge}>
					<Text style={statusText}>✓ Order Confirmed</Text>
				</Section>

				<Heading style={h1}>Your {orderTypeLabel} is On the Way!</Heading>

				<Text style={text}>Hi {userName},</Text>
				<Text style={text}>
					Great news! Your order has been confirmed and{" "}
					{driverName ? `${driverName} is` : "a driver will be"} on the way
					shortly.
				</Text>

				<Section style={infoBox}>
					<Row style={infoRow}>
						<Column style={infoLabel}>Order ID:</Column>
						<Column style={infoValue}>#{orderId}</Column>
					</Row>
					<Row style={infoRow}>
						<Column style={infoLabel}>Order Type:</Column>
						<Column style={infoValue}>{orderTypeLabel}</Column>
					</Row>
					<Row style={infoRow}>
						<Column style={infoLabel}>Date & Time:</Column>
						<Column style={infoValue}>{orderDate}</Column>
					</Row>
					{estimatedTime && (
						<Row style={infoRow}>
							<Column style={infoLabel}>Estimated Time:</Column>
							<Column style={infoValue}>{estimatedTime}</Column>
						</Row>
					)}
					{driverName && (
						<Row style={infoRow}>
							<Column style={infoLabel}>Driver:</Column>
							<Column style={infoValue}>{driverName}</Column>
						</Row>
					)}
				</Section>

				{pickupLocation && (
					<>
						<Text style={sectionTitle}>Pickup Location</Text>
						<Section style={locationBox}>
							<Text style={locationText}>📍 {pickupLocation}</Text>
						</Section>
					</>
				)}

				<Text style={sectionTitle}>
					{orderType === "RIDE" ? "Drop-off Location" : "Delivery Address"}
				</Text>
				<Section style={locationBox}>
					<Text style={locationText}>📍 {dropoffLocation}</Text>
				</Section>

				<Hr style={hr} />

				<Section style={totalSection}>
					<Row>
						<Column>
							<Text style={totalLabel}>Total Amount:</Text>
						</Column>
						<Column>
							<Text style={totalAmountStyle}>{totalAmount}</Text>
						</Column>
					</Row>
				</Section>

				<Section style={buttonContainer}>
					<Button style={button} href={trackingUrl}>
						Track Your Order
					</Button>
				</Section>

				<Hr style={hr} />

				<Text style={footerNote}>
					Need help? Contact our support team or track your order in real-time
					using the link above.
				</Text>
			</Section>
		</BaseLayout>
	);
};

export default OrderConfirmationEmail;

const statusBadge = {
	backgroundColor: "#ccfbf1",
	border: "2px solid #0d9488",
	borderRadius: "24px",
	padding: "8px 20px",
	textAlign: "center" as const,
	margin: "0 auto 24px auto",
	maxWidth: "fit-content",
};

const statusText = {
	color: "#0f766e",
	fontSize: "14px",
	fontWeight: "700",
	margin: "0",
	textTransform: "uppercase" as const,
	letterSpacing: "0.5px",
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

const infoBox = {
	backgroundColor: "#f9fafb",
	border: "2px solid #e5e7eb",
	borderRadius: "8px",
	padding: "20px",
	margin: "24px 0",
};

const infoRow = {
	marginBottom: "12px",
};

const infoLabel = {
	color: "#6b7280",
	fontSize: "14px",
	fontWeight: "600",
	width: "40%",
};

const infoValue = {
	color: "#1f2937",
	fontSize: "14px",
	fontWeight: "600",
	width: "60%",
	textAlign: "right" as const,
};

const sectionTitle = {
	color: "#1f2937",
	fontSize: "16px",
	fontWeight: "700",
	margin: "24px 0 12px 0",
};

const locationBox = {
	backgroundColor: "#f0fdfa",
	border: "2px solid #ccfbf1",
	borderRadius: "8px",
	padding: "16px",
	margin: "0 0 16px 0",
};

const locationText = {
	color: "#0f766e",
	fontSize: "15px",
	lineHeight: "1.6",
	margin: "0",
};

const hr = {
	borderColor: "#e5e7eb",
	margin: "32px 0",
};

const totalSection = {
	backgroundColor: "#f9fafb",
	borderRadius: "8px",
	padding: "20px",
	margin: "0 0 24px 0",
};

const totalLabel = {
	color: "#1f2937",
	fontSize: "18px",
	fontWeight: "700",
	margin: "0",
};

const totalAmountStyle = {
	color: "#0d9488",
	fontSize: "24px",
	fontWeight: "800",
	margin: "0",
};

const buttonContainer = {
	margin: "32px 0",
	textAlign: "center" as const,
};

const button = {
	backgroundColor: "#0d9488",
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

const footerNote = {
	color: "#6b7280",
	fontSize: "14px",
	lineHeight: "1.6",
	margin: "0",
	textAlign: "center" as const,
};
