import 'package:akademove/app/router/router.dart';
import 'package:akademove/core/_export.dart';
import 'package:akademove/features/user/presentation/cubits/_export.dart';
import 'package:akademove/features/user/presentation/state/_export.dart';
import 'package:akademove/features/user/presentation/widgets/merchant_card_widget.dart';
import 'package:akademove/features/user/presentation/widgets/merchant_list_search_bar_widget.dart';
import 'package:akademove/l10n/l10n.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class UserMerchantListScreen extends StatefulWidget {
  const UserMerchantListScreen({super.key});

  @override
  State<UserMerchantListScreen> createState() => _UserMerchantListScreenState();
}

class _UserMerchantListScreenState extends State<UserMerchantListScreen> {
  late ScrollController _scrollController;
  late Debouncer _searchDebounce;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _searchDebounce = Debouncer(milliseconds: 500);
    _scrollController.addListener(_onScroll);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<UserMerchantListCubit>().loadMerchants();
    });
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    _searchDebounce.dispose();
    super.dispose();
  }

  /// Handle scroll to load more merchants (infinite scroll at 80%)
  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent * 0.8) {
      context.read<UserMerchantListCubit>().loadMore();
    }
  }

  /// Handle search with debounce
  void _onSearchChanged(String query) {
    _searchDebounce.run(() {
      context.read<UserMerchantListCubit>().searchMerchants(query);
    });
  }

  /// Handle pull-to-refresh
  Future<void> _onRefresh() async {
    await context.read<UserMerchantListCubit>().refresh();
  }

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      scrollable: false,
      padding: EdgeInsets.zero,
      headers: [DefaultAppBar(title: context.l10n.popular_merchants)],
      onRefresh: _onRefresh,
      body: BlocBuilder<UserMerchantListCubit, UserMerchantListState>(
        builder: (context, state) {
          // Error state
          if (state.merchants.isFailure) {
            return _ErrorView(
              error:
                  state.merchants.message ??
                  context.l10n.error_failed_load_merchants,
              onRetry: () =>
                  context.read<UserMerchantListCubit>().loadMerchants(),
            );
          }

          return Column(
            children: [
              // Search bar
              MerchantListSearchBarWidget(
                onSearch: _onSearchChanged,
                onClear: () =>
                    context.read<UserMerchantListCubit>().clearSearch(),
                initialValue: state.searchQuery,
              ),

              // Merchants list
              Expanded(child: _buildMerchantList(context, state)),
            ],
          );
        },
      ),
    );
  }

  /// Build merchant list view
  Widget _buildMerchantList(BuildContext context, UserMerchantListState state) {
    final merchants = state.merchants.value ?? [];

    // Loading state - show initial loading
    if (state.merchants.isLoading && merchants.isEmpty) {
      return const _LoadingView();
    }

    // Empty state
    if (state.isEmpty && !state.merchants.isLoading) {
      return _EmptyView(
        onRetry: () => context.read<UserMerchantListCubit>().loadMerchants(),
      );
    }

    // Success state - show merchants list
    return ListView.builder(
      controller: _scrollController,
      padding: EdgeInsets.only(bottom: 16.h),
      itemCount:
          merchants.length +
          (state.merchants.isLoading && merchants.isNotEmpty ? 1 : 0),
      itemBuilder: (context, index) {
        // Loading indicator at the end
        if (index == merchants.length) {
          return const _PaginationLoadingView();
        }

        final merchant = merchants[index];
        return MerchantCardWidget(
          merchant: merchant,
          onTap: () {
            context.pushNamed(
              Routes.userMerchantDetail.name,
              pathParameters: {'merchantId': merchant.id},
              extra: {'merchant': merchant},
            );
          },
        );
      },
    );
  }
}

/// Loading view
class _LoadingView extends StatelessWidget {
  const _LoadingView();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(),
          SizedBox(height: 16.h),
          Text(
            context.l10n.loading,
            style: context.typography.p.copyWith(fontSize: 14.sp),
          ),
        ],
      ),
    );
  }
}

/// Empty state view
class _EmptyView extends StatelessWidget {
  const _EmptyView({required this.onRetry});

  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            LucideIcons.store,
            size: 64.sp,
            color: context.colorScheme.mutedForeground,
          ),
          SizedBox(height: 16.h),
          Text(
            context.l10n.text_no_merchants_found,
            style: context.typography.h4.copyWith(
              fontSize: 16.sp,
              color: context.colorScheme.mutedForeground,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            context.l10n.text_try_different_category,
            style: context.typography.small.copyWith(
              fontSize: 12.sp,
              color: context.colorScheme.mutedForeground,
            ),
          ),
          SizedBox(height: 24.h),
          PrimaryButton(
            onPressed: onRetry,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(LucideIcons.refreshCw, size: 16),
                SizedBox(width: 8.w),
                Text(context.l10n.retry),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Error view
class _ErrorView extends StatelessWidget {
  const _ErrorView({required this.error, required this.onRetry});

  final String error;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            LucideIcons.circleAlert,
            size: 64.sp,
            color: context.colorScheme.destructive,
          ),
          SizedBox(height: 16.h),
          Text(
            context.l10n.oops,
            style: context.typography.h4.copyWith(
              fontSize: 16.sp,
              color: context.colorScheme.destructive,
            ),
          ),
          SizedBox(height: 8.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 32.w),
            child: Text(
              error,
              textAlign: TextAlign.center,
              style: context.typography.small.copyWith(
                fontSize: 12.sp,
                color: context.colorScheme.mutedForeground,
              ),
            ),
          ),
          SizedBox(height: 24.h),
          PrimaryButton(
            onPressed: onRetry,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(LucideIcons.refreshCw, size: 16),
                SizedBox(width: 8.w),
                Text(context.l10n.retry),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Pagination loading indicator
class _PaginationLoadingView extends StatelessWidget {
  const _PaginationLoadingView();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.h),
      child: const Center(child: CircularProgressIndicator()),
    );
  }
}
