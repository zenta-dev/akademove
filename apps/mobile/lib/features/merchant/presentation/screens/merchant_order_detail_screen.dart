import 'package:akademove/app/router/router.dart';
import 'package:akademove/core/_export.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class MerchantOrderDetailScreen extends StatelessWidget {
  const MerchantOrderDetailScreen({super.key});

  Widget _buildCustomerInfo(BuildContext context) {
    return Card(
      child: Row(
        spacing: 8.w,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Ordered by',
                  style: context.typography.small.copyWith(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 6.h),
                Text(
                  'John Doe',
                  style: context.typography.small.copyWith(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {
              context.pushNamed(Routes.merchantCommissionReportDetail.name);
            },
            icon: const Icon(Icons.message_rounded),
            variance: ButtonVariance.primary,
          ),
        ],
      ),
    );
  }

  Widget _buildDriverInfo(BuildContext context) {
    return Card(
      child: Column(
        spacing: 8.h,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            spacing: 8.w,
            children: [
              Text(
                'Driver will arrive within',
                style: context.typography.small.copyWith(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: const Color(0XFF0498B1),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  '5 minutes',
                  style: context.typography.small.copyWith(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Matthew',
                style: context.typography.small.copyWith(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              IconButton(
                onPressed: () {
                  context.pushNamed(Routes.merchantCommissionReportDetail.name);
                },
                icon: const Icon(Icons.message_rounded),
                variance: const ButtonStyle.primary(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOrderDetails(BuildContext context) {
    return Card(
      child: Column(
        spacing: 8.h,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            spacing: 8.w,
            children: [
              Text(
                '2x',
                style: context.typography.small.copyWith(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                'Fried Rice',
                style: context.typography.small.copyWith(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0XFF7F7035),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              spacing: 8.w,
              children: [
                const Icon(Icons.menu_book_rounded),
                Text(
                  'Add some chips please',
                  style: context.typography.small.copyWith(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            spacing: 8.w,
            children: [
              Text(
                'Subtotal',
                style: context.typography.small.copyWith(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                'Rp 100.000',
                style: context.typography.small.copyWith(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            spacing: 8.w,
            children: [
              Text(
                'Total',
                style: context.typography.small.copyWith(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                'Rp 100.000',
                style: context.typography.small.copyWith(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOrderTime(BuildContext context) {
    return Card(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        spacing: 8.w,
        children: [
          Text(
            'Order time',
            style: context.typography.small.copyWith(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            '14 Sep, 10:10',
            style: context.typography.small.copyWith(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        MyScaffold(
          headers: const [
            DefaultAppBar(title: 'Order Detail', subtitle: 'F-123456789'),
          ],
          padding: EdgeInsets.all(16.w),
          body: SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.only(bottom: 120.h),
              child: Column(
                spacing: 16.h,
                children: [
                  _buildCustomerInfo(context),
                  _buildDriverInfo(context),
                  _buildOrderDetails(context),
                  _buildOrderTime(context),
                ],
              ),
            ),
          ),
        ),

        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: SafeArea(
            child: Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.background,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                spacing: 16.w,
                children: [
                  Expanded(
                    child: Button.primary(
                      onPressed: () {},
                      child: Text(
                        'Order ready',
                        style: context.typography.small.copyWith(
                          fontSize: 16.sp,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Button.destructive(
                      onPressed: () {},
                      child: Text(
                        'Cancel order',
                        style: context.typography.small.copyWith(
                          fontSize: 16.sp,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
