import 'package:akademove/core/_export.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class OopsAlertWidget extends StatelessWidget {
  const OopsAlertWidget({
    required this.message,
    required this.onRefresh,
    super.key,
  });
  final String message;
  final VoidCallback onRefresh;

  @override
  Widget build(BuildContext context) {
    return Alert.destructive(
      title: Text(
        'Oops...',
        style: context.typography.small.copyWith(fontSize: 16.sp),
      ),
      content: Text(
        message,
        style: context.typography.small.copyWith(fontSize: 14.sp),
      ),
      leading: const Icon(LucideIcons.info),
      trailing: IconButton.ghost(
        icon: const Icon(LucideIcons.refreshCcw),
        onPressed: onRefresh,
      ),
    );
  }
}
