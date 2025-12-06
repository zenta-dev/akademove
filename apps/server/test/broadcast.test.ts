import { describe, expect, it } from "bun:test";
import {
	BROADCAST_STATUS,
	BROADCAST_TYPE,
	TARGET_AUDIENCE,
} from "../src/core/tables/broadcast";

describe("Broadcast System", () => {
	it("should have correct broadcast status constants", () => {
		expect(BROADCAST_STATUS.PENDING).toBe("PENDING");
		expect(BROADCAST_STATUS.SENDING).toBe("SENDING");
		expect(BROADCAST_STATUS.SENT).toBe("SENT");
		expect(BROADCAST_STATUS.FAILED).toBe("FAILED");
	});

	it("should have correct broadcast type constants", () => {
		expect(BROADCAST_TYPE.EMAIL).toBe("EMAIL");
		expect(BROADCAST_TYPE.IN_APP).toBe("IN_APP");
		expect(BROADCAST_TYPE.ALL).toBe("ALL");
	});

	it("should have correct target audience constants", () => {
		expect(TARGET_AUDIENCE.ALL).toBe("ALL");
		expect(TARGET_AUDIENCE.USERS).toBe("USERS");
		expect(TARGET_AUDIENCE.DRIVERS).toBe("DRIVERS");
		expect(TARGET_AUDIENCE.MERCHANTS).toBe("MERCHANTS");
		expect(TARGET_AUDIENCE.ADMINS).toBe("ADMINS");
		expect(TARGET_AUDIENCE.OPERATORS).toBe("OPERATORS");
	});

	it("should validate broadcast data structure", () => {
		const broadcastData = {
			title: "Test Broadcast",
			message: "This is a test message",
			type: BROADCAST_TYPE.EMAIL,
			targetAudience: TARGET_AUDIENCE.ALL,
			createdBy: "test-user-id",
		};

		expect(broadcastData.title).toBe("Test Broadcast");
		expect(broadcastData.type).toBe("EMAIL");
		expect(broadcastData.targetAudience).toBe("ALL");
		expect(broadcastData.createdBy).toBe("test-user-id");
	});
});
