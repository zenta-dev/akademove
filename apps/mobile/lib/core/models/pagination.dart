part of '_export.dart';

@MappableClass()
class PageTokenPaginationResult<T> with PageTokenPaginationResultMappable<T> {
  const PageTokenPaginationResult({required this.data, this.token});

  final T data;
  final String? token;
}
