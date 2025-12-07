import 'package:akademove/core/_export.dart';
import 'package:api_client/api_client.dart';
import 'package:flutter/foundation.dart';

sealed class BaseResponse<T> {
  const BaseResponse({
    required this.message,
    required this.data,
    this.paginationResult,
  });

  final String message;
  final T data;
  final PaginationResult? paginationResult;

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
    required R Function() orElse,
    R Function(T data, String message)? success,
    R Function(ErrorCode code, String message)? failed,
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
    super.paginationResult,
  });

  @override
  String toString() =>
      'SuccessResponse(message: $message, data: $data, paginationResult: $paginationResult)';
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SuccessResponse<T> &&
          runtimeType == other.runtimeType &&
          message == other.message &&
          data == other.data &&
          paginationResult == other.paginationResult;

  @override
  int get hashCode => Object.hash(message, data, paginationResult);
}

@immutable
final class FailedResponse extends BaseResponse<void> {
  const FailedResponse({
    required this.code,
    required super.message,
    super.paginationResult,
  }) : super(data: null);

  factory FailedResponse.fromJson(Map<String, dynamic> json) {
    final codeStr = json['code'];
    final msg = json['message'] as String? ?? '';

    final errorCode = switch (codeStr) {
      final String code => ErrorCode.fromString(code) ?? ErrorCode.unknown,
      _ => ErrorCode.unknown,
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
