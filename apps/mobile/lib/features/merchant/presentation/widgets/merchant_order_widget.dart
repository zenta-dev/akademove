import 'package:akademove/core/_export.dart';
import 'package:api_client/api_client.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:akademove/l10n/l10n.dart';

class MerchantOrderCardWidget extends StatelessWidget {
  const MerchantOrderCardWidget({
    required this.order,
    this.onPressed,
    this.onAccept,
    super.key,
  });

  final Order order;
  final void Function()? onPressed;
  final void Function()? onAccept;

  @override
  Widget build(BuildContext context) {
    return Button(
      style: ButtonVariance.ghost.copyWith(
        padding: (context, states, value) => EdgeInsetsGeometry.zero,
      ),
      onPressed: onPressed,
      child: SizedBox(
        width: double.infinity,
        child: Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 8.h,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    order.user?.name ?? 'Folks',
                    style: context.typography.small.copyWith(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Row(
                    spacing: 4.w,
                    children: [
                      Text(
                        context.l10n.item_count(order.itemCount ?? 0),
                        style: context.typography.textMuted.copyWith(
                          fontSize: 12.sp,
                          color: context.colorScheme.mutedForeground,
                        ),
                      ),
                      Icon(
                        LucideIcons.chevronRight,
                        size: 12.sp,
                        color: context.colorScheme.mutedForeground,
                      ),
                    ],
                  ),
                ],
              ),
              Text(
                order.requestedAt.orderFormat,
                style: context.typography.small.copyWith(
                  fontSize: 12.sp,
                  color: context.colorScheme.mutedForeground,
                ),
              ),
              const Divider(),
              Text(
                'Rp. ${order.totalPrice}',
                style: context.typography.small.copyWith(fontSize: 14.sp),
              ),
              if (onAccept != null && order.status == OrderStatus.REQUESTED)
                ...[],
              SizedBox(
                width: double.infinity,
                child: PrimaryButton(
                  onPressed: () {
                    showToast(
                      context: context,
                      location: ToastLocation.topCenter,
                      builder: (context, overlay) => context.buildToast(
                        title: 'Tap Button',
                        message: 'index => ${order.id}',
                      ),
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(context.l10n.button_accept),
                      Row(
                        spacing: 4.w,
                        children: [
                          Icon(LucideIcons.clock, size: 16.sp),
                          const Text('01:00'),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
