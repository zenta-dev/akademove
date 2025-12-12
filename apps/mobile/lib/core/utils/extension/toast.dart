import "package:akademove/core/_export.dart";
import "package:akademove/l10n/l10n.dart";
import "package:flutter/services.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:shadcn_flutter/shadcn_flutter.dart";

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

  /// Show an error toast with an optional retry button
  /// Used by GlobalErrorHandler to display uncaught exceptions
  /// Message format: "Error message\n\nError Code: ERR-xxx-xxxx"
  void showErrorToast(
    String message, {
    VoidCallback? onRetry,
    Duration? showDuration,
  }) {
    // Parse the message to extract error code if present
    String displayMessage = message;
    String? errorCode;

    final errorCodeMatch = RegExp(
      r"Error Code: (ERR-\d+-[A-F0-9]+)",
    ).firstMatch(message);
    if (errorCodeMatch != null) {
      errorCode = errorCodeMatch.group(1);
      // Remove the error code line from display message
      displayMessage = message
          .replaceAll("\n\nError Code: $errorCode", "")
          .trim();
    }

    // Also check for debug format: [ERR-xxx-xxxx]
    final debugCodeMatch = RegExp(
      r"\[(ERR-\d+-[A-F0-9]+)\]",
    ).firstMatch(message);
    if (debugCodeMatch != null && errorCode == null) {
      errorCode = debugCodeMatch.group(1);
    }

    showToast(
      context: this,
      location: ToastLocation.topCenter,
      showDuration: showDuration ?? const Duration(seconds: 10),
      builder: (context, overlay) {
        return Card(
          padding: EdgeInsets.zero,
          borderWidth: 0,
          child: SurfaceCard(
            padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 12.w),
            filled: true,
            fillColor: Colors.red.withValues(alpha: 0.1),
            borderColor: Colors.red,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header row with close button
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      LucideIcons.triangleAlert,
                      color: Colors.red,
                      size: 20.w,
                    ),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          DefaultText(
                            context.l10n.error_unexpected,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            displayMessage,
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.normal,
                            ),
                            maxLines: 4,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    IconButton.ghost(
                      icon: const Icon(LucideIcons.x, size: 16),
                      onPressed: overlay.close,
                      density: ButtonDensity.compact,
                    ),
                  ],
                ),
                // Error code row (if present) - tappable to copy
                if (errorCode != null) ...[
                  SizedBox(height: 8.h),
                  GestureDetector(
                    onTap: () {
                      Clipboard.setData(ClipboardData(text: errorCode!));
                      // Show a brief toast confirmation
                      showToast(
                        context: context,
                        location: ToastLocation.bottomCenter,
                        showDuration: const Duration(seconds: 1),
                        builder: (ctx, _) => Card(
                          padding: EdgeInsets.symmetric(
                            horizontal: 12.w,
                            vertical: 8.h,
                          ),
                          child: Text(ctx.l10n.copied_to_clipboard),
                        ),
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.w,
                        vertical: 4.h,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.gray.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(4.r),
                        border: Border.all(
                          color: Colors.gray.withValues(alpha: 0.3),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            LucideIcons.copy,
                            size: 12.w,
                            color: Colors.gray,
                          ),
                          SizedBox(width: 4.w),
                          Text(
                            errorCode,
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                              fontFamily: "monospace",
                              color: Colors.gray,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
                // Retry button (if callback provided)
                if (onRetry != null) ...[
                  SizedBox(height: 8.h),
                  Align(
                    alignment: Alignment.centerRight,
                    child: PrimaryButton(
                      size: ButtonSize.small,
                      onPressed: () {
                        overlay.close();
                        onRetry();
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(LucideIcons.refreshCw, size: 14),
                          SizedBox(width: 4.w),
                          Text(context.l10n.retry),
                        ],
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}
