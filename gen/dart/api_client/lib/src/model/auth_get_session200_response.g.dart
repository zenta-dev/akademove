// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_get_session200_response.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$AuthGetSession200ResponseCWProxy {
  AuthGetSession200Response message(String message);

  AuthGetSession200Response data(GetSessionResponse? data);

  AuthGetSession200Response pagination(PaginationResult? pagination);

  AuthGetSession200Response totalPages(int? totalPages);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `AuthGetSession200Response(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// AuthGetSession200Response(...).copyWith(id: 12, name: "My name")
  /// ```
  AuthGetSession200Response call({
    String message,
    GetSessionResponse? data,
    PaginationResult? pagination,
    int? totalPages,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfAuthGetSession200Response.copyWith(...)` or call `instanceOfAuthGetSession200Response.copyWith.fieldName(value)` for a single field.
class _$AuthGetSession200ResponseCWProxyImpl implements _$AuthGetSession200ResponseCWProxy {
  const _$AuthGetSession200ResponseCWProxyImpl(this._value);

  final AuthGetSession200Response _value;

  @override
  AuthGetSession200Response message(String message) => call(message: message);

  @override
  AuthGetSession200Response data(GetSessionResponse? data) => call(data: data);

  @override
  AuthGetSession200Response pagination(PaginationResult? pagination) => call(pagination: pagination);

  @override
  AuthGetSession200Response totalPages(int? totalPages) => call(totalPages: totalPages);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `AuthGetSession200Response(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// AuthGetSession200Response(...).copyWith(id: 12, name: "My name")
  /// ```
  AuthGetSession200Response call({
    Object? message = const $CopyWithPlaceholder(),
    Object? data = const $CopyWithPlaceholder(),
    Object? pagination = const $CopyWithPlaceholder(),
    Object? totalPages = const $CopyWithPlaceholder(),
  }) {
    return AuthGetSession200Response(
      message: message == const $CopyWithPlaceholder() || message == null
          ? _value.message
          // ignore: cast_nullable_to_non_nullable
          : message as String,
      data: data == const $CopyWithPlaceholder()
          ? _value.data
          // ignore: cast_nullable_to_non_nullable
          : data as GetSessionResponse?,
      pagination: pagination == const $CopyWithPlaceholder()
          ? _value.pagination
          // ignore: cast_nullable_to_non_nullable
          : pagination as PaginationResult?,
      totalPages: totalPages == const $CopyWithPlaceholder()
          ? _value.totalPages
          // ignore: cast_nullable_to_non_nullable
          : totalPages as int?,
    );
  }
}

extension $AuthGetSession200ResponseCopyWith on AuthGetSession200Response {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfAuthGetSession200Response.copyWith(...)` or `instanceOfAuthGetSession200Response.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$AuthGetSession200ResponseCWProxy get copyWith => _$AuthGetSession200ResponseCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthGetSession200Response _$AuthGetSession200ResponseFromJson(Map<String, dynamic> json) =>
    $checkedCreate('AuthGetSession200Response', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['message', 'data']);
      final val = AuthGetSession200Response(
        message: $checkedConvert('message', (v) => v as String),
        data: $checkedConvert('data', (v) => v == null ? null : GetSessionResponse.fromJson(v as Map<String, dynamic>)),
        pagination: $checkedConvert(
          'pagination',
          (v) => v == null ? null : PaginationResult.fromJson(v as Map<String, dynamic>),
        ),
        totalPages: $checkedConvert('totalPages', (v) => (v as num?)?.toInt()),
      );
      return val;
    });

Map<String, dynamic> _$AuthGetSession200ResponseToJson(AuthGetSession200Response instance) => <String, dynamic>{
  'message': instance.message,
  'data': instance.data?.toJson(),
  'pagination': ?instance.pagination?.toJson(),
  'totalPages': ?instance.totalPages,
};
