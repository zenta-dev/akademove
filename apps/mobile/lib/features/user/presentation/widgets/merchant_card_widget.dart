import 'package:akademove/core/_export.dart';
import 'package:api_client/api_client.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

/// Merchant card widget for displaying merchant information in a list
/// Shows: merchant name, rating, distance, categories, and availability status
class MerchantCardWidget extends StatelessWidget {
  const MerchantCardWidget({
    super.key,
    required this.merchant,
    required this.onTap,
  });

  final Merchant merchant;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final image = merchant.image;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: context.colorScheme.background,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: context.colorScheme.border, width: 1),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Merchant image
            ClipRRect(
              borderRadius: BorderRadius.circular(8.r),
              child: SizedBox(
                width: 80.w,
                height: 80.w,
                child: image != null && image.isNotEmpty
                    ? CachedNetworkImage(
                        imageUrl: image,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Container(
                          color: context.colorScheme.muted,
                          child: Center(
                            child: Icon(
                              LucideIcons.store,
                              size: 24.sp,
                              color: context.colorScheme.mutedForeground,
                            ),
                          ),
                        ),
                        errorWidget: (context, url, error) => Container(
                          color: context.colorScheme.muted,
                          child: Center(
                            child: Icon(
                              LucideIcons.store,
                              size: 24.sp,
                              color: context.colorScheme.mutedForeground,
                            ),
                          ),
                        ),
                      )
                    : Container(
                        color: context.colorScheme.muted,
                        child: Center(
                          child: Icon(
                            LucideIcons.store,
                            size: 24.sp,
                            color: context.colorScheme.mutedForeground,
                          ),
                        ),
                      ),
              ),
            ),
            SizedBox(width: 12.w),
            // Merchant info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Top row: Merchant name and availability badge
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          merchant.name,
                          style: context.typography.h4.copyWith(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(width: 8.w),
                      _AvailabilityBadge(isActive: merchant.isActive),
                    ],
                  ),
                  SizedBox(height: 8.h),

                  // Middle row: Rating
                  _RatingWidget(rating: (merchant.rating).toDouble()),
                  SizedBox(height: 8.h),

                  // Categories chips
                  if ((merchant.categories).isNotEmpty)
                    Wrap(
                      spacing: 6.w,
                      runSpacing: 4.h,
                      children: merchant.categories.take(3).map((category) {
                        return _CategoryChip(category: category);
                      }).toList(),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Rating display widget with star rating
class _RatingWidget extends StatelessWidget {
  const _RatingWidget({required this.rating});

  final double rating;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(LucideIcons.star, color: Colors.amber.shade600, size: 16.sp),
        SizedBox(width: 4.w),
        Text(
          rating.toStringAsFixed(1),
          style: context.typography.small.copyWith(fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}

/// Availability badge showing Open/Closed status
class _AvailabilityBadge extends StatelessWidget {
  const _AvailabilityBadge({required this.isActive});

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    final backgroundColor = isActive
        ? Colors.green.shade100
        : Colors.red.shade100;
    final textColor = isActive ? Colors.green.shade700 : Colors.red.shade700;
    final dotColor = isActive ? Colors.green.shade600 : Colors.red.shade600;
    final label = isActive ? 'Open' : 'Closed';

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(6.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6.w,
            height: 6.h,
            decoration: BoxDecoration(color: dotColor, shape: BoxShape.circle),
          ),
          SizedBox(width: 4.w),
          Text(
            label,
            style: TextStyle(
              color: textColor,
              fontSize: 11.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

/// Category chip widget
class _CategoryChip extends StatelessWidget {
  const _CategoryChip({required this.category});

  final String category;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: context.colorScheme.muted,
        borderRadius: BorderRadius.circular(6.r),
      ),
      child: Text(
        category,
        style: context.typography.small.copyWith(
          fontSize: 11.sp,
          color: context.colorScheme.mutedForeground,
        ),
      ),
    );
  }
}
