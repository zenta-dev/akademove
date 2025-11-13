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

		if (typeof window !== "undefined" && "serviceWorker" in navigator) {
			this.messaging = getMessaging(this.app);
			this.setupMessageListener();
		}
	}

	static getInstance(config?: FirebaseConfig): FirebaseClient {
		if (!FirebaseClient.instance) {
			if (!config) throw new Error("Firebase config required.");
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
		if (!this.messaging) return null;

		const permission = await Notification.requestPermission();
		if (permission !== "granted") return null;

		const registration = await navigator.serviceWorker.register(
			"/firebase-messaging-sw.js",
		);

		try {
			return await getToken(this.messaging, {
				vapidKey,
				serviceWorkerRegistration: registration,
			});
		} catch (err) {
			console.error("FCM token error:", err);
			return null;
		}
	}

	/**
	 * Get current FCM token without requesting permission
	 */
	async getToken(vapidKey: string): Promise<string | null> {
		if (!this.messaging) return null;

		const registration = await navigator.serviceWorker.register(
			"/firebase-messaging-sw.js",
		);

		try {
			return await getToken(this.messaging, {
				vapidKey,
				serviceWorkerRegistration: registration,
			});
		} catch (err) {
			console.error("Token error:", err);
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
