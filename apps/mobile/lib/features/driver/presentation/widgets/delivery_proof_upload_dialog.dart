import 'dart:io';

import 'package:akademove/core/_export.dart';
import 'package:akademove/features/driver/presentation/cubits/_export.dart';
import 'package:akademove/l10n/l10n.dart';
import 'package:flutter/material.dart' as material;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

/// Dialog for uploading delivery proof photo
/// Used for high-value orders (>100k IDR) to verify delivery
class DeliveryProofUploadDialog extends StatefulWidget {
  const DeliveryProofUploadDialog({required this.orderId, super.key});

  final String orderId;

  @override
  State<DeliveryProofUploadDialog> createState() =>
      _DeliveryProofUploadDialogState();
}

class _DeliveryProofUploadDialogState extends State<DeliveryProofUploadDialog> {
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
        '[DeliveryProofUploadDialog] - Error picking image: $e',
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

  Future<void> _uploadProof() async {
    final selectedImage = _selectedImage;
    if (selectedImage == null || _isUploading) return;

    setState(() => _isUploading = true);

    final driverOrderCubit = context.read<DriverOrderCubit>();

    try {
      await driverOrderCubit.uploadDeliveryProof(selectedImage.path);

      if (!mounted) return;

      final state = driverOrderCubit.state;

      if (state.isSuccess) {
        Navigator.of(context).pop(true);
        context.showMyToast(
          state.message ?? 'Delivery proof uploaded successfully',
          type: ToastType.success,
        );
      } else if (state.isFailure) {
        context.showMyToast(
          state.error?.message ?? 'Failed to upload delivery proof',
          type: ToastType.failed,
        );
      }
    } finally {
      // Always reset uploading state if widget is still mounted
      if (mounted) {
        setState(() => _isUploading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return material.AlertDialog(
      title: const Text('Upload Delivery Proof'),
      content: SingleChildScrollView(
        child: SizedBox(
          width: context.mediaQuerySize.width * 0.8,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Instructions
              Text(
                'Take a photo of the delivered item or delivery location as proof of delivery.',
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
                          child: material.IconButton(
                            icon: const Icon(LucideIcons.x),
                            onPressed: () =>
                                setState(() => _selectedImage = null),
                            style: material.IconButton.styleFrom(
                              backgroundColor: material.Colors.black54,
                              foregroundColor: material.Colors.white,
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

              // Note about OTP
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
                        'After upload, you will receive an OTP code to share with the customer for verification.',
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
              : _uploadProof,
          child: _isUploading
              ? SizedBox(
                  width: 16.w,
                  height: 16.h,
                  child: const material.CircularProgressIndicator(
                    strokeWidth: 2,
                  ),
                )
              : const Text('Upload'),
        ),
      ],
    );
  }
}
