// ignore_for_file: avoid_catches_without_on_clauses

import 'dart:async';
import 'dart:io';
import 'package:akademove/core/_export.dart';
import 'package:flutter/widgets.dart';
import 'package:web_socket_channel/status.dart' as status;
import 'package:web_socket_channel/web_socket_channel.dart';

class WebSocketService with WidgetsBindingObserver {
  WebSocketService({
    this.maxReconnectAttempts = 5,
    this.initialReconnectDelay = const Duration(seconds: 1),
    this.maxReconnectDelay = const Duration(seconds: 30),
    this.useExponentialBackoff = true,
  }) {
    WidgetsBinding.instance.addObserver(this);
  }

  final Map<String, WebSocketChannel> _connections = {};
  final Map<String, StreamSubscription<dynamic>> _subscriptions = {};
  final Map<String, _ConnectionConfig> _configs = {};
  final Map<String, Timer> _reconnectTimers = {};
  final Map<String, int> _reconnectAttempts = {};

  String? sessionToken;
  bool _isPaused = false;

  final int maxReconnectAttempts;
  final Duration initialReconnectDelay;
  final Duration maxReconnectDelay;
  final bool useExponentialBackoff;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.paused:
      case AppLifecycleState.inactive:
      case AppLifecycleState.hidden:
        _pauseAllConnections();
      case AppLifecycleState.resumed:
        _resumeAllConnections();
      case AppLifecycleState.detached:
        // App is being terminated, dispose will handle cleanup
        break;
    }
  }

  void _pauseAllConnections() {
    if (_isPaused) return;
    _isPaused = true;
    _logInfo('ALL', 'App paused — suspending WebSocket connections');

    // Cancel all reconnect timers to prevent background reconnection attempts
    for (final timer in _reconnectTimers.values) {
      timer.cancel();
    }
    _reconnectTimers.clear();

    // Close all active connections gracefully
    for (final key in _connections.keys.toList()) {
      _closeConnectionWithoutRemovingConfig(key);
    }
  }

  Future<void> _resumeAllConnections() async {
    if (!_isPaused) return;
    _isPaused = false;
    _logInfo('ALL', 'App resumed — restoring WebSocket connections');

    // Reset reconnect attempts and re-establish all configured connections
    for (final key in _configs.keys.toList()) {
      _reconnectAttempts[key] = 0;
      _establishConnection(key);
    }
  }

  Future<void> _closeConnectionWithoutRemovingConfig(String key) async {
    try {
      _reconnectTimers[key]?.cancel();
      _reconnectTimers.remove(key);

      await _subscriptions[key]?.cancel();
      _subscriptions.remove(key);

      await _connections[key]?.sink.close(status.goingAway);
      _connections.remove(key);
    } catch (error) {
      _logDebug(key, 'Error during pause cleanup: $error');
    }
  }

  Future<void> connect(
    String key,
    String url, {
    void Function(dynamic msg)? onMessage,
    void Function()? onDone,
    void Function(Object error)? onError,
    bool autoReconnect = true,
  }) async {
    try {
      logger.d('[WebSocket:$key] Requested connection to $url');
      await disconnect(key);

      _configs[key] = _ConnectionConfig(
        url: url,
        onMessage: onMessage,
        onDone: onDone,
        onError: onError,
        autoReconnect: autoReconnect,
      );

      _reconnectAttempts[key] = 0;
      _logInfo(key, 'Initializing connection to $url');

      // Don't establish connection if app is paused
      if (_isPaused) {
        _logInfo(
          key,
          'App is paused — connection will be established on resume',
        );
        return;
      }

      _establishConnection(key);
    } catch (error, stackTrace) {
      _logError(key, 'Failed to connect', error: error, stackTrace: stackTrace);
    }
  }

  void _establishConnection(String key) {
    final config = _configs[key];
    if (config == null) return;

    try {
      var uri = Uri.parse(config.url);
      final existingParams = Map<String, String>.from(uri.queryParameters);

      final token = sessionToken;
      if (token != null) {
        existingParams['session-token'] = token;
      }
      uri = uri.replace(queryParameters: existingParams);

      _logInfo(key, 'Connecting → $uri');
      final channel = WebSocketChannel.connect(uri);
      _connections[key] = channel;

      // ignore: cancel_subscriptions
      final sub = channel.stream.listen(
        (data) {
          _reconnectAttempts[key] = 0;
          _logDebug(key, 'Message received: ${_truncate(data.toString())}');
          config.onMessage?.call(data);
        },
        onError: (Object? error, _) {
          _handleStreamError(key, error);
          if (error != null) {
            config.onError?.call(error);
          }
        },
        onDone: () {
          _logInfo(key, 'Connection closed (done event)');
          if (config.autoReconnect && _configs.containsKey(key)) {
            _scheduleReconnect(key);
          }
          config.onDone?.call();
        },
        cancelOnError: false,
      );

      _subscriptions[key] = sub;
      _logInfo(key, 'Connected successfully');
    } on SocketException catch (e, st) {
      _logError(
        key,
        'SocketException → likely DNS or network failure (${e.osError?.message ?? e.message})',
        error: e,
        stackTrace: st,
      );

      if (e.osError?.errorCode == 7) {
        _logError(key, 'Permanent DNS error — will not retry further.');
        return;
      }
      _scheduleReconnect(key);
    } on WebSocketChannelException catch (e, st) {
      _logError(key, 'WebSocket connection failed', error: e, stackTrace: st);
      _scheduleReconnect(key);
    } catch (error, stackTrace) {
      _logError(
        key,
        'Unexpected failure establishing connection',
        error: error,
        stackTrace: stackTrace,
      );
      _scheduleReconnect(key);
    }
  }

  void _handleStreamError(String key, Object? error) {
    _logError(key, 'Stream error', error: error);

    final config = _configs[key];
    if (config == null || !config.autoReconnect) return;

    if (error is SocketException) {
      if (error.osError?.errorCode == 7) {
        _logError(key, 'DNS lookup failed — stopping reconnect attempts.');
        return;
      }
    }

    _scheduleReconnect(key);
  }

  void _scheduleReconnect(String key) {
    final config = _configs[key];
    if (config == null || !config.autoReconnect) return;

    // Don't attempt reconnect if app is paused
    if (_isPaused) {
      _logDebug(key, 'App is paused — skipping reconnect attempt');
      return;
    }

    if (_reconnectTimers[key]?.isActive ?? false) return;

    final attempts = _reconnectAttempts[key] ?? 0;
    if (attempts >= maxReconnectAttempts) {
      _logError(
        key,
        'Max reconnect attempts ($maxReconnectAttempts) reached. Giving up.',
      );
      return;
    }

    final delay = useExponentialBackoff
        ? (initialReconnectDelay * (1 << attempts))
        : initialReconnectDelay;
    final boundedDelay = delay > maxReconnectDelay ? maxReconnectDelay : delay;

    _logInfo(
      key,
      'Reconnecting in ${boundedDelay.inSeconds}s (attempt ${attempts + 1}/$maxReconnectAttempts)',
    );

    _reconnectTimers[key] = Timer(boundedDelay, () async {
      // Double-check pause state when timer fires
      if (_isPaused) {
        _logDebug(key, 'App paused during reconnect delay — aborting');
        return;
      }

      _reconnectAttempts[key] = attempts + 1;

      _logDebug(key, 'Performing reconnect attempt ${attempts + 1}');
      try {
        await _subscriptions[key]?.cancel();
        await _connections[key]?.sink.close(status.goingAway);
      } catch (_) {}

      _subscriptions.remove(key);
      _connections.remove(key);
      _establishConnection(key);
    });
  }

  void send(String key, String message) {
    try {
      if (!_connections.containsKey(key)) {
        _logError(key, 'Send failed — no active connection.');
        return;
      }
      _logDebug(key, 'Sending message: ${_truncate(message)}');
      _connections[key]?.sink.add(message);
    } catch (error, stackTrace) {
      _logError(
        key,
        'Failed to send message',
        error: error,
        stackTrace: stackTrace,
      );
    }
  }

  Stream<dynamic>? stream(String key) => _connections[key]?.stream;

  bool isConnected(String key) => _connections.containsKey(key);

  int getReconnectAttempts(String key) => _reconnectAttempts[key] ?? 0;

  void resetReconnectAttempts(String key) => _reconnectAttempts[key] = 0;

  Future<void> disconnect(String key) async {
    try {
      _logInfo(key, 'Disconnecting...');
      _reconnectTimers[key]?.cancel();
      _reconnectTimers.remove(key);
      _configs.remove(key);
      _reconnectAttempts.remove(key);

      await _subscriptions[key]?.cancel();
      _subscriptions.remove(key);

      await _connections[key]?.sink.close(status.normalClosure);
      _connections.remove(key);

      _logInfo(key, 'Disconnected cleanly.');
    } catch (error, stackTrace) {
      _logError(
        key,
        'Failed to disconnect',
        error: error,
        stackTrace: stackTrace,
      );
    }
  }

  Future<void> dispose() async {
    try {
      _logInfo('ALL', 'Disposing WebSocketService...');

      // Remove lifecycle observer
      WidgetsBinding.instance.removeObserver(this);

      for (final timer in _reconnectTimers.values) {
        timer.cancel();
      }
      _reconnectTimers.clear();
      _configs.clear();
      _reconnectAttempts.clear();

      for (final key in _subscriptions.keys.toList()) {
        await _subscriptions[key]?.cancel();
      }
      _subscriptions.clear();

      for (final key in _connections.keys.toList()) {
        await _connections[key]?.sink.close(status.normalClosure);
      }
      _connections.clear();

      _logInfo('ALL', 'All connections closed successfully.');
    } catch (error, stackTrace) {
      _logError('ALL', 'Dispose failed', error: error, stackTrace: stackTrace);
    }
  }

  // ───────────────────────────────
  // Logging Helpers
  // ───────────────────────────────
  void _logInfo(String key, String msg) => logger.i('[WebSocket:$key] $msg');
  void _logDebug(String key, String msg) => logger.d('[WebSocket:$key] $msg');
  void _logError(
    String key,
    String msg, {
    Object? error,
    StackTrace? stackTrace,
  }) => logger.e('[WebSocket:$key] $msg', error: error, stackTrace: stackTrace);

  String _truncate(String text, {int max = 200}) =>
      (text.length <= max) ? text : '${text.substring(0, max)}...';
}

class _ConnectionConfig {
  _ConnectionConfig({
    required this.url,
    required this.autoReconnect,
    this.onMessage,
    this.onDone,
    this.onError,
  });

  final String url;
  final void Function(dynamic)? onMessage;
  final void Function()? onDone;
  final void Function(Object error)? onError;
  final bool autoReconnect;
}
