/// Test constants and sample data for use across all tests
/// Provides simple, reusable test data that avoids complex type dependencies
class TestConstants {
  TestConstants._();

  // IDs
  static const testUserId = 'test-user-id-123';
  static const testUserEmail = 'test@example.com';
  static const testUserName = 'Test User';
  static const testUserPhone = '+628123456789';

  static const testDriverId = 'test-driver-id-123';
  static const testDriverName = 'Test Driver';
  static const testVehiclePlate = 'B1234XYZ';

  static const testMerchantId = 'test-merchant-id-123';
  static const testMerchantName = 'Test Merchant';

  static const testOrderId = 'test-order-id-123';
  static const testPaymentId = 'test-payment-id-123';
  static const testTransactionId = 'test-transaction-id-123';

  static const testEmergencyId = 'test-emergency-id-123';
  static const testWalletId = 'test-wallet-id-123';

  // Location data
  static const testLatitude = -6.2088;
  static const testLongitude = 106.8456;
  static const testPickupLat = -6.2088;
  static const testPickupLng = 106.8456;
  static const testDropoffLat = -6.3;
  static const testDropoffLng = 106.9;

  // Prices and amounts
  static const testBalance = 100000.0; // Rp 100,000
  static const testOrderPrice = 25000.0; // Rp 25,000
  static const testCommission = 2500.0; // Rp 2,500
  static const testDriverEarnings = 22500.0; // Rp 22,500

  // API response messages
  static const successMessage = 'Operation successful';
  static const errorMessage = 'Operation failed';
  static const notFoundMessage = 'Resource not found';
  static const unauthorizedMessage = 'Unauthorized access';

  // Tokens
  static const testAuthToken = 'test-auth-token-xyz';
  static const testResetToken = 'test-reset-token-xyz';

  // Passwords
  static const testPassword = 'TestPassword123!';
  static const testNewPassword = 'NewTestPassword123!';

  // Dates
  static final testDate = DateTime(2024, 1, 15);
  static final testCreatedAt = DateTime(2024, 1, 15, 10, 30);
  static final testUpdatedAt = DateTime(2024, 1, 15, 11, 45);

  // WebSocket message samples
  static Map<String, Object?> get orderOfferMessage => {
    'e': 'OFFER',
    'p': {
      'detail': {
        'order': {
          'id': testOrderId,
          'userId': testUserId,
          'type': 'RIDE',
          'status': 'MATCHING',
          'pickupLocation': {'x': testPickupLng, 'y': testPickupLat},
          'dropoffLocation': {'x': testDropoffLng, 'y': testDropoffLat},
          'totalPrice': testOrderPrice,
        },
      },
    },
  };

  static Map<String, Object?> get orderAcceptedMessage => {
    'e': 'DRIVER_ACCEPTED',
    'p': {
      'detail': {
        'order': {'id': testOrderId, 'status': 'ACCEPTED'},
      },
      'driverAssigned': {'id': testDriverId, 'name': testDriverName},
    },
  };

  static Map<String, Object?> get orderCancelledMessage => {
    'e': 'CANCELED',
    'p': {'cancelReason': 'No driver available'},
  };

  static Map<String, Object?> get paymentSuccessMessage => {
    'e': 'PAYMENT_SUCCESS',
    'p': {
      'payment': {'id': testPaymentId, 'status': 'SUCCESS'},
      'transaction': {'id': testTransactionId},
    },
  };

  static Map<String, Object?> get paymentFailedMessage => {
    'e': 'PAYMENT_FAILED',
    'p': {
      'payment': {'id': testPaymentId, 'status': 'FAILED'},
    },
  };

  static Map<String, Object?> get driverLocationUpdateMessage => {
    'e': 'DRIVER_LOCATION_UPDATE',
    'p': {
      'driverUpdateLocation': {'x': testLongitude, 'y': testLatitude},
    },
  };

  static Map<String, Object?> get orderMatchingMessage => {
    'e': 'MATCHING',
    'p': {
      'detail': {
        'order': {'id': testOrderId, 'status': 'MATCHING'},
      },
    },
  };

  static Map<String, Object?> get orderUnavailableMessage => {
    'e': 'UNAVAILABLE',
    'p': {},
  };

  // Helper to create generic success response map
  static Map<String, Object?> successResponse<T>(T data, {String? message}) => {
    'message': message ?? successMessage,
    'data': data,
  };

  // Helper to create generic error response map
  static Map<String, Object?> errorResponse({String? message, String? code}) =>
      {
        'message': message ?? errorMessage,
        'code': code ?? 'INTERNAL_SERVER_ERROR',
      };
}
