import 'dart:async';
import 'dart:convert';
import 'package:akademove/core/_export.dart';

/// Configuration for WebSocket sync behavior
class WebSocketSyncConfig {
  const WebSocketSyncConfig({
    this.syncIntervalSeconds = 3,
    this.maxNoDataCount = 5,
    this.resetNoDataOnNewData = true,
  });

  /// Interval between CHECK_NEW_DATA requests in seconds
  final int syncIntervalSeconds;

  /// Number of consecutive NO_DATA responses before HTTP fallback
  final int maxNoDataCount;

  /// Whether to reset NO_DATA counter when NEW_DATA is received
  final bool resetNoDataOnNewData;
}

/// Callback for when HTTP fallback should be triggered
typedef HttpFallbackCallback = Future<void> Function();

/// Callback for when new data is received via WebSocket
typedef NewDataCallback<T> = void Function(T data);

/// Service to manage WebSocket-based data synchronization
/// Replaces HTTP polling with WebSocket CHECK_NEW_DATA pattern
///
/// Usage:
/// ```dart
/// final syncService = WebSocketSyncService<OrderEnvelope>(
///   webSocketService: wsService,
///   connectionKey: 'order-room',
///   config: const WebSocketSyncConfig(syncIntervalSeconds: 3),
///   buildCheckNewDataMessage: () => {
///     'a': 'CHECK_NEW_DATA',
///     'f': 'c',
///     't': 's',
///     'p': {'syncRequest': {'orderId': orderId, 'lastKnownVersion': version}}
///   },
///   isNewDataEvent: (data) => data['e'] == 'NEW_DATA',
///   isNoDataEvent: (data) => data['e'] == 'NO_DATA',
///   parseNewData: (data) => OrderEnvelope.fromJson(data),
///   onNewData: (envelope) => handleNewData(envelope),
///   onHttpFallback: () => fetchViaHttp(),
/// );
/// syncService.start();
/// ```
class WebSocketSyncService<T> {
  WebSocketSyncService({
    required WebSocketService webSocketService,
    required String connectionKey,
    required Map<String, Object?> Function() buildCheckNewDataMessage,
    required bool Function(Map<String, Object?> data) isNewDataEvent,
    required bool Function(Map<String, Object?> data) isNoDataEvent,
    required T Function(Map<String, Object?> data) parseNewData,
    required NewDataCallback<T> onNewData,
    required HttpFallbackCallback onHttpFallback,
    WebSocketSyncConfig config = const WebSocketSyncConfig(),
    void Function(String? version)? onVersionUpdate,
  }) : _webSocketService = webSocketService,
       _connectionKey = connectionKey,
       _buildCheckNewDataMessage = buildCheckNewDataMessage,
       _isNewDataEvent = isNewDataEvent,
       _isNoDataEvent = isNoDataEvent,
       _parseNewData = parseNewData,
       _onNewData = onNewData,
       _onHttpFallback = onHttpFallback,
       _onVersionUpdate = onVersionUpdate,
       _config = config;

  final WebSocketService _webSocketService;
  final String _connectionKey;
  final Map<String, Object?> Function() _buildCheckNewDataMessage;
  final bool Function(Map<String, Object?> data) _isNewDataEvent;
  final bool Function(Map<String, Object?> data) _isNoDataEvent;
  final T Function(Map<String, Object?> data) _parseNewData;
  final NewDataCallback<T> _onNewData;
  final HttpFallbackCallback _onHttpFallback;
  final void Function(String? version)? _onVersionUpdate;
  final WebSocketSyncConfig _config;

  Timer? _syncTimer;
  StreamSubscription<Object?>? _wsSubscription;
  int _consecutiveNoDataCount = 0;
  String? _lastKnownVersion;
  bool _isRunning = false;
  bool _isFallbackMode = false;

  /// Current version being tracked
  String? get lastKnownVersion => _lastKnownVersion;

  /// Number of consecutive NO_DATA responses
  int get consecutiveNoDataCount => _consecutiveNoDataCount;

  /// Whether the service is currently running
  bool get isRunning => _isRunning;

  /// Whether we're in HTTP fallback mode
  bool get isFallbackMode => _isFallbackMode;

  /// Update the last known version (e.g., from initial HTTP fetch)
  void setLastKnownVersion(String? version) {
    _lastKnownVersion = version;
    _onVersionUpdate?.call(version);
  }

  /// Start the sync service
  void start() {
    if (_isRunning) {
      logger.d('[WebSocketSyncService:$_connectionKey] Already running');
      return;
    }

    logger.i(
      '[WebSocketSyncService:$_connectionKey] Starting with '
      '${_config.syncIntervalSeconds}s interval',
    );

    _isRunning = true;
    _consecutiveNoDataCount = 0;
    _isFallbackMode = false;

    // Listen to WebSocket messages
    _wsSubscription = _webSocketService
        .stream(_connectionKey)
        ?.listen(
          _handleWebSocketMessage,
          onError: (Object error) {
            logger.e(
              '[WebSocketSyncService:$_connectionKey] Stream error',
              error: error,
            );
            _triggerFallback();
          },
        );

    // Start periodic sync
    _syncTimer = Timer.periodic(
      Duration(seconds: _config.syncIntervalSeconds),
      (_) => _sendCheckNewData(),
    );

    // Send initial check immediately
    _sendCheckNewData();
  }

