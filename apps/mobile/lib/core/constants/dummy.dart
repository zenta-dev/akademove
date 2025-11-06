import 'package:api_client/api_client.dart';
import 'package:const_date_time/const_date_time.dart';

const dummyConstDateTime = ConstDateTime(2025, 12, 12);
const dummyUUIDString = '00000000-0000-0000-0000-000000000000';

const dummyWalletSummary = WalletMonthlySummaryResponse(
  month: '2025-12',
  totalIncome: 0,
  totalExpense: 0,
  net: 0,
);

const dummyWalletTransaction = WalletTransaction(
  id: dummyUUIDString,
  walletId: dummyUUIDString,
  type: WalletTransactionType.adjustment,
  amount: 0,
  status: TransactionStatus.pending,
  createdAt: dummyConstDateTime,
);
