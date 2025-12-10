part of '_export.dart';

class UserHomeState extends Equatable {
  const UserHomeState({this.popularMerchants = const OperationResult.idle()});

  final OperationResult<List<Merchant>> popularMerchants;

  @override
  List<Object> get props => [popularMerchants];

  UserHomeState copyWith({OperationResult<List<Merchant>>? popularMerchants}) {
    return UserHomeState(
      popularMerchants: popularMerchants ?? this.popularMerchants,
    );
  }

  @override
  bool get stringify => true;
}
