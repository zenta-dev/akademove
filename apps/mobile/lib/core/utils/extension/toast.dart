import 'package:akademove/core/_export.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

enum ToastType {
  info,
  loading,
  success,
  error;

  Color get color {
    return switch (this) {
      ToastType.info => Colors.transparent,
      ToastType.loading => Colors.transparent,
      ToastType.success => Colors.green,
      ToastType.error => Colors.red,
    };
  }

  String title(BuildContext context) {
    return switch (this) {
      ToastType.info => 'Info',
      ToastType.loading => 'Loading',
      ToastType.success => 'Success',
      ToastType.error => 'Error',
    };
  }

  IconData get icon {
    return switch (this) {
      ToastType.info => LucideIcons.info,
      ToastType.loading => LucideIcons.loader,
      ToastType.success => LucideIcons.check,
      ToastType.error => LucideIcons.info,
    };
  }
}

extension ToastExt on BuildContext {
  void showMyToast(
    String? message, {
    ToastType type = ToastType.info,
    Widget? trailing,
  }) => showToast(
    context: this,
    location: ToastLocation.topCenter,
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
      return SurfaceCard(
        fillColor: type.color.withValues(),
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
      );
    },
  );
}
