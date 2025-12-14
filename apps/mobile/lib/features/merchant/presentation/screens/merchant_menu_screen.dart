import 'package:akademove/app/router/router.dart';
import 'package:akademove/core/_export.dart';
import 'package:akademove/features/features.dart';
import 'package:akademove/l10n/l10n.dart';
import 'package:api_client/api_client.dart';
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
    if (merchantCubit.state.mine.value == null) {
      await merchantCubit.getMine();
    }

    if (!mounted) return;

    final merchantId = merchantCubit.state.mine.value?.id;

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

    return Scaffold(
      headers: [
        AppBar(
          title: Row(
            spacing: 16.w,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: TextField(
                  controller: _searchController,
                  placeholder: Text(context.l10n.placeholder_search_menu_hint),
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
      ],
      child: Padding(
        padding: EdgeInsets.all(16.dg),
        child: Column(
          children: [
            Expanded(
              child: SafeRefreshTrigger(
                onRefresh: _initializeMenu,
                child: BlocBuilder<MerchantMenuCubit, MerchantMenuState>(
                  builder: (context, state) {
                    if (state.menus.isLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (state.menus.isFailure) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '${context.l10n.error}: ${state.menus.error?.message ?? context.l10n.an_error_occurred}',
                            ),
                            const SizedBox(height: 16),
                            PrimaryButton(
                              onPressed: _initializeMenu,
                              child: Text(context.l10n.retry),
                            ),
                          ],
                        ),
                      );
                    }

                    // Filter menus based on search query
                    final filteredMenus = _query.isEmpty
                        ? state.menus.data?.value ?? []
                        : (state.menus.data?.value ?? [])
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
                              ? context.l10n.no_menu_items_yet
                              : context.l10n.no_menu_items_found(_query),
                        ),
                      );
                    }

                    return GridView.builder(
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemCount: filteredMenus.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 12.h,
                        crossAxisSpacing: 12.w,
                        childAspectRatio: (width / 2) / (120.h + 58.h),
                      ),
                      padding: EdgeInsets.zero,
                      itemBuilder: (context, index) {
                        final menu = filteredMenus[index];
                        return _MenuCard(menu: menu);
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
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
                      height: 80.h,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          width: double.infinity,
                          height: 80.h,
                          color: const Color(0xFFE0E0E0),
                          child: const Icon(LucideIcons.image, size: 32),
                        );
                      },
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Container(
                          width: double.infinity,
                          height: 80.h,
                          color: const Color(0xFFEEEEEE),
                          child: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      },
                    )
                  : Container(
                      width: double.infinity,
                      height: 80.h,
                      color: const Color(0xFFE0E0E0),
                      child: const Icon(LucideIcons.image, size: 32),
                    ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
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
                          color: context.colorScheme.mutedForeground,
                        ),
                      ),
                      Text(
                        '${context.l10n.label_stock}: ${menu.stock}',
                        style: context.typography.small.copyWith(
                          fontSize: 11.sp,
                          color: menu.stock > 0
                              ? const Color(0xFF4CAF50)
                              : const Color(0xFFF44336),
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
