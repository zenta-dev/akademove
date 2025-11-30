/** @jsxImportSource react */

import { env } from "cloudflare:workers";
import { render } from "@react-email/components";
import type * as React from "react";
import { Resend } from "resend";
import { MailError } from "../core/error";

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

export interface EmailService {
	render(
		component: React.ReactElement,
		opts?: RenderEmailOptions,
	): Promise<string>;
	renderPlainText(component: React.ReactElement): Promise<string>;
	send(
		component: React.ReactElement,
		opts: SendEmailOptions,
	): Promise<{ id: string }>;
}

export class ResendEmailService implements EmailService {
	#client: Resend;
	#defaultFrom: string;

	constructor(apiKey: string, defaultFrom: string) {
		this.#client = new Resend(apiKey);
		this.#defaultFrom = defaultFrom;
	}

	async render(
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

	async renderPlainText(component: React.ReactElement): Promise<string> {
		try {
			const text = await render(component, { plainText: true });
			return text;
		} catch (_error) {
			throw new MailError("Failed to render plain text email");
		}
	}

	async send(
		component: React.ReactElement,
		opts: SendEmailOptions,
	): Promise<{ id: string }> {
		try {
			const html = await this.render(component);
			const text = await this.renderPlainText(component);

			const response = await this.#client.emails.send({
				from: opts.from ?? this.#defaultFrom,
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

// Default email senders
export const MAIL_SENDERS = {
	DEFAULT: "AkadeMove <no-reply@mail.akademove.com>",
	SECURITY: "AkadeMove Security <security@mail.akademove.com>",
	SUPPORT: "AkadeMove Support <support@mail.akademove.com>",
	NOTIFICATIONS: "AkadeMove Notifications <notifications@mail.akademove.com>",
} as const;

// Factory function for creating email service
export function createEmailService(): EmailService {
	return new ResendEmailService(env.RESEND_API_KEY, MAIL_SENDERS.DEFAULT);
}
