import { type App, cert, getApps, initializeApp } from "firebase-admin/app";
import {
	type AndroidConfig,
	type ApnsConfig,
	type FcmOptions,
	getMessaging,
	type Message,
	type Messaging,
	type WebpushConfig,
} from "firebase-admin/messaging";
import { log } from "@/utils";
import { FirebaseError } from "../error";

export interface NotificationPayload {
	title: string;
	body: string;
	data?: Record<string, string>;
	android?: AndroidConfig;
	webpush?: WebpushConfig;
	apns?: ApnsConfig;
	fcmOptions?: FcmOptions;
}

export interface SendNotificationOptions extends NotificationPayload {
	token: string;
}

export interface SendToTopicOptions extends NotificationPayload {
	topic: string;
}

export class FirebaseAdminService {
	readonly #app: App;
	readonly #messaging: Messaging;

	constructor(credStr: string) {
		const parse = JSON.parse(credStr);
		if (!getApps().length) {
			this.#app = initializeApp({
				credential: cert({
					projectId: parse.project_id,
					clientEmail: parse.client_email,
					privateKey: parse.private_key?.replace(/\\n/g, "\n"),
				}),
			});
		} else {
			this.#app = getApps()[0];
		}

		this.#messaging = getMessaging(this.#app);
	}

	async sendNotification(options: SendNotificationOptions): Promise<string> {
		const message: Message = {
			android: options.android,
			webpush: options.webpush,
			apns: options.apns,
			fcmOptions: options.fcmOptions,
			token: options.token,
			notification: {
				title: options.title,
				body: options.body,
			},
			data: options.data,
		};

		try {
			return await this.#messaging.send(message);
		} catch (error) {
			log.error(
				{ error },
				`[${this.constructor.name}] - send notification error`,
			);

			const msg = error instanceof Error ? error.message : "Unknown error";

			throw new FirebaseError(msg, { code: "INTERNAL_SERVER_ERROR" });
		}
	}

	async sendToTopic(options: SendToTopicOptions): Promise<string> {
		const message: Message = {
			android: options.android,
			webpush: options.webpush,
			apns: options.apns,
			fcmOptions: options.fcmOptions,
			topic: options.topic,
			notification: {
				title: options.title,
				body: options.body,
			},
			data: options.data,
		};

		try {
			return await this.#messaging.send(message);
		} catch (error) {
			log.error({ error }, `[${this.constructor.name}] - send to topic error`);

			const msg = error instanceof Error ? error.message : "Unknown error";

			throw new FirebaseError(msg, { code: "INTERNAL_SERVER_ERROR" });
		}
	}

	async sendMulticast(
		tokens: string[],
		payload: NotificationPayload,
	): Promise<{
		successCount: number;
		failureCount: number;
		failedTokens: string[];
	}> {
		const message = {
			tokens,
			notification: {
				title: payload.title,
				body: payload.body,
			},
			data: payload.data,
		};

		try {
			const response = await this.#messaging.sendEachForMulticast(message);

			const failedTokens: string[] = [];
			response.responses.forEach((resp, idx) => {
				if (!resp.success) failedTokens.push(tokens[idx]);
			});

			return {
				successCount: response.successCount,
				failureCount: response.failureCount,
				failedTokens,
			};
		} catch (error) {
			log.error({ error }, `[${this.constructor.name}] - send multicast error`);

			const msg = error instanceof Error ? error.message : "Unknown error";

			throw new FirebaseError(msg, { code: "INTERNAL_SERVER_ERROR" });
		}
	}

	async subscribeToTopic(tokens: string | string[], topic: string) {
		try {
			const tokenArray = Array.isArray(tokens) ? tokens : [tokens];
			const result = await this.#messaging.subscribeToTopic(tokenArray, topic);

			return result;
		} catch (error) {
			log.error(
				{ error },
				`[${this.constructor.name}] - subscribe to topic error`,
			);

			const msg = error instanceof Error ? error.message : "Unknown error";

			throw new FirebaseError(msg, { code: "INTERNAL_SERVER_ERROR" });
		}
	}

	async unsubscribeFromTopic(tokens: string | string[], topic: string) {
		try {
			const tokenArray = Array.isArray(tokens) ? tokens : [tokens];
			const result = await this.#messaging.unsubscribeFromTopic(
				tokenArray,
				topic,
			);

			return result;
		} catch (error) {
			log.error(
				{ error },
				`[${this.constructor.name}] - unsubscribe to topic error`,
			);

			const msg = error instanceof Error ? error.message : "Unknown error";

			throw new FirebaseError(msg, { code: "INTERNAL_SERVER_ERROR" });
		}
	}

	async sendCustomMessage(message: Message): Promise<string> {
		try {
			return await this.#messaging.send(message);
		} catch (error) {
			log.error(
				{ error },
				`[${this.constructor.name}] - send custom message error`,
			);

			const msg = error instanceof Error ? error.message : "Unknown error";

			throw new FirebaseError(msg, { code: "INTERNAL_SERVER_ERROR" });
		}
	}
}
