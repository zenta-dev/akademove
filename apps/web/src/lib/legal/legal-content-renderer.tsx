/**
 * Legal Content Renderer
 *
 * Helper component to render legal content from structured content objects
 */

import type { LegalSectionContent } from "../legal-i18n";

type LegalContentRendererProps = {
	content: LegalSectionContent;
};

export function LegalContentRenderer({ content }: LegalContentRendererProps) {
	return (
		<>
			{content.paragraphs?.map((paragraph: string, index: number) => (
				// biome-ignore lint/suspicious/noArrayIndexKey: Paragraphs are static content
				<p key={index}>{paragraph}</p>
			))}

			{content.lists?.map((list, listIndex: number) => (
				// biome-ignore lint/suspicious/noArrayIndexKey: Lists are static content
				<div key={listIndex} className={content.paragraphs ? "mt-3" : ""}>
					{list.title && <p className="mb-2 font-semibold">{list.title}</p>}
					<ul className="list-inside list-disc space-y-2">
						{list.items.map((item, itemIndex: number) => (
							// biome-ignore lint/suspicious/noArrayIndexKey: Items are static content
							<li key={itemIndex}>
								{item.label ? (
									<>
										<strong>{item.label}:</strong> {item.content}
									</>
								) : (
									item.content
								)}
							</li>
						))}
					</ul>
				</div>
			))}

			{content.additionalParagraphs?.map((paragraph: string, index: number) => (
				<p
					// biome-ignore lint/suspicious/noArrayIndexKey: Paragraphs are static content
					key={index}
					className="mt-3"
				>
					{paragraph}
				</p>
			))}
		</>
	);
}
