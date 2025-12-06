import { env } from "cloudflare:workers";
import { render } from "@react-email/components";
import { EmailVerificationEmail } from "emails/email-verification";
import { InvitationEmail } from "emails/invitation";
import { ResetPasswordEmail } from "emails/reset-password";
import * as React from "react";
import { Resend } from "resend";
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

interface SendEmailVerificationProps {
	to: string;
	url: string;
	userName?: string;
}
interface RenderEmailOptions {
	pretty?: boolean;
	plainText?: boolean;
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
}

export const MAIL_FROMS = {
	DEFAULT: "Akademove <no-reply@mail.akademove.com>",
	SECURITY: "Akademove Security <security@mail.akademove.com>",
	INVITATION: "Akademove <no-reply@mail.akademove.com>",
	VERIFICATION: "Akademove Verification <verify@mail.akademove.com>",
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
					resetUrl: props.url,
				}),
				{
					from: MAIL_FROMS.SECURITY,
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
					verificationUrl: props.url,
				}),
				{
					from: MAIL_FROMS.VERIFICATION,
					to: props.to,
					subject: "Verify Your AkadeMove Email Address",
				},
			);
		} catch (error) {
			if (error instanceof MailError) throw error;
			throw new MailError("Failed to send email verification");
		}
	}

	async #render(
		component: React.ReactElement,
		opts: RenderEmailOptions = {},
	): Promise<string> {
		try {
			const html = await render(component, {
				pretty: opts.pretty ?? false,
				plainText: opts.plainText ?? false,
			});
			return html;
		} catch (_error) {
			throw new MailError("Failed to render email template");
		}
	}

	async #send(
		component: React.ReactElement,
		opts: SendEmailOptions,
	): Promise<{ id: string }> {
		try {
			const [html, text] = await Promise.all([
				this.#render(component),
				this.#render(component, { plainText: true }),
			]);

			const response = await this.#client.emails.send({
				from: opts.from ?? MAIL_FROMS.DEFAULT,
				to: opts.to,
				subject: opts.subject,
				html,
				text,
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
