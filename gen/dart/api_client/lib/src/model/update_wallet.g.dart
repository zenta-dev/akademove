// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_wallet.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$UpdateWalletCWProxy {
  UpdateWallet userId(String? userId);

  UpdateWallet balance(num? balance);

  UpdateWallet currency(Currency? currency);

  UpdateWallet isActive(bool? isActive);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `UpdateWallet(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// UpdateWallet(...).copyWith(id: 12, name: "My name")
  /// ````
  UpdateWallet call({
    String? userId,
    num? balance,
    Currency? currency,
    bool? isActive,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfUpdateWallet.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfUpdateWallet.copyWith.fieldName(...)`
class _$UpdateWalletCWProxyImpl implements _$UpdateWalletCWProxy {
  const _$UpdateWalletCWProxyImpl(this._value);

  final UpdateWallet _value;

  @override
  UpdateWallet userId(String? userId) => this(userId: userId);

  @override
  UpdateWallet balance(num? balance) => this(balance: balance);

  @override
  UpdateWallet currency(Currency? currency) => this(currency: currency);

  @override
  UpdateWallet isActive(bool? isActive) => this(isActive: isActive);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `UpdateWallet(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// UpdateWallet(...).copyWith(id: 12, name: "My name")
  /// ````
  UpdateWallet call({
    Object? userId = const $CopyWithPlaceholder(),
    Object? balance = const $CopyWithPlaceholder(),
    Object? currency = const $CopyWithPlaceholder(),
    Object? isActive = const $CopyWithPlaceholder(),
  }) {
    return UpdateWallet(
      userId: userId == const $CopyWithPlaceholder()
          ? _value.userId
          // ignore: cast_nullable_to_non_nullable
          : userId as String?,
      balance: balance == const $CopyWithPlaceholder()
          ? _value.balance
          // ignore: cast_nullable_to_non_nullable
          : balance as num?,
      currency: currency == const $CopyWithPlaceholder()
          ? _value.currency
          // ignore: cast_nullable_to_non_nullable
          : currency as Currency?,
      isActive: isActive == const $CopyWithPlaceholder()
          ? _value.isActive
          // ignore: cast_nullable_to_non_nullable
          : isActive as bool?,
    );
  }
}

extension $UpdateWalletCopyWith on UpdateWallet {
  /// Returns a callable class that can be used as follows: `instanceOfUpdateWallet.copyWith(...)` or like so:`instanceOfUpdateWallet.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$UpdateWalletCWProxy get copyWith => _$UpdateWalletCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateWallet _$UpdateWalletFromJson(Map<String, dynamic> json) =>
    $checkedCreate('UpdateWallet', json, ($checkedConvert) {
      final val = UpdateWallet(
        userId: $checkedConvert('userId', (v) => v as String?),
        balance: $checkedConvert('balance', (v) => v as num?),
        currency: $checkedConvert(
          'currency',
          (v) => $enumDecodeNullable(_$CurrencyEnumMap, v),
        ),
        isActive: $checkedConvert('isActive', (v) => v as bool?),
      );
      return val;
    });

Map<String, dynamic> _$UpdateWalletToJson(UpdateWallet instance) =>
    <String, dynamic>{
      'userId': ?instance.userId,
      'balance': ?instance.balance,
      'currency': ?_$CurrencyEnumMap[instance.currency],
      'isActive': ?instance.isActive,
    };

const _$CurrencyEnumMap = {Currency.IDR: 'IDR'};
