/**
 * Firebase Cloud Messaging (FCM) HTTP v1 API Service
 *
 * This is a lightweight implementation that works in Cloudflare Workers.
 * It replaces the heavy firebase-admin SDK which is not compatible with Workers.
 *
 * Uses Google's OAuth2 for authentication via service account JWT.
 */

import { importPKCS8, SignJWT } from "jose";
import { logger } from "@/utils/logger";
import { FirebaseError } from "../error";

// FCM message types (compatible with firebase-admin types)
export interface AndroidNotification {
	clickAction?: string;
	channelId?: string;
}

export interface AndroidConfig {
	priority?: "high" | "normal";
	notification?: AndroidNotification;
}

export interface ApnsAps {
	category?: string;
	sound?: string;
	badge?: number;
}

export interface ApnsPayload {
	aps?: ApnsAps;
}

export interface ApnsConfig {
	payload?: ApnsPayload;
}

export interface WebpushFcmOptions {
	link?: string;
}

export interface WebpushConfig {
	fcmOptions?: WebpushFcmOptions;
}

export interface FcmOptions {
	analyticsLabel?: string;
}

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

interface FCMMessage {
	token?: string;
	topic?: string;
	notification: {
		title: string;
		body: string;
	};
	data?: Record<string, string>;
	android?: {
		priority?: string;
		notification?: {
			click_action?: string;
			channel_id?: string;
		};
	};
	apns?: {
		payload?: {
			aps?: {
				category?: string;
				sound?: string;
				badge?: number;
			};
		};
	};
	webpush?: {
		fcm_options?: {
			link?: string;
		};
	};
	fcm_options?: {
		analytics_label?: string;
	};
}

interface ServiceAccountCredentials {
	project_id: string;
	client_email: string;
	private_key: string;
}

export interface TopicManagementResponse {
	successCount: number;
	failureCount: number;
	errors?: Array<{ index: number; error: { code: string; message: string } }>;
}

const FCM_SCOPE = "https://www.googleapis.com/auth/firebase.messaging";
const TOKEN_URL = "https://oauth2.googleapis.com/token";
const FCM_URL = "https://fcm.googleapis.com/v1/projects";
const IID_URL = "https://iid.googleapis.com/iid";

// Cache for access token (1 hour validity, refresh 5 min before expiry)
let cachedToken: { token: string; expiresAt: number } | null = null;

export class FirebaseAdminService {
	readonly #credentials: ServiceAccountCredentials;
	readonly #projectId: string;

