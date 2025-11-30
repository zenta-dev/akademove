import 'package:akademove/core/_export.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class ChecklistIndicatorWidget extends StatelessWidget {
  const ChecklistIndicatorWidget({required this.isSelected, super.key});
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 16.sp,
      height: 16.sp,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isSelected ? context.colorScheme.primary : null,
        border: Border.all(
          color: isSelected
              ? context.colorScheme.primary
              : context.colorScheme.mutedForeground,
          width: 1.sp,
        ),
      ),
      child: isSelected
          ? Center(
              child: Container(
                width: 8.sp,
                height: 8.sp,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isSelected
                      ? context.colorScheme.primary
                      : context.colorScheme.mutedForeground,
                ),
                child: Icon(LucideIcons.check, size: 8.sp),
              ),
            )
          : null,
    );
  }
}
