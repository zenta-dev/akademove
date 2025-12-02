import 'package:akademove/core/_export.dart';
import 'package:flutter_test/flutter_test.dart';

/// Custom matchers and test utilities

// ============================================================================
// State Matchers
// ============================================================================

/// Matcher for checking if state is initial
Matcher isInitialState<T extends BaseState2>() =>
    isA<T>().having((s) => s.isInitial, 'isInitial', true);

/// Matcher for checking if state is loading
Matcher isLoadingState<T extends BaseState2>() =>
    isA<T>().having((s) => s.isLoading, 'isLoading', true);

/// Matcher for checking if state is success
Matcher isSuccessState<T extends BaseState2>() =>
    isA<T>().having((s) => s.isSuccess, 'isSuccess', true);

/// Matcher for checking if state is failure
Matcher isFailureState<T extends BaseState2>() =>
    isA<T>().having((s) => s.isFailure, 'isFailure', true);

/// Matcher for checking if state has specific error
Matcher hasError<T extends BaseState2>(BaseError error) => isA<T>()
    .having((s) => s.isFailure, 'isFailure', true)
    .having((s) => s.error, 'error', error);

/// Matcher for checking if state has specific error type
Matcher hasErrorType<T extends BaseState2, E extends BaseError>() => isA<T>()
    .having((s) => s.isFailure, 'isFailure', true)
    .having((s) => s.error, 'error', isA<E>());

/// Matcher for checking if state has specific message
Matcher hasMessage<T extends BaseState2>(String message) =>
    isA<T>().having((s) => s.message, 'message', message);

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
