// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'driver_wallet_get_wallet200_response.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$DriverWalletGetWallet200ResponseCWProxy {
  DriverWalletGetWallet200Response message(String message);

  DriverWalletGetWallet200Response data(Wallet data);

  DriverWalletGetWallet200Response pagination(PaginationResult? pagination);

  DriverWalletGetWallet200Response totalPages(int? totalPages);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `DriverWalletGetWallet200Response(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// DriverWalletGetWallet200Response(...).copyWith(id: 12, name: "My name")
  /// ```
  DriverWalletGetWallet200Response call({
    String message,
    Wallet data,
    PaginationResult? pagination,
    int? totalPages,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfDriverWalletGetWallet200Response.copyWith(...)` or call `instanceOfDriverWalletGetWallet200Response.copyWith.fieldName(value)` for a single field.
class _$DriverWalletGetWallet200ResponseCWProxyImpl
    implements _$DriverWalletGetWallet200ResponseCWProxy {
  const _$DriverWalletGetWallet200ResponseCWProxyImpl(this._value);

  final DriverWalletGetWallet200Response _value;

  @override
  DriverWalletGetWallet200Response message(String message) =>
      call(message: message);

  @override
  DriverWalletGetWallet200Response data(Wallet data) => call(data: data);

  @override
  DriverWalletGetWallet200Response pagination(PaginationResult? pagination) =>
      call(pagination: pagination);

  @override
  DriverWalletGetWallet200Response totalPages(int? totalPages) =>
      call(totalPages: totalPages);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `DriverWalletGetWallet200Response(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// DriverWalletGetWallet200Response(...).copyWith(id: 12, name: "My name")
  /// ```
  DriverWalletGetWallet200Response call({
    Object? message = const $CopyWithPlaceholder(),
    Object? data = const $CopyWithPlaceholder(),
    Object? pagination = const $CopyWithPlaceholder(),
    Object? totalPages = const $CopyWithPlaceholder(),
  }) {
    return DriverWalletGetWallet200Response(
      message: message == const $CopyWithPlaceholder() || message == null
          ? _value.message
          // ignore: cast_nullable_to_non_nullable
          : message as String,
      data: data == const $CopyWithPlaceholder() || data == null
          ? _value.data
          // ignore: cast_nullable_to_non_nullable
          : data as Wallet,
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

extension $DriverWalletGetWallet200ResponseCopyWith
    on DriverWalletGetWallet200Response {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfDriverWalletGetWallet200Response.copyWith(...)` or `instanceOfDriverWalletGetWallet200Response.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$DriverWalletGetWallet200ResponseCWProxy get copyWith =>
      _$DriverWalletGetWallet200ResponseCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DriverWalletGetWallet200Response _$DriverWalletGetWallet200ResponseFromJson(
  Map<String, dynamic> json,
) =>
    $checkedCreate('DriverWalletGetWallet200Response', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['message', 'data']);
      final val = DriverWalletGetWallet200Response(
        message: $checkedConvert('message', (v) => v as String),
        data: $checkedConvert(
          'data',
          (v) => Wallet.fromJson(v as Map<String, dynamic>),
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

Map<String, dynamic> _$DriverWalletGetWallet200ResponseToJson(
  DriverWalletGetWallet200Response instance,
) => <String, dynamic>{
  'message': instance.message,
  'data': instance.data.toJson(),
  'pagination': ?instance.pagination?.toJson(),
  'totalPages': ?instance.totalPages,
};
