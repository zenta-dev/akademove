import 'package:akademove/core/_export.dart';
import 'package:akademove/features/user/presentation/widgets/quantity_adjuster_widget.dart';
import 'package:api_client/api_client.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

/// Item card widget displaying menu item information
/// Shows: photo, name, price, stock status, and quantity adjuster
class ItemCardWidget extends StatelessWidget {
  /// Menu item to display
  final MerchantMenu item;

  /// Current quantity in cart
  final int currentQty;

  /// Callback when quantity changes
  final Function(int) onQuantityChanged;

  const ItemCardWidget({
    required this.item,
    required this.currentQty,
    required this.onQuantityChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final isOutOfStock = item.stock == 0;
    final image = item.image;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: isOutOfStock ? Colors.gray[50] : Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: isOutOfStock ? Colors.gray[300] : Colors.gray[200],
          width: 1,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Item photo
          ClipRRect(
            borderRadius: BorderRadius.circular(8.r),
            child: SizedBox(
              width: 80.w,
              height: 80.h,
              child: image != null && image.isNotEmpty
                  ? Opacity(
                      opacity: isOutOfStock ? 0.5 : 1.0,
                      child: CachedNetworkImage(
                        imageUrl: image,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Container(
                          color: context.colorScheme.muted,
                          child: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                        errorWidget: (context, url, error) => Container(
                          color: context.colorScheme.muted,
                          child: Center(
                            child: Icon(
                              LucideIcons.image,
                              size: 24.sp,
                              color: context.colorScheme.mutedForeground,
                            ),
                          ),
                        ),
                      ),
                    )
                  : Opacity(
                      opacity: isOutOfStock ? 0.5 : 1.0,
                      child: Container(
                        color: context.colorScheme.muted,
                        child: Center(
                          child: Icon(
                            LucideIcons.image,
                            size: 24.sp,
                            color: context.colorScheme.mutedForeground,
                          ),
                        ),
                      ),
                    ),
            ),
          ),
          SizedBox(width: 12.w),

          // Item details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 6.h,
              children: [
                // Name + out-of-stock badge
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        item.name,
                        style: context.typography.h4.copyWith(
                          fontWeight: FontWeight.w600,
                          color: isOutOfStock ? Colors.gray[500] : null,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (isOutOfStock) ...[
                      SizedBox(width: 8.w),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8.w,
                          vertical: 4.h,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.red[100],
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                        child: Text(
                          'Out',
                          style: TextStyle(
                            color: Colors.red[700],
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),

                // Price
                Text(
                  'Rp ${item.price.toStringAsFixed(0)}',
                  style: context.typography.h4.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 14.sp,
                    color: isOutOfStock ? Colors.gray[500] : null,
                  ),
                ),

                // Stock indicator + Quantity adjuster
                if (isOutOfStock)
                  Text(
                    'OUT OF STOCK',
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.w600,
                      fontSize: 12.sp,
                    ),
                  )
                else
                  QuantityAdjusterWidget(
                    initialQuantity: currentQty,
                    maxQuantity: item.stock,
                    onChanged: onQuantityChanged,
                    isDisabled: isOutOfStock,
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
