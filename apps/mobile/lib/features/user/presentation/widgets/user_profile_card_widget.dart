import 'package:akademove/core/_export.dart';
import 'package:akademove/features/user/presentation/widgets/_export.dart';
import 'package:api_client/api_client.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class UserProfileCardWidget extends StatelessWidget {
  const UserProfileCardWidget({required this.user, super.key});
  final User user;

  static const randomBadgeImage = '${UrlConstants.randomImageUrl}/seed/28/28';

  @override
  Widget build(BuildContext context) {
    return Card(
      padding: EdgeInsets.all(8.dg),
      child: Row(
        spacing: 8.w,
        children: [
          UserAvatarWidget(
            name: user.name,
            image: user.image,
            size: 40.dg,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 4.h,
            children: [
              Text(user.name).normal(
                fontWeight: FontWeight.w500,
                fontSize: 18.sp,
              ),
              Row(
                spacing: 4.w,
                children: [
                  CachedNetworkImage(
                    imageUrl: user.badges.isNotEmpty
                        ? (user.badges.first.icon ?? randomBadgeImage)
                        : randomBadgeImage,
                    width: 28,
                    height: 28,
                    placeholder: (context, url) => Container(
                      color: context.colorScheme.mutedForeground,
                    ),
                    errorWidget: (context, url, error) => const Center(
                      child: Icon(
                        LucideIcons.info,
                        color: Colors.red,
                      ),
                    ),
                  ),
                  Text(
                    user.badges.isNotEmpty ? user.badges.first.name : '',
                  ).muted(fontSize: 16.sp),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
