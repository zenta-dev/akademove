import 'package:akademove/app/router/router.dart';
import 'package:akademove/core/_export.dart';
import 'package:akademove/features/features.dart';
import 'package:akademove/gen/assets.gen.dart';
import 'package:akademove/l10n/l10n.dart';
import 'package:api_client/api_client.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class UserMartScreen extends StatefulWidget {
  const UserMartScreen({super.key});

  @override
  State<UserMartScreen> createState() => _UserMartScreenState();
}

class _UserMartScreenState extends State<UserMartScreen> {
  @override
  void initState() {
    super.initState();
    context.read<UserMartCubit>().loadMartHome();
  }

  Future<void> _onRefresh() async {
    await context.read<UserMartCubit>().loadMartHome();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      headers: [
        AppBar(
          padding: EdgeInsets.all(4.dg),
          title: Text(
            'AMart',
            style: context.typography.h4.copyWith(fontSize: 18.sp),
          ),
          leading: [
            IconButton(
              onPressed: () => context.pop(),
              icon: Icon(LucideIcons.chevronLeft, size: 20.sp),
              variance: const ButtonStyle.ghost(),
            ),
          ],
          trailing: [
            BlocProvider.value(
              value: context.read<CartCubit>(),
              child: CartBadge(
                onTap: () => context.pushNamed(Routes.userCart.name),
              ),
            ),
          ],
        ),
      ],
      child: RefreshTrigger(
        onRefresh: _onRefresh,
        child: BlocBuilder<UserMartCubit, UserMartState>(
          builder: (context, state) {
            if (state.bestSellers.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state.bestSellers.isFailure) {
              return Center(
                child: OopsAlertWidget(
                  message:
                      state.bestSellers.message ??
                      context.l10n.toast_failed_load_mart_data,
                  onRefresh: () => context.read<UserMartCubit>().loadMartHome(),
                ),
              );
            }
            return _buildContent(context, state);
          },
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context, UserMartState state) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCategoryNavigator(context, state.categories),
          Gap(16.h),
          if (state.recentOrders.hasData)
            _buildRecentOrders(context, state.recentOrders.value!),
          Gap(16.h),
          if (state.bestSellers.hasData)
            _buildBestSellers(context, state.bestSellers.value!),
          Gap(16.h),
        ],
      ),
    );
  }

  Widget _buildCategoryNavigator(
    BuildContext context,
    List<String> categories,
  ) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.l10n.label_categories,
            style: context.typography.h4.copyWith(fontSize: 16.sp),
          ),
          Gap(12.h),
          SizedBox(
            height: 100.h,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              separatorBuilder: (context, index) => Gap(10.w),
              padding: EdgeInsets.zero,
              itemBuilder: (context, index) {
                final category = categories[index];
                return _CategoryCard(
                  category: category,
                  onTap: () {
                    context.read<UserMartCubit>().loadCategoryMerchants(
                      category: category,
                    );
                    context.pushNamed(Routes.userMartCategory.name);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentOrders(BuildContext context, List<Order> orders) {
    if (orders.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                context.l10n.label_recent_orders,
                style: context.typography.h4.copyWith(fontSize: 16.sp),
              ),
              Button(
                style: const ButtonStyle.outline(density: ButtonDensity.compact)
                    .copyWith(
                      padding: (context, states, value) =>
                          EdgeInsetsGeometry.all(4.dg),
                    ),
                onPressed: () => context.goNamed(Routes.userHistory.name),
                child: Row(
                  children: [
                    Text(
                      context.l10n.button_view_all,
                      style: context.typography.small.copyWith(
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Icon(LucideIcons.chevronRight, size: 10.sp),
                  ],
                ),
              ),
            ],
          ),
          Gap(12.h),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: orders.take(2).length,
            separatorBuilder: (context, index) => Gap(8.h),
            itemBuilder: (context, index) {
              final order = orders[index];
              return _RecentOrderCard(order: order);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildBestSellers(
    BuildContext context,
    List<BestSellerItem> bestSellers,
  ) {
    if (bestSellers.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.l10n.label_best_sellers,
            style: context.typography.h4.copyWith(fontSize: 16.sp),
          ),
          Gap(12.h),
          SizedBox(
            height: 200.h,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: bestSellers.length,
              separatorBuilder: (context, index) => Gap(12.w),
              itemBuilder: (context, index) {
                final item = bestSellers[index];
                return _BestSellerItem(item: item);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _CategoryCard extends StatelessWidget {
  const _CategoryCard({required this.category, required this.onTap});

  final String category;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = _getCategoryColor(category);

    return Button(
      style: const ButtonStyle.ghost(density: ButtonDensity.icon),
      onPressed: onTap,
      child: Container(
        width: 90.w,
        height: 90.h,
        padding: EdgeInsets.all(12.dg),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(_getCategoryIcon(category), size: 32.sp, color: color),
            Gap(4.h),
            Text(
              category,
              textAlign: TextAlign.center,
              style: context.typography.small.copyWith(
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getCategoryColor(String category) {
    switch (category.toLowerCase()) {
      case 'atk':
        return Colors.blue;
      case 'printing':
        return Colors.purple;
      case 'food':
        return Colors.orange;
      default:
        return const Color(0xFF9E9E9E);
    }
  }

  IconData _getCategoryIcon(String category) {
    switch (category.toLowerCase()) {
      case 'atk':
        return LucideIcons.pencil;
      case 'printing':
        return LucideIcons.printer;
      case 'food':
        return LucideIcons.utensils;
      default:
        return LucideIcons.store;
    }
  }
}

class _RecentOrderCard extends StatelessWidget {
  const _RecentOrderCard({required this.order});

  final Order order;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(12.dg),
        child: Row(
          children: [
            Container(
              width: 48.sp,
              height: 48.sp,
              decoration: BoxDecoration(
                color: context.colorScheme.muted,
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Icon(LucideIcons.shoppingBag, size: 24.sp),
            ),
            Gap(12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${context.l10n.order_id}${order.id.substring(0, 8)}',
                    style: context.typography.h4.copyWith(fontSize: 14.sp),
                  ),
                  Gap(4.h),
                  Text(
                    order.status.name,
                    style: context.typography.small.copyWith(
                      fontSize: 12.sp,
                      color: context.colorScheme.mutedForeground,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              'Rp ${order.totalPrice}',
              style: context.typography.h4.copyWith(fontSize: 14.sp),
            ),
          ],
        ),
      ),
    );
  }
}

class _BestSellerItem extends StatelessWidget {
  const _BestSellerItem({required this.item});

  final BestSellerItem item;

  @override
  Widget build(BuildContext context) {
    return Button(
      style: const ButtonStyle.ghost(density: ButtonDensity.compact),
      onPressed: () {
        context.pushNamed(
          Routes.userMenuDetail.name,
          pathParameters: {'menuId': item.menu.id},
          extra: {'menu': item.menu, 'merchantName': item.merchantName},
        );
      },
      child: SizedBox(
        width: 150.w,
        child: Card(
          padding: EdgeInsets.zero,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (item.menu.image case final image?) ...[
                ClipRRect(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(12.r),
                  ),
                  child: CachedNetworkImage(
                    imageUrl: image,
                    width: 150.w,
                    height: 100.h,
                    fit: BoxFit.cover,
                    errorWidget: (context, url, error) =>
                        Assets.images.noImage.svg(width: 150.w, height: 100.h),
                  ),
                ),
              ] else ...[
                Assets.images.noImage.svg(width: 150.w, height: 100.h),
              ],
              Padding(
                padding: EdgeInsets.all(8.dg),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.menu.name,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: context.typography.h4.copyWith(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Gap(4.h),
                    Text(
                      'Rp ${item.menu.price}',
                      style: context.typography.small.copyWith(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold,
                        color: context.colorScheme.primary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
