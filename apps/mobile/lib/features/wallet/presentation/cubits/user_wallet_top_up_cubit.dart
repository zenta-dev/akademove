import 'dart:async';

import 'package:akademove/core/_export.dart';
import 'package:akademove/features/features.dart';
import 'package:api_client/api_client.dart';

/// Cubit for handling wallet top-up with WebSocket-first approach and HTTP polling fallback.
///
/// This cubit implements a reliable WebSocket-first pattern:
/// 1. Connect to payment WebSocket to receive real-time status updates
/// 2. Set up health check timer to detect stale/failed WebSocket connections
/// 3. If WebSocket fails, fallback to HTTP polling to check wallet balance
/// 4. Stop polling when WebSocket recovers or payment is confirmed
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

  /// Timer for WebSocket health check
  Timer? _wsHealthCheckTimer;

  /// Timer for HTTP polling fallback
  Timer? _pollingTimer;

  /// Consecutive health check failures
  int _healthCheckFailures = 0;

  /// Initial wallet balance before top-up (for polling comparison)
  num? _initialWalletBalance;

  /// Expected top-up amount
  num? _expectedTopUpAmount;

  /// Whether polling fallback is active
  bool _isPollingActive = false;

  /// Health check interval in seconds (shorter for payment - user is waiting)
  static const int _wsHealthCheckIntervalSeconds = 10;

  /// Max consecutive health check failures before fallback
  static const int _maxHealthCheckFailures = 2;

  /// Polling interval in seconds
  static const int _pollingIntervalSeconds = 5;

  Future<void> init() async {
    reset();
  }

  void reset() {
    _stopHealthCheckTimer();
    _stopPollingFallback();
    _paymentId = null;
    _healthCheckFailures = 0;
    _initialWalletBalance = null;
    _expectedTopUpAmount = null;
    _isPollingActive = false;
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

      // Store initial wallet balance for polling comparison
      try {
        final walletRes = await _walletRepository.getWallet();
        _initialWalletBalance = walletRes.data.balance;
      } catch (e) {
        logger.w(
          '[UserWalletTopUpCubit] - Failed to get initial wallet balance',
          error: e,
        );
      }

      _expectedTopUpAmount = amount;

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

    // Set up WebSocket status listener for automatic fallback
    _webSocketService.setStatusListener(
      paymentId,
      _handleWebSocketStatusChange,
    );

    void handleMessage(Map<String, dynamic> json) {
      // Reset health check failures on any message received
      _healthCheckFailures = 0;

      // If we were polling, stop it since WebSocket is working
      if (_isPollingActive) {
        logger.i(
          '[UserWalletTopUpCubit] - WebSocket message received, stopping polling fallback',
        );
        _stopPollingFallback();
      }

      final data = PaymentEnvelope.fromJson(json);

      if (data.e == PaymentEnvelopeEvent.TOP_UP_SUCCESS) {
        _handleTopUpSuccess(data);
        return;
      }

      if (data.e == PaymentEnvelopeEvent.TOP_UP_FAILED) {
        _handleTopUpFailed(data);
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

    // Start health check timer
    _startHealthCheckTimer();
  }

  /// Handle WebSocket connection status changes
  void _handleWebSocketStatusChange(WebSocketConnectionStatus status) {
    logger.d('[UserWalletTopUpCubit] - WebSocket status changed: $status');

    switch (status) {
      case WebSocketConnectionStatus.connected:
        // WebSocket reconnected, stop polling if active
        _healthCheckFailures = 0;
        if (_isPollingActive) {
          logger.i(
            '[UserWalletTopUpCubit] - WebSocket reconnected, stopping polling fallback',
          );
          _stopPollingFallback();
        }
        // Restart health check timer
        _startHealthCheckTimer();

      case WebSocketConnectionStatus.failed:
        // WebSocket failed permanently, start polling fallback
        logger.w(
          '[UserWalletTopUpCubit] - WebSocket failed, starting polling fallback',
        );
        _startPollingFallback();

      case WebSocketConnectionStatus.reconnecting:
        // WebSocket is trying to reconnect, continue with current strategy
        logger.d('[UserWalletTopUpCubit] - WebSocket reconnecting...');

      case WebSocketConnectionStatus.disconnected:
      case WebSocketConnectionStatus.connecting:
        // Transitional states, no action needed
        break;
    }
  }

  void _handleTopUpSuccess(PaymentEnvelope data) {
    logger.i('[UserWalletTopUpCubit] - Top-up success received via WebSocket');

    // Stop all timers since payment is confirmed
    _stopHealthCheckTimer();
    _stopPollingFallback();

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

    // Stop all timers since payment is resolved
    _stopHealthCheckTimer();
    _stopPollingFallback();

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

  /// Start WebSocket health check timer
  void _startHealthCheckTimer() {
    _stopHealthCheckTimer();
    _wsHealthCheckTimer = Timer.periodic(
      Duration(seconds: _wsHealthCheckIntervalSeconds),
      (_) => _performHealthCheck(),
    );
  }

  /// Stop WebSocket health check timer
  void _stopHealthCheckTimer() {
    _wsHealthCheckTimer?.cancel();
    _wsHealthCheckTimer = null;
  }

  /// Perform WebSocket health check
  void _performHealthCheck() {
    final paymentId = _paymentId;
    if (paymentId == null) return;

    final isHealthy = _webSocketService.isConnectionHealthy(paymentId);

    if (!isHealthy) {
      _healthCheckFailures++;
      logger.d(
        '[UserWalletTopUpCubit] - WebSocket health check failed '
        '($_healthCheckFailures/$_maxHealthCheckFailures)',
      );

      if (_healthCheckFailures >= _maxHealthCheckFailures &&
          !_isPollingActive) {
        logger.w(
          '[UserWalletTopUpCubit] - Max health check failures reached, '
          'starting polling fallback',
        );
        _startPollingFallback();
      }
    } else {
      _healthCheckFailures = 0;
    }
  }

  /// Start HTTP polling fallback
  void _startPollingFallback() {
    if (_isPollingActive) return;

    _isPollingActive = true;
    logger.i('[UserWalletTopUpCubit] - Starting HTTP polling fallback');

    _pollingTimer = Timer.periodic(
      Duration(seconds: _pollingIntervalSeconds),
      (_) => _pollPaymentStatus(),
    );

    // Also poll immediately
    _pollPaymentStatus();
  }

  /// Stop HTTP polling fallback
  void _stopPollingFallback() {
    _pollingTimer?.cancel();
    _pollingTimer = null;
    _isPollingActive = false;
  }

  /// Poll wallet balance to detect successful top-up
  Future<void> _pollPaymentStatus() async {
    if (!_isPollingActive) return;

    try {
      logger.d('[UserWalletTopUpCubit] - Polling wallet balance...');

      final walletRes = await _walletRepository.getWallet();
      final currentBalance = walletRes.data.balance;
      final initialBalance = _initialWalletBalance;
      final expectedAmount = _expectedTopUpAmount;

      // Check if balance increased (top-up successful)
      if (initialBalance != null && expectedAmount != null) {
        final expectedBalance = initialBalance + expectedAmount;

        if (currentBalance >= expectedBalance) {
          logger.i(
            '[UserWalletTopUpCubit] - Top-up detected via polling! '
            'Balance: $initialBalance -> $currentBalance',
          );

          // Stop polling since we detected success
          _stopPollingFallback();
          _stopHealthCheckTimer();

          // Update the payment status and emit success with wallet
          // Note: We don't create a fake Transaction here since we don't have
          // the walletId. The real transaction will come from WebSocket or
          // can be fetched later. The important thing is we detected the
          // successful balance change.
          final currentPayment = state.payment.value;
          if (currentPayment != null) {
            emit(
              state.copyWith(
                payment: OperationResult.success(currentPayment),
                wallet: OperationResult.success(walletRes.data),
              ),
            );
          }
        }
      }
    } catch (e, st) {
      logger.e(
        '[UserWalletTopUpCubit] - Polling failed',
        error: e,
        stackTrace: st,
      );
      // Continue polling even on error - network might recover
    }
  }

  Future<void> teardownWebsocket() async {
    _stopHealthCheckTimer();
    _stopPollingFallback();

    if (_paymentId != null) {
      _webSocketService.removeStatusListener(_paymentId!);
      await _webSocketService.disconnect(_paymentId!);
    }

    _paymentId = null;
    _healthCheckFailures = 0;
    _initialWalletBalance = null;
    _expectedTopUpAmount = null;
    _isPollingActive = false;
  }
}
