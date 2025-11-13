import 'package:akademove/core/_export.dart';
import 'package:akademove/features/features.dart';
import 'package:api_client/api_client.dart';

class UserWalletTopUpCubit extends BaseCubit<UserWalletTopUpState> {
  UserWalletTopUpCubit({
    required WalletRepository walletRepository,
    required WebSocketService webSocketService,
  }) : _walletRepository = walletRepository,
       _webSocketService = webSocketService,
       super(UserWalletTopUpState());

  final WalletRepository _walletRepository;
  final WebSocketService _webSocketService;
  String? _paymentId;

  Future<void> init() async {
    reset();
  }

  void reset() {
    _paymentId = null;
    emit(UserWalletTopUpState());
  }

  @override
  Future<void> close() async {
    await teardownWebsocket();
    return super.close();
  }

  Future<void> topUp(int amount, TopUpRequestMethodEnum method) async {
    try {
      final methodName = getMethodName();
      if (state.checkAndAssignOperation(methodName)) return;
      emit(state.toLoading());
      final res = await _walletRepository.topUp(
        TopUpRequest(
          amount: amount,
          provider: PaymentProvider.MIDTRANS,
          method: method,
        ),
      );

      state.unAssignOperation(methodName);
      _paymentId = res.data.id;
      _setupPaymentWebsocket(paymentId: res.data.id);

      emit(state.toSuccess(paymentResult: res.data));
    } on BaseError catch (e, st) {
      logger.e(
        '[UserRideCubit] - Error: ${e.message}',
        error: e,
        stackTrace: st,
      );
    }
  }

  void _setupPaymentWebsocket({required String paymentId}) {
    _paymentId = paymentId;

    void handleMessage(Map<String, dynamic> json) {
      final data = WSPaymentEnvelope.fromJson(json);

      if (data.type == WSEnvelopeType.walletColonTopUpSuccess) {
        emit(
          state.toSuccess(
            transactionResult: data.payload.transaction,
            paymentResult: data.payload.payment,
          ),
        );
      }
      if (data.type == WSEnvelopeType.walletColonTopUpFailed) {
        emit(
          state.toSuccess(
            transactionResult: data.payload.transaction,
            paymentResult: data.payload.payment,
          ),
        );
        emit(state.toFailure(const UnknownError('Payment expired')));
      }
    }

    _webSocketService.connect(
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
    emit(state.toSuccess());
    reset();
  }
}
