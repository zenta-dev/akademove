import "dart:io";
import "package:akademove/core/_export.dart";
import "package:file_picker/file_picker.dart";

/// Supported document types for printing attachments
enum DocumentType { pdf, doc, docx, image }

/// Result of a document pick operation
class DocumentPickResult {
  const DocumentPickResult({
    required this.file,
    required this.fileName,
    required this.extension,
    required this.size,
  });

  final File file;
  final String fileName;
  final String extension;
  final int size;

  /// Get the document type based on extension
  DocumentType get documentType {
    switch (extension.toLowerCase()) {
      case "pdf":
        return DocumentType.pdf;
      case "doc":
        return DocumentType.doc;
      case "docx":
        return DocumentType.docx;
      case "jpg":
      case "jpeg":
      case "png":
      case "gif":
      case "webp":
        return DocumentType.image;
      default:
        return DocumentType.pdf;
    }
  }

  /// Human-readable file size
  String get formattedSize {
    if (size < 1024) return "$size B";
    if (size < 1024 * 1024) return "${(size / 1024).toStringAsFixed(1)} KB";
    return "${(size / (1024 * 1024)).toStringAsFixed(1)} MB";
  }
}

/// Service for picking document files (PDF, DOC, images) for printing attachments
abstract class DocumentService extends BaseService {
  /// Pick a document file from device storage
  /// Supports PDF, DOC, DOCX, and image files
  Future<DocumentPickResult> pickDocument();
}

class DocumentPickerService implements DocumentService {
  DocumentPickerService();

  /// Maximum file size in bytes (10 MB)
  static const int maxFileSize = 10 * 1024 * 1024;

  /// Allowed file extensions for printing documents
  static const List<String> allowedExtensions = [
    "pdf",
    "doc",
    "docx",
    "jpg",
    "jpeg",
    "png",
  ];

  @override
  Future<void> setup() async {}

  @override
  void teardown() {}

  @override
  Future<DocumentPickResult> pickDocument() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: allowedExtensions,
        allowMultiple: false,
      );

      if (result == null || result.files.isEmpty) {
        throw const ServiceError(
          "No document selected",
          code: ErrorCode.notFound,
        );
      }

      final pickedFile = result.files.first;

      if (pickedFile.path == null) {
        throw const ServiceError(
          "Could not access the selected file",
          code: ErrorCode.unknown,
        );
      }

      // Check file size
      if (pickedFile.size > maxFileSize) {
        throw const ServiceError(
          "File size exceeds 10 MB limit",
          code: ErrorCode.badRequest,
        );
      }

      final file = File(pickedFile.path!);
      final extension = pickedFile.extension ?? "pdf";

      return DocumentPickResult(
        file: file,
        fileName: pickedFile.name,
        extension: extension,
        size: pickedFile.size,
      );
    } on ServiceError {
      rethrow;
    } catch (e, stack) {
      logger.e("DocumentPickerService Error", error: e, stackTrace: stack);
      throw const ServiceError(
        "An unexpected error occurred while picking the document",
        code: ErrorCode.unknown,
      );
    }
  }
}
