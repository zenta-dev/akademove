import 'package:akademove/core/_export.dart';
import 'package:akademove/features/wallet/presentation/cubits/user_wallet_cubit.dart';
import 'package:akademove/features/wallet/presentation/states/_export.dart';
import 'package:api_client/api_client.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../helpers/mock_factories.dart';
import '../../../../helpers/test_constants.dart';

void main() {
  group('UserWalletCubit', () {
    late UserWalletCubit cubit;
    late MockWalletRepository mockWalletRepository;
    late MockTransactionRepository mockTransactionRepository;

    setUp(() {
      mockWalletRepository = MockWalletRepository();
      mockTransactionRepository = MockTransactionRepository();
      cubit = UserWalletCubit(
        walletRepository: mockWalletRepository,
        transactionRepository: mockTransactionRepository,
      );
    });

    tearDown(() {
      cubit.close();
    });

    test('initial state is correct', () {
      expect(cubit.state, isA<UserWalletState>());
      expect(cubit.state.myWallet, isNull);
      expect(cubit.state.myTransactions, isEmpty);
      expect(cubit.state.thisMonthSummary, isNull);
    });

    group('init', () {
      test(
        'calls getMine, getTransactionsMine, and getMonthlySummary in parallel',
        () async {
          // Arrange
          final wallet = Wallet(
            id: TestConstants.testWalletId,
            userId: TestConstants.testUserId,
            balance: TestConstants.testBalance,
            currency: Currency.IDR,
            isActive: true,
            createdAt: TestConstants.testCreatedAt,
            updatedAt: TestConstants.testUpdatedAt,
          );
          final transactions = <Transaction>[];
          final summary = WalletMonthlySummaryResponse(
            month: '1',
            totalIncome: 100000,
            totalExpense: 50000,
            net: 50000,
          );

          when(() => mockWalletRepository.getWallet()).thenAnswer(
            (_) async => SuccessResponse(message: 'Success', data: wallet),
          );
          when(() => mockTransactionRepository.list()).thenAnswer(
            (_) async =>
                SuccessResponse(message: 'Success', data: transactions),
          );
          when(
            () => mockWalletRepository.getMonthlySummary(
              month: any(named: 'month'),
              year: any(named: 'year'),
            ),
          ).thenAnswer(
            (_) async => SuccessResponse(message: 'Success', data: summary),
          );

          // Act
          await cubit.init();

          // Assert - all three methods should be called
          verify(() => mockWalletRepository.getWallet()).called(1);
          verify(() => mockTransactionRepository.list()).called(1);
          verify(
            () => mockWalletRepository.getMonthlySummary(
              month: any(named: 'month'),
              year: any(named: 'year'),
            ),
          ).called(1);
        },
      );
    });

    group('getMine', () {
      blocTest<UserWalletCubit, UserWalletState>(
        'emits [loading, success] when getMine succeeds',
        build: () {
          final wallet = Wallet(
            id: TestConstants.testWalletId,
            userId: TestConstants.testUserId,
            balance: TestConstants.testBalance,
            currency: Currency.IDR,
            isActive: true,
            createdAt: TestConstants.testCreatedAt,
            updatedAt: TestConstants.testUpdatedAt,
          );
          when(() => mockWalletRepository.getWallet()).thenAnswer(
            (_) async => SuccessResponse(message: 'Success', data: wallet),
          );
          return cubit;
        },
        act: (cubit) => cubit.getMine(),
        expect: () => [
          isA<UserWalletState>().having((s) => s.isLoading, 'isLoading', true),
          isA<UserWalletState>()
              .having((s) => s.isSuccess, 'isSuccess', true)
              .having((s) => s.myWallet, 'myWallet', isNotNull)
              .having(
                (s) => s.myWallet?.id,
                'myWallet.id',
                TestConstants.testWalletId,
              ),
        ],
        verify: (_) {
          verify(() => mockWalletRepository.getWallet()).called(1);
        },
      );

      test('deduplicates concurrent calls', () async {
        // Arrange
        final wallet = Wallet(
          id: TestConstants.testWalletId,
          userId: TestConstants.testUserId,
          balance: TestConstants.testBalance,
          currency: Currency.IDR,
          isActive: true,
          createdAt: TestConstants.testCreatedAt,
          updatedAt: TestConstants.testUpdatedAt,
        );
        when(() => mockWalletRepository.getWallet()).thenAnswer(
          (_) async {
            await Future<void>.delayed(const Duration(milliseconds: 50));
            return SuccessResponse(message: 'Success', data: wallet);
          },
        );

        // Act - fire multiple calls without awaiting
        cubit.getMine();
        cubit.getMine();
        await cubit.getMine();

        // Assert - should only call repository once due to operation deduplication
        verify(() => mockWalletRepository.getWallet()).called(1);
      });

      test('handles error gracefully (logs but does not emit failure)', () async {
        // Arrange
        when(() => mockWalletRepository.getWallet()).thenThrow(
          const RepositoryError('Failed to get wallet', code: ErrorCode.internalServerError),
        );

        // Act
        await cubit.getMine();

        // Assert - error is caught and logged, wallet remains null
        expect(cubit.state.myWallet, isNull);
      });
          when(() => mockWalletRepository.getWallet()).thenAnswer((_) async {
            await Future<void>.delayed(const Duration(milliseconds: 100));
            return SuccessResponse(message: 'Success', data: wallet);
          });
          return cubit;
        },
        act: (cubit) async {
          // Fire multiple calls without awaiting
          cubit.getMine();
          cubit.getMine();
          await cubit.getMine();
        },
        verify: (_) {
          // Should only call repository once due to operation deduplication
          verify(() => mockWalletRepository.getWallet()).called(1);
        },
      );

      blocTest<UserWalletCubit, UserWalletState>(
        'handles error gracefully',
        build: () {
          when(() => mockWalletRepository.getWallet()).thenThrow(
            const RepositoryError(
              'Failed to get wallet',
              code: ErrorCode.internalServerError,
            ),
          );
          return cubit;
        },
        act: (cubit) => cubit.getMine(),
        expect: () => [
          isA<UserWalletState>().having((s) => s.isLoading, 'isLoading', true),
          // Error is logged but state remains in loading
          isA<UserWalletState>().having((s) => s.isLoading, 'isLoading', true),
        ],
      );
    });

    group('getTransactionsMine', () {
      blocTest<UserWalletCubit, UserWalletState>(
        'emits [loading, success] when getTransactionsMine succeeds',
        build: () {
          final transactions = [
            Transaction(
              id: TestConstants.testTransactionId,
              walletId: TestConstants.testWalletId,
              type: TransactionType.TOPUP,
              status: TransactionStatus.SUCCESS,
              amount: 100000,
              createdAt: TestConstants.testCreatedAt,
              updatedAt: TestConstants.testUpdatedAt,
            ),
          ];
          when(() => mockTransactionRepository.list()).thenAnswer(
            (_) async =>
                SuccessResponse(message: 'Success', data: transactions),
          );
          return cubit;
        },
        act: (cubit) => cubit.getTransactionsMine(),
        expect: () => [
          isA<UserWalletState>().having((s) => s.isLoading, 'isLoading', true),
          isA<UserWalletState>()
              .having((s) => s.isSuccess, 'isSuccess', true)
              .having((s) => s.myTransactions, 'myTransactions', isNotEmpty)
              .having(
                (s) => s.myTransactions.length,
                'myTransactions.length',
                1,
              ),
        ],
        verify: (_) {
          verify(() => mockTransactionRepository.list()).called(1);
        },
      );

      blocTest<UserWalletCubit, UserWalletState>(
        'handles empty transaction list',
        build: () {
          when(() => mockTransactionRepository.list()).thenAnswer(
            (_) async => const SuccessResponse(message: 'Success', data: []),
          );
          return cubit;
        },
        act: (cubit) => cubit.getTransactionsMine(),
        expect: () => [
          isA<UserWalletState>().having((s) => s.isLoading, 'isLoading', true),
          isA<UserWalletState>()
              .having((s) => s.isSuccess, 'isSuccess', true)
              .having((s) => s.myTransactions, 'myTransactions', isEmpty),
        ],
      );
    });

    group('getMonthlySummary', () {
      blocTest<UserWalletCubit, UserWalletState>(
        'emits [loading, success] when getMonthlySummary succeeds',
        build: () {
          final summary = WalletMonthlySummaryResponse(
            month: '1',
            totalIncome: 500000,
            totalExpense: 100000,
            net: 400000,
          );
          when(
            () => mockWalletRepository.getMonthlySummary(
              month: any(named: 'month'),
              year: any(named: 'year'),
            ),
          ).thenAnswer(
            (_) async => SuccessResponse(message: 'Success', data: summary),
          );
          return cubit;
        },
        act: (cubit) => cubit.getMonthlySummary(),
        expect: () => [
          isA<UserWalletState>().having((s) => s.isLoading, 'isLoading', true),
          isA<UserWalletState>()
              .having((s) => s.isSuccess, 'isSuccess', true)
              .having((s) => s.thisMonthSummary, 'thisMonthSummary', isNotNull)
              .having(
                (s) => s.thisMonthSummary?.totalIncome,
                'totalIncome',
                500000,
              )
              .having((s) => s.thisMonthSummary?.net, 'net', 400000),
        ],
        verify: (_) {
          verify(
            () => mockWalletRepository.getMonthlySummary(
              month: any(named: 'month'),
              year: any(named: 'year'),
            ),
          ).called(1);
        },
      );

      blocTest<UserWalletCubit, UserWalletState>(
        'uses current month and year',
        build: () {
          final summary = WalletMonthlySummaryResponse(
            month: DateTime.now().month.toString(),
            totalIncome: 500000,
            totalExpense: 100000,
            net: 400000,
          );
          when(
            () => mockWalletRepository.getMonthlySummary(
              month: any(named: 'month'),
              year: any(named: 'year'),
            ),
          ).thenAnswer(
            (_) async => SuccessResponse(message: 'Success', data: summary),
          );
          return cubit;
        },
        act: (cubit) => cubit.getMonthlySummary(),
        verify: (_) {
          final now = DateTime.now();
          verify(
            () => mockWalletRepository.getMonthlySummary(
              month: now.month,
              year: now.year,
            ),
          ).called(1);
        },
      );
    });
  });
}
