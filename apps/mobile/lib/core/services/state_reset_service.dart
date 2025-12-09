import "package:akademove/core/_export.dart";

/// Service responsible for resetting all user-specific state on logout.
/// This includes clearing WebSocket connections, local storage,
/// and notifying cubits to reset their state.
class StateResetService {
  StateResetService({
    required WebSocketService webSocketService,
    required KeyValueService keyValueService,
  }) : _webSocketService = webSocketService,
       _keyValueService = keyValueService;

  final WebSocketService _webSocketService;
  final KeyValueService _keyValueService;

  /// Reset all user-specific state.
  /// Should be called during logout process.
  Future<void> resetAll() async {
    logger.i("[StateResetService] Starting full state reset...");

    await Future.wait([_clearWebSocketConnections(), _clearUserLocalStorage()]);

    logger.i("[StateResetService] Full state reset completed");
  }

  /// Disconnect all active WebSocket connections
  Future<void> _clearWebSocketConnections() async {
    try {
      await _webSocketService.dispose();
      logger.i("[StateResetService] WebSocket connections cleared");
    } catch (e, st) {
      logger.e(
        "[StateResetService] Failed to clear WebSocket connections",
        error: e,
        stackTrace: st,
      );
    }
  }

  /// Clear user-specific data from local storage.
  /// Preserves user preferences (theme, locale).
  Future<void> _clearUserLocalStorage() async {
    try {
      // Clear user-specific keys, preserve preferences
      await Future.wait([
        _keyValueService.remove(KeyValueKeys.cart),
        _keyValueService.remove(KeyValueKeys.fcmToken),
      ]);
      logger.i("[StateResetService] User local storage cleared");
    } catch (e, st) {
      logger.e(
        "[StateResetService] Failed to clear user local storage",
        error: e,
        stackTrace: st,
      );
    }
  }
}
