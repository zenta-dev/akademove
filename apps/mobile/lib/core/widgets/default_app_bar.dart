import 'package:akademove/core/_export.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class DefaultAppBar extends StatelessWidget {
  const DefaultAppBar({
    required this.title,
    this.subtitle,
    this.padding,
    this.trailing = const [],
    super.key,
  });
  final String title;
  final String? subtitle;
  final EdgeInsetsGeometry? padding;
  final List<Widget> trailing;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      padding: padding ?? EdgeInsets.all(4.dg),
      title: Text(
        title,
        style: context.typography.h4.copyWith(fontSize: 18.sp),
      ),
      subtitle: subtitle != null
          ? Text(
              subtitle ?? '',
              style: context.typography.small.copyWith(fontSize: 14.sp),
            )
          : null,
      trailing: trailing,
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
