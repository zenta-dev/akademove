import 'package:akademove/core/_export.dart';
import 'package:akademove/features/features.dart';
import 'package:akademove/gen/assets.gen.dart';
import 'package:akademove/l10n/l10n.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class UserDetailProfileScreen extends StatelessWidget {
  const UserDetailProfileScreen({super.key});

  static const randomBadgeImage = '${UrlConstants.randomImageUrl}/seed/42/42';

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      scrollable: false,
      padding: EdgeInsets.zero,
      body: Column(
        spacing: 16.h,
        children: [_buildHeader(context), const SizedBox(), _buildDetail()],
      ),
    );
  }

  Widget _buildDetail() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.dg),
      child: Builder(
        builder: (context) {
          return Column(
            spacing: 16.h,
            children: [
              BlocBuilder<AuthCubit, AuthState>(
                builder: (context, state) {
                  final user = state.data ?? dummyUser;
                  return DefaultText(
                    user.name,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w600,
                  ).asSkeleton(enabled: state.isLoading);
                },
              ),
              SizedBox(
                width: double.infinity,
                child: Card(
                  child: BlocBuilder<AuthCubit, AuthState>(
                    builder: (context, state) {
                      final user = state.data ?? dummyUser;
                      return Column(
                        spacing: 12.h,
                        children: [
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
                      ).asSkeleton(enabled: state.isLoading);
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
                child: Card(
                  child: BlocBuilder<AuthCubit, AuthState>(
                    builder: (context, state) {
                      final user = state.data ?? dummyUser;
                      return Column(
                        spacing: 12.h,
                        children: [
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
                      ).asSkeleton(enabled: state.isLoading);
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
                    final user = state.data ?? dummyUser;
                    return ListView.builder(
                      itemCount: user.userBadges.length,
                      padding: EdgeInsets.zero,
                      itemBuilder: (context, index) {
                        final userBadge = user.userBadges[index];
                        final badge = userBadge.badge;
                        return Basic(
                          leading: CachedNetworkImage(
                            imageUrl: badge.icon ?? randomBadgeImage,
                            width: 42,
                            height: 42,
                            placeholder: (context, url) => Container(
                              color: context.colorScheme.mutedForeground,
                            ),
                            errorWidget: (context, url, error) => const Center(
                              child: Icon(LucideIcons.info, color: Colors.red),
                            ),
                          ),
                          title: DefaultText(badge.name),
                          subtitle: DefaultText(
                            '${context.l10n.text_earned_at} ${userBadge.earnedAt.format('dd MMMM yyyy')}',
                            fontSize: 12.sp,
                            color: context.colorScheme.mutedForeground,
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          );
        },
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
            onPressed: () {
              // context.pop();
            },
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
              final user = state.data ?? dummyUser;
              return UserAvatarWidget(
                name: user.name,
                image: user.image,
                size: 86.dg,
              ).asSkeleton(enabled: state.isLoading);
            },
          ),
        ),
      ],
    );
  }
}
