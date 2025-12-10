// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_sign_out200_response.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$AuthSignOut200ResponseCWProxy {
  AuthSignOut200Response message(String? message);

  AuthSignOut200Response data(bool data);

  AuthSignOut200Response pagination(PaginationResult? pagination);

  AuthSignOut200Response totalPages(int? totalPages);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `AuthSignOut200Response(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// AuthSignOut200Response(...).copyWith(id: 12, name: "My name")
  /// ```
  AuthSignOut200Response call({
    String? message,
    bool data,
    PaginationResult? pagination,
    int? totalPages,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfAuthSignOut200Response.copyWith(...)` or call `instanceOfAuthSignOut200Response.copyWith.fieldName(value)` for a single field.
class _$AuthSignOut200ResponseCWProxyImpl
    implements _$AuthSignOut200ResponseCWProxy {
  const _$AuthSignOut200ResponseCWProxyImpl(this._value);

  final AuthSignOut200Response _value;

  @override
  AuthSignOut200Response message(String? message) => call(message: message);

  @override
  AuthSignOut200Response data(bool data) => call(data: data);

  @override
  AuthSignOut200Response pagination(PaginationResult? pagination) =>
      call(pagination: pagination);

  @override
  AuthSignOut200Response totalPages(int? totalPages) =>
      call(totalPages: totalPages);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `AuthSignOut200Response(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// AuthSignOut200Response(...).copyWith(id: 12, name: "My name")
  /// ```
  AuthSignOut200Response call({
    Object? message = const $CopyWithPlaceholder(),
    Object? data = const $CopyWithPlaceholder(),
    Object? pagination = const $CopyWithPlaceholder(),
    Object? totalPages = const $CopyWithPlaceholder(),
  }) {
    return AuthSignOut200Response(
      message: message == const $CopyWithPlaceholder()
          ? _value.message
          // ignore: cast_nullable_to_non_nullable
          : message as String?,
      data: data == const $CopyWithPlaceholder() || data == null
          ? _value.data
          // ignore: cast_nullable_to_non_nullable
          : data as bool,
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

extension $AuthSignOut200ResponseCopyWith on AuthSignOut200Response {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfAuthSignOut200Response.copyWith(...)` or `instanceOfAuthSignOut200Response.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$AuthSignOut200ResponseCWProxy get copyWith =>
      _$AuthSignOut200ResponseCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthSignOut200Response _$AuthSignOut200ResponseFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('AuthSignOut200Response', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['message', 'data']);
  final val = AuthSignOut200Response(
    message: $checkedConvert('message', (v) => v as String?),
    data: $checkedConvert('data', (v) => v as bool),
    pagination: $checkedConvert(
      'pagination',
      (v) => v == null
          ? null
          : PaginationResult.fromJson(v as Map<String, dynamic>),
    ),
    totalPages: $checkedConvert('totalPages', (v) => (v as num?)?.toInt()),
  );
  return val;
});

Map<String, dynamic> _$AuthSignOut200ResponseToJson(
  AuthSignOut200Response instance,
) => <String, dynamic>{
  'message': instance.message,
  'data': instance.data,
  'pagination': ?instance.pagination?.toJson(),
  'totalPages': ?instance.totalPages,
};
