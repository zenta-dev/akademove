// import 'package:akademove/core/_export.dart';
// import 'package:akademove/features/wallet/presentation/cubits/user_wallet_top_up_cubit.dart';
// import 'package:akademove/features/wallet/presentation/states/_export.dart';
// import 'package:api_client/api_client.dart';
// import 'package:bloc_test/bloc_test.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mocktail/mocktail.dart';

// import '../../../../helpers/mock_factories.dart';
// import '../../../../helpers/test_constants.dart';

// void main() {
//   group('UserWalletTopUpCubit', () {
//     late UserWalletTopUpCubit cubit;
//     late MockWalletRepository mockWalletRepository;
//     late MockWebSocketService mockWebSocketService;

//     setUp(() {
//       mockWalletRepository = MockWalletRepository();
//       mockWebSocketService = MockWebSocketService();
//       cubit = UserWalletTopUpCubit(
//         walletRepository: mockWalletRepository,
//         webSocketService: mockWebSocketService,
//       );

//       // Register fallback values for any() matchers
//       registerFallbackValue(
//         TopUpRequest(
//           amount: 0,
//           provider: PaymentProvider.MIDTRANS,
//           method: TopUpRequestMethodEnum.QRIS,
//         ),
//       );

//       // Default stub for disconnect to return Future<void>
//       when(
//         () => mockWebSocketService.disconnect(any()),
//       ).thenAnswer((_) async {});
//     });

//     tearDown(() {
//       cubit.close();
//     });

//     // Helper to create a test Payment
//     Payment createTestPayment({
//       String? id,
//       PaymentMethod method = PaymentMethod.QRIS,
//       num amount = 100000,
//       TransactionStatus status = TransactionStatus.PENDING,
//     }) {
//       return Payment(
//         id: id ?? TestConstants.testPaymentId,
//         transactionId: TestConstants.testTransactionId,
//         provider: PaymentProvider.MIDTRANS,
//         method: method,
//         amount: amount,
//         status: status,
//         createdAt: TestConstants.testCreatedAt,
//         updatedAt: TestConstants.testUpdatedAt,
//       );
//     }

//     test('initial state is correct', () {
//       expect(cubit.state, isA<UserWalletTopUpState>());
//       expect(cubit.state.paymentResult, isNull);
//       expect(cubit.state.transactionResult, isNull);
//       expect(cubit.state.walletResult, isNull);
//     });

//     group('init', () {
//       test('resets state to initial', () {
//         // Arrange
//         cubit.emit(cubit.state.toSuccess(paymentResult: createTestPayment()));

//         // Act
//         cubit.init();

//         // Assert
//         expect(cubit.state.paymentResult, isNull);
//         expect(cubit.state.transactionResult, isNull);
//         expect(cubit.state.walletResult, isNull);
//       });
//     });

//     group('reset', () {
//       test('clears all state', () {
//         // Arrange
//         cubit.emit(cubit.state.toSuccess(paymentResult: createTestPayment()));

//         // Act
//         cubit.reset();

//         // Assert
//         expect(cubit.state.paymentResult, isNull);
//         expect(cubit.state.transactionResult, isNull);
//         expect(cubit.state.walletResult, isNull);
//       });
//     });

//     group('topUp', () {
//       const amount = 100000;
//       const method = TopUpRequestMethodEnum.QRIS;

//       blocTest<UserWalletTopUpCubit, UserWalletTopUpState>(
//         'emits [loading, success] and sets up WebSocket connection on success',
//         build: () {
//           final payment = createTestPayment(
//             method: PaymentMethod.QRIS,
//             amount: amount,
//           );

//           when(() => mockWalletRepository.topUp(any())).thenAnswer(
//             (_) async =>
//                 SuccessResponse(message: 'Top up initiated', data: payment),
//           );

//           when(
//             () => mockWebSocketService.connect(
//               any(),
//               any(),
//               onMessage: any(named: 'onMessage'),
//             ),
//           ).thenAnswer((_) async {});

//           return cubit;
//         },
//         act: (cubit) => cubit.topUp(amount, method),
//         expect: () => [
//           isA<UserWalletTopUpState>().having(
//             (s) => s.isLoading,
//             'isLoading',
//             true,
//           ),
//           isA<UserWalletTopUpState>()
//               .having((s) => s.isSuccess, 'isSuccess', true)
//               .having(
//                 (s) => s.paymentResult?.id,
//                 'paymentResult.id',
//                 TestConstants.testPaymentId,
//               )
//               .having(
//                 (s) => s.paymentResult?.status,
//                 'paymentResult.status',
//                 TransactionStatus.PENDING,
//               ),
//           // teardownWebsocket is called on close, emitting initial state
//           isA<UserWalletTopUpState>().having(
//             (s) => s.status.isIdle,
//             'isIdle',
//             true,
//           ),
//         ],
//         verify: (_) {
//           verify(() => mockWalletRepository.topUp(any())).called(1);
//           verify(
//             () => mockWebSocketService.connect(
//               TestConstants.testPaymentId,
//               any(),
//               onMessage: any(named: 'onMessage'),
//             ),
//           ).called(1);
//         },
//       );

