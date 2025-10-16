// ignore_for_file: constant_identifier_names im just lazy to rewrite
enum ErrorCode {
  BAD_REQUEST,
  UNAUTHORIZED,
  FORBIDDEN,
  NOT_FOUND,
  METHOD_NOT_SUPPORTED,
  NOT_ACCEPTABLE,
  TIMEOUT,
  CONFLICT,
  PRECONDITION_FAILED,
  PAYLOAD_TOO_LARGE,
  UNSUPPORTED_MEDIA_TYPE,
  UNPROCESSABLE_CONTENT,
  TOO_MANY_REQUESTS,
  CLIENT_CLOSED_REQUEST,
  INTERNAL_SERVER_ERROR,
  NOT_IMPLEMENTED,
  BAD_GATEWAY,
  SERVICE_UNAVAILABLE,
  GATEWAY_TIMEOUT,
  UNKNOWN,
  INVALID_TYPE;

  const ErrorCode();

  static ErrorCode? fromString(String str) {
    switch (str) {
      case 'BAD_REQUEST':
        return ErrorCode.BAD_REQUEST;
      case 'UNAUTHORIZED':
        return ErrorCode.UNAUTHORIZED;
      case 'FORBIDDEN':
        return ErrorCode.FORBIDDEN;
      case 'NOT_FOUND':
        return ErrorCode.NOT_FOUND;
      case 'METHOD_NOT_SUPPORTED':
        return ErrorCode.METHOD_NOT_SUPPORTED;
      case 'NOT_ACCEPTABLE':
        return ErrorCode.NOT_ACCEPTABLE;
      case 'TIMEOUT':
        return ErrorCode.TIMEOUT;
      case 'CONFLICT':
        return ErrorCode.CONFLICT;
      case 'PRECONDITION_FAILED':
        return ErrorCode.PRECONDITION_FAILED;
      case 'PAYLOAD_TOO_LARGE':
        return ErrorCode.PAYLOAD_TOO_LARGE;
      case 'UNSUPPORTED_MEDIA_TYPE':
        return ErrorCode.UNSUPPORTED_MEDIA_TYPE;
      case 'UNPROCESSABLE_CONTENT':
        return ErrorCode.UNPROCESSABLE_CONTENT;
      case 'TOO_MANY_REQUESTS':
        return ErrorCode.TOO_MANY_REQUESTS;
      case 'CLIENT_CLOSED_REQUEST':
        return ErrorCode.CLIENT_CLOSED_REQUEST;
      case 'INTERNAL_SERVER_ERROR':
        return ErrorCode.INTERNAL_SERVER_ERROR;
      case 'NOT_IMPLEMENTED':
        return ErrorCode.NOT_IMPLEMENTED;
      case 'BAD_GATEWAY':
        return ErrorCode.BAD_GATEWAY;
      case 'SERVICE_UNAVAILABLE':
        return ErrorCode.SERVICE_UNAVAILABLE;
      case 'GATEWAY_TIMEOUT':
        return ErrorCode.GATEWAY_TIMEOUT;
      case 'UNKNOWN':
        return ErrorCode.UNKNOWN;
      case 'INVALID_TYPE':
        return ErrorCode.INVALID_TYPE;
      default:
        return null;
    }
  }
}

sealed class BaseError implements Exception {
  const BaseError(this.message, {this.code});

  final String? message;
  final ErrorCode? code;

  @override
  String toString() =>
      'BaseError(code: ${code?.name ?? "UNKNOWN"}, message: $message)';
}

final class RepositoryError extends BaseError {
  const RepositoryError(super.message, {super.code});

  @override
  String toString() =>
      'RepositoryError(code: ${code?.name ?? "UNKNOWN"}, message: $message)';
}

final class ServiceError extends BaseError {
  const ServiceError(super.message, {super.code});

  @override
  String toString() =>
      'ServiceError(code: ${code?.name ?? "UNKNOWN"}, message: $message)';
}
