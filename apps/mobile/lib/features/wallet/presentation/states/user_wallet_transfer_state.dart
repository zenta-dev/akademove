part of '_export.dart';

class UserWalletTransferState extends Equatable {
  const UserWalletTransferState({
    this.transfer = const OperationResult.idle(),
    this.recipientLookup = const OperationResult.idle(),
    this.selectedRecipient,
  });

  final OperationResult<TransferResponse> transfer;
  final OperationResult<UserLookupResult?> recipientLookup;
  final UserLookupResult? selectedRecipient;

  @override
  List<Object?> get props => [transfer, recipientLookup, selectedRecipient];

  UserWalletTransferState copyWith({
    OperationResult<TransferResponse>? transfer,
    OperationResult<UserLookupResult?>? recipientLookup,
    UserLookupResult? selectedRecipient,
    bool clearRecipient = false,
  }) {
    return UserWalletTransferState(
      transfer: transfer ?? this.transfer,
      recipientLookup: recipientLookup ?? this.recipientLookup,
      selectedRecipient: clearRecipient
          ? null
          : (selectedRecipient ?? this.selectedRecipient),
    );
  }

  @override
  bool get stringify => true;
}
