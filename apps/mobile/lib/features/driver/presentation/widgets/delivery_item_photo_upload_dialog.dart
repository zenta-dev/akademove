import 'dart:io';

import 'package:akademove/core/_export.dart';
import 'package:akademove/features/driver/presentation/cubits/_export.dart';
import 'package:akademove/features/driver/presentation/states/_export.dart';
import 'package:akademove/l10n/l10n.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

/// Dialog for uploading delivery item photo
/// Used by drivers to document the item they picked up for delivery
class DeliveryItemPhotoUploadDialog extends StatefulWidget {
  const DeliveryItemPhotoUploadDialog({required this.orderId, super.key});

  final String orderId;

  @override
  State<DeliveryItemPhotoUploadDialog> createState() =>
      _DeliveryItemPhotoUploadDialogState();
}

class _DeliveryItemPhotoUploadDialogState
    extends State<DeliveryItemPhotoUploadDialog> {
  final ImagePicker _picker = ImagePicker();
  XFile? _selectedImage;
  bool _isUploading = false;

  Future<void> _pickImage(ImageSource source) async {
    try {
      final image = await _picker.pickImage(
        source: source,
        maxWidth: 1920,
        maxHeight: 1920,
        imageQuality: 85,
      );

      if (image != null) {
        setState(() => _selectedImage = image);
      }
    } catch (e, st) {
      logger.e(
        '[DeliveryItemPhotoUploadDialog] - Error picking image: $e',
        error: e,
        stackTrace: st,
      );
      if (mounted) {
        context.showMyToast(
          context.l10n.an_error_occurred,
          type: ToastType.failed,
        );
      }
    }
  }

  void _uploadPhoto() {
    final selectedImage = _selectedImage;
    if (selectedImage == null || _isUploading) return;

    setState(() => _isUploading = true);

    // BlocListener handles state changes
    context.read<DriverOrderCubit>().uploadDeliveryItemPhoto(
      selectedImage.path,
    );
  }

  void _onUploadStateChanged(DriverOrderState state) {
    if (state.uploadItemPhotoResult.isSuccess) {
      Navigator.of(context).pop(true);
      context.showMyToast(
        'Delivery item photo uploaded successfully',
        type: ToastType.success,
      );
    } else if (state.uploadItemPhotoResult.isFailure) {
      setState(() => _isUploading = false);
      context.showMyToast(
        state.uploadItemPhotoResult.error?.message ??
            'Failed to upload delivery item photo',
        type: ToastType.failed,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<DriverOrderCubit, DriverOrderState>(
      listenWhen: (previous, current) =>
          previous.uploadItemPhotoResult != current.uploadItemPhotoResult,
      listener: (context, state) => _onUploadStateChanged(state),
      child: AlertDialog(
        title: const Text('Upload Item Photo'),
        content: SingleChildScrollView(
          child: SizedBox(
            width: context.mediaQuerySize.width * 0.8,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Instructions
                Text(
                  'Take a photo of the item you picked up for delivery. '
                  'This helps verify the item condition at pickup.',
                  style: context.typography.small,
                ),
                SizedBox(height: 16.h),

                // Image preview or picker buttons
                if (_selectedImage != null)
                  Builder(
                    builder: (context) {
                      final imagePath = _selectedImage?.path;
                      if (imagePath == null) return const SizedBox.shrink();

                      return Stack(
                        alignment: Alignment.topRight,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8.r),
                            child: Image.file(
                              File(imagePath),
                              width: double.infinity,
                              height: 200.h,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                            top: 8,
                            right: 8,
                            child: GestureDetector(
                              onTap: () =>
                                  setState(() => _selectedImage = null),
                              child: Container(
                                padding: EdgeInsets.all(4.dg),
                                decoration: BoxDecoration(
                                  color: Colors.black.withValues(alpha: 0.54),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  LucideIcons.x,
                                  size: 16.sp,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  )
                else
                  Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: OutlineButton(
                          onPressed: () => _pickImage(ImageSource.camera),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            spacing: 8.w,
                            children: [
                              Icon(LucideIcons.camera, size: 20.sp),
                              const Text('Take Photo'),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 12.h),
                      SizedBox(
                        width: double.infinity,
                        child: OutlineButton(
                          onPressed: () => _pickImage(ImageSource.gallery),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            spacing: 8.w,
                            children: [
                              Icon(LucideIcons.image, size: 20.sp),
                              const Text('Choose from Gallery'),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),

                SizedBox(height: 16.h),

                // Note about photo usage
                Container(
                  padding: EdgeInsets.all(12.dg),
                  decoration: BoxDecoration(
                    color: context.theme.colorScheme.muted,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 8.w,
                    children: [
                      Icon(
                        LucideIcons.info,
                        size: 16.sp,
                        color: context.theme.colorScheme.mutedForeground,
                      ),
                      Expanded(
                        child: Text(
                          'This photo will be saved as proof of item condition '
                          'at pickup and can be viewed by the customer.',
                          style: context.typography.small.copyWith(
                            color: context.theme.colorScheme.mutedForeground,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        actions: [
          OutlineButton(
            onPressed: _isUploading ? null : () => Navigator.of(context).pop(),
            child: Text(context.l10n.cancel),
          ),
          PrimaryButton(
            onPressed: _selectedImage == null || _isUploading
                ? null
                : _uploadPhoto,
            child: _isUploading
                ? SizedBox(
                    width: 16.w,
                    height: 16.h,
                    child: const CircularProgressIndicator(size: 16),
                  )
                : const Text('Upload'),
          ),
        ],
      ),
    );
  }
}
