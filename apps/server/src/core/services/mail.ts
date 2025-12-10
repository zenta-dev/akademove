import { env } from "cloudflare:workers";
import { ContactResponseEmail } from "emails/contact-response";
import { DriverApprovalStatusEmail } from "emails/driver-approval-status";
import { EmailVerificationEmail } from "emails/email-verification";
import { InvitationEmail } from "emails/invitation";
import { MerchantApprovalStatusEmail } from "emails/merchant-approval-status";
import { ResetPasswordEmail } from "emails/reset-password";
import * as React from "react";
import { Resend } from "resend";
import { logger } from "@/utils/logger";
import { MailError } from "../error";

interface BaseSendMailProps {
	from: string;
	to: string;
	subject: string;
	text: string;
}

interface SendResetPasswordProps {
	to: string;
	code: string;
	userName?: string;
}

interface SendInvitationProps {
	to: string;
	email: string;
	password: string;
	role: string;
}

interface SendEmailVerificationProps {
	to: string;
	code: string;
	userName?: string;
}

interface SendContactResponseProps {
	to: string;
	userName: string;
	subject: string;
	originalMessage: string;
	response: string;
	respondedBy: string;
}

interface SendDriverApprovalStatusProps {
	to: string;
	driverName: string;
	status: "APPROVED" | "REJECTED";
	reason?: string;
	rejectionDetails?: {
		studentCard?: string;
		driverLicense?: string;
		vehicleRegistration?: string;
	};
}

interface SendMerchantApprovalStatusProps {
	to: string;
	merchantName: string;
	status: "APPROVED" | "REJECTED";
	reason?: string;
	rejectionDetails?: {
		businessDocument?: string;
	};
}

interface SendEmailOptions {
	from?: string;
	to: string | string[];
	subject: string;
	replyTo?: string;
	cc?: string | string[];
	bcc?: string | string[];
	tags?: Array<{ name: string; value: string }>;
}

export interface MailService {
	sendMail(props: BaseSendMailProps): Promise<void>;
	sendResetPassword(props: SendResetPasswordProps): Promise<void>;
	sendInvitation(props: SendInvitationProps): Promise<void>;
	sendEmailVerification(props: SendEmailVerificationProps): Promise<void>;
	sendContactResponse(props: SendContactResponseProps): Promise<void>;
	sendDriverApprovalStatus(props: SendDriverApprovalStatusProps): Promise<void>;
	sendMerchantApprovalStatus(
		props: SendMerchantApprovalStatusProps,
	): Promise<void>;
}

export const MAIL_FROMS = {
	DEFAULT: "Akademove <no-reply@mail.akademove.com>",
	SECURITY: "Akademove Security <security@mail.akademove.com>",
	INVITATION: "Akademove <no-reply@mail.akademove.com>",
	VERIFICATION: "Akademove Verification <verify@mail.akademove.com>",
	SUPPORT: "Akademove Support <support@mail.akademove.com>",
};

export class ResendMailService implements MailService {
	#client: Resend;

	constructor(apiKey: string) {
		this.#client = new Resend(apiKey);
	}

	async sendMail(props: BaseSendMailProps): Promise<void> {
		try {
			await this.#client.emails.send(props);
		} catch (_error) {
			throw new MailError("Failed to send email");
		}
	}

