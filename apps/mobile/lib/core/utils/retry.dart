// ignore_for_file: avoid_catches_without_on_clauses

import 'package:akademove/core/_export.dart';
import 'package:dio/dio.dart';

/// Configuration for retry logic
class RetryConfig {
  const RetryConfig({
    this.maxAttempts = 3,
    this.initialDelayMs = 1000,
    this.maxDelayMs = 30000,
    this.exponentialBackoff = true,
    this.retryOnNetworkError = true,
    this.retryOnTimeout = true,
    this.retryOnServerError = true,
  });

  /// Maximum number of retry attempts (default: 3)
  final int maxAttempts;

  /// Initial delay before first retry in milliseconds (default: 1000ms = 1s)
  final int initialDelayMs;

  /// Maximum delay between retries in milliseconds (default: 30000ms = 30s)
  final int maxDelayMs;

  /// Use exponential backoff (delay doubles each attempt)
  final bool exponentialBackoff;

  /// Retry on network errors (no internet, DNS failure, etc.)
  final bool retryOnNetworkError;

  /// Retry on timeout errors
  final bool retryOnTimeout;

  /// Retry on server errors (5xx)
  final bool retryOnServerError;

  /// Default retry configuration
  static const defaultConfig = RetryConfig();

  /// Aggressive retry configuration (more attempts, faster initial retry)
  static const aggressive = RetryConfig(maxAttempts: 5, initialDelayMs: 500);

  /// Conservative retry configuration (fewer attempts, longer delays)
  static const conservative = RetryConfig(maxAttempts: 2, initialDelayMs: 2000);
}

/// Executes an async function with automatic retry logic
///
/// Usage:
/// ```dart
/// final result = await retry(
///   () => apiClient.getData(),
///   config: RetryConfig.defaultConfig,
/// );
/// ```
Future<T> retry<T>(
  Future<T> Function() action, {
  RetryConfig config = RetryConfig.defaultConfig,
  void Function(int attempt, Object error)? onRetry,
}) async {
  var attempt = 0;
  var delayMs = config.initialDelayMs;

  while (true) {
    attempt++;

    try {
      return await action();
    } catch (error, stackTrace) {
      // Check if we should retry this error
      final shouldRetry = _shouldRetryError(error, config);
      final hasAttemptsLeft = attempt < config.maxAttempts;

      if (!shouldRetry || !hasAttemptsLeft) {
        // No more retries, rethrow the error
        logger.e(
          '[Retry] Failed after $attempt attempts',
          error: error,
          stackTrace: stackTrace,
        );
        rethrow;
      }

      // Log retry attempt
      logger.w(
        '[Retry] Attempt $attempt failed, retrying in ${delayMs}ms...',
        error: error,
      );

      // Call retry callback if provided
      onRetry?.call(attempt, error);

      // Wait before retrying
      await Future.delayed(Duration(milliseconds: delayMs));

      // Calculate next delay (exponential backoff)
      if (config.exponentialBackoff) {
        delayMs = (delayMs * 2).clamp(config.initialDelayMs, config.maxDelayMs);
      }
    }
  }
}

/// Determines if an error should trigger a retry based on configuration
bool _shouldRetryError(Object error, RetryConfig config) {
  if (error is DioException) {
    switch (error.type) {
      // Network errors
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return config.retryOnTimeout;

      case DioExceptionType.connectionError:
      case DioExceptionType.unknown:
        return config.retryOnNetworkError;

      // Server responded with error
      case DioExceptionType.badResponse:
        final statusCode = error.response?.statusCode;
        if (statusCode == null) return false;

        // Retry on 5xx server errors
        if (statusCode >= 500 && statusCode < 600) {
          return config.retryOnServerError;
        }

        // Retry on 408 (Request Timeout) and 429 (Too Many Requests)
        if (statusCode == 408 || statusCode == 429) {
          return true;
        }

        // Don't retry on 4xx client errors (except 408, 429)
        return false;

      case DioExceptionType.cancel:
      case DioExceptionType.badCertificate:
        // Don't retry cancelled requests or certificate errors
        return false;
    }
  }

  if (error is RepositoryError) {
    final code = error.code;
    if (code == null) return false;

    // Retry on network-related error codes
    return code == ErrorCode.timeout ||
        code == ErrorCode.serviceUnavailable ||
        code == ErrorCode.gatewayTimeout ||
        code == ErrorCode.badGateway ||
        code == ErrorCode.internalServerError;
  }

  // Don't retry unknown errors by default
  return false;
}

/// Check if an error is a network connectivity error
bool isNetworkError(Object error) {
  if (error is DioException) {
    return error.type == DioExceptionType.connectionError ||
        error.type == DioExceptionType.connectionTimeout ||
        error.type == DioExceptionType.unknown;
  }

  if (error is RepositoryError) {
    return error.code == ErrorCode.timeout ||
        error.code == ErrorCode.serviceUnavailable ||
        error.code == ErrorCode.gatewayTimeout;
  }

  return false;
}

/// Check if an error is retryable
bool isRetryableError(Object error) {
  return _shouldRetryError(error, RetryConfig.defaultConfig);
}
