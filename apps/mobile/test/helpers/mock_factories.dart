import 'package:akademove/core/_export.dart';
import 'package:akademove/features/auth/data/repositories/auth_repository.dart';
import 'package:akademove/features/configuration/data/repositories/configuration_repository.dart';
import 'package:akademove/features/coupon/data/repositories/coupon_repository.dart';
import 'package:akademove/features/driver/data/repositories/driver_repository.dart';
import 'package:akademove/features/driver/data/repositories/review_repository.dart';
import 'package:akademove/features/emergency/data/emergency_repository.dart';
import 'package:akademove/features/merchant/data/repositories/merchant_order_repository.dart';
import 'package:akademove/features/merchant/data/repositories/merchant_repository.dart';
import 'package:akademove/features/notification/data/repositories/notification_repository.dart';
import 'package:akademove/features/order/data/repositories/order_chat_repository.dart';
import 'package:akademove/features/order/data/repositories/order_repository.dart';
import 'package:akademove/features/transaction/data/repositories/transaction_repository.dart';
import 'package:akademove/features/user/data/repositories/user_repository.dart';
import 'package:akademove/features/wallet/data/repositories/wallet_repository.dart';
import 'package:api_client/api_client.dart';
import 'package:mocktail/mocktail.dart';

/// Mock factories for creating test doubles
/// Uses mocktail for clean, type-safe mocking

// ============================================================================
// API Client Mocks
// ============================================================================

class MockApiClient extends Mock implements ApiClient {}

class MockEmergencyApi extends Mock implements EmergencyApi {}

// ============================================================================
// Repository Mocks
// ============================================================================

class MockWalletRepository extends Mock implements WalletRepository {}

class MockTransactionRepository extends Mock implements TransactionRepository {}

class MockOrderRepository extends Mock implements OrderRepository {}

class MockDriverRepository extends Mock implements DriverRepository {}

class MockReviewRepository extends Mock implements ReviewRepository {}

class MockMerchantRepository extends Mock implements MerchantRepository {}

class MockMerchantOrderRepository extends Mock
    implements MerchantOrderRepository {}

class MockUserRepository extends Mock implements UserRepository {}

class MockAuthRepository extends Mock implements AuthRepository {}

class MockEmergencyRepository extends Mock implements EmergencyRepository {}

class MockConfigurationRepository extends Mock
    implements ConfigurationRepository {}

class MockNotificationRepository extends Mock
    implements NotificationRepository {}

class MockCouponRepository extends Mock implements CouponRepository {}

class MockOrderChatRepository extends Mock implements OrderChatRepository {}

// ============================================================================
// Service Mocks
// ============================================================================

class MockWebSocketService extends Mock implements WebSocketService {}
