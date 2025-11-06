enum ErrorCode {
  badRequest(400),
  unathorized(401),
  forbidden(403),
  notFound(404),
  methodNotSupported(405),
  notAcceptable(406),
  timeout(408),
  conflict(409),
  preconditionFailed(412),
  payloadTooLarge(413),
  unsupportedMediaType(415),
  unprocessableContent(422),
  tooManyRequests(429),
  clientClosedRequest(499),
  internalServerError(500),
  notImplemented(501),
  badGateway(502),
  serviceUnavailable(503),
  gatewayTimeout(504),
  unknown(null),
  invalidType(null);

  const ErrorCode(this.code);
  final int? code;

  static final Map<String, ErrorCode> _byName = {
    for (final e in ErrorCode.values) e.name: e,
  };

  static final Map<int, ErrorCode> _byCode = {
    for (final e in ErrorCode.values)
      if (e.code != null) e.code!: e,
  };

  static ErrorCode? fromString(String? str) => _byName[str?.toUpperCase()];

  static ErrorCode? fromInt(int? code) => _byCode[code];

  static ErrorCode fromIntOrUnknown(int? code) =>
      _byCode[code] ?? ErrorCode.unknown;

  static ErrorCode fromStringOrUnknown(String? str) =>
      _byName[str?.toUpperCase()] ?? ErrorCode.unknown;
}

sealed class BaseError implements Exception {
  const BaseError(this.message, {this.code});

  final String? message;
  final ErrorCode? code;

  @override
  String toString() =>
      // ignore: no_runtimetype_tostring still lazt
      '$runtimeType(code: ${code?.name ?? "UNKNOWN"}, message: $message)';
}

final class RepositoryError extends BaseError {
  const RepositoryError(super.message, {super.code});
}

final class ServiceError extends BaseError {
  const ServiceError(super.message, {super.code});
}

final class UnknownError extends BaseError {
  const UnknownError(super.message, {super.code});
}
