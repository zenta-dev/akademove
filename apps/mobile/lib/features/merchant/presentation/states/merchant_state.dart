import 'package:akademove/core/_export.dart';
import 'package:api_client/api_client.dart';
import 'package:equatable/equatable.dart';

class MerchantState extends Equatable {
  const MerchantState({this.mine = const OperationResult.idle()});

  final OperationResult<Merchant> mine;

  bool get isLoading => mine.isLoading;
  bool get isFailure => mine.isFailure;
  BaseError? get error => mine.error;

  @override
  List<Object> get props => [mine];

  MerchantState copyWith({OperationResult<Merchant>? mine}) {
    return MerchantState(mine: mine ?? this.mine);
  }

  @override
  bool get stringify => true;
}
