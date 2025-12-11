// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_verify_email200_response.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$AuthVerifyEmail200ResponseCWProxy {
  AuthVerifyEmail200Response message(String message);

  AuthVerifyEmail200Response data(AuthVerifyEmail200ResponseData data);

  AuthVerifyEmail200Response pagination(PaginationResult? pagination);

  AuthVerifyEmail200Response totalPages(int? totalPages);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `AuthVerifyEmail200Response(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// AuthVerifyEmail200Response(...).copyWith(id: 12, name: "My name")
  /// ```
  AuthVerifyEmail200Response call({
    String message,
    AuthVerifyEmail200ResponseData data,
    PaginationResult? pagination,
    int? totalPages,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfAuthVerifyEmail200Response.copyWith(...)` or call `instanceOfAuthVerifyEmail200Response.copyWith.fieldName(value)` for a single field.
class _$AuthVerifyEmail200ResponseCWProxyImpl
    implements _$AuthVerifyEmail200ResponseCWProxy {
  const _$AuthVerifyEmail200ResponseCWProxyImpl(this._value);

  final AuthVerifyEmail200Response _value;

  @override
  AuthVerifyEmail200Response message(String message) => call(message: message);

  @override
  AuthVerifyEmail200Response data(AuthVerifyEmail200ResponseData data) =>
      call(data: data);

  @override
  AuthVerifyEmail200Response pagination(PaginationResult? pagination) =>
      call(pagination: pagination);

  @override
  AuthVerifyEmail200Response totalPages(int? totalPages) =>
      call(totalPages: totalPages);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `AuthVerifyEmail200Response(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// AuthVerifyEmail200Response(...).copyWith(id: 12, name: "My name")
  /// ```
  AuthVerifyEmail200Response call({
    Object? message = const $CopyWithPlaceholder(),
    Object? data = const $CopyWithPlaceholder(),
    Object? pagination = const $CopyWithPlaceholder(),
    Object? totalPages = const $CopyWithPlaceholder(),
  }) {
    return AuthVerifyEmail200Response(
      message: message == const $CopyWithPlaceholder() || message == null
          ? _value.message
          // ignore: cast_nullable_to_non_nullable
          : message as String,
      data: data == const $CopyWithPlaceholder() || data == null
          ? _value.data
          // ignore: cast_nullable_to_non_nullable
          : data as AuthVerifyEmail200ResponseData,
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

extension $AuthVerifyEmail200ResponseCopyWith on AuthVerifyEmail200Response {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfAuthVerifyEmail200Response.copyWith(...)` or `instanceOfAuthVerifyEmail200Response.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$AuthVerifyEmail200ResponseCWProxy get copyWith =>
      _$AuthVerifyEmail200ResponseCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthVerifyEmail200Response _$AuthVerifyEmail200ResponseFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('AuthVerifyEmail200Response', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['message', 'data']);
  final val = AuthVerifyEmail200Response(
    message: $checkedConvert('message', (v) => v as String),
    data: $checkedConvert(
      'data',
      (v) => AuthVerifyEmail200ResponseData.fromJson(v as Map<String, dynamic>),
    ),
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

Map<String, dynamic> _$AuthVerifyEmail200ResponseToJson(
  AuthVerifyEmail200Response instance,
) => <String, dynamic>{
  'message': instance.message,
  'data': instance.data.toJson(),
  'pagination': ?instance.pagination?.toJson(),
  'totalPages': ?instance.totalPages,
};
