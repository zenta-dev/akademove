import 'package:akademove/core/_export.dart';
import 'package:akademove/core/response.dart';
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
        code: ErrorCode.INTERNAL_SERVER_ERROR,
        message: 'An error occured',
        data: null,
      );

      if (data is Map<String, dynamic>) {
        failed = FailedResponse.fromJson(data);
      }
      throw RepositoryError(failed.message, code: failed.code);
    } on RepositoryError {
      rethrow;
      // ignore: avoid_catches_without_on_clauses wildcard
    } catch (e, stack) {
      logger.e('Repository Error', error: e, stackTrace: stack);
      throw const RepositoryError(
        'Internal server error',
        code: ErrorCode.UNKNOWN,
      );
    }
  }
}
