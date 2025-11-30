/** @jsxImportSource react */
import { env } from "cloudflare:workers";
import * as React from "react";
import { Resend } from "resend";
import {
	createEmailService,
	type EmailService,
	InvitationEmail,
	MAIL_SENDERS,
	ResetPasswordEmail,
} from "@/emails";
import { MailError } from "../error";

interface BaseSendMailProps {
	from: string;
	to: string;
	subject: string;
	text: string;
}

interface SendResetPasswordProps {
	to: string;
	url: string;
	userName?: string;
}

interface SendInvitationProps {
	to: string;
	email: string;
	password: string;
	role: string;
}

export interface MailService {
	sendMail(props: BaseSendMailProps): Promise<void>;
	sendResetPassword(props: SendResetPasswordProps): Promise<void>;
	sendInvitation(props: SendInvitationProps): Promise<void>;
}

// TODO: Replace with actual domain
export const MAIL_FROMS = {
	DEFAULT: "Akademove <no-reply@mail.akademove.com>",
	VERIFICATION: "Akademove Security <security@mail.akademove.com>",
	RESET_PASSWORD: "Akademove Security <security@mail.akademove.com>",
	INVITATION: "Akademove <no-reply@mail.akademove.com>",
};

export class ResendMailService implements MailService {
	#client: Resend;
	#emailService: EmailService;

	constructor(apiKey: string) {
		this.#client = new Resend(apiKey);
		this.#emailService = createEmailService();
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
			await this.#emailService.send(
				React.createElement(ResetPasswordEmail, {
					userName: props.userName ?? "User",
					resetUrl: props.url,
				}),
				{
					from: MAIL_SENDERS.SECURITY,
					to: props.to,
					subject: "Reset Your AkadeMove Password",
				},
			);
		} catch (error) {
			if (error instanceof MailError) throw error;
			throw new MailError("Failed to send reset password email");
		}
	}

	async sendInvitation(props: SendInvitationProps): Promise<void> {
		try {
			await this.#emailService.send(
				React.createElement(InvitationEmail, {
					email: props.email,
					password: props.password,
					role: props.role,
					loginUrl: `${env.CORS_ORIGIN}/sign-in`,
				}),
				{
					from: MAIL_SENDERS.DEFAULT,
					to: props.to,
					subject: "Welcome to AkadeMove Platform",
				},
			);
		} catch (error) {
			if (error instanceof MailError) throw error;
			throw new MailError("Failed to send invitation email");
		}
	}
}