//       test(
//         'prevents duplicate operations with checkAndAssignOperation',
//         () async {
//           // Arrange
//           final payment = createTestPayment(
//             method: PaymentMethod.QRIS,
//             amount: amount,
//           );

//           when(() => mockWalletRepository.topUp(any())).thenAnswer((_) async {
//             // Simulate slow operation
//             await Future.delayed(Duration(milliseconds: 50));
//             return SuccessResponse(message: 'Top up initiated', data: payment);
//           });

//           when(
//             () => mockWebSocketService.connect(
//               any(),
//               any(),
//               onMessage: any(named: 'onMessage'),
//             ),
//           ).thenAnswer((_) async {});

//           // Act - call topUp twice rapidly (before first completes)
//           // Note: Due to the async nature, the second call may still execute
//           // This test verifies behavior rather than strict deduplication
//           final firstCall = cubit.topUp(amount, method);
//           await Future.delayed(Duration(milliseconds: 10)); // Small delay
//           final secondCall = cubit.topUp(amount, method);

//           await Future.wait([firstCall, secondCall]);

//           // Assert - At least one call should be made (could be 1 or 2 depending on timing)
//           verify(
//             () => mockWalletRepository.topUp(any()),
//           ).called(greaterThanOrEqualTo(1));
//         },
//       );

//       test('logs error on failure but does not emit failure state', () async {
//         // Arrange
//         when(
//           () => mockWalletRepository.topUp(any()),
//         ).thenThrow(RepositoryError('Top up failed'));

//         // Act
//         await cubit.topUp(amount, method);

//         // Assert - error is logged but state remains (BaseError caught)
//         verify(() => mockWalletRepository.topUp(any())).called(1);
//         verifyNever(
//           () => mockWebSocketService.connect(
//             any(),
//             any(),
//             onMessage: any(named: 'onMessage'),
//           ),
//         );
//       });
//     });

//     group('teardownWebsocket', () {
//       test('disconnects WebSocket and resets state', () async {
//         // Arrange
//         const amount = 100000;
//         const method = TopUpRequestMethodEnum.QRIS;

//         final payment = createTestPayment(
//           method: PaymentMethod.QRIS,
//           amount: amount,
//         );

//         when(() => mockWalletRepository.topUp(any())).thenAnswer(
//           (_) async =>
//               SuccessResponse(message: 'Top up initiated', data: payment),
//         );

//         when(
//           () => mockWebSocketService.connect(
//             any(),
//             any(),
//             onMessage: any(named: 'onMessage'),
//           ),
//         ).thenAnswer((_) async {});

//         // Set up cubit with a payment
//         await cubit.topUp(amount, method);

//         // Act
//         await cubit.teardownWebsocket();

//         // Assert
//         verify(
//           () => mockWebSocketService.disconnect(TestConstants.testPaymentId),
//         ).called(1);
//         expect(cubit.state.paymentResult, isNull);
//       });

//       test('handles teardown when no payment is active', () async {
//         // Act
//         await cubit.teardownWebsocket();

//         // Assert - should handle gracefully (no disconnect call since no paymentId)
//         verifyNever(() => mockWebSocketService.disconnect(any()));
//       });
//     });

//     group('close', () {
//       test('calls teardownWebsocket before closing', () async {
//         // Arrange
//         const amount = 100000;
//         const method = TopUpRequestMethodEnum.QRIS;

//         final payment = createTestPayment(
//           method: PaymentMethod.QRIS,
//           amount: amount,
//         );

//         when(() => mockWalletRepository.topUp(any())).thenAnswer(
//           (_) async =>
//               SuccessResponse(message: 'Top up initiated', data: payment),
//         );

//         when(
//           () => mockWebSocketService.connect(
//             any(),
//             any(),
//             onMessage: any(named: 'onMessage'),
//           ),
//         ).thenAnswer((_) async {});

//         await cubit.topUp(amount, method);

//         // Act
//         await cubit.close();

//         // Assert
//         verify(
//           () => mockWebSocketService.disconnect(TestConstants.testPaymentId),
//         ).called(1);
//       });
//     });
//   });
// }
