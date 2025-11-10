import { type FirebaseApp, initializeApp } from "firebase/app";
import {
	getMessaging,
	getToken,
	type MessagePayload,
	type Messaging,
	onMessage,
} from "firebase/messaging";

export interface FirebaseConfig {
	apiKey: string;
	authDomain: string;
	projectId: string;
	storageBucket: string;
	messagingSenderId: string;
	appId: string;
}

export class FirebaseClient {
	private app: FirebaseApp;
	private messaging: Messaging | null = null;
	private static instance: FirebaseClient;
	private messageListeners: Set<(payload: MessagePayload) => void> = new Set();

	private constructor(config: FirebaseConfig) {
		this.app = initializeApp(config);

		// Only initialize messaging in browser environment
		if (typeof window !== "undefined") {
			this.messaging = getMessaging(this.app);
			this.setupMessageListener();
		}
	}

	static getInstance(config?: FirebaseConfig): FirebaseClient {
		if (!FirebaseClient.instance) {
			if (!config) {
				throw new Error("Firebase config required for first initialization");
			}
			FirebaseClient.instance = new FirebaseClient(config);
		}
		return FirebaseClient.instance;
	}

	/**
	 * Setup listener for foreground messages
	 */
	private setupMessageListener() {
		if (!this.messaging) return;

		onMessage(this.messaging, (payload) => {
			this.messageListeners.forEach((listener) => {
				listener(payload);
			});
		});
	}

	/**
	 * Request notification permission and get FCM token
	 */
	async requestPermissionAndGetToken(vapidKey: string): Promise<string | null> {
		if (!this.messaging) {
			console.warn("Messaging not available in this environment");
			return null;
		}

		try {
			const permission = await Notification.requestPermission();

			if (permission === "granted") {
				const token = await getToken(this.messaging, { vapidKey });
				return token;
			}
			console.log("Notification permission denied");
			return null;
		} catch (error) {
			console.error("Error getting FCM token:", error);
			return null;
		}
	}

	/**
	 * Get current FCM token without requesting permission
	 */
	async getToken(vapidKey: string): Promise<string | null> {
		if (!this.messaging) return null;

		try {
			return await getToken(this.messaging, { vapidKey });
		} catch (error) {
			console.error("Error getting token:", error);
			return null;
		}
	}

	/**
	 * Add a listener for foreground messages
	 */
	onMessage(callback: (payload: MessagePayload) => void): () => void {
		this.messageListeners.add(callback);

		// Return unsubscribe function
		return () => {
			this.messageListeners.delete(callback);
		};
	}

	/**
	 * Remove a message listener
	 */
	offMessage(callback: (payload: MessagePayload) => void): void {
		this.messageListeners.delete(callback);
	}

	/**
	 * Clear all message listeners
	 */
	clearMessageListeners(): void {
		this.messageListeners.clear();
	}

	/**
	 * Check if notifications are supported
	 */
	isSupported(): boolean {
		return typeof window !== "undefined" && "Notification" in window;
	}

	/**
	 * Get current notification permission status
	 */
	getPermissionStatus(): NotificationPermission | null {
		if (!this.isSupported()) return null;
		return Notification.permission;
	}

	/**
	 * Get the messaging instance
	 */
	getMessaging(): Messaging | null {
		return this.messaging;
	}

	/**
	 * Get the Firebase app instance
	 */
	getApp(): FirebaseApp {
		return this.app;
	}
}

// Initialize and export singleton

export const firebaseClient =
	typeof window !== "undefined"
		? FirebaseClient.getInstance({
				apiKey: import.meta.env.VITE_FIREBASE_API_KEY,
				authDomain: import.meta.env.VITE_FIREBASE_AUTH_DOMAIN,
				projectId: import.meta.env.VITE_FIREBASE_PROJECT_ID,
				storageBucket: import.meta.env.VITE_FIREBASE_STORAGE_BUCKET,
				messagingSenderId: import.meta.env.VITE_FIREBASE_MESSAGING_SENDER_ID,
				appId: import.meta.env.VITE_FIREBASE_APP_ID,
			})
		: null;
