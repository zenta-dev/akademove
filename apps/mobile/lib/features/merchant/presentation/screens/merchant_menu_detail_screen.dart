import 'package:akademove/app/router.dart';
import 'package:akademove/core/_export.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class MerchantMenuDetailScreen extends StatelessWidget {
  const MerchantMenuDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      safeArea: true,
      headers: const [
        DefaultAppBar(title: 'Menu’s Detail'),
      ],
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          spacing: 8.h,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12.r),
              child: Image.asset(
                "assets/images/item's_photo.png",
                width: 150.w,
                height: 150.w,
                fit: BoxFit.cover,
              ),
            ),
            _buildDetailRow(context, 'Menu’s Category:', 'Drink'),
            _buildDetailRow(context, 'Menu’s Name:', 'Butterscotch Milk'),
            _buildDetailRow(
              context,
              'Menu’s Description :',
              'Milk combined with brown sugar',
              multiline: true,
            ),
            _buildDetailRow(context, 'Menu’s Price:', 'Rp 30.000'),
            Row(
              spacing: 16.w,
              children: [
                Expanded(
                  child: Button.primary(
                    onPressed: () =>
                        context.pushNamed(Routes.merchantEditMenu.name),
                    child: Text(
                      'Edit menu',
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
                      'Delete menu',
                      style: context.typography.small.copyWith(
                        fontSize: 16.sp,
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

  Widget _buildDetailRow(
    BuildContext context,
    String label,
    String value, {
    bool multiline = false,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Row(
        crossAxisAlignment: multiline
            ? CrossAxisAlignment.start
            : CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 4,
            child: Text(
              label,
              style: context.typography.small.copyWith(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            flex: 6,
            child: Text(
              value,
              style: context.typography.small.copyWith(
                fontSize: 14.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
