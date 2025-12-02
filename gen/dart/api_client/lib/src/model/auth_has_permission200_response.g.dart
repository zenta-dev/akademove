// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_has_permission200_response.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$AuthHasPermission200ResponseCWProxy {
  AuthHasPermission200Response message(String message);

  AuthHasPermission200Response data(bool data);

  AuthHasPermission200Response pagination(PaginationResult? pagination);

  AuthHasPermission200Response totalPages(int? totalPages);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `AuthHasPermission200Response(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// AuthHasPermission200Response(...).copyWith(id: 12, name: "My name")
  /// ```
  AuthHasPermission200Response call({String message, bool data, PaginationResult? pagination, int? totalPages});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfAuthHasPermission200Response.copyWith(...)` or call `instanceOfAuthHasPermission200Response.copyWith.fieldName(value)` for a single field.
class _$AuthHasPermission200ResponseCWProxyImpl implements _$AuthHasPermission200ResponseCWProxy {
  const _$AuthHasPermission200ResponseCWProxyImpl(this._value);

  final AuthHasPermission200Response _value;

  @override
  AuthHasPermission200Response message(String message) => call(message: message);

  @override
  AuthHasPermission200Response data(bool data) => call(data: data);

  @override
  AuthHasPermission200Response pagination(PaginationResult? pagination) => call(pagination: pagination);

  @override
  AuthHasPermission200Response totalPages(int? totalPages) => call(totalPages: totalPages);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `AuthHasPermission200Response(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// AuthHasPermission200Response(...).copyWith(id: 12, name: "My name")
  /// ```
  AuthHasPermission200Response call({
    Object? message = const $CopyWithPlaceholder(),
    Object? data = const $CopyWithPlaceholder(),
    Object? pagination = const $CopyWithPlaceholder(),
    Object? totalPages = const $CopyWithPlaceholder(),
  }) {
    return AuthHasPermission200Response(
      message: message == const $CopyWithPlaceholder() || message == null
          ? _value.message
          // ignore: cast_nullable_to_non_nullable
          : message as String,
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

extension $AuthHasPermission200ResponseCopyWith on AuthHasPermission200Response {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfAuthHasPermission200Response.copyWith(...)` or `instanceOfAuthHasPermission200Response.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$AuthHasPermission200ResponseCWProxy get copyWith => _$AuthHasPermission200ResponseCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthHasPermission200Response _$AuthHasPermission200ResponseFromJson(Map<String, dynamic> json) =>
    $checkedCreate('AuthHasPermission200Response', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['message', 'data']);
      final val = AuthHasPermission200Response(
        message: $checkedConvert('message', (v) => v as String),
        data: $checkedConvert('data', (v) => v as bool),
        pagination: $checkedConvert(
          'pagination',
          (v) => v == null ? null : PaginationResult.fromJson(v as Map<String, dynamic>),
        ),
        totalPages: $checkedConvert('totalPages', (v) => (v as num?)?.toInt()),
      );
      return val;
    });

Map<String, dynamic> _$AuthHasPermission200ResponseToJson(AuthHasPermission200Response instance) => <String, dynamic>{
  'message': instance.message,
  'data': instance.data,
  'pagination': ?instance.pagination?.toJson(),
  'totalPages': ?instance.totalPages,
};
