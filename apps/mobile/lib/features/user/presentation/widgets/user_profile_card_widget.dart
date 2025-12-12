import 'package:akademove/app/router/router.dart';
import 'package:akademove/core/_export.dart';
import 'package:akademove/features/user/presentation/widgets/_export.dart';
import 'package:api_client/api_client.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class UserProfileCardWidget extends StatelessWidget {
  const UserProfileCardWidget({required this.user, super.key});
  final User user;

  static const randomBadgeImage = '${UrlConstants.randomImageUrl}/seed/28/28';

  @override
  Widget build(BuildContext context) {
    final latest3 =
        (user.userBadges.toList()
              ..sort((a, b) => b.earnedAt.compareTo(a.earnedAt)))
            .take(3)
            .toList();

    return Card(
      padding: EdgeInsets.all(8.dg),
      child: Row(
        spacing: 8.w,
        children: [
          UserAvatarWidget(name: user.name, image: user.image, size: 40.dg),
          Expanded(
            child: Button(
              style: const ButtonStyle.ghost(density: ButtonDensity.compact),
              onPressed: () {
                context.pushNamed(Routes.userDetailProfile.name);
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 4.h,
                children: [
                  Text(
                    user.name,
                  ).normal(fontWeight: FontWeight.w500, fontSize: 18.sp),
                  Row(
                    spacing: 4.w,
                    children: [
                      AvatarGroup.toRight(
                        children: _buildBadgesGroup(context, latest3),
                      ),
                      Text(
                        user.userBadges.isNotEmpty
                            ? latest3.last.badge.name
                            : '',
                      ).muted(fontSize: 16.sp),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Avatar> _buildBadgesGroup(
    BuildContext context,
    List<UserBadge> userBadges,
  ) {
    return userBadges.map((e) {
      final randColor = context.randomColor.withValues(alpha: 0.1);

      return Avatar(
        size: 28,
        initials: Avatar.getInitials(e.badge.name),
        backgroundColor: randColor,
        provider: e.badge.icon != null
            ? CachedNetworkImageProvider(e.badge.icon!)
            : null,
      );
    }).toList();
  }
}
