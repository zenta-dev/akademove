import 'dart:io';
import 'package:akademove/core/_export.dart';
import 'package:image_picker/image_picker.dart';

abstract class ImageService extends BaseService {
  Future<File> pickFromGallery();
  Future<File> pickFromCamera();
}

class ImagePickerService implements ImageService {
  ImagePickerService() {
    _picker = ImagePicker();
  }

  late final ImagePicker _picker;

  @override
  void setup() {}

  @override
  void teardown() {}

  @override
  Future<File> pickFromCamera() => _pickImage(ImageSource.camera);

  @override
  Future<File> pickFromGallery() => _pickImage(ImageSource.gallery);

  Future<File> _pickImage(ImageSource source) async {
    try {
      final result = await _picker.pickImage(source: source);

      if (result == null) {
        throw const ServiceError(
          'No image selected',
          code: ErrorCode.NOT_FOUND,
        );
      }

      return File(result.path);
    } on ServiceError {
      rethrow;
      // ignore: avoid_catches_without_on_clauses fix latee
    } catch (e, stack) {
      logger.e('ImagePickerService Error', error: e, stackTrace: stack);
      throw const ServiceError(
        'An unexpected error occurred while picking the image',
        code: ErrorCode.UNKNOWN,
      );
    }
  }
}
