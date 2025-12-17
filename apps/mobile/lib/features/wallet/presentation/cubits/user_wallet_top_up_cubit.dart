import 'dart:async';
import 'dart:convert';

import 'package:akademove/core/_export.dart';
import 'package:akademove/features/features.dart';
import 'package:api_client/api_client.dart';

/// Cubit for handling wallet top-up with WebSocket real-time updates.
///
/// This cubit implements a WebSocket-based pattern:
/// 1. Connect to payment WebSocket to receive real-time status updates
/// 2. All payment updates are pushed by the server via WebSocket
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

    // Set up WebSocket status listener
    _webSocketService.setStatusListener(
      paymentId,
      _handleWebSocketStatusChange,
    );

    void handleMessage(Map<String, dynamic> json) {
      final data = PaymentEnvelope.fromJson(json);

      if (data.e == PaymentEnvelopeEvent.TOP_UP_SUCCESS) {
        _handleTopUpSuccess(data);
        return;
      }

      if (data.e == PaymentEnvelopeEvent.TOP_UP_FAILED) {
        _handleTopUpFailed(data);
        return;
      }

      if (data.e == PaymentEnvelopeEvent.NEW_DATA) {
        _handleNewData(data);
        return;
      }

      if (data.e == PaymentEnvelopeEvent.NO_DATA) {
        logger.d('[UserWalletTopUpCubit] - No new data available');
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
      autoReconnect: true,
    );
  }

  /// Handle WebSocket connection status changes
  void _handleWebSocketStatusChange(WebSocketConnectionStatus status) {
    logger.d('[UserWalletTopUpCubit] - WebSocket status changed: $status');

    switch (status) {
      case WebSocketConnectionStatus.connected:
        logger.i('[UserWalletTopUpCubit] - WebSocket connected');
        // Request initial payment status after connection is established
        _requestInitialData();

      case WebSocketConnectionStatus.failed:
        logger.w('[UserWalletTopUpCubit] - WebSocket failed');

      case WebSocketConnectionStatus.reconnecting:
        logger.d('[UserWalletTopUpCubit] - WebSocket reconnecting...');

      case WebSocketConnectionStatus.disconnected:
      case WebSocketConnectionStatus.connecting:
        // Transitional states, no action needed
        break;
    }
  }

  /// Request initial payment status after WebSocket connection is established
  /// This ensures we get the current payment status if it changed before client connected
  void _requestInitialData() {
    final paymentId = _paymentId;
    if (paymentId == null) return;

    try {
      final envelope = PaymentEnvelope(
        f: EnvelopeSender.c,
        t: EnvelopeSender.s,
        a: PaymentEnvelopeAction.CHECK_NEW_DATA,
        p: PaymentEnvelopePayload(
          syncRequest: PaymentEnvelopePayloadSyncRequest(paymentId: paymentId),
        ),
      );

      _webSocketService.send(paymentId, jsonEncode(envelope.toJson()));
      logger.i(
        '[UserWalletTopUpCubit] - Requested initial data via CHECK_NEW_DATA',
      );
    } catch (e, st) {
      logger.e(
        '[UserWalletTopUpCubit] - Failed to request initial data',
        error: e,
        stackTrace: st,
      );
    }
  }

  void _handleTopUpSuccess(PaymentEnvelope data) {
    logger.i('[UserWalletTopUpCubit] - Top-up success received via WebSocket');

    final payment = data.p.payment;
    final transaction = data.p.transaction;
    final wallet = data.p.wallet;

    emit(
      state.copyWith(
        payment: payment != null
            ? OperationResult.success(payment)
            : state.payment,
        transaction: transaction != null
            ? OperationResult.success(transaction)
            : state.transaction,
        wallet: wallet != null ? OperationResult.success(wallet) : state.wallet,
      ),
    );
  }

  void _handleTopUpFailed(PaymentEnvelope data) {
    logger.i('[UserWalletTopUpCubit] - Top-up failed received via WebSocket');

    final transaction = data.p.transaction;
    final wallet = data.p.wallet;

    emit(
      state.copyWith(
        payment: OperationResult.failed(const UnknownError('Top up failed')),
        transaction: transaction != null
            ? OperationResult.success(transaction)
            : state.transaction,
        wallet: wallet != null ? OperationResult.success(wallet) : state.wallet,
      ),
    );
  }

  /// Handle NEW_DATA event - update payment status from server
  void _handleNewData(PaymentEnvelope data) {
    logger.i('[UserWalletTopUpCubit] - Received NEW_DATA from server');

    final payment = data.p.payment;
    final transaction = data.p.transaction;
    final wallet = data.p.wallet;

    // Check if payment status indicates success or failure
    if (payment != null) {
      if (payment.status == TransactionStatus.SUCCESS) {
        _handleTopUpSuccess(data);
        return;
      }

      if (payment.status == TransactionStatus.FAILED ||
          payment.status == TransactionStatus.EXPIRED) {
        _handleTopUpFailed(data);
        return;
      }
    }

    // Update state with current data (payment still pending)
    emit(
      state.copyWith(
        payment: payment != null
            ? OperationResult.success(payment)
            : state.payment,
        transaction: transaction != null
            ? OperationResult.success(transaction)
            : state.transaction,
        wallet: wallet != null ? OperationResult.success(wallet) : state.wallet,
      ),
    );
  }

  Future<void> teardownWebsocket() async {
    if (_paymentId != null) {
      _webSocketService.removeStatusListener(_paymentId!);
      await _webSocketService.disconnect(_paymentId!);
    }

    _paymentId = null;
  }
}
