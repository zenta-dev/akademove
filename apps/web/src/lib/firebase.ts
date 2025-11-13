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
	private static instance: FirebaseClient;

	private app: FirebaseApp;
	private messaging: Messaging | null = null;

	private swRegistration: ServiceWorkerRegistration | null = null;
	private cachedToken: string | null = null;

	private messageListeners = new Set<(payload: MessagePayload) => void>();

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
	 * Service worker registration caching
	 */
	private async getSwRegistration(): Promise<ServiceWorkerRegistration> {
		if (this.swRegistration) return this.swRegistration;

		this.swRegistration = await navigator.serviceWorker.register(
			"/firebase-messaging-sw.js",
		);

		return this.swRegistration;
	}

	/**
	 * Foreground message listener
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
	 * Request permission and fetch FCM token
	 */
	async requestPermissionAndGetToken(vapidKey: string): Promise<string | null> {
		if (!this.messaging) return null;

		const permission = await Notification.requestPermission();
		if (permission !== "granted") return null;

		return this.getToken(vapidKey);
	}

	/**
	 * Get FCM token (cached)
	 */
	async getToken(vapidKey: string): Promise<string | null> {
		if (!this.messaging) return null;

		// return cached token immediately
		if (this.cachedToken) return this.cachedToken;

		const registration = await this.getSwRegistration();

		try {
			const token = await getToken(this.messaging, {
				vapidKey,
				serviceWorkerRegistration: registration,
			});

			this.cachedToken = token;
			return token;
		} catch (error) {
			console.error("Error getting token:", error);
			return null;
		}
	}

	/**
	 * Foreground listeners
	 */
	onMessage(callback: (payload: MessagePayload) => void): () => void {
		this.messageListeners.add(callback);
		return () => this.messageListeners.delete(callback);
	}

	offMessage(callback: (payload: MessagePayload) => void): void {
		this.messageListeners.delete(callback);
	}

	clearMessageListeners(): void {
		this.messageListeners.clear();
	}

	isSupported(): boolean {
		return typeof window !== "undefined" && "Notification" in window;
	}

	getPermissionStatus(): NotificationPermission | null {
		return this.isSupported() ? Notification.permission : null;
	}

	getMessaging(): Messaging | null {
		return this.messaging;
	}

	getApp(): FirebaseApp {
		return this.app;
	}
}

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