	constructor(credStr: string) {
		const parse = JSON.parse(credStr) as ServiceAccountCredentials;
		this.#credentials = {
			project_id: parse.project_id,
			client_email: parse.client_email,
			private_key: parse.private_key?.replace(/\\n/g, "\n"),
		};
		this.#projectId = parse.project_id;
	}

	/**
	 * Get OAuth2 access token for FCM API
	 * Caches the token and refreshes 5 minutes before expiry
	 */
	private async getAccessToken(): Promise<string> {
		const now = Date.now();

		// Return cached token if valid (with 5 min buffer)
		if (cachedToken && cachedToken.expiresAt > now + 5 * 60 * 1000) {
			return cachedToken.token;
		}

		try {
			// Create JWT assertion for Google OAuth2
			const privateKey = await importPKCS8(
				this.#credentials.private_key,
				"RS256",
			);

			const nowSec = Math.floor(now / 1000);
			const jwt = await new SignJWT({
				scope: FCM_SCOPE,
			})
				.setProtectedHeader({ alg: "RS256", typ: "JWT" })
				.setIssuer(this.#credentials.client_email)
				.setSubject(this.#credentials.client_email)
				.setAudience(TOKEN_URL)
				.setIssuedAt(nowSec)
				.setExpirationTime(nowSec + 3600) // 1 hour
				.sign(privateKey);

			// Exchange JWT for access token
			const response = await fetch(TOKEN_URL, {
				method: "POST",
				headers: {
					"Content-Type": "application/x-www-form-urlencoded",
				},
				body: new URLSearchParams({
					grant_type: "urn:ietf:params:oauth:grant-type:jwt-bearer",
					assertion: jwt,
				}),
			});

			if (!response.ok) {
				const errorText = await response.text();
				throw new Error(`OAuth2 token request failed: ${errorText}`);
			}

			const tokenData = (await response.json()) as {
				access_token: string;
				expires_in: number;
			};

			// Cache the token
			cachedToken = {
				token: tokenData.access_token,
				expiresAt: now + tokenData.expires_in * 1000,
			};

			return tokenData.access_token;
		} catch (error) {
			logger.error(
				{ error },
				"[FirebaseAdminService] Failed to get access token",
			);
			throw new FirebaseError("Failed to authenticate with Firebase", {
				code: "INTERNAL_SERVER_ERROR",
			});
		}
	}

	/**
	 * Build FCM message payload from options
	 */
	private buildMessage(
		options: SendNotificationOptions | SendToTopicOptions,
	): FCMMessage {
		const message: FCMMessage = {
			notification: {
				title: options.title,
				body: options.body,
			},
		};

		if ("token" in options && options.token) {
			message.token = options.token;
		}

		if ("topic" in options && options.topic) {
			message.topic = options.topic;
		}

		if (options.data) {
			message.data = options.data;
		}

		if (options.android) {
			message.android = {
				priority: options.android.priority,
			};
			if (options.android.notification) {
				message.android.notification = {
					click_action: options.android.notification.clickAction,
					channel_id: options.android.notification.channelId,
				};
			}
		}

		if (options.apns) {
			message.apns = {
				payload: {
					aps: options.apns.payload?.aps,
				},
			};
		}

		if (options.webpush?.fcmOptions) {
			message.webpush = {
				fcm_options: {
					link: options.webpush.fcmOptions.link,
				},
			};
		}

		if (options.fcmOptions) {
			message.fcm_options = {
				analytics_label: options.fcmOptions.analyticsLabel,
			};
		}

		return message;
	}

	/**
	 * Send a push notification to a single device token
	 */
	async sendNotification(options: SendNotificationOptions): Promise<string> {
		try {
			const accessToken = await this.getAccessToken();
			const message = this.buildMessage(options);

			const response = await fetch(
				`${FCM_URL}/${this.#projectId}/messages:send`,
				{
					method: "POST",
					headers: {
						Authorization: `Bearer ${accessToken}`,
						"Content-Type": "application/json",
					},
					body: JSON.stringify({ message }),
				},
			);

			if (!response.ok) {
				const errorData = await response.json().catch(() => ({}));
				logger.error(
					{ error: errorData, status: response.status },
					"[FirebaseAdminService] FCM send failed",
				);
				throw new Error(
					`FCM send failed: ${response.status} ${JSON.stringify(errorData)}`,
				);
			}

			const result = (await response.json()) as { name: string };

			// Extract message ID from the name (format: projects/{project}/messages/{messageId})
			const messageId = result.name.split("/").pop() ?? result.name;

			return messageId;
		} catch (error) {
			logger.error({ error }, "[FirebaseAdminService] Send notification error");

			const msg = error instanceof Error ? error.message : "Unknown error";
			throw new FirebaseError(msg, { code: "INTERNAL_SERVER_ERROR" });
		}
	}

	/**
	 * Send a push notification to a topic
	 */
	async sendToTopic(options: SendToTopicOptions): Promise<string> {
		try {
			const accessToken = await this.getAccessToken();
			const message = this.buildMessage(options);

			const response = await fetch(
				`${FCM_URL}/${this.#projectId}/messages:send`,
				{
					method: "POST",
					headers: {
						Authorization: `Bearer ${accessToken}`,
						"Content-Type": "application/json",
					},
					body: JSON.stringify({ message }),
				},
			);

			if (!response.ok) {
				const errorData = await response.json().catch(() => ({}));
				logger.error(
					{ error: errorData, status: response.status },
					"[FirebaseAdminService] FCM topic send failed",
				);
				throw new Error(
					`FCM topic send failed: ${response.status} ${JSON.stringify(errorData)}`,
				);
			}

			const result = (await response.json()) as { name: string };
			const messageId = result.name.split("/").pop() ?? result.name;

			return messageId;
		} catch (error) {
			logger.error({ error }, "[FirebaseAdminService] Send to topic error");

			const msg = error instanceof Error ? error.message : "Unknown error";
			throw new FirebaseError(msg, { code: "INTERNAL_SERVER_ERROR" });
		}
	}

	/**
	 * Send push notifications to multiple device tokens
	 */
	async sendMulticast(
		tokens: string[],
		payload: NotificationPayload,
	): Promise<{
		successCount: number;
		failureCount: number;
		failedTokens: string[];
	}> {
		const results = await Promise.allSettled(
			tokens.map((token) => this.sendNotification({ ...payload, token })),
		);

		const failedTokens: string[] = [];
		let successCount = 0;
		let failureCount = 0;

		results.forEach((result, idx) => {
			if (result.status === "fulfilled") {
				successCount++;
			} else {
				failureCount++;
				failedTokens.push(tokens[idx]);
			}
		});

		return { successCount, failureCount, failedTokens };
	}

	/**
	 * Subscribe device tokens to a topic
	 */
	async subscribeToTopic(
		tokens: string | string[],
		topic: string,
	): Promise<TopicManagementResponse> {
		try {
			const accessToken = await this.getAccessToken();
			const tokenArray = Array.isArray(tokens) ? tokens : [tokens];

			const response = await fetch(`${IID_URL}/v1:batchAdd`, {
				method: "POST",
				headers: {
					Authorization: `Bearer ${accessToken}`,
					"Content-Type": "application/json",
				},
				body: JSON.stringify({
					to: `/topics/${topic}`,
					registration_tokens: tokenArray,
				}),
			});

			if (!response.ok) {
				const errorData = await response.json().catch(() => ({}));
				throw new Error(
					`Topic subscribe failed: ${response.status} ${JSON.stringify(errorData)}`,
				);
			}

			const result = (await response.json()) as { results?: Array<object> };
			const successCount =
				result.results?.filter((r) => !("error" in r)).length ??
				tokenArray.length;

			return {
				successCount,
				failureCount: tokenArray.length - successCount,
			};
		} catch (error) {
			logger.error(
				{ error },
				"[FirebaseAdminService] Subscribe to topic error",
			);

			const msg = error instanceof Error ? error.message : "Unknown error";
			throw new FirebaseError(msg, { code: "INTERNAL_SERVER_ERROR" });
		}
	}

	/**
	 * Unsubscribe device tokens from a topic
	 */
	async unsubscribeFromTopic(
		tokens: string | string[],
		topic: string,
	): Promise<TopicManagementResponse> {
		try {
			const accessToken = await this.getAccessToken();
			const tokenArray = Array.isArray(tokens) ? tokens : [tokens];

			const response = await fetch(`${IID_URL}/v1:batchRemove`, {
				method: "POST",
				headers: {
					Authorization: `Bearer ${accessToken}`,
					"Content-Type": "application/json",
				},
				body: JSON.stringify({
					to: `/topics/${topic}`,
					registration_tokens: tokenArray,
				}),
			});

			if (!response.ok) {
				const errorData = await response.json().catch(() => ({}));
				throw new Error(
					`Topic unsubscribe failed: ${response.status} ${JSON.stringify(errorData)}`,
				);
			}

			const result = (await response.json()) as { results?: Array<object> };
			const successCount =
				result.results?.filter((r) => !("error" in r)).length ??
				tokenArray.length;

			return {
				successCount,
				failureCount: tokenArray.length - successCount,
			};
		} catch (error) {
			logger.error(
				{ error },
				"[FirebaseAdminService] Unsubscribe from topic error",
			);

			const msg = error instanceof Error ? error.message : "Unknown error";
			throw new FirebaseError(msg, { code: "INTERNAL_SERVER_ERROR" });
		}
	}

	/**
	 * Send a custom FCM message (advanced usage)
	 */
	async sendCustomMessage(message: FCMMessage): Promise<string> {
		try {
			const accessToken = await this.getAccessToken();

			const response = await fetch(
				`${FCM_URL}/${this.#projectId}/messages:send`,
				{
					method: "POST",
					headers: {
						Authorization: `Bearer ${accessToken}`,
						"Content-Type": "application/json",
					},
					body: JSON.stringify({ message }),
				},
			);

			if (!response.ok) {
				const errorData = await response.json().catch(() => ({}));
				throw new Error(
					`FCM custom message failed: ${response.status} ${JSON.stringify(errorData)}`,
				);
			}

			const result = (await response.json()) as { name: string };
			const messageId = result.name.split("/").pop() ?? result.name;

			return messageId;
		} catch (error) {
			logger.error(
				{ error },
				"[FirebaseAdminService] Send custom message error",
			);

			const msg = error instanceof Error ? error.message : "Unknown error";
			throw new FirebaseError(msg, { code: "INTERNAL_SERVER_ERROR" });
		}
	}
}
