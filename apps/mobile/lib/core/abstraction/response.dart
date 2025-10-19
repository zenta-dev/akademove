import 'package:akademove/core/_export.dart';
import 'package:flutter/foundation.dart';

sealed class BaseResponse<T> {
  const BaseResponse({
    required this.message,
    required this.data,
  });

  final String message;
  final T data;

  bool get isSuccess => this is SuccessResponse<T>;
  bool get isFailed => this is FailedResponse;

  R when<R>({
    required R Function(T data, String message) success,
    required R Function(ErrorCode code, String message) failed,
  }) {
    return switch (this) {
      SuccessResponse(:final data, :final message) => success(data, message),
      FailedResponse(:final code, :final message) => failed(code, message),
    };
  }

  R? whenOrNull<R>({
    R Function(T data, String message)? success,
    R Function(ErrorCode code, String message)? failed,
  }) {
    return switch (this) {
      SuccessResponse(:final data, :final message) => success?.call(
        data,
        message,
      ),
      FailedResponse(:final code, :final message) => failed?.call(
        code,
        message,
      ),
    };
  }

  R maybeWhen<R>({
    R Function(T data, String message)? success,
    R Function(ErrorCode code, String message)? failed,
    required R Function() orElse,
  }) {
    return switch (this) {
      SuccessResponse(:final data, :final message) =>
        success?.call(data, message) ?? orElse(),
      FailedResponse(:final code, :final message) =>
        failed?.call(code, message) ?? orElse(),
    };
  }
}

@immutable
final class SuccessResponse<T> extends BaseResponse<T> {
  const SuccessResponse({
    required super.message,
    required super.data,
  });

  @override
  String toString() => 'SuccessResponse(message: $message, data: $data)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SuccessResponse<T> &&
          runtimeType == other.runtimeType &&
          message == other.message &&
          data == other.data;

  @override
  int get hashCode => Object.hash(message, data);
}

@immutable
final class FailedResponse extends BaseResponse<void> {
  const FailedResponse({
    required this.code,
    required super.message,
  }) : super(data: null);

  factory FailedResponse.fromJson(Map<String, dynamic> json) {
    final codeStr = json['code'];
    final msg = json['message'] as String? ?? '';

    final errorCode = switch (codeStr) {
      final String code => ErrorCode.fromString(code) ?? ErrorCode.UNKNOWN,
      _ => ErrorCode.UNKNOWN,
    };

    return FailedResponse(code: errorCode, message: msg);
  }

  final ErrorCode code;

  @override
  String toString() => 'FailedResponse(code: $code, message: $message)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FailedResponse &&
          runtimeType == other.runtimeType &&
          code == other.code &&
          message == other.message;

  @override
  int get hashCode => Object.hash(code, message);
}
