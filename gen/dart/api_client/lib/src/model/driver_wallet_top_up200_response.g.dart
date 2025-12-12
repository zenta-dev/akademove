// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'driver_wallet_top_up200_response.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$DriverWalletTopUp200ResponseCWProxy {
  DriverWalletTopUp200Response message(String message);

  DriverWalletTopUp200Response data(Payment data);

  DriverWalletTopUp200Response pagination(PaginationResult? pagination);

  DriverWalletTopUp200Response totalPages(int? totalPages);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `DriverWalletTopUp200Response(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// DriverWalletTopUp200Response(...).copyWith(id: 12, name: "My name")
  /// ```
  DriverWalletTopUp200Response call({
    String message,
    Payment data,
    PaginationResult? pagination,
    int? totalPages,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfDriverWalletTopUp200Response.copyWith(...)` or call `instanceOfDriverWalletTopUp200Response.copyWith.fieldName(value)` for a single field.
class _$DriverWalletTopUp200ResponseCWProxyImpl
    implements _$DriverWalletTopUp200ResponseCWProxy {
  const _$DriverWalletTopUp200ResponseCWProxyImpl(this._value);

  final DriverWalletTopUp200Response _value;

  @override
  DriverWalletTopUp200Response message(String message) =>
      call(message: message);

  @override
  DriverWalletTopUp200Response data(Payment data) => call(data: data);

  @override
  DriverWalletTopUp200Response pagination(PaginationResult? pagination) =>
      call(pagination: pagination);

  @override
  DriverWalletTopUp200Response totalPages(int? totalPages) =>
      call(totalPages: totalPages);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `DriverWalletTopUp200Response(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// DriverWalletTopUp200Response(...).copyWith(id: 12, name: "My name")
  /// ```
  DriverWalletTopUp200Response call({
    Object? message = const $CopyWithPlaceholder(),
    Object? data = const $CopyWithPlaceholder(),
    Object? pagination = const $CopyWithPlaceholder(),
    Object? totalPages = const $CopyWithPlaceholder(),
  }) {
    return DriverWalletTopUp200Response(
      message: message == const $CopyWithPlaceholder() || message == null
          ? _value.message
          // ignore: cast_nullable_to_non_nullable
          : message as String,
      data: data == const $CopyWithPlaceholder() || data == null
          ? _value.data
          // ignore: cast_nullable_to_non_nullable
          : data as Payment,
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

extension $DriverWalletTopUp200ResponseCopyWith
    on DriverWalletTopUp200Response {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfDriverWalletTopUp200Response.copyWith(...)` or `instanceOfDriverWalletTopUp200Response.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$DriverWalletTopUp200ResponseCWProxy get copyWith =>
      _$DriverWalletTopUp200ResponseCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DriverWalletTopUp200Response _$DriverWalletTopUp200ResponseFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('DriverWalletTopUp200Response', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['message', 'data']);
  final val = DriverWalletTopUp200Response(
    message: $checkedConvert('message', (v) => v as String),
    data: $checkedConvert(
      'data',
      (v) => Payment.fromJson(v as Map<String, dynamic>),
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

Map<String, dynamic> _$DriverWalletTopUp200ResponseToJson(
  DriverWalletTopUp200Response instance,
) => <String, dynamic>{
  'message': instance.message,
  'data': instance.data.toJson(),
  'pagination': ?instance.pagination?.toJson(),
  'totalPages': ?instance.totalPages,
};
