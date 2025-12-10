// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet_transfer200_response.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$WalletTransfer200ResponseCWProxy {
  WalletTransfer200Response message(String? message);

  WalletTransfer200Response data(TransferResponse data);

  WalletTransfer200Response pagination(PaginationResult? pagination);

  WalletTransfer200Response totalPages(int? totalPages);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `WalletTransfer200Response(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// WalletTransfer200Response(...).copyWith(id: 12, name: "My name")
  /// ```
  WalletTransfer200Response call({
    String? message,
    TransferResponse data,
    PaginationResult? pagination,
    int? totalPages,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfWalletTransfer200Response.copyWith(...)` or call `instanceOfWalletTransfer200Response.copyWith.fieldName(value)` for a single field.
class _$WalletTransfer200ResponseCWProxyImpl
    implements _$WalletTransfer200ResponseCWProxy {
  const _$WalletTransfer200ResponseCWProxyImpl(this._value);

  final WalletTransfer200Response _value;

  @override
  WalletTransfer200Response message(String? message) => call(message: message);

  @override
  WalletTransfer200Response data(TransferResponse data) => call(data: data);

  @override
  WalletTransfer200Response pagination(PaginationResult? pagination) =>
      call(pagination: pagination);

  @override
  WalletTransfer200Response totalPages(int? totalPages) =>
      call(totalPages: totalPages);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `WalletTransfer200Response(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// WalletTransfer200Response(...).copyWith(id: 12, name: "My name")
  /// ```
  WalletTransfer200Response call({
    Object? message = const $CopyWithPlaceholder(),
    Object? data = const $CopyWithPlaceholder(),
    Object? pagination = const $CopyWithPlaceholder(),
    Object? totalPages = const $CopyWithPlaceholder(),
  }) {
    return WalletTransfer200Response(
      message: message == const $CopyWithPlaceholder()
          ? _value.message
          // ignore: cast_nullable_to_non_nullable
          : message as String?,
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

extension $WalletTransfer200ResponseCopyWith on WalletTransfer200Response {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfWalletTransfer200Response.copyWith(...)` or `instanceOfWalletTransfer200Response.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$WalletTransfer200ResponseCWProxy get copyWith =>
      _$WalletTransfer200ResponseCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WalletTransfer200Response _$WalletTransfer200ResponseFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('WalletTransfer200Response', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['message', 'data']);
  final val = WalletTransfer200Response(
    message: $checkedConvert('message', (v) => v as String?),
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

Map<String, dynamic> _$WalletTransfer200ResponseToJson(
  WalletTransfer200Response instance,
) => <String, dynamic>{
  'message': instance.message,
  'data': instance.data.toJson(),
  'pagination': ?instance.pagination?.toJson(),
  'totalPages': ?instance.totalPages,
};
