/**
 * Simple audio notification utility using Web Audio API
 * Generates a pleasant notification sound without external files
 */

class NotificationSound {
	private audioContext: AudioContext | null = null;
	private enabled = true;

	constructor() {
		if (typeof window !== "undefined" && "AudioContext" in window) {
			this.audioContext = new AudioContext();
		}
	}

	/**
	 * Play a notification sound
	 * Generates a two-tone pleasant beep
	 */
	play(): void {
		if (!this.enabled || !this.audioContext) return;

		try {
			const now = this.audioContext.currentTime;

			// Create oscillator for first tone (higher pitch)
			const oscillator1 = this.audioContext.createOscillator();
			const gainNode1 = this.audioContext.createGain();

			oscillator1.connect(gainNode1);
			gainNode1.connect(this.audioContext.destination);

			oscillator1.frequency.value = 800; // Higher frequency
			gainNode1.gain.setValueAtTime(0.3, now);
			gainNode1.gain.exponentialRampToValueAtTime(0.01, now + 0.1);

			oscillator1.start(now);
			oscillator1.stop(now + 0.1);

			// Create oscillator for second tone (lower pitch) - slight delay
			const oscillator2 = this.audioContext.createOscillator();
			const gainNode2 = this.audioContext.createGain();

			oscillator2.connect(gainNode2);
			gainNode2.connect(this.audioContext.destination);

			oscillator2.frequency.value = 600; // Lower frequency
			gainNode2.gain.setValueAtTime(0, now + 0.05);
			gainNode2.gain.setValueAtTime(0.3, now + 0.05);
			gainNode2.gain.exponentialRampToValueAtTime(0.01, now + 0.2);

			oscillator2.start(now + 0.05);
			oscillator2.stop(now + 0.2);
		} catch (error) {
			console.error("Failed to play notification sound:", error);
		}
	}

	/**
	 * Enable notification sounds
	 */
	enable(): void {
		this.enabled = true;
	}

	/**
	 * Disable notification sounds
	 */
	disable(): void {
		this.enabled = false;
	}

	/**
	 * Check if sounds are enabled
	 */
	isEnabled(): boolean {
		return this.enabled;
	}

	/**
	 * Toggle sound on/off
	 */
	toggle(): boolean {
		this.enabled = !this.enabled;
		return this.enabled;
	}
}

// Export singleton instance
export const notificationSound = new NotificationSound();
