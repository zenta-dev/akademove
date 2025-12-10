// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet_get200_response.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$WalletGet200ResponseCWProxy {
  WalletGet200Response message(String message);

  WalletGet200Response data(Wallet data);

  WalletGet200Response pagination(PaginationResult? pagination);

  WalletGet200Response totalPages(int? totalPages);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `WalletGet200Response(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// WalletGet200Response(...).copyWith(id: 12, name: "My name")
  /// ```
  WalletGet200Response call({
    String message,
    Wallet data,
    PaginationResult? pagination,
    int? totalPages,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfWalletGet200Response.copyWith(...)` or call `instanceOfWalletGet200Response.copyWith.fieldName(value)` for a single field.
class _$WalletGet200ResponseCWProxyImpl
    implements _$WalletGet200ResponseCWProxy {
  const _$WalletGet200ResponseCWProxyImpl(this._value);

  final WalletGet200Response _value;

  @override
  WalletGet200Response message(String message) => call(message: message);

  @override
  WalletGet200Response data(Wallet data) => call(data: data);

  @override
  WalletGet200Response pagination(PaginationResult? pagination) =>
      call(pagination: pagination);

  @override
  WalletGet200Response totalPages(int? totalPages) =>
      call(totalPages: totalPages);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `WalletGet200Response(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// WalletGet200Response(...).copyWith(id: 12, name: "My name")
  /// ```
  WalletGet200Response call({
    Object? message = const $CopyWithPlaceholder(),
    Object? data = const $CopyWithPlaceholder(),
    Object? pagination = const $CopyWithPlaceholder(),
    Object? totalPages = const $CopyWithPlaceholder(),
  }) {
    return WalletGet200Response(
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

extension $WalletGet200ResponseCopyWith on WalletGet200Response {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfWalletGet200Response.copyWith(...)` or `instanceOfWalletGet200Response.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$WalletGet200ResponseCWProxy get copyWith =>
      _$WalletGet200ResponseCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WalletGet200Response _$WalletGet200ResponseFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('WalletGet200Response', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['message', 'data']);
  final val = WalletGet200Response(
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

Map<String, dynamic> _$WalletGet200ResponseToJson(
  WalletGet200Response instance,
) => <String, dynamic>{
  'message': instance.message,
  'data': instance.data.toJson(),
  'pagination': ?instance.pagination?.toJson(),
  'totalPages': ?instance.totalPages,
};
