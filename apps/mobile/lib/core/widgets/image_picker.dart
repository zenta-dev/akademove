import 'dart:io';

import 'package:akademove/core/_export.dart';
import 'package:akademove/l10n/l10n.dart';
import 'package:akademove/locator.dart';
import 'package:cached_network_image/cached_network_image.dart';

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
            title: context.l10n.error_photo_pick_failed,
            message: e.toString(),
          ),
        );
      }
    }
  }

  void _showSourceOptions() {
    openSheet<void>(
      context: context,
      position: OverlayPosition.bottom,
      builder: (sheetContext) => SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: () {
                  closeOverlay<void>(sheetContext);
                  _pickImage(ImageSource.camera);
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  child: Row(
                    children: [
                      const Icon(LucideIcons.camera),
                      const SizedBox(width: 16),
                      Text(context.l10n.action_take_photo),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  closeOverlay<void>(sheetContext);
                  _pickImage(ImageSource.gallery);
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  child: Row(
                    children: [
                      const Icon(LucideIcons.image),
                      const SizedBox(width: 16),
                      Text(context.l10n.action_choose_gallery),
                    ],
                  ),
                ),
              ),
              if (_selectedImage != null)
                GestureDetector(
                  onTap: () {
                    closeOverlay<void>(sheetContext);
                    setState(() => _selectedImage = null);
                    widget.onValueChanged?.call(File(''));
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    child: Row(
                      children: [
                        const Icon(LucideIcons.trash2),
                        const SizedBox(width: 16),
                        Text(context.l10n.action_remove_image),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final previewUrl = widget.previewUrl;
    final selectedImage = _selectedImage;
    final hasImage = selectedImage != null && selectedImage.existsSync();

    final placeholder = Center(
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
                      image: FileImage(selectedImage),
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
