/**
 * Legal content translation helper
 *
 * This module provides utilities for managing legal page translations.
 * It supports fallback to English when translations are missing.
 */

import { getLocale } from "@repo/i18n";

/**
 * Gets the legal content in the appropriate language
 * Falls back to English if translation is not available
 */
export function getLegalContent<T>(content: { en: T; id?: T }): T {
	const lang = getLocale();
	if (lang === "id" && content.id) {
		return content.id;
	}
	return content.en;
}

/**
 * Legal section translation type
 */
export type LegalSectionContent = {
	title: string;
	paragraphs?: string[];
	lists?: {
		title?: string;
		items: Array<{
			label?: string;
			content: string;
		}>;
	}[];
	/**
	 * Additional paragraphs that appear after lists
	 */
	additionalParagraphs?: string[];
};
