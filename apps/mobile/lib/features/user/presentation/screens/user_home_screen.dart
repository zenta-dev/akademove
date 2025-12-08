import 'package:akademove/app/router/router.dart';
import 'package:akademove/core/_export.dart';
import 'package:akademove/features/features.dart';
import 'package:akademove/gen/assets.gen.dart';

import 'package:akademove/l10n/l10n.dart';
import 'package:akademove/locator.dart';
import 'package:api_client/api_client.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart' hide Banner, TabItem;

class _Route extends BottomNavBarItem {
  const _Route({
    required super.label,
    required super.icon,
    required this.route,
    required this.color,
  });

  final Routes route;
  final Color color;
}

class UserHomeScreen extends StatefulWidget {
  const UserHomeScreen({super.key});

  @override
  State<UserHomeScreen> createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends State<UserHomeScreen> {
  late final TextEditingController _searchController;
  late final CarouselController _bannerController;
  late final NotificationCubit _notificationCubit;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _bannerController = CarouselController();
    _notificationCubit = sl<NotificationCubit>();
    _notificationCubit.getUnreadCount();
    Future.wait([
      context.read<UserHomeCubit>().getPopulars(),
      context.read<ConfigurationCubit>().getConfigurations(),
      context.read<UserLocationCubit>().getMyLocation(context),
      context.read<UserWalletCubit>().getMine(),
    ]);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _bannerController.dispose();
    _notificationCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      headers: [
        AppBar(
          title: TextField(controller: _searchController),
          trailing: [
            BlocBuilder<NotificationCubit, NotificationState>(
              bloc: _notificationCubit,
              builder: (context, state) {
                return IconButton(
                  variance: ButtonVariance.ghost,
                  onPressed: () async {
                    await context.pushNamed(Routes.userNotifications.name);
                    // Refresh unread count when returning from notifications
                    _notificationCubit.getUnreadCount();
                  },
                  icon: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      const Icon(LucideIcons.bell),
                      if (state.unreadCount > 0)
                        Positioned(
                          right: -4,
                          top: -4,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 4.w,
                              vertical: 2.h,
                            ),
                            decoration: BoxDecoration(
                              color: context.colorScheme.destructive,
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                            constraints: BoxConstraints(
                              minWidth: 16.w,
                              minHeight: 16.h,
                            ),
                            child: Text(
                              state.unreadCount > 99
                                  ? '99+'
                                  : state.unreadCount.toString(),
                              style: TextStyle(
                                fontSize: 10.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                    ],
                  ),
                );
              },
            ),
            BlocBuilder<AuthCubit, AuthState>(
              builder: (context, state) {
                return IconButton(
                  icon: UserAvatarWidget(
                    name: state.user.data?.value.name ?? AppConstants.name,
                    image: state.user.data?.value.image,
                  ),
                  variance: ButtonVariance.ghost,
                  onPressed: () {
                    context.read<BottomNavBarCubit>().setIndex(2);
                    context.goNamed(Routes.userProfile.name);
                  },
                ).asSkeleton(enabled: state.user.isLoading);
              },
            ),
          ],
        ),
      ],
      padding: EdgeInsets.zero,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [_buildBanners(), _buildBody(context)],
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.all(16.dg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 12.h,
        children: [
          Text(
            context.l10n.choose_the_service_that_you_want,
            style: context.typography.h4.copyWith(fontSize: 16.sp),
          ),
          _buildNavigation(context),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                context.l10n.popular_merchants,
                style: context.typography.h4.copyWith(fontSize: 16.sp),
              ),
              Button(
                style: const ButtonStyle.outline(density: ButtonDensity.compact)
                    .copyWith(
                      padding: (context, states, value) =>
                          EdgeInsetsGeometry.all(4.dg),
                    ),
                onPressed: () {
                  print('🔵 View All clicked!');
                  print('🔵 Route name: ${Routes.userListMerchant.name}');
                  print('🔵 Route path: ${Routes.userListMerchant.path}');

                  context.pushNamed(Routes.userListMerchant.name);

                  print('🔵 Navigation called');
                },
                child: Row(
                  children: [
                    Text(
                      context.l10n.view_all,
                      style: context.typography.small.copyWith(fontSize: 12.sp),
                    ),
                    Icon(LucideIcons.chevronRight, size: 10.sp),
                  ],
                ),
              ),
            ],
          ),
          _buildPopularMerchants(),
        ],
      ),
    );
  }

  Widget _buildPopularMerchants() {
    return SizedBox(
      height: 166.h,
      width: double.infinity,
      child: BlocBuilder<UserHomeCubit, UserHomeState>(
        builder: (context, state) {
          return state.whenOr(
            success: (_) => ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: state.popularMerchants.length,
              separatorBuilder: (context, index) => Gap(16.w),
              itemBuilder: (context, index) => Button(
                style: const ButtonStyle.ghost(density: ButtonDensity.compact),
                onPressed: () {
                  context.pushNamed(
                    Routes.userMerchantDetail.name,
                    pathParameters: {
                      'merchantId': state.popularMerchants[index].id,
                    },
                    extra: {'merchant': state.popularMerchants[index]},
                  );
                },
                child: LimitedBox(
                  maxWidth: 111.w,
                  child: _MerchantCardWidget(
                    merchant: state.popularMerchants[index],
                  ),
                ),
              ),
            ),
            failure: (error) => Container(
              width: double.infinity,
              padding: EdgeInsets.only(top: 16.dg),
              child: OopsAlertWidget(
                message: error.message ?? context.l10n.an_error_occurred,
                onRefresh: () => context.read<UserHomeCubit>().getPopulars(),
              ),
            ),
            orElse: () => ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: 5,
              separatorBuilder: (context, index) => Gap(16.w),
              itemBuilder: (_, _) => LimitedBox(
                maxWidth: 111.w,
                child: const _MerchantCardWidget(merchant: dummyMerchant),
              ).asSkeleton(),
            ),
          );
        },
      ),
    );
  }

  Widget _buildNavigation(BuildContext context) {
    final routes = [
      _Route(
        label: context.l10n.ride,
        icon: LucideIcons.bike,
        route: Routes.userRide,
        color: Colors.blue,
      ),
      _Route(
        label: context.l10n.delivery,
        icon: LucideIcons.package,
        route: Routes.userDelivery,
        color: Colors.green,
      ),
      _Route(
        label: context.l10n.mart,
        icon: LucideIcons.store,
        route: Routes.userMart,
        color: Colors.pink,
      ),
      _Route(
        label: context.l10n.wallet,
        icon: LucideIcons.wallet,
        route: Routes.userWallet,
        color: Colors.red,
      ),
      _Route(
        label: context.l10n.voucher,
        icon: LucideIcons.tag,
        route: Routes.userVoucher,
        color: Colors.yellow,
      ),
    ];

    return Center(
      child: Wrap(
        alignment: WrapAlignment.center,
        spacing: 8.dg,
        runSpacing: 4.dg,
        children: routes
            .map(
              (e) => Button(
                style: const ButtonStyle.ghost(density: ButtonDensity.icon),
                onPressed: () async {
                  await context.pushNamed(e.route.name);
                },
                child: Column(
                  spacing: 4.h,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.all(14.dg),
                      decoration: BoxDecoration(
                        color: e.color.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Icon(e.icon, size: 36.sp, color: e.color),
                    ),
                    Text(
                      e.label,
                      style: context.typography.small.copyWith(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            )
            .toList(),
      ),
    );
  }

  Widget _buildBanners() {
    return Container(
      height: 180.h,
      padding: EdgeInsets.only(top: 8.dg),
      child: BlocBuilder<ConfigurationCubit, ConfigurationState>(
        builder: (context, state) {
          final find = state.configurations.data?.value.firstWhere(
            (v) => v.key == 'user-home-banner',
          );
          final banners = (find?.value ?? []) as List<BannerConfiguration>;

          return Carousel(
            transition: CarouselTransition.sliding(gap: 16.w),
            controller: _bannerController,
            autoplaySpeed: const Duration(seconds: 10),
            itemCount: banners.length,
            itemBuilder: (context, index) {
              final banner = banners[index];
              return SizedBox(
                width: context.mediaQuerySize.width,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16.r),
                  child: CachedNetworkImage(
                    imageUrl: banner.imageUrl,
                    fit: BoxFit.cover,
                    width: context.mediaQuerySize.width,
                    height: context.mediaQuerySize.height,
                  ),
                ),
              );
            },
            speed: const Duration(seconds: 10),
            duration: const Duration(seconds: 10),
          );
        },
      ),
    );
  }
}

class _MerchantCardWidget extends StatelessWidget {
  const _MerchantCardWidget({required this.merchant});

  final Merchant merchant;

  @override
  Widget build(BuildContext context) {
    final radius14 = Radius.circular(14.dg);
    return Card(
      padding: EdgeInsets.zero,
      borderRadius: BorderRadius.all(radius14),
      child: Column(
        children: [
          if (merchant.image != null) ...[
            CachedNetworkImage(
              imageUrl: merchant.image ?? UrlConstants.placeholderImageUrl,
              width: 135.w,
              height: 100.h,
              imageBuilder: (context, imageProvider) {
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: radius14,
                      topRight: radius14,
                    ),
                    color: context.colorScheme.mutedForeground,
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
              errorWidget: (context, url, error) =>
                  Assets.images.noImage.svg(width: 135.w, height: 100.h),
            ),
          ] else ...[
            Assets.images.noImage.svg(width: 135.w, height: 100.h),
          ],
          Padding(
            padding: EdgeInsetsGeometry.all(8.dg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 2.h,
              children: [
                Text(
                  merchant.name,
                  overflow: TextOverflow.ellipsis,
                  style: context.typography.h4.copyWith(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  merchant.categories.join(', '),
                  overflow: TextOverflow.ellipsis,
                  style: context.typography.textMuted.copyWith(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.normal,
                    color: context.colorScheme.mutedForeground,
                  ),
                ),
                Gap(2.h),
                StarRating(
                  starSize: 12.sp,
                  value: merchant.rating.toDouble(),
                  activeColor: Colors.amber,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
