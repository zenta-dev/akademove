// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet_get200_response.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$WalletGet200ResponseCWProxy {
  WalletGet200Response message(String message);

  WalletGet200Response data(Wallet data);

  WalletGet200Response totalPages(int? totalPages);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `WalletGet200Response(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// WalletGet200Response(...).copyWith(id: 12, name: "My name")
  /// ````
  WalletGet200Response call({String message, Wallet data, int? totalPages});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfWalletGet200Response.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfWalletGet200Response.copyWith.fieldName(...)`
class _$WalletGet200ResponseCWProxyImpl
    implements _$WalletGet200ResponseCWProxy {
  const _$WalletGet200ResponseCWProxyImpl(this._value);

  final WalletGet200Response _value;

  @override
  WalletGet200Response message(String message) => this(message: message);

  @override
  WalletGet200Response data(Wallet data) => this(data: data);

  @override
  WalletGet200Response totalPages(int? totalPages) =>
      this(totalPages: totalPages);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `WalletGet200Response(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// WalletGet200Response(...).copyWith(id: 12, name: "My name")
  /// ````
  WalletGet200Response call({
    Object? message = const $CopyWithPlaceholder(),
    Object? data = const $CopyWithPlaceholder(),
    Object? totalPages = const $CopyWithPlaceholder(),
  }) {
    return WalletGet200Response(
      message: message == const $CopyWithPlaceholder()
          ? _value.message
          // ignore: cast_nullable_to_non_nullable
          : message as String,
      data: data == const $CopyWithPlaceholder()
          ? _value.data
          // ignore: cast_nullable_to_non_nullable
          : data as Wallet,
      totalPages: totalPages == const $CopyWithPlaceholder()
          ? _value.totalPages
          // ignore: cast_nullable_to_non_nullable
          : totalPages as int?,
    );
  }
}

extension $WalletGet200ResponseCopyWith on WalletGet200Response {
  /// Returns a callable class that can be used as follows: `instanceOfWalletGet200Response.copyWith(...)` or like so:`instanceOfWalletGet200Response.copyWith.fieldName(...)`.
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
    totalPages: $checkedConvert('totalPages', (v) => (v as num?)?.toInt()),
  );
  return val;
});

Map<String, dynamic> _$WalletGet200ResponseToJson(
  WalletGet200Response instance,
) => <String, dynamic>{
  'message': instance.message,
  'data': instance.data.toJson(),
  'totalPages': ?instance.totalPages,
};
