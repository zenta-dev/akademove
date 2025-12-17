import 'package:akademove/core/_export.dart';
import 'package:api_client/api_client.dart';
import 'package:const_date_time/const_date_time.dart';

const dummyConstDateTime = ConstDateTime(2025, 12, 12);
const dummyUUIDString = '00000000-0000-0000-0000-000000000000';
const dummyAmount = 50_000;

const dummyWalletSummary = WalletMonthlySummaryResponse(
  month: '2025-12',
  totalIncome: 0,
  totalExpense: 0,
  net: 0,
  totalEarnings: 0,
  totalCommission: 0,
  commissionRate: 0,
);

const dummyTransaction = Transaction(
  id: dummyUUIDString,
  walletId: dummyUUIDString,
  type: TransactionType.ADJUSTMENT,
  amount: 0,
  status: TransactionStatus.PENDING,
  createdAt: dummyConstDateTime,
  updatedAt: dummyConstDateTime,
);

const dummyOrder = Order(
  id: dummyUUIDString,
  userId: dummyUUIDString,
  type: OrderType.DELIVERY,
  status: OrderStatus.REQUESTED,
  pickupLocation: MapConstants.defaultCoordinate,
  dropoffLocation: MapConstants.defaultCoordinate,
  distanceKm: 2,
  basePrice: 1000,
  totalPrice: 2000,
  requestedAt: dummyConstDateTime,
  createdAt: dummyConstDateTime,
  updatedAt: dummyConstDateTime,
);

const dummyPayment = Payment(
  id: dummyUUIDString,
  transactionId: dummyUUIDString,
  provider: PaymentProvider.MANUAL,
  method: PaymentMethod.QRIS,
  amount: dummyAmount,
  status: TransactionStatus.PENDING,
  createdAt: dummyConstDateTime,
  updatedAt: dummyConstDateTime,
);

const dummyPlaceOrderResponse = PlaceOrderResponse(
  order: dummyOrder,
  payment: dummyPayment,
  transaction: dummyTransaction,
);

const dummyPhone = Phone(countryCode: CountryCode.ID, number: 123456);

const dummyMerchant = Merchant(
  id: dummyUUIDString,
  userId: dummyUUIDString,
  name: 'Bakso Solo',
  email: 'bakso@gmail.com',
  phone: dummyPhone,
  address: 'St. Somewhere',
  isActive: true,
  rating: 3,
  category: MerchantCategory.food,
  bank: Bank(provider: BankProvider.BCA, number: 12345),
  categories: ['Drink', 'Coffe', 'Desert', 'Food'],
  image: '${UrlConstants.randomImageUrl}/seed/512/512',
  operatingStatus: MerchantOperatingStatusEnum.MAINTENANCE,
  isOnline: false,
  status: MerchantStatusEnum.ACTIVE,
  createdAt: dummyConstDateTime,
  updatedAt: dummyConstDateTime,
  activeOrderCount: 0,
);

const dummyPlace = Place(
  name: 'Zenta Dev',
  vicinity: 'St. Boulvard No.80',
  lat: 0,
  lng: 0,
  icon: '${UrlConstants.randomImageUrl}/seed/24/24',
);

const dummyUser = User(
  id: dummyUUIDString,
  name: 'Folks',
  email: 'folks@akademove.com',
  emailVerified: false,
  role: UserRole.USER,
  banned: false,
  phone: dummyPhone,
  createdAt: dummyConstDateTime,
  updatedAt: dummyConstDateTime,
  userBadges: [],
);

const dummyBank = Bank(provider: BankProvider.BCA, number: 12345678);

const dummyDriver = Driver(
  id: dummyUUIDString,
  userId: dummyUUIDString,
  studentId: 21051204020,
  licensePlate: 'S 1234 AB',
  status: DriverStatus.ACTIVE,
  rating: 4.5,
  isTakingOrder: false,
  isOnline: true,
  createdAt: dummyConstDateTime,
  studentCard: '${UrlConstants.randomImageUrl}/seed/24/24',
  driverLicense: '${UrlConstants.randomImageUrl}/seed/24/24',
  vehicleCertificate: '${UrlConstants.randomImageUrl}/seed/24/24',
  bank: dummyBank,
);

const dummyDriverSchedule = DriverSchedule(
  id: dummyUUIDString,
  name: 'Comp Science',
  dayOfWeek: DayOfWeek.MONDAY,
  startTime: Time(h: 12, m: 0),
  endTime: Time(h: 14, m: 0),
  driverId: dummyUUIDString,
  createdAt: dummyConstDateTime,
  updatedAt: dummyConstDateTime,
);
