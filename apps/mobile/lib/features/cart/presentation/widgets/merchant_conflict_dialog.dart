import 'package:akademove/core/_export.dart';
import 'package:akademove/features/cart/presentation/cubits/user_cart_cubit.dart';
import 'package:akademove/l10n/l10n.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

/// Dialog shown when user tries to add item from different merchant
/// Requires confirmation to replace cart with new merchant's items
class MerchantConflictDialog extends StatelessWidget {
  const MerchantConflictDialog({
    required this.currentMerchantName,
    required this.newMerchantName,
    required this.cartCubit,
    super.key,
  });

  final String currentMerchantName;
  final String newMerchantName;
  final UserCartCubit cartCubit;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        spacing: 12.w,
        children: [
          Icon(
            LucideIcons.triangleAlert,
            color: context.colorScheme.primary,
            size: 24.sp,
          ),
          Text(context.l10n.cart_replace_cart_items),
        ],
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 8.h,
          children: [
            Text(
              context.l10n.cart_current_cart_will_be_cleared,
              style: context.typography.small.copyWith(
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              context.l10n.cart_discard_and_add_from(newMerchantName),
              style: context.typography.p.copyWith(fontSize: 14.sp),
            ),
            SizedBox(height: 8.h),
            Alert(
              leading: Icon(LucideIcons.info, size: 16.sp),
              content: Text(
                context.l10n.cart_current_cart_will_be_cleared,
                style: context.typography.small.copyWith(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
      actions: [
        OutlineButton(
          onPressed: () {
            cartCubit.cancelReplaceCart();
            Navigator.of(context).pop();
          },
          child: Text(context.l10n.cancel),
        ),
        PrimaryButton(
          onPressed: () {
            cartCubit.confirmReplaceCart();
            Navigator.of(context).pop();
          },
          child: Text(context.l10n.cart_replace_cart),
        ),
      ],
    );
  }

  /// Show the dialog
  static Future<void> show(
    BuildContext context, {
    required String currentMerchantName,
    required String newMerchantName,
  }) {
    // Capture the cubit from the parent context before showing dialog
    final cartCubit = context.read<UserCartCubit>();

    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => MerchantConflictDialog(
        currentMerchantName: currentMerchantName,
        newMerchantName: newMerchantName,
        cartCubit: cartCubit,
      ),
    );
  }
}
