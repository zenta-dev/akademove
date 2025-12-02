import 'package:akademove/core/_export.dart';
import 'package:akademove/features/emergency/data/emergency_repository.dart';
import 'package:api_client/api_client.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../helpers/mock_factories.dart';
import '../../../helpers/test_constants.dart';
import '../../../helpers/test_extensions.dart';

void main() {
  late MockApiClient mockApiClient;
  late MockEmergencyApi mockEmergencyApi;
  late EmergencyRepository repository;

  setUpAll(() {
    // Register fallback values for any() matchers
    registerFallbackValue(
      InsertEmergency(
        orderId: TestConstants.testOrderId,
        userId: TestConstants.testUserId,
        type: EmergencyType.ACCIDENT,
        status: EmergencyStatus.REPORTED,
        description: 'Fallback emergency',
      ),
    );
  });

  setUp(() {
    mockApiClient = MockApiClient();
    mockEmergencyApi = MockEmergencyApi();
    repository = EmergencyRepository(apiClient: mockApiClient);

    // Setup API client to return mock emergency API
    when(() => mockApiClient.getEmergencyApi()).thenReturn(mockEmergencyApi);
  });

  group('EmergencyRepository', () {
    group('trigger', () {
      test('should return success response when trigger succeeds', () async {
        // Arrange
        final query = TriggerEmergencyQuery(
          orderId: TestConstants.testOrderId,
          userId: TestConstants.testUserId,
          type: EmergencyType.ACCIDENT,
          description: 'Test emergency',
          location: EmergencyLocation(
            latitude: TestConstants.testLatitude,
            longitude: TestConstants.testLongitude,
          ),
          contactedAuthorities: ['Police'],
        );

        final emergency = Emergency(
          id: TestConstants.testEmergencyId,
          orderId: TestConstants.testOrderId,
          userId: TestConstants.testUserId,
          type: EmergencyType.ACCIDENT,
          status: EmergencyStatus.REPORTED,
          description: 'Test emergency',
          reportedAt: TestConstants.testCreatedAt,
        );

        final response = EmergencyTrigger200Response(
          message: 'Emergency triggered successfully',
          data: emergency,
        );

        when(
          () => mockEmergencyApi.emergencyTrigger(
            insertEmergency: any(named: 'insertEmergency'),
          ),
        ).thenAnswer(
          (_) async => Response(
            requestOptions: RequestOptions(path: '/emergencies'),
            statusCode: 200,
            data: response,
          ),
        );

        // Act
        final result = await repository.trigger(query);

        // Assert
        expect(result, isSuccessResponse<Emergency>());
        expect(result.data, equals(emergency));
        expect(result.message, equals('Emergency triggered successfully'));

        verify(
          () => mockEmergencyApi.emergencyTrigger(
            insertEmergency: any(named: 'insertEmergency'),
          ),
        ).called(1);
      });

      test('should throw RepositoryError when response is null', () async {
        // Arrange
        final query = TriggerEmergencyQuery(
          orderId: TestConstants.testOrderId,
          userId: TestConstants.testUserId,
          type: EmergencyType.ACCIDENT,
          description: 'Test emergency',
        );

        when(
          () => mockEmergencyApi.emergencyTrigger(
            insertEmergency: any(named: 'insertEmergency'),
          ),
        ).thenAnswer(
          (_) async => Response(
            requestOptions: RequestOptions(path: '/emergencies'),
            statusCode: 200,
            data: null,
          ),
        );

        // Act & Assert
        expect(
          () => repository.trigger(query),
          throwsA(isRepositoryErrorWithCode(ErrorCode.internalServerError)),
        );
      });

      test('should throw RepositoryError when API call fails', () async {
        // Arrange
        final query = TriggerEmergencyQuery(
          orderId: TestConstants.testOrderId,
          userId: TestConstants.testUserId,
          type: EmergencyType.ACCIDENT,
          description: 'Test emergency',
        );

        when(
          () => mockEmergencyApi.emergencyTrigger(
            insertEmergency: any(named: 'insertEmergency'),
          ),
        ).thenThrow(
          DioException(
            requestOptions: RequestOptions(path: '/emergencies'),
            type: DioExceptionType.connectionTimeout,
          ),
        );

        // Act & Assert
        expect(
          () => repository.trigger(query),
          throwsA(isA<RepositoryError>()),
        );
      });
    });

    group('listByOrder', () {
      test('should return success response when list succeeds', () async {
        // Arrange
        final emergencies = [
          Emergency(
            id: TestConstants.testEmergencyId,
            orderId: TestConstants.testOrderId,
            userId: TestConstants.testUserId,
            type: EmergencyType.ACCIDENT,
            status: EmergencyStatus.REPORTED,
            description: 'Test emergency',
            reportedAt: TestConstants.testCreatedAt,
          ),
        ];

        final response = EmergencyListByOrder200Response(
          message: 'Emergencies retrieved successfully',
          data: emergencies,
        );

        when(
          () => mockEmergencyApi.emergencyListByOrder(
            orderId: TestConstants.testOrderId,
          ),
        ).thenAnswer(
          (_) async => Response(
            requestOptions: RequestOptions(
              path: '/emergencies/order/${TestConstants.testOrderId}',
            ),
            statusCode: 200,
            data: response,
          ),
        );

        // Act
        final result = await repository.listByOrder(TestConstants.testOrderId);

        // Assert
        expect(result, isSuccessResponse<List<Emergency>>());
        expect(result.data, equals(emergencies));
        expect(result.message, equals('Emergencies retrieved successfully'));

        verify(
          () => mockEmergencyApi.emergencyListByOrder(
            orderId: TestConstants.testOrderId,
          ),
        ).called(1);
      });

      test('should return empty list when no emergencies found', () async {
        // Arrange
        final response = EmergencyListByOrder200Response(
          message: 'No emergencies found',
          data: [],
        );

        when(
          () => mockEmergencyApi.emergencyListByOrder(
            orderId: TestConstants.testOrderId,
          ),
        ).thenAnswer(
          (_) async => Response(
            requestOptions: RequestOptions(
              path: '/emergencies/order/${TestConstants.testOrderId}',
            ),
            statusCode: 200,
            data: response,
          ),
        );

        // Act
        final result = await repository.listByOrder(TestConstants.testOrderId);

        // Assert
        expect(result, isSuccessResponse<List<Emergency>>());
        expect(result.data, isEmpty);
      });

      test('should throw RepositoryError when API call fails', () async {
        // Arrange
        when(
          () => mockEmergencyApi.emergencyListByOrder(
            orderId: TestConstants.testOrderId,
          ),
        ).thenThrow(
          DioException(
            requestOptions: RequestOptions(
              path: '/emergencies/order/${TestConstants.testOrderId}',
            ),
            type: DioExceptionType.badResponse,
            response: Response(
              requestOptions: RequestOptions(
                path: '/emergencies/order/${TestConstants.testOrderId}',
              ),
              statusCode: 404,
            ),
          ),
        );

        // Act & Assert
        expect(
          () => repository.listByOrder(TestConstants.testOrderId),
          throwsA(isA<RepositoryError>()),
        );
      });
    });

    group('get', () {
      test('should return success response when get succeeds', () async {
        // Arrange
        final emergency = Emergency(
          id: TestConstants.testEmergencyId,
          orderId: TestConstants.testOrderId,
          userId: TestConstants.testUserId,
          type: EmergencyType.ACCIDENT,
          status: EmergencyStatus.REPORTED,
          description: 'Test emergency',
          reportedAt: TestConstants.testCreatedAt,
        );

        final response = EmergencyTrigger200Response(
          message: 'Emergency retrieved successfully',
          data: emergency,
        );

        when(
          () =>
              mockEmergencyApi.emergencyGet(id: TestConstants.testEmergencyId),
        ).thenAnswer(
          (_) async => Response(
            requestOptions: RequestOptions(
              path: '/emergencies/${TestConstants.testEmergencyId}',
            ),
            statusCode: 200,
            data: response,
          ),
        );

        // Act
        final result = await repository.get(TestConstants.testEmergencyId);

        // Assert
        expect(result, isSuccessResponse<Emergency>());
        expect(result.data, equals(emergency));
        expect(result.message, equals('Emergency retrieved successfully'));

        verify(
          () =>
              mockEmergencyApi.emergencyGet(id: TestConstants.testEmergencyId),
        ).called(1);
      });

      test('should throw RepositoryError when response is null', () async {
        // Arrange
        when(
          () =>
              mockEmergencyApi.emergencyGet(id: TestConstants.testEmergencyId),
        ).thenAnswer(
          (_) async => Response(
            requestOptions: RequestOptions(
              path: '/emergencies/${TestConstants.testEmergencyId}',
            ),
            statusCode: 200,
            data: null,
          ),
        );

        // Act & Assert
        expect(
          () => repository.get(TestConstants.testEmergencyId),
          throwsA(isRepositoryErrorWithCode(ErrorCode.internalServerError)),
        );
      });

      test('should throw RepositoryError when emergency not found', () async {
        // Arrange
        when(
          () =>
              mockEmergencyApi.emergencyGet(id: TestConstants.testEmergencyId),
        ).thenThrow(
          DioException(
            requestOptions: RequestOptions(
              path: '/emergencies/${TestConstants.testEmergencyId}',
            ),
            type: DioExceptionType.badResponse,
            response: Response(
              requestOptions: RequestOptions(
                path: '/emergencies/${TestConstants.testEmergencyId}',
              ),
              statusCode: 404,
            ),
          ),
        );

        // Act & Assert
        expect(
          () => repository.get(TestConstants.testEmergencyId),
          throwsA(isA<RepositoryError>()),
        );
      });
    });
  });
}
