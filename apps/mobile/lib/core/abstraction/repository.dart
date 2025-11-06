import 'package:akademove/core/_export.dart';
import 'package:dio/dio.dart';

abstract class BaseRepository {
  const BaseRepository();
  Future<T> guard<T>(Future<T> Function() action) async {
    try {
      return await action();
    } on DioException catch (e, stack) {
      logger.e('Repository Error', error: e, stackTrace: stack);
      final data = e.response?.data;

      var failed = const FailedResponse(
        code: ErrorCode.internalServerError,
        message: 'An error occured',
      );

      if (data is Map<String, dynamic>) {
        failed = FailedResponse.fromJson(data);
      }
      throw RepositoryError(failed.message, code: failed.code);
    } on BaseError {
      rethrow;
      // ignore: avoid_catches_without_on_clauses wildcard
    } catch (e, stack) {
      logger.e('Repository Error', error: e, stackTrace: stack);
      throw const RepositoryError(
        'Internal server error',
        code: ErrorCode.unknown,
      );
    }
  }
}
