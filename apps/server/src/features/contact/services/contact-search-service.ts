/**
 * ContactSearchService
 *
 * SOLID Principles Applied:
 * - SRP: Handles only contact search and filtering logic
 * - OCP: Open for extension with new search/filter strategies
 * - DIP: Depends on abstractions (SQL types, not concrete implementations)
 */

import type { ContactStatus } from "@repo/schema/contact";
import { and, eq, ilike, or, type SQL } from "drizzle-orm";
import { tables } from "@/core/services/db";

/**
 * ContactSearchService
 *
 * Static service for contact search and filtering operations:
 * - Search clause generation (multi-field search)
 * - Status filtering
 * - Combined filter building
 */
export class ContactSearchService {
	/**
	 * Generate search clause for multi-field contact search
	 * Searches across name, email, and subject fields using ILIKE
	 *
	 * @param searchQuery - Search query string
	 * @returns SQL OR clause for WHERE condition
	 */
	static generateSearchClause(searchQuery: string): SQL {
		const pattern = `%${searchQuery}%`;
		const clause = or(
			ilike(tables.contact.name, pattern),
			ilike(tables.contact.email, pattern),
			ilike(tables.contact.subject, pattern),
		);
		// or() with 3 args never returns undefined
		if (!clause) {
			throw new Error("Failed to generate search clause");
		}
		return clause;
	}

	/**
	 * Generate status filter clause
	 *
	 * @param status - Contact status to filter by
	 * @returns SQL clause for WHERE condition
	 */
	static generateStatusClause(status: ContactStatus): SQL {
		return eq(tables.contact.status, status);
	}

	/**
	 * Build combined WHERE clause from filters
	 * Combines status and search filters with AND logic
	 *
	 * @param options - Filter options
	 * @returns Combined SQL WHERE clause or undefined if no filters
	 */
	static buildWhereClause(options: {
		status?: ContactStatus;
		search?: string;
	}): SQL | undefined {
		const conditions: SQL[] = [];

		if (options.status) {
			conditions.push(
				ContactSearchService.generateStatusClause(options.status),
			);
		}

		if (options.search) {
			const sanitized = ContactSearchService.sanitizeSearchQuery(
				options.search,
			);
			conditions.push(ContactSearchService.generateSearchClause(sanitized));
		}

		return conditions.length > 0 ? and(...conditions) : undefined;
	}

	/**
	 * Validate and sanitize search query
	 * Prevents SQL injection and excessive wildcards
	 *
	 * @param query - Raw search query
	 * @returns Sanitized query string
	 */
	static sanitizeSearchQuery(query: string): string {
		// Trim whitespace
		const trimmed = query.trim();

		// Limit length to prevent performance issues
		const maxLength = 100;
		if (trimmed.length > maxLength) {
			return trimmed.slice(0, maxLength);
		}

		// Remove null bytes and control characters
		// biome-ignore lint/suspicious/noControlCharactersInRegex: intentionally removing control characters
		return trimmed.replace(/[\x00-\x1F\x7F]/g, "");
	}

	/**
	 * Validate status value
	 * Ensures status is one of the allowed values
	 *
	 * @param status - Status string to validate
	 * @returns True if status is valid
	 */
	static isValidStatus(status: string): status is ContactStatus {
		const validStatuses: ContactStatus[] = [
			"PENDING",
			"REVIEWING",
			"RESOLVED",
			"CLOSED",
		];
		return validStatuses.includes(status as ContactStatus);
	}
}
