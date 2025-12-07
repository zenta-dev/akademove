import 'package:akademove/core/_export.dart';
import 'package:akademove/features/merchant/data/repositories/_export.dart';
import 'package:akademove/features/user/presentation/state/_export.dart';

class UserMerchantListCubit extends BaseCubit<UserMerchantListState> {
  UserMerchantListCubit({required MerchantRepository merchantRepository})
    : _merchantRepository = merchantRepository,
      super(UserMerchantListState());

  final MerchantRepository _merchantRepository;

  /// Load initial popular merchants (no nearby logic)
  /// This is called when opening the merchant list screen
  /// Always shows popular merchants sorted by popularity/rating
  Future<void> loadMerchants() async =>
      await taskManager.execute('UMLC-lM-popular', () async {
        try {
          emit(state.toLoading());

          // If searching, use listWithFilters; otherwise use getPopulars
          final res = state.searchQuery.isEmpty
              ? await _merchantRepository.getPopulars()
              : await _merchantRepository.listWithFilters(
                  query: state.searchQuery,
                  isActive: true, // Only show open merchants
                  sortBy: 'popularity', // Always sort by popularity
                  limit: 20,
                  cursor: null,
                );

          emit(
            state.toSuccess(
              merchants: res.data,
              hasMore:
                  res.data.length >=
                  20, // If received 20 items, likely more exist
              cursor: res.data.isNotEmpty
                  ? res.data.last.updatedAt.toIso8601String()
                  : null,
              message: res.message,
            ),
          );
        } on BaseError catch (e, st) {
          logger.e(
            '[UserMerchantListCubit] - loadMerchants Error: ${e.message}',
            error: e,
            stackTrace: st,
          );
          emit(state.toFailure(e));
        }
      });

  /// Load next page of merchants (pagination)
  /// Called when user scrolls to 80% of the list
  Future<void> loadMore() async {
    if (!state.hasMore || state.isLoading) return;

    await taskManager.execute(
      'UMLC-lMore-${state.cursor ?? "start"}',
      () async {
        try {
          emit(state.toLoading());

          final res = await _merchantRepository.listWithFilters(
            query: state.searchQuery.isEmpty ? null : state.searchQuery,
            isActive: true,
            sortBy: 'popularity', // Always sort by popularity
            limit: 20,
            cursor: state.cursor,
          );

          emit(
            state.appendMerchants(
              res.data,
              res.data.isNotEmpty
                  ? res.data.last.updatedAt.toIso8601String()
                  : null,
            ),
          );
        } on BaseError catch (e, st) {
          logger.e(
            '[UserMerchantListCubit] - loadMore Error: ${e.message}',
            error: e,
            stackTrace: st,
          );
          emit(state.toFailure(e));
        }
      },
    );
  }

  /// Search merchants by name (debounced in UI)
  /// This method resets pagination and searches with new query
  Future<void> searchMerchants(String query) async {
    // Update search query in state first
    emit(state.updateSearchQuery(query));

    // Then load merchants with new search term
    await loadMerchants();
  }

  /// Clear search query and reload
  Future<void> clearSearch() async {
    emit(state.updateSearchQuery(''));
    await loadMerchants();
  }

  /// Refresh the entire list (pull-to-refresh)
  Future<void> refresh() async {
    await loadMerchants();
  }

  /// Reset to initial state
  void reset() {
    emit(state.reset());
  }
}