  /// Stop the sync service
  void stop() {
    if (!_isRunning) return;

    logger.i('[WebSocketSyncService:$_connectionKey] Stopping');

    _isRunning = false;
    _syncTimer?.cancel();
    _syncTimer = null;
    _wsSubscription?.cancel();
    _wsSubscription = null;
    _consecutiveNoDataCount = 0;
    _isFallbackMode = false;
  }

  /// Reset the NO_DATA counter (e.g., after successful HTTP fallback)
  void resetNoDataCounter() {
    _consecutiveNoDataCount = 0;
    _isFallbackMode = false;
    logger.d('[WebSocketSyncService:$_connectionKey] NO_DATA counter reset');
  }

  /// Force an immediate check (e.g., after user action)
  void checkNow() {
    if (!_isRunning) return;
    _sendCheckNewData();
  }

  void _sendCheckNewData() {
    if (!_webSocketService.isConnectionHealthy(_connectionKey)) {
      logger.d(
        '[WebSocketSyncService:$_connectionKey] Connection not healthy, '
        'skipping CHECK_NEW_DATA',
      );
      _triggerFallback();
      return;
    }

    final message = _buildCheckNewDataMessage();
    final jsonStr = jsonEncode(message);

    logger.d(
      '[WebSocketSyncService:$_connectionKey] Sending CHECK_NEW_DATA '
      '(version: $_lastKnownVersion)',
    );

    _webSocketService.send(_connectionKey, jsonStr);
  }

  void _handleWebSocketMessage(Object? message) {
    if (message == null) return;

    try {
      final data = message is String
          ? jsonDecode(message) as Map<String, Object?>
          : message as Map<String, Object?>;

      if (_isNewDataEvent(data)) {
        _handleNewData(data);
      } else if (_isNoDataEvent(data)) {
        _handleNoData(data);
      }
      // Other events are handled by the main WebSocket handler
    } catch (e, st) {
      logger.e(
        '[WebSocketSyncService:$_connectionKey] Failed to parse message',
        error: e,
        stackTrace: st,
      );
    }
  }

  void _handleNewData(Map<String, Object?> data) {
    logger.d('[WebSocketSyncService:$_connectionKey] Received NEW_DATA');

    // Reset NO_DATA counter on successful data receipt
    if (_config.resetNoDataOnNewData) {
      _consecutiveNoDataCount = 0;
      _isFallbackMode = false;
    }

    // Extract version from syncRequest if present
    final payload = data['p'] as Map<String, Object?>?;
    final syncRequest = payload?['syncRequest'] as Map<String, Object?>?;
    final newVersion = syncRequest?['lastKnownVersion'] as String?;

    if (newVersion != null) {
      _lastKnownVersion = newVersion;
      _onVersionUpdate?.call(newVersion);
    }

    // Parse and deliver the data
    try {
      final parsedData = _parseNewData(data);
      _onNewData(parsedData);
    } catch (e, st) {
      logger.e(
        '[WebSocketSyncService:$_connectionKey] Failed to parse NEW_DATA',
        error: e,
        stackTrace: st,
      );
    }
  }

  void _handleNoData(Map<String, Object?> data) {
    _consecutiveNoDataCount++;

    // Extract version from syncRequest if present
    final payload = data['p'] as Map<String, Object?>?;
    final syncRequest = payload?['syncRequest'] as Map<String, Object?>?;
    final version = syncRequest?['lastKnownVersion'] as String?;

    if (version != null && _lastKnownVersion != version) {
      _lastKnownVersion = version;
      _onVersionUpdate?.call(version);
    }

    logger.d(
      '[WebSocketSyncService:$_connectionKey] Received NO_DATA '
      '($_consecutiveNoDataCount/${_config.maxNoDataCount})',
    );

    if (_consecutiveNoDataCount >= _config.maxNoDataCount) {
      _triggerFallback();
    }
  }

  void _triggerFallback() {
    if (_isFallbackMode) return;

    _isFallbackMode = true;
    logger.i(
      '[WebSocketSyncService:$_connectionKey] Triggering HTTP fallback '
      '(NO_DATA count: $_consecutiveNoDataCount)',
    );

    // Execute fallback asynchronously
    _onHttpFallback()
        .then((_) {
          // Reset counter after successful fallback
          _consecutiveNoDataCount = 0;
          _isFallbackMode = false;
          logger.d(
            '[WebSocketSyncService:$_connectionKey] HTTP fallback completed',
          );
        })
        .catchError((Object e, StackTrace st) {
          logger.e(
            '[WebSocketSyncService:$_connectionKey] HTTP fallback failed',
            error: e,
            stackTrace: st,
          );
          // Keep fallback mode to prevent immediate retry
        });
  }

  /// Dispose the service
  void dispose() {
    stop();
  }
}
