import 'dart:io';

import 'package:akademove/core/_export.dart';
import 'package:akademove/locator.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart'
    as material
    show ListTile, showModalBottomSheet;
import 'package:image_picker/image_picker.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class ImagePickerWidget extends StatefulWidget {
  const ImagePickerWidget({
    super.key,
    this.value,
    this.onValueChanged,
    this.previewUrl,
    this.size = const Size(120, 120),
    this.borderRadius = 12,
    this.enabled = true,
  });

  final File? value;
  final void Function(File file)? onValueChanged;
  final String? previewUrl;
  final Size size;
  final double borderRadius;
  final bool enabled;

  @override
  State<ImagePickerWidget> createState() => _ImagePickerWidgetState();
}

class _ImagePickerWidgetState extends State<ImagePickerWidget> {
  final ImageService _picker = sl<ImageService>();
  File? _selectedImage;

  @override
  void initState() {
    super.initState();
    _selectedImage = widget.value;
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      final pickedFile = source == ImageSource.camera
          ? await _picker.pickFromCamera()
          : await _picker.pickFromGallery();

      setState(() => _selectedImage = pickedFile);
      widget.onValueChanged?.call(pickedFile);
    } catch (e, stack) {
      logger.e('ImagePickerWidget Error', error: e, stackTrace: stack);
      if (context.mounted && mounted) {
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
    material.showModalBottomSheet<void>(
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
                  widget.onValueChanged?.call(File(''));
                },
              ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final previewUrl = widget.previewUrl;
    final hasImage = _selectedImage != null && _selectedImage!.existsSync();

    const placeholder = Center(
      child: Icon(LucideIcons.camera, color: Colors.neutral, size: 36),
    );

    return GestureDetector(
      onTap: widget.enabled ? _showSourceOptions : null,
      child: Stack(
        clipBehavior: Clip.none,

        children: [
          Container(
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
                ? previewUrl != null
                      ? CachedNetworkImage(
                          imageUrl: previewUrl,
                          width: 36,
                          height: 36,
                          imageBuilder: (context, imageProvider) => Container(
                            decoration: BoxDecoration(
                              color: context.colorScheme.mutedForeground,
                              borderRadius: BorderRadius.circular(
                                widget.borderRadius,
                              ),
                              image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          placeholder: (context, url) => Container(
                            width: 36,
                            height: 36,
                            decoration: BoxDecoration(
                              color: context.colorScheme.mutedForeground,
                              borderRadius: BorderRadius.circular(
                                widget.borderRadius,
                              ),
                            ),
                          ),
                          errorWidget: (context, url, error) => placeholder,
                        )
                      : placeholder
                : null,
          ),
          if (hasImage || previewUrl != null)
            Positioned(
              right: -8,
              bottom: -8,
              child: Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: context.colorScheme.primary.withValues(alpha: 0.5),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: context.colorScheme.primary,
                    width: 2,
                  ),
                ),
                child: const Icon(LucideIcons.pencil, size: 16),
              ),
            ),
        ],
      ),
    );
  }
}
