import { env } from "cloudflare:workers";
import { Resend } from "resend";
import { MailError } from "../error";

interface BaseSendMailProps {
	from: string;
	to: string;
	subject: string;
	text: string;
}

interface SendResetPasswordProps
	extends Omit<BaseSendMailProps, "from" | "subject" | "text"> {
	url: string;
}

interface SendInvitationProps
	extends Omit<BaseSendMailProps, "from" | "subject" | "text"> {
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
	DEFAULT: "Zenta Dev <cs@info.zenta.dev>",
	VERIFICATION: "Zenta Verification <verification@info.zenta.dev>",
	RESET_PASSWORD: "Zenta Reset Password <reset-password@info.zenta.dev>",
	INVITATION: "Zenta Invitation <invitation@info.zenta.dev>",
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
		await this.sendMail({
			...props,
			from: MAIL_FROMS.RESET_PASSWORD,
			subject: "Reset password",
			text: `Click the link to verify your email: ${props.url}\nIf you did not request this, please ignore this email.`,
		});
	}

	async sendInvitation(props: SendInvitationProps): Promise<void> {
		await this.sendMail({
			...props,
			from: MAIL_FROMS.INVITATION,
			subject: "Invitation",
			text: `Your are invited into AkadeMove Platform as ${props.role}, this your credentials\nEmail: ${props.email}\nPassword: ${props.password}\nPlease immedietly change your password on ${env.CORS_ORIGIN}/sign-in`,
		});
	}
}
