import 'package:akademove/core/_export.dart';
import 'package:akademove/features/cart/presentation/cubits/user_cart_cubit.dart';
import 'package:akademove/features/cart/presentation/states/_export.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

/// Widget for uploading document attachments for Printing merchants
/// Supports PDF, DOC, DOCX, and image files
class AttachmentUploadWidget extends StatelessWidget {
  const AttachmentUploadWidget({super.key});

  /// Allowed file extensions for upload
  static const _allowedExtensions = [
    'pdf',
    'doc',
    'docx',
    'jpg',
    'jpeg',
    'png',
  ];

  /// Max file size in bytes (10MB)
  static const _maxFileSize = 10 * 1024 * 1024;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCartCubit, UserCartState>(
      listenWhen: (previous, current) =>
          previous.uploadAttachmentResult != current.uploadAttachmentResult,
      listener: (context, state) {
        if (state.uploadAttachmentResult.isSuccess) {
          showToast(
            context: context,
            builder: (context, overlay) => SurfaceCard(
              child: Basic(
                leading: Icon(LucideIcons.circleCheck, color: Colors.green),
                title: const Text('File berhasil diunggah'),
              ),
            ),
          );
        } else if (state.uploadAttachmentResult.isFailed) {
          showToast(
            context: context,
            builder: (context, overlay) => SurfaceCard(
              child: Basic(
                leading: Icon(
                  LucideIcons.triangleAlert,
                  color: context.colorScheme.destructive,
                ),
                title: Text(
                  state.uploadAttachmentResult.error?.message ??
                      'Gagal mengunggah file',
                ),
              ),
            ),
          );
        }
      },
      builder: (context, state) {
        final isUploading = state.uploadAttachmentResult.isLoading;
        final hasAttachment = state.hasAttachment;
        final attachmentUrl = state.currentCart?.attachmentUrl;

        return Card(
          child: Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      LucideIcons.paperclip,
                      size: 20.sp,
                      color: context.colorScheme.primary,
                    ),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: Text(
                        'Lampiran Dokumen',
                        style: context.typography.semiBold.copyWith(
                          fontSize: 14.sp,
                        ),
                      ),
                    ),
                    if (hasAttachment)
                      IconButton(
                        variance: const ButtonStyle.ghost(),
                        onPressed: isUploading
                            ? null
                            : () => _removeAttachment(context),
                        icon: Icon(
                          LucideIcons.trash2,
                          size: 18.sp,
                          color: context.colorScheme.destructive,
                        ),
                      ),
                  ],
                ),
                SizedBox(height: 8.h),
                Text(
                  'Unggah file yang ingin dicetak (PDF, DOC, atau gambar)',
                  style: context.typography.small.copyWith(
                    color: context.colorScheme.mutedForeground,
                  ),
                ),
                SizedBox(height: 12.h),
                if (hasAttachment && attachmentUrl != null)
                  _buildAttachmentPreview(context, attachmentUrl, isUploading)
                else
                  _buildUploadButton(context, isUploading),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildUploadButton(BuildContext context, bool isUploading) {
    return SizedBox(
      width: double.infinity,
      child: OutlineButton(
        onPressed: isUploading ? null : () => _pickAndUploadFile(context),
        leading: isUploading
            ? SizedBox(
                width: 16.w,
                height: 16.h,
                child: const CircularProgressIndicator(strokeWidth: 2),
              )
            : Icon(LucideIcons.upload, size: 18.sp),
        child: Text(isUploading ? 'Mengunggah...' : 'Pilih File'),
      ),
    );
  }

  Widget _buildAttachmentPreview(
    BuildContext context,
    String url,
    bool isUploading,
  ) {
    final fileName = _extractFileName(url);
    final isImage = _isImageFile(fileName);

    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: context.colorScheme.muted.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: context.colorScheme.border),
      ),
      child: Row(
        children: [
          Container(
            width: 40.w,
            height: 40.h,
            decoration: BoxDecoration(
              color: context.colorScheme.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Center(
              child: Icon(
                isImage ? LucideIcons.image : LucideIcons.fileText,
                size: 20.sp,
                color: context.colorScheme.primary,
              ),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  fileName,
                  style: context.typography.small.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 2.h),
                Text(
                  'File berhasil diunggah',
                  style: context.typography.xSmall.copyWith(
                    color: Colors.green,
                  ),
                ),
              ],
            ),
          ),
          if (isUploading)
            SizedBox(
              width: 20.w,
              height: 20.h,
              child: const CircularProgressIndicator(strokeWidth: 2),
            )
          else
            Icon(LucideIcons.circleCheck, size: 20.sp, color: Colors.green),
        ],
      ),
    );
  }

  Future<void> _pickAndUploadFile(BuildContext context) async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: _allowedExtensions,
        allowMultiple: false,
      );

      if (result == null || result.files.isEmpty) {
        return;
      }

      final file = result.files.first;

      // Validate file size
      if (file.size > _maxFileSize) {
        if (context.mounted) {
          showToast(
            context: context,
            builder: (context, overlay) => SurfaceCard(
              child: Basic(
                leading: Icon(
                  LucideIcons.triangleAlert,
                  color: context.colorScheme.destructive,
                ),
                title: const Text('Ukuran file maksimal 10MB'),
              ),
            ),
          );
        }
        return;
      }

      // Validate file path exists
      final filePath = file.path;
      if (filePath == null) {
        if (context.mounted) {
          showToast(
            context: context,
            builder: (context, overlay) => SurfaceCard(
              child: Basic(
                leading: Icon(
                  LucideIcons.triangleAlert,
                  color: context.colorScheme.destructive,
                ),
                title: const Text('Tidak dapat membaca file'),
              ),
            ),
          );
        }
        return;
      }

      // Upload the file
      if (context.mounted) {
        await context.read<UserCartCubit>().uploadAttachment(filePath);
      }
    } catch (e) {
      if (context.mounted) {
        showToast(
          context: context,
          builder: (context, overlay) => SurfaceCard(
            child: Basic(
              leading: Icon(
                LucideIcons.triangleAlert,
                color: context.colorScheme.destructive,
              ),
              title: const Text('Gagal memilih file'),
            ),
          ),
        );
      }
    }
  }

  void _removeAttachment(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Hapus Lampiran'),
        content: const Text('Apakah Anda yakin ingin menghapus lampiran ini?'),
        actions: [
          OutlineButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: const Text('Batal'),
          ),
          PrimaryButton(
            onPressed: () {
              Navigator.of(dialogContext).pop();
              context.read<UserCartCubit>().removeAttachment();
            },
            child: const Text('Hapus'),
          ),
        ],
      ),
    );
  }

  /// Extract filename from URL
  String _extractFileName(String url) {
    try {
      final uri = Uri.parse(url);
      final pathSegments = uri.pathSegments;
      if (pathSegments.isNotEmpty) {
        return pathSegments.last;
      }
    } catch (e) {
      // URI parsing failed, fallback to default filename
      debugPrint('[AttachmentUploadWidget] Failed to parse URL: $e');
    }
    return 'document';
  }

  /// Check if file is an image based on extension
  bool _isImageFile(String fileName) {
    final extension = fileName.split('.').last.toLowerCase();
    return ['jpg', 'jpeg', 'png', 'gif', 'webp'].contains(extension);
  }
}
