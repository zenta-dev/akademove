// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet_transactions200_response.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$WalletTransactions200ResponseCWProxy {
  WalletTransactions200Response message(String message);

  WalletTransactions200Response data(List<Transaction> data);

  WalletTransactions200Response totalPages(num? totalPages);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `WalletTransactions200Response(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// WalletTransactions200Response(...).copyWith(id: 12, name: "My name")
  /// ````
  WalletTransactions200Response call({
    String message,
    List<Transaction> data,
    num? totalPages,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfWalletTransactions200Response.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfWalletTransactions200Response.copyWith.fieldName(...)`
class _$WalletTransactions200ResponseCWProxyImpl
    implements _$WalletTransactions200ResponseCWProxy {
  const _$WalletTransactions200ResponseCWProxyImpl(this._value);

  final WalletTransactions200Response _value;

  @override
  WalletTransactions200Response message(String message) =>
      this(message: message);

  @override
  WalletTransactions200Response data(List<Transaction> data) =>
      this(data: data);

  @override
  WalletTransactions200Response totalPages(num? totalPages) =>
      this(totalPages: totalPages);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `WalletTransactions200Response(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// WalletTransactions200Response(...).copyWith(id: 12, name: "My name")
  /// ````
  WalletTransactions200Response call({
    Object? message = const $CopyWithPlaceholder(),
    Object? data = const $CopyWithPlaceholder(),
    Object? totalPages = const $CopyWithPlaceholder(),
  }) {
    return WalletTransactions200Response(
      message: message == const $CopyWithPlaceholder()
          ? _value.message
          // ignore: cast_nullable_to_non_nullable
          : message as String,
      data: data == const $CopyWithPlaceholder()
          ? _value.data
          // ignore: cast_nullable_to_non_nullable
          : data as List<Transaction>,
      totalPages: totalPages == const $CopyWithPlaceholder()
          ? _value.totalPages
          // ignore: cast_nullable_to_non_nullable
          : totalPages as num?,
    );
  }
}

extension $WalletTransactions200ResponseCopyWith
    on WalletTransactions200Response {
  /// Returns a callable class that can be used as follows: `instanceOfWalletTransactions200Response.copyWith(...)` or like so:`instanceOfWalletTransactions200Response.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$WalletTransactions200ResponseCWProxy get copyWith =>
      _$WalletTransactions200ResponseCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WalletTransactions200Response _$WalletTransactions200ResponseFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('WalletTransactions200Response', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['message', 'data']);
  final val = WalletTransactions200Response(
    message: $checkedConvert('message', (v) => v as String),
    data: $checkedConvert(
      'data',
      (v) => (v as List<dynamic>)
          .map((e) => Transaction.fromJson(e as Map<String, dynamic>))
          .toList(),
    ),
    totalPages: $checkedConvert('totalPages', (v) => v as num?),
  );
  return val;
});

Map<String, dynamic> _$WalletTransactions200ResponseToJson(
  WalletTransactions200Response instance,
) => <String, dynamic>{
  'message': instance.message,
  'data': instance.data.map((e) => e.toJson()).toList(),
  'totalPages': ?instance.totalPages,
};
