import "package:akademove/core/_export.dart";
import "package:firebase_crashlytics/firebase_crashlytics.dart";
import "package:flutter/foundation.dart";
import "package:flutter/widgets.dart";

/// Global error handler that catches uncaught exceptions
/// and reports errors to Firebase Crashlytics for tracing.
class GlobalErrorHandler {
  GlobalErrorHandler._();

  static final GlobalErrorHandler _instance = GlobalErrorHandler._();
  static GlobalErrorHandler get instance => _instance;

  /// Global navigator key for accessing context from anywhere
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  /// Firebase Crashlytics instance
  late final FirebaseCrashlytics _crashlytics;

  /// The last error that occurred
  Object? _lastError;
  StackTrace? _lastStackTrace;
  String? _lastErrorCode;

  /// Initialize the global error handler
  /// Call this in bootstrap.dart after Firebase.initializeApp()
  Future<void> initialize() async {
    _crashlytics = FirebaseCrashlytics.instance;

    // Disable Crashlytics in debug mode to avoid noise
    await _crashlytics.setCrashlyticsCollectionEnabled(!kDebugMode);

    // Handle Flutter framework errors
    FlutterError.onError = _handleFlutterError;

    // Handle platform errors (Dart errors not caught by Flutter)
    PlatformDispatcher.instance.onError = _handlePlatformError;
  }

  /// Set user identifier for better error tracking
  Future<void> setUserId(String? userId) async {
    if (userId != null) {
      await _crashlytics.setUserIdentifier(userId);
    }
  }

  /// Set custom key-value pairs for better error context
  Future<void> setCustomKey(String key, Object value) async {
    await _crashlytics.setCustomKey(key, value);
  }

  /// Generate a unique error code for tracing
  /// Format: ERR-{timestamp}-{hash}
  /// Example: ERR-1702403821-A3F2
  String _generateErrorCode(Object error, StackTrace? stackTrace) {
    final timestamp = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    final errorHash = error.hashCode.abs().toRadixString(16).toUpperCase();
    final shortHash = errorHash.length > 4
        ? errorHash.substring(0, 4)
        : errorHash.padLeft(4, "0");
    return "ERR-$timestamp-$shortHash";
  }

  /// Extract location info from stack trace for better tracing
  String? _extractErrorLocation(StackTrace? stackTrace) {
    if (stackTrace == null) return null;

    final lines = stackTrace.toString().split("\n");
    for (final line in lines) {
      // Skip framework/package lines, look for app code
      if (line.contains("package:akademove/") &&
          !line.contains("global_error_handler")) {
        // Extract file and line number
        final match = RegExp(
          r"package:akademove/(.+\.dart):(\d+)",
        ).firstMatch(line);
        if (match != null) {
          return "${match.group(1)}:${match.group(2)}";
        }
      }
    }

    // Fallback: get the first meaningful line
    for (final line in lines) {
      if (line.trim().isNotEmpty &&
          !line.contains("<asynchronous suspension>")) {
        final match = RegExp(r"\((.+\.dart):(\d+)").firstMatch(line);
        if (match != null) {
          final file = match.group(1)?.split("/").last ?? "unknown";
          return "$file:${match.group(2)}";
        }
      }
    }

    return null;
  }

  /// Extract a clean error message
  String _extractErrorMessage(Object error) {
    if (error is BaseError) {
      return error.message ?? "An unexpected error occurred";
    }

    final errorString = error.toString();

    // Clean up common error prefixes
    if (errorString.startsWith("Exception: ")) {
      return errorString.substring(11);
    }
    if (errorString.startsWith("Error: ")) {
      return errorString.substring(7);
    }

    // Truncate very long messages
    if (errorString.length > 200) {
      return "${errorString.substring(0, 200)}...";
    }

    return errorString;
  }

