import 'package:akademove/core/_export.dart';
import 'package:api_client/api_client.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

/// Header widget displaying merchant profile information
/// Shows: cover photo, name, and rating
class MerchantDetailHeaderWidget extends StatelessWidget {
  final Merchant merchant;

  const MerchantDetailHeaderWidget({required this.merchant, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Cover photo
        CachedNetworkImage(
          imageUrl: merchant.image ?? '',
          width: double.infinity,
          height: 200.h,
          fit: BoxFit.cover,
          placeholder: (context, url) => Container(
            color: Colors.gray[300],
            child: const Center(child: CircularProgressIndicator()),
          ),
          errorWidget: (context, url, error) => Container(
            color: Colors.gray[300],
            child: const Center(child: Icon(Icons.image_not_supported)),
          ),
        ),

        Padding(
          padding: EdgeInsets.all(16.dg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 8.h,
            children: [
              // Merchant name
              Text(
                merchant.name,
                style: context.typography.h3.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),

              // Rating display: "⭐ 4.5"
              Row(
                children: [
                  Icon(Icons.star_rounded, color: Colors.amber, size: 18.sp),
                  SizedBox(width: 6.w),
                  Text(
                    '${merchant.rating}',
                    style: context.typography.h4.copyWith(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
