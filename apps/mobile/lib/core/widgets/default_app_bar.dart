import 'package:akademove/core/_export.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class DefaultAppBar extends StatelessWidget {
  const DefaultAppBar({required this.title, this.subtitle, super.key});
  final String title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      padding: EdgeInsets.all(4.dg),
      title: Text(
        title,
        style: context.typography.h4.copyWith(fontSize: 18.sp),
      ),
      subtitle: subtitle != null
          ? Text(
              subtitle ?? '',
              style: context.typography.h4.copyWith(fontSize: 14.sp),
            )
          : null,
      leading: [
        if (context.canPop()) ...[
          IconButton(
            onPressed: () => context.pop(),
            icon: Icon(LucideIcons.chevronLeft, size: 20.sp),
            variance: const ButtonStyle.ghost(),
          ),
        ],
      ],
    );
  }
}
