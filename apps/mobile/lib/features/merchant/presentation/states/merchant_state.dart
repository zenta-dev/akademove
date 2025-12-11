import 'package:akademove/core/_export.dart';
import 'package:api_client/api_client.dart';
import 'package:equatable/equatable.dart';

class MerchantState extends Equatable {
  const MerchantState({
    this.mine = const OperationResult.idle(),
    this.updateProfile = const OperationResult.idle(),
  });

  final OperationResult<Merchant> mine;
  final OperationResult<Merchant> updateProfile;

  @override
  List<Object> get props => [mine, updateProfile];

  MerchantState copyWith({
    OperationResult<Merchant>? mine,
    OperationResult<Merchant>? updateProfile,
  }) {
    return MerchantState(
      mine: mine ?? this.mine,
      updateProfile: updateProfile ?? this.updateProfile,
    );
  }

  @override
  bool get stringify => true;
}
