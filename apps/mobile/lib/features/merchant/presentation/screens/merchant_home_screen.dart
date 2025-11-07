import 'package:akademove/app/router.dart';
import 'package:akademove/core/_export.dart';
import 'package:akademove/features/features.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class MerchantHomeScreen extends StatelessWidget {
  const MerchantHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 16.h,
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16.dg),
              decoration: BoxDecoration(
                color: context.colorScheme.primary.withValues(alpha: .5),
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Column(
                spacing: 8.h,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      BlocBuilder<MerchantCubit, MerchantState>(
                        builder: (context, state) {
                          return Text(
                            'Hello, ${state.mine?.name ?? "Folks"}',
                            style: context.typography.h1.copyWith(
                              fontSize: 20.sp,
                            ),
                          ).asSkeleton(enabled: state.isLoading);
                        },
                      ),
                      Row(
                        spacing: 4.w,
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: Icon(LucideIcons.power, size: 20.sp),
                            variance: const ButtonStyle.ghostIcon(),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(LucideIcons.bell, size: 20.sp),
                            variance: const ButtonStyle.ghostIcon(),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    spacing: 4.w,
                    children: [
                      Icon(LucideIcons.alarmClock, size: 20.sp),
                      Text(
                        'Open Today',
                        style: context.typography.h4.copyWith(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Gap(4.w),
                      Chip(
                        child: Text(
                          '10.00 - 22.00 WIB',
                          style: context.typography.h4.copyWith(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Text(
              'Sales Recap',
              style: context.typography.h2.copyWith(
                fontSize: 20.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            Row(
              spacing: 12.w,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: (context.mediaQuerySize.width / 2) - 32,
                  child: Card(
                    child: Column(
                      spacing: 4.h,
                      children: [
                        Icon(
                          LucideIcons.shoppingCart,
                          size: 32.sp,
                        ),
                        Text(
                          'Today’s transaction',
                          style: context.typography.p.copyWith(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          '15',
                          style: context.typography.p.copyWith(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: (context.mediaQuerySize.width / 2) - 32,
                  child: Card(
                    child: Column(
                      spacing: 4.h,
                      children: [
                        Icon(
                          LucideIcons.circleDollarSign,
                          size: 32.sp,
                        ),
                        Text(
                          "Today's gross sales",
                          style: context.typography.p.copyWith(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          'Rp 1.500.000',
                          style: context.typography.p.copyWith(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Row(
              spacing: 12.w,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: (context.mediaQuerySize.width / 2) - 32,
                  child: Button(
                    style: ButtonVariance.ghost.copyWith(
                      padding: (context, states, value) =>
                          EdgeInsetsGeometry.zero,
                    ),
                    onPressed: () {
                      context.pushNamed(Routes.merchantSalesReportDetail.name);
                    },
                    child: Card(
                      child: Column(
                        spacing: 4.h,
                        children: [
                          Icon(
                            LucideIcons.chartArea,
                            size: 32.sp,
                          ),
                          Text(
                            'Sales Report',
                            style: context.typography.p.copyWith(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: OutlineButton(
                              onPressed: () {},
                              density: ButtonDensity.iconDense,
                              child: Row(
                                spacing: 4.w,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text('See detail').xSmall,
                                  Icon(
                                    LucideIcons.chevronRight,
                                    size: 16.sp,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: (context.mediaQuerySize.width / 2) - 32,
                  child: Button(
                    style: ButtonVariance.ghost.copyWith(
                      padding: (context, states, value) =>
                          EdgeInsetsGeometry.zero,
                    ),
                    onPressed: () {
                      context.pushNamed(
                        Routes.merchantCommissionReportDetail.name,
                      );
                    },
                    child: Card(
                      child: Column(
                        spacing: 4.h,
                        children: [
                          Icon(
                            LucideIcons.badgeDollarSign,
                            size: 32.sp,
                          ),
                          Text(
                            'Commission Report',
                            style: context.typography.p.copyWith(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: OutlineButton(
                              onPressed: () {},
                              density: ButtonDensity.iconDense,
                              child: Row(
                                spacing: 4.w,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text('See detail').xSmall,
                                  Icon(
                                    LucideIcons.chevronRight,
                                    size: 16.sp,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
