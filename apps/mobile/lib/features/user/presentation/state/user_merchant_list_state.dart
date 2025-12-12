part of '_export.dart';

class UserMerchantListState extends Equatable {
  const UserMerchantListState({
    this.merchants = const OperationResult.idle(),
    this.searchQuery = '',
  });

  /// Result of merchants list operation with pagination data
  final OperationResult<List<Merchant>> merchants;

  /// Current search query
  final String searchQuery;

  bool get isEmpty {
    final value = merchants.value;
    return value == null || value.isEmpty;
  }

  @override
  List<Object> get props => [merchants, searchQuery];

  UserMerchantListState copyWith({
    OperationResult<List<Merchant>>? merchants,
    String? searchQuery,
  }) {
    return UserMerchantListState(
      merchants: merchants ?? this.merchants,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }

  @override
  bool get stringify => true;
}
