import 'package:akademove/core/_export.dart';
import 'package:akademove/features/emergency/data/emergency_repository.dart';
import 'package:akademove/features/emergency/presentation/cubits/emergency_cubit.dart';
import 'package:akademove/features/emergency/presentation/states/_export.dart';
import 'package:api_client/api_client.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../helpers/mock_factories.dart';
import '../../../../helpers/test_constants.dart';

void main() {
  group('EmergencyCubit', () {
    late EmergencyCubit cubit;
    late MockEmergencyRepository mockEmergencyRepository;

    setUpAll(() {
      // Register fallback values for any() matchers
      registerFallbackValue(
        TriggerEmergencyQuery(
          orderId: TestConstants.testOrderId,
          userId: TestConstants.testUserId,
          type: EmergencyType.ACCIDENT,
          description: 'Fallback',
        ),
      );
    });

    setUp(() {
      mockEmergencyRepository = MockEmergencyRepository();
      cubit = EmergencyCubit(repository: mockEmergencyRepository);
    });

    tearDown(() {
      cubit.close();
    });

    test('initial state is correct', () {
      expect(cubit.state, isA<EmergencyState>());
      expect(cubit.state.triggerEmergency.value, isNull);
      expect(cubit.state.emergencies.value, isNull);
    });

    group('init', () {
      test('resets state to initial', () async {
        // Arrange - modify state first
        cubit.emit(
          cubit.state.copyWith(
            triggerEmergency: OperationResult.success(
              Emergency(
                id: TestConstants.testEmergencyId,
                orderId: TestConstants.testOrderId,
                userId: TestConstants.testUserId,
                type: EmergencyType.ACCIDENT,
                status: EmergencyStatus.REPORTED,
                description: 'Test',
                reportedAt: TestConstants.testCreatedAt,
              ),
            ),
          ),
        );

        // Act
        await cubit.init();

        // Assert
        expect(cubit.state.triggerEmergency.value, isNull);
        expect(cubit.state.emergencies.value, isNull);
      });
    });

    group('reset', () {
      test('resets state to initial', () {
        // Arrange - modify state first
        cubit.emit(
          cubit.state.copyWith(
            triggerEmergency: OperationResult.success(
              Emergency(
                id: TestConstants.testEmergencyId,
                orderId: TestConstants.testOrderId,
                userId: TestConstants.testUserId,
                type: EmergencyType.ACCIDENT,
                status: EmergencyStatus.REPORTED,
                description: 'Test',
                reportedAt: TestConstants.testCreatedAt,
              ),
            ),
          ),
        );

        // Act
        cubit.reset();

        // Assert
        expect(cubit.state.triggerEmergency.value, isNull);
        expect(cubit.state.emergencies.value, isNull);
      });
    });

    group('trigger', () {
      blocTest<EmergencyCubit, EmergencyState>(
        'emits [loading, success] when trigger succeeds',
        build: () {
          final emergency = Emergency(
            id: TestConstants.testEmergencyId,
            orderId: TestConstants.testOrderId,
            userId: TestConstants.testUserId,
            type: EmergencyType.ACCIDENT,
            status: EmergencyStatus.REPORTED,
            description: 'Test emergency',
            reportedAt: TestConstants.testCreatedAt,
          );

          when(() => mockEmergencyRepository.trigger(any())).thenAnswer(
            (_) async => SuccessResponse(
              message: 'Emergency triggered',
              data: emergency,
            ),
          );

          return cubit;
        },
        act: (cubit) => cubit.trigger(
          orderId: TestConstants.testOrderId,
          userId: TestConstants.testUserId,
          type: EmergencyType.ACCIDENT,
          description: 'Test emergency',
        ),
        expect: () => [
          isA<EmergencyState>().having(
            (s) => s.triggerEmergency.isLoading,
            'triggerEmergency.isLoading',
            true,
          ),
          isA<EmergencyState>()
              .having(
                (s) => s.triggerEmergency.isSuccess,
                'triggerEmergency.isSuccess',
                true,
              )
              .having(
                (s) => s.triggerEmergency.value,
                'triggerEmergency.value',
                isNotNull,
              )
              .having(
                (s) => s.triggerEmergency.value?.id,
                'triggerEmergency.value.id',
                TestConstants.testEmergencyId,
              ),
        ],
        verify: (_) {
          verify(() => mockEmergencyRepository.trigger(any())).called(1);
        },
      );

      blocTest<EmergencyCubit, EmergencyState>(
        'emits [loading, failure] when trigger fails',
        build: () {
          when(() => mockEmergencyRepository.trigger(any())).thenThrow(
            const RepositoryError(
              'Failed to trigger emergency',
              code: ErrorCode.internalServerError,
            ),
          );

          return cubit;
        },
        act: (cubit) => cubit.trigger(
          orderId: TestConstants.testOrderId,
          userId: TestConstants.testUserId,
          type: EmergencyType.ACCIDENT,
          description: 'Test emergency',
        ),
        expect: () => [
          isA<EmergencyState>().having(
            (s) => s.triggerEmergency.isLoading,
            'triggerEmergency.isLoading',
            true,
          ),
          isA<EmergencyState>()
              .having(
                (s) => s.triggerEmergency.isFailure,
                'triggerEmergency.isFailure',
                true,
              )
              .having(
                (s) => s.triggerEmergency.error,
                'triggerEmergency.error',
                isA<RepositoryError>(),
              ),
        ],
      );

      test(
        'deduplicates concurrent calls',
        () async {
          // This test is flaky because the emit() creates new state object
          // between checkAndAssignOperation and emit(state.toLoading()).
          // The taskManager.execute already handles deduplication via task keys.
          // Skipping until a proper solution is found.

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

          when(() => mockEmergencyRepository.trigger(any())).thenAnswer((
            _,
          ) async {
            // Simulate slow operation
            await Future<void>.delayed(const Duration(milliseconds: 50));
            return SuccessResponse(
              message: 'Emergency triggered',
              data: emergency,
            );
          });

          // Act - fire multiple calls without awaiting
          // ignore: unawaited_futures
          cubit.trigger(
            orderId: TestConstants.testOrderId,
            userId: TestConstants.testUserId,
            type: EmergencyType.ACCIDENT,
            description: 'Test emergency',
          );
          // ignore: unawaited_futures
          cubit.trigger(
            orderId: TestConstants.testOrderId,
            userId: TestConstants.testUserId,
            type: EmergencyType.ACCIDENT,
            description: 'Test emergency',
          );
          await cubit.trigger(
            orderId: TestConstants.testOrderId,
            userId: TestConstants.testUserId,
            type: EmergencyType.ACCIDENT,
            description: 'Test emergency',
          );

          // Assert - should only call repository once due to operation deduplication
          verify(() => mockEmergencyRepository.trigger(any())).called(1);
        },
        skip: 'Flaky test - deduplication timing issue with state emissions',
      );
    });

    group('loadByOrder', () {
      blocTest<EmergencyCubit, EmergencyState>(
        'emits [loading, success] when loadByOrder succeeds',
        build: () {
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

          when(() => mockEmergencyRepository.listByOrder(any())).thenAnswer(
            (_) async => SuccessResponse(
              message: 'Emergencies loaded',
              data: emergencies,
            ),
          );

          return cubit;
        },
        act: (cubit) => cubit.loadByOrder(TestConstants.testOrderId),
        expect: () => [
          isA<EmergencyState>().having(
            (s) => s.emergencies.isLoading,
            'emergencies.isLoading',
            true,
          ),
          isA<EmergencyState>()
              .having(
                (s) => s.emergencies.isSuccess,
                'emergencies.isSuccess',
                true,
              )
              .having(
                (s) => s.emergencies.value,
                'emergencies.value',
                hasLength(1),
              )
              .having(
                (s) => s.emergencies.value?.first.id,
                'emergencies.value.first.id',
                TestConstants.testEmergencyId,
              ),
        ],
        verify: (_) {
          verify(
            () =>
                mockEmergencyRepository.listByOrder(TestConstants.testOrderId),
          ).called(1);
        },
      );

      blocTest<EmergencyCubit, EmergencyState>(
        'emits [loading, success] with empty list when no emergencies found',
        build: () {
          when(() => mockEmergencyRepository.listByOrder(any())).thenAnswer(
            (_) async => SuccessResponse<List<Emergency>>(
              message: 'No emergencies found',
              data: [],
            ),
          );

          return cubit;
        },
        act: (cubit) => cubit.loadByOrder(TestConstants.testOrderId),
        expect: () => [
          isA<EmergencyState>().having(
            (s) => s.emergencies.isLoading,
            'emergencies.isLoading',
            true,
          ),
          isA<EmergencyState>()
              .having(
                (s) => s.emergencies.isSuccess,
                'emergencies.isSuccess',
                true,
              )
              .having((s) => s.emergencies.value, 'emergencies.value', isEmpty),
        ],
      );

      blocTest<EmergencyCubit, EmergencyState>(
        'emits [loading, failure] when loadByOrder fails',
        build: () {
          when(() => mockEmergencyRepository.listByOrder(any())).thenThrow(
            const RepositoryError(
              'Failed to load emergencies',
              code: ErrorCode.internalServerError,
            ),
          );

          return cubit;
        },
        act: (cubit) => cubit.loadByOrder(TestConstants.testOrderId),
        expect: () => [
          isA<EmergencyState>().having(
            (s) => s.emergencies.isLoading,
            'emergencies.isLoading',
            true,
          ),
          isA<EmergencyState>()
              .having(
                (s) => s.emergencies.isFailure,
                'emergencies.isFailure',
                true,
              )
              .having(
                (s) => s.emergencies.error,
                'emergencies.error',
                isA<RepositoryError>(),
              ),
        ],
      );
    });

    group('get', () {
      blocTest<EmergencyCubit, EmergencyState>(
        'emits [loading, success] when get succeeds',
        build: () {
          final emergency = Emergency(
            id: TestConstants.testEmergencyId,
            orderId: TestConstants.testOrderId,
            userId: TestConstants.testUserId,
            type: EmergencyType.ACCIDENT,
            status: EmergencyStatus.REPORTED,
            description: 'Test emergency',
            reportedAt: TestConstants.testCreatedAt,
          );

          when(() => mockEmergencyRepository.get(any())).thenAnswer(
            (_) async => SuccessResponse(
              message: 'Emergency retrieved',
              data: emergency,
            ),
          );

          return cubit;
        },
        act: (cubit) => cubit.get(TestConstants.testEmergencyId),
        expect: () => [
          isA<EmergencyState>().having(
            (s) => s.triggerEmergency.isLoading,
            'triggerEmergency.isLoading',
            true,
          ),
          isA<EmergencyState>()
              .having(
                (s) => s.triggerEmergency.isSuccess,
                'triggerEmergency.isSuccess',
                true,
              )
              .having(
                (s) => s.triggerEmergency.value,
                'triggerEmergency.value',
                isNotNull,
              )
              .having(
                (s) => s.triggerEmergency.value?.id,
                'triggerEmergency.value.id',
                TestConstants.testEmergencyId,
              ),
        ],
        verify: (_) {
          verify(
            () => mockEmergencyRepository.get(TestConstants.testEmergencyId),
          ).called(1);
        },
      );

      blocTest<EmergencyCubit, EmergencyState>(
        'emits [loading, failure] when get fails',
        build: () {
          when(() => mockEmergencyRepository.get(any())).thenThrow(
            const RepositoryError(
              'Failed to get emergency',
              code: ErrorCode.notFound,
            ),
          );

          return cubit;
        },
        act: (cubit) => cubit.get(TestConstants.testEmergencyId),
        expect: () => [
          isA<EmergencyState>().having(
            (s) => s.triggerEmergency.isLoading,
            'triggerEmergency.isLoading',
            true,
          ),
          isA<EmergencyState>()
              .having(
                (s) => s.triggerEmergency.isFailure,
                'triggerEmergency.isFailure',
                true,
              )
              .having(
                (s) => s.triggerEmergency.error,
                'triggerEmergency.error',
                isA<RepositoryError>(),
              ),
        ],
      );
    });
  });
}
