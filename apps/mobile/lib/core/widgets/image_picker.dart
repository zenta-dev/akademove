import 'dart:io';

import 'package:akademove/core/_export.dart';
import 'package:akademove/locator.dart';
import 'package:flutter/material.dart'
    as material
    show showModalBottomSheet, ListTile;
import 'package:image_picker/image_picker.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class ImagePickerWidget extends StatefulWidget {
  const ImagePickerWidget({
    super.key,
    this.initialImage,
    this.onImagePicked,
    this.size = const Size(120, 120),
    this.borderRadius = 12,
  });

  final File? initialImage;
  final void Function(File file)? onImagePicked;
  final Size size;
  final double borderRadius;

  @override
  State<ImagePickerWidget> createState() => _ImagePickerWidgetState();
}

class _ImagePickerWidgetState extends State<ImagePickerWidget> {
  final ImageService _picker = sl<ImageService>();
  File? _selectedImage;

  @override
  void initState() {
    super.initState();
    _selectedImage = widget.initialImage;
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      final pickedFile = source == ImageSource.camera
          ? await _picker.pickFromCamera()
          : await _picker.pickFromGallery();

      setState(() => _selectedImage = pickedFile);
      widget.onImagePicked?.call(pickedFile);
    } catch (e, stack) {
      logger.e('ImagePickerWidget Error', error: e, stackTrace: stack);
      if (context.mounted) {
        showToast(
          context: context,
          builder: (context, overlay) => context.buildToast(
            title: 'Failed to pick image',
            message: e.toString(),
          ),
        );
      }
    }
  }

  void _showSourceOptions() {
    material.showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) => SafeArea(
        child: Wrap(
          children: [
            material.ListTile(
              leading: const Icon(Icons.photo_camera),
              title: const Text('Take a photo'),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.camera);
              },
            ),
            material.ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Choose from gallery'),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.gallery);
              },
            ),
            if (_selectedImage != null)
              material.ListTile(
                leading: const Icon(Icons.delete),
                title: const Text('Remove image'),
                onTap: () {
                  Navigator.pop(context);
                  setState(() => _selectedImage = null);
                  widget.onImagePicked?.call(File(''));
                },
              ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final hasImage = _selectedImage != null && _selectedImage!.existsSync();

    return GestureDetector(
      onTap: _showSourceOptions,
      child: Container(
        height: widget.size.height,
        width: widget.size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(widget.borderRadius),
          color: context.isDarkMode
              ? Colors.neutral.shade900
              : Colors.neutral.shade100,
          border: Border.all(
            color: context.isDarkMode
                ? Colors.neutral.shade700
                : Colors.neutral.shade400,
          ),
          image: hasImage
              ? DecorationImage(
                  image: FileImage(_selectedImage!),
                  fit: BoxFit.cover,
                )
              : null,
        ),
        child: !hasImage
            ? const Center(
                child: Icon(
                  LucideIcons.camera,
                  color: Colors.neutral,
                  size: 36,
                ),
              )
            : null,
      ),
    );
  }
}
