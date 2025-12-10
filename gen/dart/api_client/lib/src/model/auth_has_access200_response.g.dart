// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_has_access200_response.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$AuthHasAccess200ResponseCWProxy {
  AuthHasAccess200Response message(String? message);

  AuthHasAccess200Response data(bool data);

  AuthHasAccess200Response pagination(PaginationResult? pagination);

  AuthHasAccess200Response totalPages(int? totalPages);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `AuthHasAccess200Response(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// AuthHasAccess200Response(...).copyWith(id: 12, name: "My name")
  /// ```
  AuthHasAccess200Response call({
    String? message,
    bool data,
    PaginationResult? pagination,
    int? totalPages,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfAuthHasAccess200Response.copyWith(...)` or call `instanceOfAuthHasAccess200Response.copyWith.fieldName(value)` for a single field.
class _$AuthHasAccess200ResponseCWProxyImpl
    implements _$AuthHasAccess200ResponseCWProxy {
  const _$AuthHasAccess200ResponseCWProxyImpl(this._value);

  final AuthHasAccess200Response _value;

  @override
  AuthHasAccess200Response message(String? message) => call(message: message);

  @override
  AuthHasAccess200Response data(bool data) => call(data: data);

  @override
  AuthHasAccess200Response pagination(PaginationResult? pagination) =>
      call(pagination: pagination);

  @override
  AuthHasAccess200Response totalPages(int? totalPages) =>
      call(totalPages: totalPages);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `AuthHasAccess200Response(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// AuthHasAccess200Response(...).copyWith(id: 12, name: "My name")
  /// ```
  AuthHasAccess200Response call({
    Object? message = const $CopyWithPlaceholder(),
    Object? data = const $CopyWithPlaceholder(),
    Object? pagination = const $CopyWithPlaceholder(),
    Object? totalPages = const $CopyWithPlaceholder(),
  }) {
    return AuthHasAccess200Response(
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

extension $AuthHasAccess200ResponseCopyWith on AuthHasAccess200Response {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfAuthHasAccess200Response.copyWith(...)` or `instanceOfAuthHasAccess200Response.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$AuthHasAccess200ResponseCWProxy get copyWith =>
      _$AuthHasAccess200ResponseCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthHasAccess200Response _$AuthHasAccess200ResponseFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('AuthHasAccess200Response', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['message', 'data']);
  final val = AuthHasAccess200Response(
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

Map<String, dynamic> _$AuthHasAccess200ResponseToJson(
  AuthHasAccess200Response instance,
) => <String, dynamic>{
  'message': instance.message,
  'data': instance.data,
  'pagination': ?instance.pagination?.toJson(),
  'totalPages': ?instance.totalPages,
};
