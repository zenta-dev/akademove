import 'package:akademove/core/_export.dart';
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

const dummyTransaction = Transaction(
  id: dummyUUIDString,
  walletId: dummyUUIDString,
  type: TransactionType.adjustment,
  amount: 0,
  status: TransactionStatus.pending,
  createdAt: dummyConstDateTime,
);

const dummyOrder = Order(
  id: dummyUUIDString,
  userId: dummyUUIDString,
  type: OrderType.delivery,
  status: OrderStatus.requested,
  pickupLocation: Constants.defaultCoordinate,
  dropoffLocation: Constants.defaultCoordinate,
  distanceKm: 2,
  basePrice: 1000,
  totalPrice: 2000,
  requestedAt: dummyConstDateTime,
  createdAt: dummyConstDateTime,
  updatedAt: dummyConstDateTime,
);

const dummyMerchant = Merchant(
  id: dummyUUIDString,
  userId: dummyUUIDString,
  name: 'Bakso Solo',
  email: 'bakso@gmail.com',
  phone: Phone(countryCode: CountryCode.ID, number: 123456),
  address: 'St. Somewhere',
  isActive: true,
  rating: 3,
  bank: Bank(provider: BankProviderEnum.BCA, number: 12345),
  categories: ['Drink', 'Coffe', 'Desert', 'Food'],
  image: '${Constants.randomImageUrl}/seed/512/512',
  createdAt: dummyConstDateTime,
  updatedAt: dummyConstDateTime,
);

const dummyPlace = Place(
  name: 'Zenta Dev',
  vicinity: 'St. Boulvard No.80',
  lat: 0,
  lng: 0,
  icon: '${Constants.randomImageUrl}/seed/24/24',
);
