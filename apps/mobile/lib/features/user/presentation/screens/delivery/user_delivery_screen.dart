import 'package:akademove/app/router/router.dart';
import 'package:akademove/core/_export.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class UserDeliveryScreen extends StatelessWidget {
  const UserDeliveryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      headers: [
        AppBar(
          padding: EdgeInsets.all(4.dg),
          title: Text(
            'Delivery Service',
            style: context.typography.h4.copyWith(fontSize: 18.sp),
          ),
          leading: [
            IconButton(
              onPressed: () => context.pop(),
              icon: Icon(LucideIcons.chevronLeft, size: 20.sp),
              variance: const ButtonStyle.ghost(),
            ),
          ],
        ),
      ],
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          spacing: 24.h,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Send packages within campus', style: context.typography.h3),
            DefaultText(
              'Fast and reliable delivery service for all your needs',
              fontSize: 14.sp,
              color: context.colorScheme.mutedForeground,
            ),
            SizedBox(height: 24.h),
            Card(
              child: Padding(
                padding: EdgeInsets.all(12.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 12.h,
                  children: [
                    Row(
                      children: [
                        Icon(LucideIcons.package, size: 24.sp),
                        SizedBox(width: 12.w),
                        DefaultText('Max weight: 20kg', fontSize: 14.sp),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(LucideIcons.clock, size: 24.sp),
                        SizedBox(width: 12.w),
                        DefaultText('Fast delivery', fontSize: 14.sp),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(LucideIcons.shield, size: 24.sp),
                        SizedBox(width: 12.w),
                        DefaultText('Secure handling', fontSize: 14.sp),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: Button.primary(
                onPressed: () => context.push(Routes.userDeliveryPickup.path),
                child: const Text('Start Delivery'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
