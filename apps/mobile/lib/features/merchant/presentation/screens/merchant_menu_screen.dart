import 'package:akademove/app/router/router.dart';
import 'package:akademove/core/_export.dart';
import 'package:akademove/features/features.dart';
import 'package:api_client/api_client.dart';
import 'package:flutter/material.dart' as material;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class MerchantMenuScreen extends StatefulWidget {
  const MerchantMenuScreen({super.key});

  @override
  State<MerchantMenuScreen> createState() => _MerchantMenuScreenState();
}

class _MerchantMenuScreenState extends State<MerchantMenuScreen> {
  late final TextEditingController _searchController;
  String _query = '';

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    WidgetsBinding.instance.addPostFrameCallback((_) => _initializeMenu());
  }

  Future<void> _initializeMenu() async {
    if (!mounted) return;

    final merchantCubit = context.read<MerchantCubit>();
    final menuCubit = context.read<MerchantMenuCubit>();

    // Get merchant data if not already loaded
    if (merchantCubit.state.mine == null) {
      await merchantCubit.getMine();
    }

    if (!mounted) return;

    final merchantId = merchantCubit.state.mine?.id;

    if (merchantId != null) {
      await menuCubit.init(merchantId: merchantId);
    } else {
      logger.e('[MerchantMenuScreen] - No merchant ID found');
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return MyScaffold(
      scrollable: false,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Row(
              spacing: 16.w,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    placeholder: const Text('Search menu...'),
                    onChanged: (value) {
                      setState(() => _query = value);
                    },
                  ),
                ),
                IconButton(
                  onPressed: () =>
                      context.pushNamed(Routes.merchantCreateMenu.name),
                  icon: const Icon(LucideIcons.plus, size: 18),
                  variance: ButtonVariance.primary,
                ),
              ],
            ),
          ),
          Expanded(
            child: BlocBuilder<MerchantMenuCubit, MerchantMenuState>(
              builder: (context, state) {
                if (state.isLoading) {
                  return const Center(
                    child: material.CircularProgressIndicator(),
                  );
                }

                if (state.isFailure) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Error: ${state.error?.message ?? "Unknown error"}',
                        ),
                        const SizedBox(height: 16),
                        PrimaryButton(
                          onPressed: _initializeMenu,
                          child: const Text('Retry'),
                        ),
                      ],
                    ),
                  );
                }

                // Filter menus based on search query
                final filteredMenus = _query.isEmpty
                    ? state.list
                    : state.list
                          .where(
                            (menu) => menu.name.toLowerCase().contains(
                              _query.toLowerCase(),
                            ),
                          )
                          .toList();

                if (filteredMenus.isEmpty) {
                  return Center(
                    child: Text(
                      _query.isEmpty
                          ? 'No menu items yet. Tap + to add your first item.'
                          : 'No menu items found for "$_query"',
                    ),
                  );
                }

                return GridView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: filteredMenus.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 12.h,
                    crossAxisSpacing: 12.w,
                    childAspectRatio: (width / 2) / (120.h + 58.h),
                  ),
                  itemBuilder: (context, index) {
                    final menu = filteredMenus[index];
                    return _MenuCard(menu: menu);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _MenuCard extends StatelessWidget {
  const _MenuCard({required this.menu});

  final MerchantMenu menu;

  @override
  Widget build(BuildContext context) {
    return Card(
      padding: EdgeInsets.zero,
      child: Button.ghost(
        onPressed: () {
          context.read<MerchantMenuCubit>().selectMenu(menu);
          context.pushNamed(Routes.merchantMenuDetail.name, extra: menu);
        },
        child: Column(
          spacing: 8.h,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12.r),
              child: menu.image != null
                  ? Image.network(
                      menu.image!,
                      width: double.infinity,
                      height: 95.h,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          width: double.infinity,
                          height: 95.h,
                          color: material.Colors.grey[300],
                          child: const Icon(LucideIcons.image, size: 32),
                        );
                      },
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Container(
                          width: double.infinity,
                          height: 95.h,
                          color: material.Colors.grey[200],
                          child: const Center(
                            child: material.CircularProgressIndicator(),
                          ),
                        );
                      },
                    )
                  : Container(
                      width: double.infinity,
                      height: 95.h,
                      color: material.Colors.grey[300],
                      child: const Icon(LucideIcons.image, size: 32),
                    ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        menu.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: context.typography.small.copyWith(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        'Rp ${menu.price.toStringAsFixed(0)}',
                        style: context.typography.small.copyWith(
                          fontSize: 12.sp,
                          color: material.Colors.grey[600],
                        ),
                      ),
                      Text(
                        'Stock: ${menu.stock}',
                        style: context.typography.small.copyWith(
                          fontSize: 11.sp,
                          color: menu.stock > 0
                              ? material.Colors.green
                              : material.Colors.red,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(LucideIcons.chevronRight, size: 16.sp),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