  /// Report error to Firebase Crashlytics
  Future<void> _reportToCrashlytics({
    required Object error,
    required StackTrace? stackTrace,
    required String errorCode,
    String? location,
    bool fatal = false,
  }) async {
    try {
      // Set custom keys for better tracing
      await _crashlytics.setCustomKey("error_code", errorCode);
      if (location != null) {
        await _crashlytics.setCustomKey("error_location", location);
      }
      await _crashlytics.setCustomKey(
        "error_timestamp",
        DateTime.now().toIso8601String(),
      );

      // Record the error
      await _crashlytics.recordError(
        error,
        stackTrace ?? StackTrace.current,
        reason: "[$errorCode] ${_extractErrorMessage(error)}",
        fatal: fatal,
      );

      logger.d(
        "[GlobalErrorHandler] Error reported to Crashlytics: $errorCode",
      );
    } catch (e) {
      logger.w("[GlobalErrorHandler] Failed to report to Crashlytics: $e");
    }
  }

  /// Handle Flutter framework errors
  void _handleFlutterError(FlutterErrorDetails details) {
    final errorCode = _generateErrorCode(details.exception, details.stack);
    final location = _extractErrorLocation(details.stack);

    logger.e('''
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
💥 FLUTTER ERROR [$errorCode]
\tLocation: ${location ?? "unknown"}
\tException: ${details.exceptionAsString()}

\tStack Trace:
\t${details.stack}
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
''');

    _lastError = details.exception;
    _lastStackTrace = details.stack;
    _lastErrorCode = errorCode;

    // Report to Crashlytics
    _reportToCrashlytics(
      error: details.exception,
      stackTrace: details.stack,
      errorCode: errorCode,
      location: location,
      fatal: false,
    );
  }

  /// Handle platform/Dart errors
  bool _handlePlatformError(Object error, StackTrace stackTrace) {
    final errorCode = _generateErrorCode(error, stackTrace);
    final location = _extractErrorLocation(stackTrace);

    logger.e('''
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🔥 PLATFORM ERROR [$errorCode]
\tLocation: ${location ?? "unknown"}
\tError: $error

\tStack Trace:
\t$stackTrace
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
''');

    _lastError = error;
    _lastStackTrace = stackTrace;
    _lastErrorCode = errorCode;

    // Report to Crashlytics
    _reportToCrashlytics(
      error: error,
      stackTrace: stackTrace,
      errorCode: errorCode,
      location: location,
      fatal: true, // Platform errors are typically fatal
    );

    // Return true to prevent the error from propagating and crashing the app
    return true;
  }

  /// Handle errors from runZonedGuarded
  void handleZoneError(Object error, StackTrace stackTrace) {
    final errorCode = _generateErrorCode(error, stackTrace);
    final location = _extractErrorLocation(stackTrace);

    logger.e('''
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
⚡ ZONE ERROR [$errorCode]
\tLocation: ${location ?? "unknown"}
\tError: $error

\tStack Trace:
\t$stackTrace
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
''');

    _lastError = error;
    _lastStackTrace = stackTrace;
    _lastErrorCode = errorCode;

    // Report to Crashlytics
    _reportToCrashlytics(
      error: error,
      stackTrace: stackTrace,
      errorCode: errorCode,
      location: location,
      fatal: false,
    );
  }

  /// Manually report an error to Crashlytics
  void reportError(Object error, {StackTrace? stackTrace}) {
    final errorCode = _generateErrorCode(error, stackTrace);
    final location = _extractErrorLocation(stackTrace);

    _lastError = error;
    _lastStackTrace = stackTrace;
    _lastErrorCode = errorCode;

    logger.e('''
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📢 REPORTED ERROR [$errorCode]
\tLocation: ${location ?? "unknown"}
\tError: $error

\tStack Trace:
\t${stackTrace ?? "No stack trace available"}
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
''');

    // Report to Crashlytics
    _reportToCrashlytics(
      error: error,
      stackTrace: stackTrace,
      errorCode: errorCode,
      location: location,
      fatal: false,
    );
  }

  /// Log a non-fatal message to Crashlytics (for debugging)
  Future<void> log(String message) async {
    await _crashlytics.log(message);
  }

  /// Get the last error for debugging purposes
  Object? get lastError => _lastError;

  /// Get the last stack trace for debugging purposes
  StackTrace? get lastStackTrace => _lastStackTrace;

  /// Get the last error code for debugging purposes
  String? get lastErrorCode => _lastErrorCode;
}
