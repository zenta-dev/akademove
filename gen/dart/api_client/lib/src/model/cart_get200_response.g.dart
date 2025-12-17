// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_get200_response.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$CartGet200ResponseCWProxy {
  CartGet200Response message(String message);

  CartGet200Response data(CartResponse data);

  CartGet200Response pagination(PaginationResult? pagination);

  CartGet200Response totalPages(int? totalPages);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `CartGet200Response(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// CartGet200Response(...).copyWith(id: 12, name: "My name")
  /// ```
  CartGet200Response call({
    String message,
    CartResponse data,
    PaginationResult? pagination,
    int? totalPages,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfCartGet200Response.copyWith(...)` or call `instanceOfCartGet200Response.copyWith.fieldName(value)` for a single field.
class _$CartGet200ResponseCWProxyImpl implements _$CartGet200ResponseCWProxy {
  const _$CartGet200ResponseCWProxyImpl(this._value);

  final CartGet200Response _value;

  @override
  CartGet200Response message(String message) => call(message: message);

  @override
  CartGet200Response data(CartResponse data) => call(data: data);

  @override
  CartGet200Response pagination(PaginationResult? pagination) =>
      call(pagination: pagination);

  @override
  CartGet200Response totalPages(int? totalPages) =>
      call(totalPages: totalPages);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `CartGet200Response(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// CartGet200Response(...).copyWith(id: 12, name: "My name")
  /// ```
  CartGet200Response call({
    Object? message = const $CopyWithPlaceholder(),
    Object? data = const $CopyWithPlaceholder(),
    Object? pagination = const $CopyWithPlaceholder(),
    Object? totalPages = const $CopyWithPlaceholder(),
  }) {
    return CartGet200Response(
      message: message == const $CopyWithPlaceholder() || message == null
          ? _value.message
          // ignore: cast_nullable_to_non_nullable
          : message as String,
      data: data == const $CopyWithPlaceholder() || data == null
          ? _value.data
          // ignore: cast_nullable_to_non_nullable
          : data as CartResponse,
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

extension $CartGet200ResponseCopyWith on CartGet200Response {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfCartGet200Response.copyWith(...)` or `instanceOfCartGet200Response.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$CartGet200ResponseCWProxy get copyWith =>
      _$CartGet200ResponseCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CartGet200Response _$CartGet200ResponseFromJson(Map<String, dynamic> json) =>
    $checkedCreate('CartGet200Response', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['message', 'data']);
      final val = CartGet200Response(
        message: $checkedConvert('message', (v) => v as String),
        data: $checkedConvert(
          'data',
          (v) => CartResponse.fromJson(v as Map<String, dynamic>),
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

Map<String, dynamic> _$CartGet200ResponseToJson(CartGet200Response instance) =>
    <String, dynamic>{
      'message': instance.message,
      'data': instance.data.toJson(),
      'pagination': ?instance.pagination?.toJson(),
      'totalPages': ?instance.totalPages,
    };
