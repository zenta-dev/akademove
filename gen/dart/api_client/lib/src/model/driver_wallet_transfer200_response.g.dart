// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'driver_wallet_transfer200_response.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$DriverWalletTransfer200ResponseCWProxy {
  DriverWalletTransfer200Response message(String message);

  DriverWalletTransfer200Response data(TransferResponse data);

  DriverWalletTransfer200Response pagination(PaginationResult? pagination);

  DriverWalletTransfer200Response totalPages(int? totalPages);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `DriverWalletTransfer200Response(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// DriverWalletTransfer200Response(...).copyWith(id: 12, name: "My name")
  /// ```
  DriverWalletTransfer200Response call({
    String message,
    TransferResponse data,
    PaginationResult? pagination,
    int? totalPages,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfDriverWalletTransfer200Response.copyWith(...)` or call `instanceOfDriverWalletTransfer200Response.copyWith.fieldName(value)` for a single field.
class _$DriverWalletTransfer200ResponseCWProxyImpl
    implements _$DriverWalletTransfer200ResponseCWProxy {
  const _$DriverWalletTransfer200ResponseCWProxyImpl(this._value);

  final DriverWalletTransfer200Response _value;

  @override
  DriverWalletTransfer200Response message(String message) =>
      call(message: message);

  @override
  DriverWalletTransfer200Response data(TransferResponse data) =>
      call(data: data);

  @override
  DriverWalletTransfer200Response pagination(PaginationResult? pagination) =>
      call(pagination: pagination);

  @override
  DriverWalletTransfer200Response totalPages(int? totalPages) =>
      call(totalPages: totalPages);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `DriverWalletTransfer200Response(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// DriverWalletTransfer200Response(...).copyWith(id: 12, name: "My name")
  /// ```
  DriverWalletTransfer200Response call({
    Object? message = const $CopyWithPlaceholder(),
    Object? data = const $CopyWithPlaceholder(),
    Object? pagination = const $CopyWithPlaceholder(),
    Object? totalPages = const $CopyWithPlaceholder(),
  }) {
    return DriverWalletTransfer200Response(
      message: message == const $CopyWithPlaceholder() || message == null
          ? _value.message
          // ignore: cast_nullable_to_non_nullable
          : message as String,
      data: data == const $CopyWithPlaceholder() || data == null
          ? _value.data
          // ignore: cast_nullable_to_non_nullable
          : data as TransferResponse,
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

extension $DriverWalletTransfer200ResponseCopyWith
    on DriverWalletTransfer200Response {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfDriverWalletTransfer200Response.copyWith(...)` or `instanceOfDriverWalletTransfer200Response.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$DriverWalletTransfer200ResponseCWProxy get copyWith =>
      _$DriverWalletTransfer200ResponseCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DriverWalletTransfer200Response _$DriverWalletTransfer200ResponseFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('DriverWalletTransfer200Response', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['message', 'data']);
  final val = DriverWalletTransfer200Response(
    message: $checkedConvert('message', (v) => v as String),
    data: $checkedConvert(
      'data',
      (v) => TransferResponse.fromJson(v as Map<String, dynamic>),
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

Map<String, dynamic> _$DriverWalletTransfer200ResponseToJson(
  DriverWalletTransfer200Response instance,
) => <String, dynamic>{
  'message': instance.message,
  'data': instance.data.toJson(),
  'pagination': ?instance.pagination?.toJson(),
  'totalPages': ?instance.totalPages,
};
