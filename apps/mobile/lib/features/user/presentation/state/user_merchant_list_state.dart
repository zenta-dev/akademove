part of '_export.dart';

@MappableClass(
  generateMethods:
      GenerateMethods.stringify | GenerateMethods.equals | GenerateMethods.copy,
)
class UserMerchantListState extends BaseState2
    with UserMerchantListStateMappable {
  UserMerchantListState({
    this.merchants = const [],
    this.hasMore = true,
    this.cursor,
    this.searchQuery = '',
    super.state,
    super.message,
    super.error,
  });

  /// List of merchants loaded so far
  final List<Merchant> merchants;

  /// Whether there are more merchants to load
  final bool hasMore;

  /// Cursor for pagination (timestamp from last item)
  final String? cursor;

  /// Current search query
  final String searchQuery;

  bool get isEmpty => merchants.isEmpty;

  @override
  UserMerchantListState toInitial() =>
      copyWith(state: CubitState.initial, message: null, error: null);

  @override
  UserMerchantListState toLoading() =>
      copyWith(state: CubitState.loading, message: null, error: null);

  @override
  UserMerchantListState toSuccess({
    List<Merchant>? merchants,
    bool? hasMore,
    String? cursor,
    String? message,
  }) => copyWith(
    state: CubitState.success,
    merchants: merchants ?? this.merchants,
    hasMore: hasMore ?? this.hasMore,
    cursor: cursor ?? this.cursor,
    message: message,
    error: null,
  );

  @override
  UserMerchantListState toFailure(BaseError error, {String? message}) =>
      copyWith(state: CubitState.failure, error: error, message: message);

  /// Success state - appends to list (pagination)
  UserMerchantListState appendMerchants(
    List<Merchant> newMerchants,
    String? nextCursor,
  ) {
    return copyWith(
      state: CubitState.success,
      merchants: [...merchants, ...newMerchants],
      cursor: nextCursor,
      hasMore: nextCursor != null,
      message: null,
      error: null,
    );
  }

  /// Update search query
  UserMerchantListState updateSearchQuery(String query) {
    return copyWith(searchQuery: query);
  }

  /// Reset to initial state
  UserMerchantListState reset() {
    return UserMerchantListState(
      state: CubitState.initial,
      message: null,
      error: null,
    );
  }
}
