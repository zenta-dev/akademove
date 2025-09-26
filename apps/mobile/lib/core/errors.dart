base class BaseError implements Exception {
  BaseError(this.message, this.prevs);
  final String? message;
  final List<Exception> prevs;
}

final class RepositoryError extends BaseError {
  RepositoryError(super.message, super.prevs);
}
