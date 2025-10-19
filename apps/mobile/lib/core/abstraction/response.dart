import 'package:akademove/core/_export.dart';

abstract class BaseResponse<T> {
  const BaseResponse({
    required this.message,
    required this.data,
  });

  final String message;
  final T data;
}

class SuccessResponse<T> extends BaseResponse<T> {
  const SuccessResponse({
    required super.message,
    required super.data,
  });
}

class FailedResponse extends BaseResponse<Null> {
  const FailedResponse({
    required this.code,
    required super.message,
    required super.data,
  });

  factory FailedResponse.fromJson(Map<String, dynamic> json) {
    final codeStr = json['code'];
    final msg = (json['message'] ?? '') as String;

    final errorCode = (codeStr is String)
        ? ErrorCode.fromString(codeStr) ?? ErrorCode.UNKNOWN
        : ErrorCode.UNKNOWN;

    return FailedResponse(code: errorCode, message: msg, data: null);
  }

  final ErrorCode code;
}
