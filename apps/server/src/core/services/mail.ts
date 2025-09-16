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

export interface MailService {
	sendMail(props: BaseSendMailProps): Promise<void>;
	sendResetPassword(props: SendResetPasswordProps): Promise<void>;
}

// TODO: Replace with actual domain
export const MAIL_FROMS = Object.freeze({
	DEFAULT: "Zenta Dev <cs@info.zenta.dev>",
	VERIFICATION: "Zenta Verification <verification@info.zenta.dev>",
	RESET_PASSWORD: "Zenta Reset Password <reset-password@info.zenta.dev>",
} as const);

export class ResendMailService implements MailService {
	#client: Resend;
	constructor(apiKey: string) {
		this.#client = new Resend(apiKey);
	}

	async sendMail(props: BaseSendMailProps): Promise<void> {
		try {
			await this.#client.emails.send(props);
		} catch (error) {
			throw new MailError("Failed to send email", {
				prevError: error instanceof Error ? error : undefined,
			});
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
}
