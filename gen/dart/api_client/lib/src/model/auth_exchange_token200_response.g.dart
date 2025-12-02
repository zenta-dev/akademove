// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_exchange_token200_response.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$AuthExchangeToken200ResponseCWProxy {
  AuthExchangeToken200Response message(String message);

  AuthExchangeToken200Response data(String data);

  AuthExchangeToken200Response pagination(PaginationResult? pagination);

  AuthExchangeToken200Response totalPages(int? totalPages);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `AuthExchangeToken200Response(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// AuthExchangeToken200Response(...).copyWith(id: 12, name: "My name")
  /// ```
  AuthExchangeToken200Response call({String message, String data, PaginationResult? pagination, int? totalPages});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfAuthExchangeToken200Response.copyWith(...)` or call `instanceOfAuthExchangeToken200Response.copyWith.fieldName(value)` for a single field.
class _$AuthExchangeToken200ResponseCWProxyImpl implements _$AuthExchangeToken200ResponseCWProxy {
  const _$AuthExchangeToken200ResponseCWProxyImpl(this._value);

  final AuthExchangeToken200Response _value;

  @override
  AuthExchangeToken200Response message(String message) => call(message: message);

  @override
  AuthExchangeToken200Response data(String data) => call(data: data);

  @override
  AuthExchangeToken200Response pagination(PaginationResult? pagination) => call(pagination: pagination);

  @override
  AuthExchangeToken200Response totalPages(int? totalPages) => call(totalPages: totalPages);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `AuthExchangeToken200Response(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// AuthExchangeToken200Response(...).copyWith(id: 12, name: "My name")
  /// ```
  AuthExchangeToken200Response call({
    Object? message = const $CopyWithPlaceholder(),
    Object? data = const $CopyWithPlaceholder(),
    Object? pagination = const $CopyWithPlaceholder(),
    Object? totalPages = const $CopyWithPlaceholder(),
  }) {
    return AuthExchangeToken200Response(
      message: message == const $CopyWithPlaceholder() || message == null
          ? _value.message
          // ignore: cast_nullable_to_non_nullable
          : message as String,
      data: data == const $CopyWithPlaceholder() || data == null
          ? _value.data
          // ignore: cast_nullable_to_non_nullable
          : data as String,
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

extension $AuthExchangeToken200ResponseCopyWith on AuthExchangeToken200Response {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfAuthExchangeToken200Response.copyWith(...)` or `instanceOfAuthExchangeToken200Response.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$AuthExchangeToken200ResponseCWProxy get copyWith => _$AuthExchangeToken200ResponseCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthExchangeToken200Response _$AuthExchangeToken200ResponseFromJson(Map<String, dynamic> json) =>
    $checkedCreate('AuthExchangeToken200Response', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['message', 'data']);
      final val = AuthExchangeToken200Response(
        message: $checkedConvert('message', (v) => v as String),
        data: $checkedConvert('data', (v) => v as String),
        pagination: $checkedConvert(
          'pagination',
          (v) => v == null ? null : PaginationResult.fromJson(v as Map<String, dynamic>),
        ),
        totalPages: $checkedConvert('totalPages', (v) => (v as num?)?.toInt()),
      );
      return val;
    });

Map<String, dynamic> _$AuthExchangeToken200ResponseToJson(AuthExchangeToken200Response instance) => <String, dynamic>{
  'message': instance.message,
  'data': instance.data,
  'pagination': ?instance.pagination?.toJson(),
  'totalPages': ?instance.totalPages,
};
