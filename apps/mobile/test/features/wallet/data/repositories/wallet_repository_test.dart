import 'package:akademove/core/_export.dart';
import 'package:akademove/features/wallet/data/repositories/wallet_repository.dart';
import 'package:api_client/api_client.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../helpers/mock_factories.dart';
import '../../../../helpers/test_constants.dart';

void main() {
  group('WalletRepository', () {
    late WalletRepository repository;
    late MockApiClient mockApiClient;
    late MockWalletApi mockWalletApi;

    setUp(() {
      mockApiClient = MockApiClient();
      mockWalletApi = MockWalletApi();
      when(() => mockApiClient.getWalletApi()).thenReturn(mockWalletApi);
      repository = WalletRepository(apiClient: mockApiClient);
    });

    group('getWallet', () {
      test('returns SuccessResponse when API call succeeds', () async {
        // Arrange
        final mockWallet = Wallet(
          id: TestConstants.testWalletId,
          userId: TestConstants.testUserId,
          balance: TestConstants.testBalance,
          currency: Currency.IDR,
          isActive: true,
          createdAt: TestConstants.testCreatedAt,
          updatedAt: TestConstants.testUpdatedAt,
        );
        final mockResponse = Response<WalletGet200Response>(
          data: WalletGet200Response(
            message: TestConstants.successMessage,
            data: mockWallet,
          ),
          statusCode: 200,
          requestOptions: RequestOptions(),
        );
        when(
          () => mockWalletApi.walletGet(),
        ).thenAnswer((_) async => mockResponse);

        // Act
        final result = await repository.getWallet();

        // Assert
        expect(result, isA<SuccessResponse<Wallet>>());
        expect(result.data.id, equals(TestConstants.testWalletId));
        expect(result.data.balance, equals(TestConstants.testBalance));
        expect(result.message, equals(TestConstants.successMessage));
        verify(() => mockWalletApi.walletGet()).called(1);
      });

      test('throws RepositoryError when API returns null data', () async {
        // Arrange
        final mockResponse = Response<WalletGet200Response>(
          data: null,
          statusCode: 200,
          requestOptions: RequestOptions(),
        );
        when(
          () => mockWalletApi.walletGet(),
        ).thenAnswer((_) async => mockResponse);

        // Act & Assert
        expect(
          () => repository.getWallet(),
          throwsA(
            isA<RepositoryError>()
                .having((e) => e.message, 'message', 'Wallet not found')
                .having((e) => e.code, 'code', ErrorCode.notFound),
          ),
        );
      });

      test('throws RepositoryError when DioException occurs', () async {
        // Arrange
        when(() => mockWalletApi.walletGet()).thenThrow(
          DioException(
            requestOptions: RequestOptions(),
            response: Response(
              requestOptions: RequestOptions(),
              statusCode: 500,
              data: {
                'message': 'Internal server error',
                'code': 'INTERNAL_SERVER_ERROR',
              },
            ),
          ),
        );

        // Act & Assert
        expect(() => repository.getWallet(), throwsA(isA<RepositoryError>()));
      });
    });

    group('getMonthlySummary', () {
      test('returns SuccessResponse with monthly data', () async {
        // Arrange
        const month = 1;
        const year = 2024;
        final mockSummary = WalletMonthlySummaryResponse(
          month: month.toString(),
          totalIncome: 500000,
          totalExpense: 100000,
          net: 400000,
        );
        final mockResponse = Response<WalletGetMonthlySummary200Response>(
          data: WalletGetMonthlySummary200Response(
            message: TestConstants.successMessage,
            data: mockSummary,
          ),
          statusCode: 200,
          requestOptions: RequestOptions(),
        );
        when(
          () => mockWalletApi.walletGetMonthlySummary(month: month, year: year),
        ).thenAnswer((_) async => mockResponse);

        // Act
        final result = await repository.getMonthlySummary(
          month: month,
          year: year,
        );

        // Assert
        expect(result, isA<SuccessResponse<WalletMonthlySummaryResponse>>());
        expect(result.data.totalIncome, equals(500000));
        expect(result.data.net, equals(400000));
        verify(
          () => mockWalletApi.walletGetMonthlySummary(month: month, year: year),
        ).called(1);
      });

      test('throws RepositoryError when API returns null data', () async {
        // Arrange
        const month = 1;
        const year = 2024;
        final mockResponse = Response<WalletGetMonthlySummary200Response>(
          data: null,
          statusCode: 200,
          requestOptions: RequestOptions(),
        );
        when(
          () => mockWalletApi.walletGetMonthlySummary(month: month, year: year),
        ).thenAnswer((_) async => mockResponse);

        // Act & Assert
        expect(
          () => repository.getMonthlySummary(month: month, year: year),
          throwsA(isA<RepositoryError>()),
        );
      });
    });

    group('topUp', () {
      test(
        'returns SuccessResponse with Payment when API call succeeds',
        () async {
          // Arrange
          final topUpRequest = TopUpRequest(
            amount: 100000,
            provider: PaymentProvider.MIDTRANS,
            method: TopUpRequestMethodEnum.QRIS,
          );
          final mockPayment = Payment(
            id: TestConstants.testPaymentId,
            transactionId: TestConstants.testTransactionId,
            provider: PaymentProvider.MIDTRANS,
            method: PaymentMethod.QRIS,
            status: TransactionStatus.PENDING,
            amount: 100000,
            createdAt: TestConstants.testCreatedAt,
            updatedAt: TestConstants.testUpdatedAt,
          );
          final mockResponse = Response<WalletTopUp200Response>(
            data: WalletTopUp200Response(
              message: TestConstants.successMessage,
              data: mockPayment,
            ),
            statusCode: 200,
            requestOptions: RequestOptions(),
          );
          when(
            () => mockWalletApi.walletTopUp(topUpRequest: topUpRequest),
          ).thenAnswer((_) async => mockResponse);

          // Act
          final result = await repository.topUp(topUpRequest);

          // Assert
          expect(result, isA<SuccessResponse<Payment>>());
          expect(result.data.id, equals(TestConstants.testPaymentId));
          expect(result.data.amount, equals(100000));
          verify(
            () => mockWalletApi.walletTopUp(topUpRequest: topUpRequest),
          ).called(1);
        },
      );

      test('throws RepositoryError when API returns null data', () async {
        // Arrange
        final topUpRequest = TopUpRequest(
          amount: 100000,
          provider: PaymentProvider.MIDTRANS,
          method: TopUpRequestMethodEnum.QRIS,
        );
        final mockResponse = Response<WalletTopUp200Response>(
          data: null,
          statusCode: 200,
          requestOptions: RequestOptions(),
        );
        when(
          () => mockWalletApi.walletTopUp(topUpRequest: topUpRequest),
        ).thenAnswer((_) async => mockResponse);

        // Act & Assert
        expect(
          () => repository.topUp(topUpRequest),
          throwsA(isA<RepositoryError>()),
        );
      });

      test('handles network errors gracefully', () async {
        // Arrange
        final topUpRequest = TopUpRequest(
          amount: 100000,
          provider: PaymentProvider.MIDTRANS,
          method: TopUpRequestMethodEnum.QRIS,
        );
        when(
          () => mockWalletApi.walletTopUp(topUpRequest: topUpRequest),
        ).thenThrow(
          DioException(
            requestOptions: RequestOptions(),
            type: DioExceptionType.connectionTimeout,
          ),
        );

        // Act & Assert
        expect(
          () => repository.topUp(topUpRequest),
          throwsA(isA<RepositoryError>()),
        );
      });
    });
  });
}

// Mock API class
class MockWalletApi extends Mock implements WalletApi {}
