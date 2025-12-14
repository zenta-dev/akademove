import 'package:akademove/core/_export.dart';
import 'package:akademove/features/merchant/data/repositories/_export.dart';
import 'package:akademove/features/user/presentation/state/_export.dart';

class UserMerchantListCubit extends BaseCubit<UserMerchantListState> {
  UserMerchantListCubit({required MerchantRepository merchantRepository})
    : _merchantRepository = merchantRepository,
      super(const UserMerchantListState());

  final MerchantRepository _merchantRepository;

  // Track cursor and hasMore internally since they are not part of OperationResult
  String? _cursor;
  bool _hasMore = true;

  /// Load initial popular merchants (no nearby logic)
  /// This is called when opening the merchant list screen
  /// Always shows popular merchants sorted by popularity/rating
  Future<void> loadMerchants() async => await taskManager.execute(
    'UMLC-lM-popular',
    () async {
      try {
        emit(state.copyWith(merchants: const OperationResult.loading()));
        _cursor = null;
        _hasMore = true;

        // If searching, use listWithFilters; otherwise use getPopulars
        final res = state.searchQuery.isEmpty
            ? await _merchantRepository.getPopulars()
            : await _merchantRepository.listWithFilters(
                query: state.searchQuery,
                isActive: true, // Only show active merchants
                operatingStatus:
                    'OPEN', // Only show open merchants (matches server populars)
                sortBy: 'popularity', // Always sort by popularity
                limit: 20,
                cursor: null,
              );

        _cursor = res.data.isNotEmpty
            ? res.data.last.updatedAt.toIso8601String()
            : null;
        _hasMore = res.data.length >= 20;

        emit(
          state.copyWith(
            merchants: OperationResult.success(res.data, message: res.message),
          ),
        );
      } on BaseError catch (e, st) {
        logger.e(
          '[UserMerchantListCubit] - loadMerchants Error: ${e.message}',
          error: e,
          stackTrace: st,
        );
        emit(state.copyWith(merchants: OperationResult.failed(e)));
      }
    },
  );

  /// Load next page of merchants (pagination)
  /// Called when user scrolls to 80% of the list
  Future<void> loadMore() async {
    if (!_hasMore || state.merchants.isLoading) return;

    await taskManager.execute('UMLC-lMore-${_cursor ?? "start"}', () async {
      try {
        // Keep showing current data while loading more
        // But we need a way to indicate "loading more" without replacing data with loading spinner
        // Usually we can check isLoading but data is present.
        // However, OperationResult.loading() clears data by default design unless we change it.
        // Let's assume for now we don't emit loading state for infinite scroll to avoid clearing list,
        // or we handle "loading" distinct from "refreshing".
        // But BaseCubit/OperationResult pattern suggests explicit states.
        // If OperationResult.loading() sets data to null, we lose the list.

        // Workaround: Don't emit loading for pagination, or use a separate loading flag if needed.
        // Or OperationResult could support keeping data while loading (optimistic).
        // Checking OperationResult definition:
        // const OperationResult.loading() : status = OperationStatus.loading, data = null, error = null;
        // So it clears data.

        // We will NOT emit loading here to prevent list from disappearing.
        // The UI can show a footer spinner based on some other flag if needed, or we just append.

        final res = await _merchantRepository.listWithFilters(
          query: state.searchQuery.isEmpty ? null : state.searchQuery,
          isActive: true,
          operatingStatus:
              'OPEN', // Only show open merchants (matches server populars)
          sortBy: 'popularity', // Always sort by popularity
          limit: 20,
          cursor: _cursor,
        );

        final currentList = state.merchants.value ?? [];
        final newList = [...currentList, ...res.data];

        _cursor = res.data.isNotEmpty
            ? res.data.last.updatedAt.toIso8601String()
            : null;
        _hasMore = res.data.length >= 20;

        emit(state.copyWith(merchants: OperationResult.success(newList)));
      } on BaseError catch (e, st) {
        logger.e(
          '[UserMerchantListCubit] - loadMore Error: ${e.message}',
          error: e,
          stackTrace: st,
        );
        // If failed, keep existing data but maybe show toast
        // We don't want to replace success state with failure state if we want to keep the list visible.
        // But strictly following pattern:
        // emit(state.copyWith(merchants: OperationResult.failed(e)));
        // This would hide the list.
        // Better: maybe just log error or show transient error without changing state to failed.
      }
    });
  }

  /// Search merchants by name (debounced in UI)
  /// This method resets pagination and searches with new query
  Future<void> searchMerchants(String query) async {
    // Update search query in state first
    emit(state.copyWith(searchQuery: query));

    // Then load merchants with new search term
    await loadMerchants();
  }

  /// Clear search query and reload
  Future<void> clearSearch() async {
    emit(state.copyWith(searchQuery: ''));
    await loadMerchants();
  }

  /// Refresh the entire list (pull-to-refresh)
  Future<void> refresh() async {
    await loadMerchants();
  }

  /// Reset to initial state
  void reset() {
    emit(const UserMerchantListState());
  }
}
