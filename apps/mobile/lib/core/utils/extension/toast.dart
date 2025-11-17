import 'package:akademove/core/_export.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

enum ToastType {
  info,
  loading,
  success,
  error,
  failed;

  Color get color {
    return switch (this) {
      ToastType.info => Colors.transparent,
      ToastType.loading => Colors.transparent,
      ToastType.success => Colors.green,
      ToastType.error => Colors.red,
      ToastType.failed => Colors.red,
    };
  }

  String title(BuildContext context) {
    return switch (this) {
      ToastType.info => 'Info',
      ToastType.loading => 'Loading',
      ToastType.success => 'Success',
      ToastType.error => 'Error',
      ToastType.failed => 'Failed',
    };
  }

  IconData get icon {
    return switch (this) {
      ToastType.info => LucideIcons.info,
      ToastType.loading => LucideIcons.loader,
      ToastType.success => LucideIcons.check,
      ToastType.error => LucideIcons.x,
      ToastType.failed => LucideIcons.x,
    };
  }
}

extension ToastExt on BuildContext {
  void showMyToast(
    String? message, {
    ToastType type = ToastType.info,
    Widget? trailing,
    Duration? showDuration,
  }) => showToast(
    context: this,
    location: ToastLocation.topCenter,
    showDuration: showDuration ?? const Duration(seconds: 5),
    builder: (context, overlay) {
      final title = type.title(context);
      final subtitle = (type != ToastType.loading && message != null)
          ? Text(
              message,
              style: context.typography.small.copyWith(
                fontSize: 14.sp,
                fontWeight: FontWeight.normal,
              ),
            )
          : null;
      return Card(
        padding: EdgeInsets.zero,
        borderWidth: 0,
        child: SurfaceCard(
          filled: true,
          fillColor: type.color.withValues(alpha: 0.1),
          borderColor: type.color,
          child: Basic(
            leading: Icon(type.icon, color: type.color),
            title: Text(
              title,
              style: context.typography.small.copyWith(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            subtitle: subtitle,
            trailing: trailing,
            trailingAlignment: Alignment.center,
            leadingAlignment: Alignment.center,
          ),
        ),
      );
    },
  );
}
