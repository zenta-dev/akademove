import { DOMParser as XDOMParser } from "@xmldom/xmldom";

globalThis.DOMParser = XDOMParser;

// Polyfill Node interface for AWS SDK XML parser
// These are DOM Node type constants used by the SDK's XML deserializer
// @ts-expect-error - Node is a browser global, not available in Cloudflare Workers
globalThis.Node = {
	ELEMENT_NODE: 1,
	ATTRIBUTE_NODE: 2,
	TEXT_NODE: 3,
	CDATA_SECTION_NODE: 4,
	PROCESSING_INSTRUCTION_NODE: 7,
	COMMENT_NODE: 8,
	DOCUMENT_NODE: 9,
	DOCUMENT_TYPE_NODE: 10,
	DOCUMENT_FRAGMENT_NODE: 11,
};
