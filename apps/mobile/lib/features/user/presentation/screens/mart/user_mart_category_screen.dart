import 'package:akademove/core/_export.dart';
import 'package:akademove/features/features.dart';
import 'package:akademove/gen/assets.gen.dart';
import 'package:api_client/api_client.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class UserMartCategoryScreen extends StatelessWidget {
  const UserMartCategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserMartCubit, UserMartState>(
      builder: (context, state) {
        final category = state.selectedCategory ?? 'All';

        return MyScaffold(
          headers: [
            AppBar(
              padding: EdgeInsets.all(4.dg),
              title: Text(
                category,
                style: context.typography.h4.copyWith(fontSize: 18.sp),
              ),
              leading: [
                IconButton(
                  onPressed: () => context.pop(),
                  icon: Icon(LucideIcons.chevronLeft, size: 20.sp),
                  variance: const ButtonStyle.ghost(),
                ),
              ],
            ),
          ],
          body: state.whenOr(
            success: (_) =>
                _buildMerchantList(context, state.categoryMerchants),
            failure: (error) => Center(
              child: OopsAlertWidget(
                message: error.message ?? 'Failed to load merchants',
                onRefresh: () {
                  if (state.selectedCategory != null) {
                    context.read<UserMartCubit>().loadCategoryMerchants(
                      category: state.selectedCategory!,
                    );
                  }
                },
              ),
            ),
            orElse: () => const Center(child: CircularProgressIndicator()),
          ),
        );
      },
    );
  }

  Widget _buildMerchantList(BuildContext context, List<Merchant> merchants) {
    if (merchants.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              LucideIcons.store,
              size: 64.sp,
              color: context.colorScheme.mutedForeground,
            ),
            Gap(16.h),
            Text(
              'No merchants found',
              style: context.typography.h4.copyWith(fontSize: 16.sp),
            ),
            Gap(8.h),
            Text(
              'Try selecting a different category',
              style: context.typography.small.copyWith(
                fontSize: 14.sp,
                color: context.colorScheme.mutedForeground,
              ),
            ),
          ],
        ),
      );
    }

    return Padding(
      padding: EdgeInsets.all(16.w),
      child: ListView.separated(
        itemCount: merchants.length,
        separatorBuilder: (context, index) => Gap(12.h),
        itemBuilder: (context, index) {
          final merchant = merchants[index];
          return _MerchantCard(merchant: merchant);
        },
      ),
    );
  }
}

class _MerchantCard extends StatelessWidget {
  const _MerchantCard({required this.merchant});

  final Merchant merchant;

  @override
  Widget build(BuildContext context) {
    return Button(
      style: const ButtonStyle.ghost(density: ButtonDensity.compact),
      onPressed: () {
        // Navigate to merchant detail screen (to be implemented)
      },
      child: Card(
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12.r),
              child: SizedBox(
                width: 100.w,
                height: 100.h,
                child: merchant.image != null
                    ? CachedNetworkImage(
                        imageUrl: merchant.image!,
                        fit: BoxFit.cover,
                        errorWidget: (context, url, error) =>
                            Assets.images.noImage.svg(),
                      )
                    : Assets.images.noImage.svg(),
              ),
            ),
            Gap(12.w),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 8.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      merchant.name,
                      style: context.typography.h4.copyWith(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Gap(4.h),
                    Text(
                      merchant.categories.join(', '),
                      style: context.typography.small.copyWith(
                        fontSize: 12.sp,
                        color: context.colorScheme.mutedForeground,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Gap(8.h),
                    Row(
                      children: [
                        Icon(
                          LucideIcons.star,
                          size: 14.sp,
                          color: Colors.amber,
                        ),
                        Gap(4.w),
                        Text(
                          merchant.rating.toString(),
                          style: context.typography.small.copyWith(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Gap(12.w),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8.w,
                            vertical: 4.h,
                          ),
                          decoration: BoxDecoration(
                            color: merchant.isActive
                                ? Colors.green.withValues(alpha: 0.1)
                                : Colors.red.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(4.r),
                          ),
                          child: Text(
                            merchant.isActive ? 'Open' : 'Closed',
                            style: context.typography.small.copyWith(
                              fontSize: 10.sp,
                              color: merchant.isActive
                                  ? Colors.green
                                  : Colors.red,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
