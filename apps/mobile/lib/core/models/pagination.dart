part of '_export.dart';

class PageTokenPaginationResult<T> extends Equatable {
  const PageTokenPaginationResult({required this.data, this.token});

  final T data;
  final String? token;

  PageTokenPaginationResult<T> copyWith({T? data, String? token}) {
    return PageTokenPaginationResult<T>(
      data: data ?? this.data,
      token: token ?? this.token,
    );
  }

  @override
  List<Object?> get props => [data, token];

  @override
  bool get stringify => true;
}
