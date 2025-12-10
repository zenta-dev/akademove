part of '_export.dart';

class UserWalletTransferState extends Equatable {
  const UserWalletTransferState({this.transfer = const OperationResult.idle()});

  final OperationResult<TransferResponse> transfer;

  @override
  List<Object> get props => [transfer];

  UserWalletTransferState copyWith({
    OperationResult<TransferResponse>? transfer,
  }) {
    return UserWalletTransferState(transfer: transfer ?? this.transfer);
  }

  @override
  bool get stringify => true;
}