	async sendResetPassword(props: SendResetPasswordProps): Promise<void> {
		try {
			await this.#send(
				React.createElement(ResetPasswordEmail, {
					userName: props.userName ?? "User",
					verificationCode: props.code,
				}),
				{
					from: MAIL_FROMS.SECURITY,
					to: props.to,
					subject: "Your AkadeMove Password Reset Code",
				},
			);
		} catch (error) {
			if (error instanceof MailError) throw error;
			throw new MailError("Failed to send reset password email");
		}
	}

	async sendInvitation(props: SendInvitationProps): Promise<void> {
		try {
			await this.#send(
				React.createElement(InvitationEmail, {
					email: props.email,
					password: props.password,
					role: props.role,
					loginUrl: `${env.CORS_ORIGIN}/sign-in`,
				}),
				{
					from: MAIL_FROMS.DEFAULT,
					to: props.to,
					subject: "Welcome to AkadeMove Platform",
				},
			);
		} catch (error) {
			if (error instanceof MailError) throw error;
			throw new MailError("Failed to send invitation email");
		}
	}

	async sendEmailVerification(
		props: SendEmailVerificationProps,
	): Promise<void> {
		try {
			await this.#send(
				React.createElement(EmailVerificationEmail, {
					userName: props.userName ?? "User",
					verificationCode: props.code,
				}),
				{
					from: MAIL_FROMS.VERIFICATION,
					to: props.to,
					subject: "Your AkadeMove Verification Code",
				},
			);
		} catch (error) {
			if (error instanceof MailError) throw error;
			throw new MailError("Failed to send email verification");
		}
	}

	async sendContactResponse(props: SendContactResponseProps): Promise<void> {
		try {
			logger.debug(
				{
					to: props.to,
					userName: props.userName,
					subject: props.subject,
					originalMessageLength: props.originalMessage?.length,
					responseLength: props.response?.length,
					respondedBy: props.respondedBy,
				},
				"[MailService] Sending contact response email",
			);
			const res = await this.#send(
				React.createElement(ContactResponseEmail, {
					userName: props.userName,
					subject: props.subject,
					originalMessage: props.originalMessage,
					response: props.response,
					respondedBy: props.respondedBy,
				}),
				{
					from: MAIL_FROMS.SUPPORT,
					to: props.to,
					subject: `Re: ${props.subject}`,
				},
			);
			logger.debug({ res }, "[MailService] Contact response email sent");
		} catch (error) {
			logger.error({ error }, "[MailService] sendContactResponse error");
			if (error instanceof MailError) throw error;
			throw new MailError("Failed to send contact response email");
		}
	}

	async sendDriverApprovalStatus(
		props: SendDriverApprovalStatusProps,
	): Promise<void> {
		try {
			const subject =
				props.status === "APPROVED"
					? "Your AkadeMove Driver Application Approved ✓"
					: "Action Required: Your AkadeMove Driver Application";

			await this.#send(
				React.createElement(DriverApprovalStatusEmail, {
					driverName: props.driverName,
					status: props.status,
					reason: props.reason,
					rejectionDetails: props.rejectionDetails,
				}),
				{
					from: MAIL_FROMS.DEFAULT,
					to: props.to,
					subject,
				},
			);
		} catch (error) {
			if (error instanceof MailError) throw error;
			throw new MailError("Failed to send driver approval email");
		}
	}

	async sendMerchantApprovalStatus(
		props: SendMerchantApprovalStatusProps,
	): Promise<void> {
		try {
			const subject =
				props.status === "APPROVED"
					? "Your AkadeMove Merchant Application Approved ✓"
					: "Action Required: Your AkadeMove Merchant Application";

			await this.#send(
				React.createElement(MerchantApprovalStatusEmail, {
					merchantName: props.merchantName,
					status: props.status,
					reason: props.reason,
					rejectionDetails: props.rejectionDetails,
				}),
				{
					from: MAIL_FROMS.DEFAULT,
					to: props.to,
					subject,
				},
			);
		} catch (error) {
			if (error instanceof MailError) throw error;
			throw new MailError("Failed to send merchant approval email");
		}
	}

	async #send(
		component: React.ReactElement,
		opts: SendEmailOptions,
	): Promise<{ id: string }> {
		try {
			const response = await this.#client.emails.send({
				from: opts.from ?? MAIL_FROMS.DEFAULT,
				to: opts.to,
				subject: opts.subject,
				react: component,
				replyTo: opts.replyTo,
				cc: opts.cc,
				bcc: opts.bcc,
				tags: opts.tags,
			});

			if (!response.data?.id) {
				throw new MailError("Failed to send email - no response ID");
			}

			return { id: response.data.id };
		} catch (error) {
			if (error instanceof MailError) throw error;
			throw new MailError("Failed to send email");
		}
	}
}
