import 'package:akademove/core/_export.dart';
import 'package:flutter_test/flutter_test.dart';

/// Custom matchers and test utilities

// ============================================================================
// OperationResult Matchers
// ============================================================================

/// Matcher for checking if OperationResult is idle
Matcher isIdleResult<T>() =>
    isA<OperationResult<T>>().having((r) => r.isIdle, 'isIdle', true);

/// Matcher for checking if OperationResult is loading
Matcher isLoadingResult<T>() =>
    isA<OperationResult<T>>().having((r) => r.isLoading, 'isLoading', true);

/// Matcher for checking if OperationResult is success
Matcher isSuccessResult<T>() =>
    isA<OperationResult<T>>().having((r) => r.isSuccess, 'isSuccess', true);

/// Matcher for checking if OperationResult is failure
Matcher isFailureResult<T>() =>
    isA<OperationResult<T>>().having((r) => r.isFailure, 'isFailure', true);

/// Matcher for checking if OperationResult has specific error
Matcher hasResultError<T>(BaseError error) => isA<OperationResult<T>>()
    .having((r) => r.isFailure, 'isFailure', true)
    .having((r) => r.error, 'error', error);

/// Matcher for checking if OperationResult has specific error type
Matcher hasResultErrorType<T, E extends BaseError>() =>
    isA<OperationResult<T>>()
        .having((r) => r.isFailure, 'isFailure', true)
        .having((r) => r.error, 'error', isA<E>());

/// Matcher for checking if OperationResult has specific message
Matcher hasResultMessage<T>(String message) =>
    isA<OperationResult<T>>().having((r) => r.message, 'message', message);

// ============================================================================
// Error Matchers
// ============================================================================

/// Matcher for RepositoryError with specific code
Matcher isRepositoryErrorWithCode(ErrorCode code) =>
    isA<RepositoryError>().having((e) => e.code, 'code', code);

/// Matcher for RepositoryError with specific message
Matcher isRepositoryErrorWithMessage(String message) =>
    isA<RepositoryError>().having((e) => e.message, 'message', message);

// ============================================================================
// Response Matchers
// ============================================================================

/// Matcher for SuccessResponse
Matcher isSuccessResponse<T>() => isA<SuccessResponse<T>>();

/// Matcher for FailedResponse
Matcher isFailedResponse() => isA<FailedResponse>();

/// Matcher for SuccessResponse with specific data
Matcher isSuccessResponseWithData<T>(T data) =>
    isA<SuccessResponse<T>>().having((r) => r.data, 'data', data);

// ============================================================================
// Test Utilities
// ============================================================================

/// Wait for a short period (useful for async operations)
Future<void> pumpAndSettle({
  Duration duration = const Duration(milliseconds: 100),
}) async {
  await Future<void>.delayed(duration);
}

/// Create a test DateTime that's deterministic
DateTime testDateTime({int year = 2024, int month = 1, int day = 15}) =>
    DateTime(year, month, day);
