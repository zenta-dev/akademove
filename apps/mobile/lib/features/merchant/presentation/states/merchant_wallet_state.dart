import 'package:akademove/core/_export.dart';
import 'package:api_client/api_client.dart';
import 'package:equatable/equatable.dart';

class MerchantWalletState extends Equatable {
  const MerchantWalletState({
    this.wallet = const OperationResult.idle(),
    this.monthlySummary = const OperationResult.idle(),
  });

  final OperationResult<Wallet> wallet;
  final OperationResult<WalletMonthlySummaryResponse> monthlySummary;

  @override
  List<Object> get props => [wallet, monthlySummary];

  MerchantWalletState copyWith({
    OperationResult<Wallet>? wallet,
    OperationResult<WalletMonthlySummaryResponse>? monthlySummary,
  }) {
    return MerchantWalletState(
      wallet: wallet ?? this.wallet,
      monthlySummary: monthlySummary ?? this.monthlySummary,
    );
  }

  @override
  bool get stringify => true;
}
