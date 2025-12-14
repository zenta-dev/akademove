import 'package:akademove/core/_export.dart';
import 'package:akademove/features/features.dart';
import 'package:akademove/gen/assets.gen.dart';
import 'package:akademove/l10n/l10n.dart';
import 'package:api_client/api_client.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class UserDetailProfileScreen extends StatelessWidget {
  const UserDetailProfileScreen({super.key});

  static const randomBadgeImage = '${UrlConstants.randomImageUrl}/seed/42/42';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      child: Column(
        spacing: 16.h,
        children: [_buildHeader(context), const SizedBox(), _buildDetail()],
      ),
    );
  }

  Widget _buildDetail() {
    return Builder(
      builder: (context) {
        return SafeRefreshTrigger(
          onRefresh: () async {
            await context.read<AuthCubit>().authenticate();
          },
          child: SingleChildScrollView(
            padding: EdgeInsets.all(16.dg),
            child: Column(
              spacing: 16.h,
              children: [
                BlocBuilder<AuthCubit, AuthState>(
                  builder: (context, state) {
                    final user = state.user.data?.value ?? dummyUser;
                    return DefaultText(
                      user.name,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600,
                    ).asSkeleton(enabled: state.user.isLoading);
                  },
                ),
                SizedBox(
                  width: double.infinity,
                  child: Card(
                    child: BlocBuilder<AuthCubit, AuthState>(
                      builder: (context, state) {
                        final user = state.user.data?.value ?? dummyUser;
                        return Column(
                          spacing: 12.h,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                DefaultText(
                                  context.l10n.label_user_id,
                                  fontSize: 14.sp,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Clipboard.setData(
                                      ClipboardData(text: user.id),
                                    );
                                    context.showMyToast(
                                      context.l10n.copied_to_clipboard,
                                      type: ToastType.success,
                                    );
                                  },
                                  child: Row(
                                    spacing: 4.w,
                                    children: [
                                      DefaultText(
                                        user.id.length > 8
                                            ? '${user.id.substring(0, 8)}...'
                                            : user.id,
                                        fontSize: 14.sp,
                                      ),
                                      Icon(
                                        LucideIcons.copy,
                                        size: 14.sp,
                                        color:
                                            context.colorScheme.mutedForeground,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const Divider(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                DefaultText(
                                  context.l10n.label_email,
                                  fontSize: 14.sp,
                                ),
                                DefaultText(user.email, fontSize: 14.sp),
                              ],
                            ),
                            const Divider(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                DefaultText(
                                  context.l10n.label_phone,
                                  fontSize: 14.sp,
                                ),
                                DefaultText(
                                  user.phone.toPhoneNumber().toString(),
                                  fontSize: 14.sp,
                                ),
                              ],
                            ),
                          ],
                        ).asSkeleton(enabled: state.user.isLoading);
                      },
                    ),
                  ),
                ),
                DefaultText(
                  context.l10n.label_achievements,
                  fontWeight: FontWeight.w500,
                ),
                SizedBox(
                  width: double.infinity,
                  height: 0.3.sh,
                  child: BlocBuilder<AuthCubit, AuthState>(
                    builder: (context, state) {
                      final user = state.user.data?.value ?? dummyUser;
                      return ListView.builder(
                        itemCount: user.userBadges.length,
                        padding: EdgeInsets.zero,
                        itemBuilder: (context, index) {
                          final userBadge = user.userBadges[index];
                          final badge = userBadge.badge;
                          return Button(
                            style: const ButtonStyle.ghost(
                              density: ButtonDensity.compact,
                            ),
                            onPressed: () =>
                                _showBadgeDialog(context, userBadge),
                            child: Basic(
                              leading: CachedNetworkImage(
                                imageUrl: badge.icon ?? randomBadgeImage,
                                width: 42,
                                height: 42,
                                placeholder: (context, url) => Container(
                                  color: context.colorScheme.mutedForeground,
                                ),
                                errorWidget: (context, url, error) =>
                                    const Center(
                                      child: Icon(
                                        LucideIcons.info,
                                        color: Colors.red,
                                      ),
                                    ),
                              ),
                              title: DefaultText(badge.name),
                              subtitle: DefaultText(
                                '${context.l10n.text_earned_at} ${userBadge.earnedAt.format('dd MMMM yyyy')}',
                                fontSize: 12.sp,
                                color: context.colorScheme.mutedForeground,
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showBadgeDialog(BuildContext context, UserBadge userBadge) {
    final badge = userBadge.badge;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: DefaultText(
                badge.name,
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            IconButton.ghost(
              icon: const Icon(LucideIcons.x),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 16.h,
          children: [
            // Badge icon
            Center(
              child: CachedNetworkImage(
                imageUrl: badge.icon ?? randomBadgeImage,
                width: 80.w,
                height: 80.h,
                placeholder: (context, url) => Container(
                  width: 80.w,
                  height: 80.h,
                  color: context.colorScheme.mutedForeground,
                ),
                errorWidget: (context, url, error) => Container(
                  width: 80.w,
                  height: 80.h,
                  color: context.colorScheme.mutedForeground,
                  child: const Icon(LucideIcons.award, color: Colors.red),
                ),
              ),
            ),

            // Earned date
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
              decoration: BoxDecoration(
                color: context.colorScheme.secondary.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: DefaultText(
                '${context.l10n.text_earned_at} ${userBadge.earnedAt.format('dd MMMM yyyy')}',
                fontSize: 12.sp,
                color: context.colorScheme.mutedForeground,
              ),
            ),

            // Description
            DefaultText(
              badge.description,
              fontSize: 14.sp,
              fontWeight: FontWeight.normal,
              color: context.colorScheme.foreground,
            ),
          ],
        ),
      ),
    );
  }

  Stack _buildHeader(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        (context.isDarkMode
                ? Assets.images.bg.staticGradientDark
                : Assets.images.bg.staticGradientLight)
            .image(width: double.infinity, height: 180.h, fit: BoxFit.cover),
        Positioned(
          top: 0.08.sw,
          left: 0.01.sw,
          child: GhostButton(
            density: ButtonDensity.icon,
            onPressed: () => context.pop(),
            child: Icon(
              LucideIcons.chevronLeft,
              color: Colors.black,
              size: 20.sp,
            ),
          ),
        ),
        Positioned(
          bottom: -50,
          left: 0.35.sw,
          child: BlocBuilder<AuthCubit, AuthState>(
            builder: (context, state) {
              final user = state.user.data?.value ?? dummyUser;
              return UserAvatarWidget(
                name: user.name,
                image: user.image,
                size: 86.dg,
              ).asSkeleton(enabled: state.user.isLoading);
            },
          ),
        ),
      ],
    );
  }
}
