import 'package:akademove/core/_export.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

/// Sticky bottom cart button showing item count and total price
/// Positioned at bottom center with count badge
class BottomCartButtonWidget extends StatelessWidget {
  /// Number of items in cart
  final int itemCount;

  /// Total price of cart
  final double totalPrice;

  /// Button label text
  final String buttonText;

  /// Callback when button is pressed
  final VoidCallback onPressed;

  const BottomCartButtonWidget({
    required this.itemCount,
    required this.totalPrice,
    required this.onPressed,
    this.buttonText = 'Checkout',
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: context.colorScheme.primary,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 8.r,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: Button(
        style: const ButtonStyle.primary(density: ButtonDensity.icon),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Cart icon + item count badge
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  LucideIcons.shoppingCart,
                  color: context.colorScheme.primaryForeground,
                  size: 20.sp,
                ),
                SizedBox(width: 8.w),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: context.colorScheme.primaryForeground,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Text(
                    itemCount.toString(),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12.sp,
                      color: context.colorScheme.primary,
                    ),
                  ),
                ),
              ],
            ),

            // Total price
            Text(
              'Rp ${totalPrice.toStringAsFixed(0)}',
              style: context.typography.h4.copyWith(
                color: context.colorScheme.primaryForeground,
                fontWeight: FontWeight.w600,
              ),
            ),

            // Button text
            Text(
              buttonText,
              style: context.typography.h4.copyWith(
                color: context.colorScheme.primaryForeground,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
