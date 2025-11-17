import 'package:akademove/core/_export.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class UserAvatarWidget extends StatelessWidget {
  const UserAvatarWidget({
    required this.name,
    this.image,
    this.size,
    super.key,
  });
  final String name;
  final String? image;
  final double? size;

  @override
  Widget build(BuildContext context) {
    return Avatar(
      backgroundColor: context.colorScheme.primary,
      size: size ?? 24.sp,
      initials: Avatar.getInitials(name),
      provider: image != null
          ? CachedNetworkImageProvider(
              image ?? UrlConstants.placeholderImageUrl,
            )
          : null,
    );
  }
}
