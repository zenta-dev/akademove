// ignore_for_file: avoid_catches_without_on_clauses it should catch any error

import 'package:akademove/core/_export.dart';

class Result<T> {
  const Result._(this.success, {this.data, this.error, this.stackTrace});

  final bool success;
  final T? data;
  final Object? error;
  final StackTrace? stackTrace;

  static Result<T> ok<T>(T data) => Result._(true, data: data);

  static Result<T> err<T>(Object error, {StackTrace? stackTrace}) =>
      Result._(false, error: error, stackTrace: stackTrace);

  bool get isOk => success;
  bool get isErr => !success;
}

Future<Result<T>> safeAsync<T>(Future<T> Function() fn) async {
  try {
    final data = await fn();
    return Result.ok(data);
  } catch (error, stackTrace) {
    logger.e(
      'Failed to execute this function',
      error: error,
      stackTrace: stackTrace,
      time: DateTime.now(),
    );
    return Result.err(error, stackTrace: stackTrace);
  }
}

Result<T> safeSync<T>(T Function() fn) {
  try {
    final data = fn();
    return Result.ok(data);
  } catch (error, stackTrace) {
    logger.e(
      'Failed to execute this function',
      error: error,
      stackTrace: stackTrace,
      time: DateTime.now(),
    );
    return Result.err(error, stackTrace: stackTrace);
  }
}
