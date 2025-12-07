import 'package:akademove/app/router/router.dart';
import 'package:akademove/core/_export.dart';
import 'package:akademove/features/user/presentation/cubits/_export.dart';
import 'package:akademove/features/user/presentation/state/_export.dart';
import 'package:akademove/features/user/presentation/widgets/merchant_card_widget.dart';
import 'package:akademove/features/user/presentation/widgets/merchant_list_search_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Popular Merchants'),
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: BlocBuilder<UserMerchantListCubit, UserMerchantListState>(
        builder: (context, state) {
          // Error state
          if (state.isFailure) {
            return _ErrorView(
              error: state.error?.message ?? 'Failed to load merchants',
              onRetry: () =>
                  context.read<UserMerchantListCubit>().loadMerchants(),
            );
          }

          return RefreshIndicator(
            onRefresh: _onRefresh,
            child: Column(
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
            ),
          );
        },
      ),
    );
  }

  /// Build merchant list view
  Widget _buildMerchantList(BuildContext context, UserMerchantListState state) {
    // Loading state - show initial loading
    if (state.isLoading && state.merchants.isEmpty) {
      return const _LoadingView();
    }

    // Empty state
    if (state.isEmpty) {
      return _EmptyView(
        onRetry: () => context.read<UserMerchantListCubit>().loadMerchants(),
      );
    }

    // Success state - show merchants list
    return ListView.builder(
      controller: _scrollController,
      padding: EdgeInsets.only(bottom: 16.h),
      itemCount:
          state.merchants.length +
          (state.isLoading && state.merchants.isNotEmpty ? 1 : 0),
      itemBuilder: (context, index) {
        // Loading indicator at the end
        if (index == state.merchants.length) {
          return const _PaginationLoadingView();
        }

        final merchant = state.merchants[index];
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
            'Loading merchants...',
            style: Theme.of(context).textTheme.bodyMedium,
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
          Icon(Icons.store_rounded, size: 64.sp, color: Colors.grey[400]),
          SizedBox(height: 16.h),
          Text(
            'No merchants found',
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(color: Colors.grey[600]),
          ),
          SizedBox(height: 8.h),
          Text(
            'Try adjusting your search',
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(color: Colors.grey[500]),
          ),
          SizedBox(height: 24.h),
          ElevatedButton.icon(
            onPressed: onRetry,
            icon: const Icon(Icons.refresh),
            label: const Text('Try Again'),
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
          Icon(Icons.error_outline, size: 64.sp, color: Colors.red[400]),
          SizedBox(height: 16.h),
          Text(
            'Something went wrong',
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(color: Colors.red[600]),
          ),
          SizedBox(height: 8.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 32.w),
            child: Text(
              error,
              textAlign: TextAlign.center,
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(color: Colors.grey[600]),
            ),
          ),
          SizedBox(height: 24.h),
          ElevatedButton.icon(
            onPressed: onRetry,
            icon: const Icon(Icons.refresh),
            label: const Text('Retry'),
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
