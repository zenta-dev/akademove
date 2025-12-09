import 'package:api_client/api_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: const Color(0xFFE5E7EB), width: 1),
        ),
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
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
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

            // Middle row: Rating and distance
            Row(
              children: [
                // Rating
                _RatingWidget(rating: (merchant.rating).toDouble()),
                SizedBox(width: 12.w),
              ],
            ),
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
        Icon(Icons.star_rounded, color: Colors.amber[600], size: 16.sp),
        SizedBox(width: 4.w),
        Text(
          rating.toStringAsFixed(1),
          style: Theme.of(
            context,
          ).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w600),
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
    final backgroundColor = isActive ? Colors.green[100] : Colors.red[100];
    final textColor = isActive ? Colors.green[700] : Colors.red[700];
    final dotColor = isActive ? Colors.green[600] : Colors.red[600];
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
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(6.r),
      ),
      child: Text(
        category,
        style: Theme.of(
          context,
        ).textTheme.labelSmall?.copyWith(color: Colors.grey[700]),
      ),
    );
  }
}
