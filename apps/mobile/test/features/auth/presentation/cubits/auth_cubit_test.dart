import 'package:akademove/core/_export.dart';
import 'package:akademove/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:akademove/features/auth/presentation/states/_export.dart';
import 'package:api_client/api_client.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../helpers/mock_factories.dart';
import '../../../../helpers/test_constants.dart';

void main() {
  group('AuthCubit', () {
    late AuthCubit cubit;
    late MockAuthRepository mockAuthRepository;

    setUp(() {
      mockAuthRepository = MockAuthRepository();
      cubit = AuthCubit(authRepository: mockAuthRepository);
    });

    tearDown(() {
      cubit.close();
    });

    test('initial state is correct', () {
      expect(cubit.state, isA<AuthState>());
      expect(cubit.state.isInitial, isTrue);
      expect(cubit.state.data, isNull);
    });

    group('init', () {
      blocTest<AuthCubit, AuthState>(
        'calls authenticate on init',
        build: () {
          final user = User(
            id: TestConstants.testUserId,
            email: TestConstants.testUserEmail,
            name: TestConstants.testUserName,
            phone: Phone(
              countryCode: CountryCode.ID,
              number: TestConstants.testUserPhoneNumber,
            ),
            role: UserRole.USER,
            emailVerified: true,
            banned: false,
            userBadges: const [],
            createdAt: TestConstants.testCreatedAt,
            updatedAt: TestConstants.testUpdatedAt,
          );

          when(() => mockAuthRepository.authenticate()).thenAnswer(
            (_) async => SuccessResponse(
              message: TestConstants.successMessage,
              data: user,
            ),
          );

          return cubit;
        },
        act: (cubit) => cubit.init(),
        expect: () => [
          isA<AuthState>().having((s) => s.isLoading, 'isLoading', true),
          isA<AuthState>()
              .having((s) => s.isSuccess, 'isSuccess', true)
              .having((s) => s.data, 'data', isNotNull)
              .having((s) => s.data?.id, 'data.id', TestConstants.testUserId),
        ],
        verify: (_) {
          verify(() => mockAuthRepository.authenticate()).called(1);
        },
      );
    });

    group('authenticate', () {
      blocTest<AuthCubit, AuthState>(
        'emits [loading, success] when authenticate succeeds',
        build: () {
          final user = User(
            id: TestConstants.testUserId,
            email: TestConstants.testUserEmail,
            name: TestConstants.testUserName,
            phone: Phone(
              countryCode: CountryCode.ID,
              number: TestConstants.testUserPhoneNumber,
            ),
            role: UserRole.USER,
            emailVerified: true,
            banned: false,
            userBadges: const [],
            createdAt: TestConstants.testCreatedAt,
            updatedAt: TestConstants.testUpdatedAt,
          );

          when(() => mockAuthRepository.authenticate()).thenAnswer(
            (_) async => SuccessResponse(
              message: TestConstants.successMessage,
              data: user,
            ),
          );

          return cubit;
        },
        act: (cubit) => cubit.authenticate(),
        expect: () => [
          isA<AuthState>().having((s) => s.isLoading, 'isLoading', true),
          isA<AuthState>()
              .having((s) => s.isSuccess, 'isSuccess', true)
              .having((s) => s.data, 'data', isNotNull)
              .having((s) => s.data?.id, 'data.id', TestConstants.testUserId)
              .having(
                (s) => s.data?.email,
                'data.email',
                TestConstants.testUserEmail,
              )
              .having(
                (s) => s.data?.name,
                'data.name',
                TestConstants.testUserName,
              ),
        ],
        verify: (_) {
          verify(() => mockAuthRepository.authenticate()).called(1);
        },
      );

      blocTest<AuthCubit, AuthState>(
        'emits [loading, failure] when authenticate fails',
        build: () {
          when(() => mockAuthRepository.authenticate()).thenThrow(
            const RepositoryError(
              TestConstants.unauthorizedMessage,
              code: ErrorCode.unauthorized,
            ),
          );

          return cubit;
        },
        act: (cubit) => cubit.authenticate(),
        expect: () => [
          isA<AuthState>().having((s) => s.isLoading, 'isLoading', true),
          isA<AuthState>()
              .having((s) => s.isFailure, 'isFailure', true)
              .having((s) => s.error, 'error', isA<RepositoryError>())
              .having(
                (s) => s.error?.message,
                'error.message',
                TestConstants.unauthorizedMessage,
              ),
        ],
      );
    });

    group('signOut', () {
      blocTest<AuthCubit, AuthState>(
        'emits [loading, success] when signOut succeeds',
        build: () {
          when(() => mockAuthRepository.signOut()).thenAnswer(
            (_) async =>
                SuccessResponse(message: 'Signed out successfully', data: true),
          );

          return cubit;
        },
        act: (cubit) => cubit.signOut(),
        expect: () => [
          isA<AuthState>().having((s) => s.isLoading, 'isLoading', true),
          isA<AuthState>()
              .having((s) => s.isSuccess, 'isSuccess', true)
              .having((s) => s.data, 'data', isNull),
        ],
        verify: (_) {
          verify(() => mockAuthRepository.signOut()).called(1);
        },
      );

      blocTest<AuthCubit, AuthState>(
        'emits [loading, failure] when signOut fails',
        build: () {
          when(() => mockAuthRepository.signOut()).thenThrow(
            const RepositoryError(
              TestConstants.errorMessage,
              code: ErrorCode.internalServerError,
            ),
          );

          return cubit;
        },
        act: (cubit) => cubit.signOut(),
        expect: () => [
          isA<AuthState>().having((s) => s.isLoading, 'isLoading', true),
          isA<AuthState>()
              .having((s) => s.isFailure, 'isFailure', true)
              .having((s) => s.error, 'error', isA<RepositoryError>()),
        ],
      );
    });

    group('forgotPassword', () {
      blocTest<AuthCubit, AuthState>(
        'emits [loading, success] when forgotPassword succeeds',
        build: () {
          when(
            () => mockAuthRepository.forgotPassword(email: any(named: 'email')),
          ).thenAnswer(
            (_) async => SuccessResponse(
              message: 'Password reset email sent',
              data: true,
            ),
          );

          return cubit;
        },
        act: (cubit) => cubit.forgotPassword(TestConstants.testUserEmail),
        expect: () => [
          isA<AuthState>().having((s) => s.isLoading, 'isLoading', true),
          isA<AuthState>()
              .having((s) => s.isSuccess, 'isSuccess', true)
              .having((s) => s.message, 'message', 'Password reset email sent'),
        ],
        verify: (_) {
          verify(
            () => mockAuthRepository.forgotPassword(
              email: TestConstants.testUserEmail,
            ),
          ).called(1);
        },
      );

      blocTest<AuthCubit, AuthState>(
        'emits [loading, failure] when forgotPassword fails',
        build: () {
          when(
            () => mockAuthRepository.forgotPassword(email: any(named: 'email')),
          ).thenThrow(
            const RepositoryError(
              TestConstants.notFoundMessage,
              code: ErrorCode.notFound,
            ),
          );

          return cubit;
        },
        act: (cubit) => cubit.forgotPassword(TestConstants.testUserEmail),
        expect: () => [
          isA<AuthState>().having((s) => s.isLoading, 'isLoading', true),
          isA<AuthState>()
              .having((s) => s.isFailure, 'isFailure', true)
              .having((s) => s.error, 'error', isA<RepositoryError>()),
        ],
      );
    });

    group('resetPassword', () {
      blocTest<AuthCubit, AuthState>(
        'emits [loading, success] when resetPassword succeeds',
        build: () {
          when(
            () => mockAuthRepository.resetPassword(
              token: any(named: 'token'),
              newPassword: any(named: 'newPassword'),
              confirmPassword: any(named: 'confirmPassword'),
            ),
          ).thenAnswer(
            (_) async => SuccessResponse(
              message: 'Password reset successfully',
              data: true,
            ),
          );

          return cubit;
        },
        act: (cubit) => cubit.resetPassword(
          token: TestConstants.testResetToken,
          newPassword: TestConstants.testNewPassword,
          confirmPassword: TestConstants.testNewPassword,
        ),
        expect: () => [
          isA<AuthState>().having((s) => s.isLoading, 'isLoading', true),
          isA<AuthState>()
              .having((s) => s.isSuccess, 'isSuccess', true)
              .having(
                (s) => s.message,
                'message',
                'Password reset successfully',
              ),
        ],
        verify: (_) {
          verify(
            () => mockAuthRepository.resetPassword(
              token: TestConstants.testResetToken,
              newPassword: TestConstants.testNewPassword,
              confirmPassword: TestConstants.testNewPassword,
            ),
          ).called(1);
        },
      );

      blocTest<AuthCubit, AuthState>(
        'emits [loading, failure] when resetPassword fails',
        build: () {
          when(
            () => mockAuthRepository.resetPassword(
              token: any(named: 'token'),
              newPassword: any(named: 'newPassword'),
              confirmPassword: any(named: 'confirmPassword'),
            ),
          ).thenThrow(
            const RepositoryError('Invalid token', code: ErrorCode.badRequest),
          );

          return cubit;
        },
        act: (cubit) => cubit.resetPassword(
          token: TestConstants.testResetToken,
          newPassword: TestConstants.testNewPassword,
          confirmPassword: TestConstants.testNewPassword,
        ),
        expect: () => [
          isA<AuthState>().having((s) => s.isLoading, 'isLoading', true),
          isA<AuthState>()
              .having((s) => s.isFailure, 'isFailure', true)
              .having((s) => s.error, 'error', isA<RepositoryError>())
              .having(
                (s) => s.error?.message,
                'error.message',
                'Invalid token',
              ),
        ],
      );
    });

    group('reset', () {
      test('resets state to initial', () {
        // Arrange - modify state first
        cubit.emit(
          AuthState.success(
            User(
              id: TestConstants.testUserId,
              email: TestConstants.testUserEmail,
              name: TestConstants.testUserName,
              phone: Phone(
                countryCode: CountryCode.ID,
                number: TestConstants.testUserPhoneNumber,
              ),
              role: UserRole.USER,
              emailVerified: true,
              banned: false,
              userBadges: const [],
              createdAt: TestConstants.testCreatedAt,
              updatedAt: TestConstants.testUpdatedAt,
            ),
            message: 'Test',
          ),
        );

        expect(cubit.state.data, isNotNull);

        // Act
        cubit.reset();

        // Assert
        expect(cubit.state.isInitial, isTrue);
        expect(cubit.state.data, isNull);
      });
    });
  });
}
