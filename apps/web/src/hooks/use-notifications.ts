import { useCallback, useEffect, useState } from "react";

export type NotificationPermission = "default" | "granted" | "denied";

interface UseNotificationsReturn {
	permission: NotificationPermission;
	isSupported: boolean;
	requestPermission: () => Promise<NotificationPermission>;
	showNotification: (title: string, options?: NotificationOptions) => void;
}

/**
 * Hook to manage browser notifications
 *
 * Provides:
 * - Permission state tracking
 * - Permission request function
 * - Notification display function
 * - Browser support detection
 */
export const useNotifications = (): UseNotificationsReturn => {
	const [permission, setPermission] = useState<NotificationPermission>(
		typeof window !== "undefined" && "Notification" in window
			? (Notification.permission as NotificationPermission)
			: "default",
	);

	const isSupported = typeof window !== "undefined" && "Notification" in window;

	useEffect(() => {
		if (!isSupported) return;

		// Update permission state if it changes
		const handlePermissionChange = () => {
			setPermission(Notification.permission as NotificationPermission);
		};

		// Check permission periodically (no native event exists)
		const interval = setInterval(handlePermissionChange, 1000);

		return () => clearInterval(interval);
	}, [isSupported]);

	const requestPermission =
		useCallback(async (): Promise<NotificationPermission> => {
			if (!isSupported) {
				return "denied";
			}

			try {
				const result = await Notification.requestPermission();
				setPermission(result as NotificationPermission);
				return result as NotificationPermission;
			} catch (error) {
				console.error("Failed to request notification permission:", error);
				return "denied";
			}
		}, [isSupported]);

	const showNotification = useCallback(
		(title: string, options?: NotificationOptions) => {
			if (!isSupported || permission !== "granted") {
				return;
			}

			try {
				// Use service worker notification if available, fallback to basic
				if (
					"serviceWorker" in navigator &&
					navigator.serviceWorker.controller
				) {
					navigator.serviceWorker.ready.then((registration) => {
						registration.showNotification(title, {
							icon: "/android-chrome-192x192.png",
							badge: "/favicon-32x32.png",
							...options,
						});
					});
				} else {
					new Notification(title, {
						icon: "/android-chrome-192x192.png",
						...options,
					});
				}
			} catch (error) {
				console.error("Failed to show notification:", error);
			}
		},
		[isSupported, permission],
	);

	return {
		permission,
		isSupported,
		requestPermission,
		showNotification,
	};
};
