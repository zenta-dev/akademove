import 'package:akademove/core/_export.dart';
import 'package:akademove/features/features.dart';
import 'package:api_client/api_client.dart';

class UserWalletTopUpCubit extends BaseCubit<UserWalletTopUpState> {
  UserWalletTopUpCubit({
    required WalletRepository walletRepository,
    required WebSocketService webSocketService,
  }) : _walletRepository = walletRepository,
       _webSocketService = webSocketService,
       super(const UserWalletTopUpState());

  final WalletRepository _walletRepository;
  final WebSocketService _webSocketService;
  String? _paymentId;

  Future<void> init() async {
    reset();
  }

  void reset() {
    _paymentId = null;
    emit(const UserWalletTopUpState());
  }

  @override
  Future<void> close() async {
    await teardownWebsocket();
    return super.close();
  }

  Future<void> topUp(
    int amount,
    TopUpRequestMethodEnum method, {
    BankProvider? bankProvider,
  }) async => await taskManager.execute('UWTPC-tU1', () async {
    try {
      emit(state.copyWith(payment: const OperationResult.loading()));
      final res = await _walletRepository.topUp(
        TopUpRequest(
          amount: amount,
          provider: PaymentProvider.MIDTRANS,
          method: method,
          bankProvider: bankProvider,
        ),
      );

      _paymentId = res.data.id;
      await _setupPaymentWebsocket(paymentId: res.data.id);

      emit(
        state.copyWith(
          payment: OperationResult.success(res.data, message: res.message),
        ),
      );
    } on BaseError catch (e, st) {
      logger.e(
        '[UserWalletTopUpCubit] - Error: ${e.message}',
        error: e,
        stackTrace: st,
      );
      emit(state.copyWith(payment: OperationResult.failed(e)));
    }
  });

  Future<void> _setupPaymentWebsocket({required String paymentId}) async {
    _paymentId = paymentId;

    void handleMessage(Map<String, dynamic> json) {
      final data = PaymentEnvelope.fromJson(json);

      if (data.e == PaymentEnvelopeEvent.TOP_UP_SUCCESS) {
        emit(
          state.copyWith(
            payment: OperationResult.success(data.p.payment),
            transaction: OperationResult.success(data.p.transaction),
            wallet: OperationResult.success(data.p.wallet),
          ),
        );
        return;
      }

      if (data.e == PaymentEnvelopeEvent.TOP_UP_FAILED) {
        emit(
          state.copyWith(
            payment: OperationResult.failed(
              const UnknownError('Top up failed'),
            ),
            transaction: OperationResult.success(data.p.transaction),
            wallet: OperationResult.success(data.p.wallet),
          ),
        );
        return;
      }
    }

    await _webSocketService.connect(
      paymentId,
      '${UrlConstants.wsBaseUrl}/payment/$paymentId',
      onMessage: (msg) {
        final json = (msg as String).parseJson();
        if (json is Map<String, dynamic>) handleMessage(json);
      },
    );
  }

  Future<void> teardownWebsocket() async {
    if (_paymentId != null) {
      await _webSocketService.disconnect(_paymentId ?? '');
    }
    // Just reset, don't emit success with no args as it might confuse state
    reset();
  }
}
