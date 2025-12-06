#!/usr/bin/env bun

/**
 * Test script to verify audit logging functionality
 * This script tests the audit system by checking database tables
 */

import { drizzle } from "drizzle-orm/postgres-js";
import postgres from "postgres";

// import * as schema from "../apps/server/src/core/tables";

interface AuditRecord {
	id: string;
	operation: string;
	recordId: string;
	updatedAt: string | Date;
	reason: string | null;
}

const connectionString =
	process.env.DATABASE_URL ||
	"postgresql://postgres:postgres@127.0.0.1:5432/postgres";
const client = postgres(connectionString);
const _db = drizzle(client);

async function testAuditSystem() {
	console.log("🔍 Testing Audit System...\n");

	try {
		// Check if audit tables exist
		console.log("📋 Checking audit tables...");

		const userAuditTable = await client`
      SELECT EXISTS (
        SELECT FROM information_schema.tables 
        WHERE table_schema = 'public' 
        AND table_name = 'am___user_audit_log'
      ) as exists;
    `;

		const walletAuditTable = await client`
      SELECT EXISTS (
        SELECT FROM information_schema.tables 
        WHERE table_schema = 'public' 
        AND table_name = 'am___wallet_audit_log'
      ) as exists;
    `;

		console.log(`   ✅ User audit table exists: ${userAuditTable[0].exists}`);
		console.log(
			`   ✅ Wallet audit table exists: ${walletAuditTable[0].exists}`,
		);

		// Check recent audit logs
		console.log("\n📊 Checking recent audit logs...");

		const userAuditCount =
			await client`SELECT COUNT(*) as count FROM am___user_audit_log`;
		const walletAuditCount =
			await client`SELECT COUNT(*) as count FROM am___wallet_audit_log`;

		console.log(`   📝 User audit logs: ${userAuditCount[0].count} entries`);
		console.log(
			`   💰 Wallet audit logs: ${walletAuditCount[0].count} entries`,
		);

		// Show recent entries if any exist
		if (Number.parseInt(userAuditCount[0].count, 10) > 0) {
			const recentUserAudits = await client`
        SELECT id, operation, "recordId", "updatedAt", metadata->>'reason' as reason
        FROM am___user_audit_log 
        ORDER BY "updatedAt" DESC 
        LIMIT 3
      `;

			console.log("\n   📋 Recent user audits:");
			for (const audit of recentUserAudits as unknown as AuditRecord[]) {
				console.log(
					`      - ${audit.operation} on ${audit.recordId} (${new Date(audit.updatedAt).toISOString()}) - ${audit.reason || "No reason"}`,
				);
			}
		}

		if (Number.parseInt(walletAuditCount[0].count, 10) > 0) {
			const recentWalletAudits = await client`
        SELECT id, operation, "recordId", "updatedAt", metadata->>'reason' as reason
        FROM am___wallet_audit_log 
        ORDER BY "updatedAt" DESC 
        LIMIT 3
      `;

			console.log("\n   💰 Recent wallet audits:");
			for (const audit of recentWalletAudits as unknown as AuditRecord[]) {
				console.log(
					`      - ${audit.operation} on ${audit.recordId} (${new Date(audit.updatedAt).toISOString()}) - ${audit.reason || "No reason"}`,
				);
			}
		}

		// Check if audit API endpoint works
		console.log("\n🌐 Testing audit API endpoint...");
		try {
			const response = await fetch("http://localhost:3000/api/audit-logs", {
				headers: {
					Authorization: "Bearer test-token",
					"Content-Type": "application/json",
				},
			});

			if (response.status === 401) {
				console.log(
					"   ✅ Audit API endpoint exists (requires auth - expected)",
				);
			} else if (response.status === 200) {
				console.log("   ✅ Audit API endpoint working");
			} else {
				console.log(`   ⚠️  Audit API returned status: ${response.status}`);
			}
		} catch (_error) {
			console.log("   ❌ Audit API endpoint not accessible");
		}

		console.log("\n✅ Audit system test completed!");
		console.log("\n📝 Manual Testing Required:");
		console.log("   1. Login as ADMIN user");
		console.log("   2. Ban a user and check audit logs");
		console.log("   3. Change user role and check audit logs");
		console.log("   4. Adjust wallet balance and check audit logs");
		console.log("   5. View audit dashboard at /dash/admin/audit-logs");
	} catch (error) {
		console.error("❌ Test failed:", error);
		process.exit(1);
	} finally {
		await client.end();
	}
}

testAuditSystem();
