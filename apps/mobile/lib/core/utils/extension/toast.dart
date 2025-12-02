import 'package:akademove/core/_export.dart';
import 'package:akademove/l10n/l10n.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

enum ToastType {
  info,
  loading,
  success,
  failed,
  warning;

  Color get color {
    return switch (this) {
      ToastType.info => Colors.transparent,
      ToastType.loading => Colors.transparent,
      ToastType.success => Colors.green,
      ToastType.failed => Colors.red,
      ToastType.warning => Colors.orange,
    };
  }

  String title(BuildContext context) {
    return switch (this) {
      ToastType.info => context.l10n.info,
      ToastType.loading => context.l10n.loading,
      ToastType.success => context.l10n.success,
      ToastType.failed => context.l10n.failed,
      ToastType.warning => context.l10n.warning,
    };
  }

  IconData get icon {
    return switch (this) {
      ToastType.info => LucideIcons.info,
      ToastType.loading => LucideIcons.loader,
      ToastType.success => LucideIcons.check,
      ToastType.failed => LucideIcons.x,
      ToastType.warning => LucideIcons.info,
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
      final subtitle = (type != ToastType.loading)
          ? DefaultText(
              message ?? context.l10n.an_error_occurred,
              fontSize: 14.sp,
              fontWeight: FontWeight.normal,
            )
          : null;
      return Card(
        padding: EdgeInsets.zero,
        borderWidth: 0,
        child: SurfaceCard(
          padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 12.w),
          filled: true,
          fillColor: type.color.withValues(alpha: 0.1),
          borderColor: type.color,
          child: Basic(
            leading: Icon(type.icon, color: type.color),
            title: DefaultText(
              title,
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
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
