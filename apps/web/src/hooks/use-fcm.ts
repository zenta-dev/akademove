import { useMutation } from "@tanstack/react-query";
import type { MessagePayload } from "firebase/messaging";
import { useEffect, useState } from "react";
import { toast } from "sonner";
import { firebaseClient } from "@/lib/firebase";
import { notificationSound } from "@/lib/notification-sound";
import { orpcClient } from "@/lib/orpc";

const FCM_LOCAL_STORAGE_KEY = "fcm_token";

export function useFCM() {
	const [fcmToken, setFcmToken] = useState<string | null>(null);
	const [notification, setNotification] = useState<MessagePayload | null>(null);
	const [isLoading, setIsLoading] = useState(false);
	const [error, setError] = useState<string | null>(null);

	const saveTokenMutation = useMutation({
		mutationFn: async (variables: { body: { token: string } }) => {
			const result = await orpcClient.notification.saveToken(variables);
			if (result.status !== 200) {
				throw new Error(result.body.message || "Failed to save FCM token");
			}
			return result;
		},
	});

	const subscribeMutation = useMutation({
		mutationFn: async (variables: {
			body: { topic: string; token: string };
		}) => {
			const result = await orpcClient.notification.subscribeToTopic(variables);
			if (result.status !== 200) {
				throw new Error(result.body.message || "Failed to subscribe to topic");
			}
			return result;
		},
	});

	const unsubscribeMutation = useMutation({
		mutationFn: async (variables: {
			body: { topic: string; token: string };
		}) => {
			const result =
				await orpcClient.notification.unsubscribeToTopic(variables);
			if (result.status !== 200) {
				throw new Error(
					result.body.message || "Failed to unsubscribe from topic",
				);
			}
			return result;
		},
	});

	const client = firebaseClient;

	useEffect(() => {
		if (!client) return;

		const initializeFCM = async () => {
			setIsLoading(true);
			setError(null);

			try {
				const vapidKey = import.meta.env.VITE_FIREBASE_VAPID_KEY;
				const localToken = localStorage.getItem(FCM_LOCAL_STORAGE_KEY);
				const freshToken = await client.requestPermissionAndGetToken(vapidKey);

				if (freshToken && freshToken !== localToken) {
					setFcmToken(freshToken);
					localStorage.setItem(FCM_LOCAL_STORAGE_KEY, freshToken);
					await saveTokenMutation.mutateAsync({
						body: { token: freshToken },
					});
				} else if (localToken) {
					setFcmToken(localToken);
				}
			} catch (err) {
				setError(
					err instanceof Error ? err.message : "Failed to initialize FCM",
				);
			} finally {
				setIsLoading(false);
			}
		};

		initializeFCM();

		const unsubscribe = client.onMessage((payload) => {
			setNotification(payload);

			// Show toast notification for foreground messages
			if (payload.notification) {
				toast.info(payload.notification.title, {
					description: payload.notification.body,
				});

				// Play notification sound
				notificationSound.play();
			}
		});

		return () => unsubscribe();
	}, [client, saveTokenMutation.mutateAsync]);

	const subscribeToTopic = async (topic: string) => {
		if (!fcmToken) throw new Error("No FCM token available");

		return await subscribeMutation.mutateAsync({
			body: { topic, token: fcmToken },
		});
	};

	const unsubscribeFromTopic = async (topic: string) => {
		if (!fcmToken) throw new Error("No FCM token available");
		return await unsubscribeMutation.mutateAsync({
			body: { topic, token: fcmToken },
		});
	};

	return {
		fcmToken,
		notification,
		isLoading,
		error,
		isSupported: client?.isSupported() ?? false,
		permissionStatus: client?.getPermissionStatus() ?? null,
		subscribeToTopic,
		unsubscribeFromTopic,
		clearNotification: () => setNotification(null),
	};
}
