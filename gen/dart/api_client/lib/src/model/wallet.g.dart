// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$WalletCWProxy {
  Wallet id(String id);

  Wallet userId(String userId);

  Wallet balance(num balance);

  Wallet currency(Currency currency);

  Wallet isActive(bool isActive);

  Wallet createdAt(DateTime createdAt);

  Wallet updatedAt(DateTime updatedAt);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `Wallet(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// Wallet(...).copyWith(id: 12, name: "My name")
  /// ```
  Wallet call({
    String id,
    String userId,
    num balance,
    Currency currency,
    bool isActive,
    DateTime createdAt,
    DateTime updatedAt,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfWallet.copyWith(...)` or call `instanceOfWallet.copyWith.fieldName(value)` for a single field.
class _$WalletCWProxyImpl implements _$WalletCWProxy {
  const _$WalletCWProxyImpl(this._value);

  final Wallet _value;

  @override
  Wallet id(String id) => call(id: id);

  @override
  Wallet userId(String userId) => call(userId: userId);

  @override
  Wallet balance(num balance) => call(balance: balance);

  @override
  Wallet currency(Currency currency) => call(currency: currency);

  @override
  Wallet isActive(bool isActive) => call(isActive: isActive);

  @override
  Wallet createdAt(DateTime createdAt) => call(createdAt: createdAt);

  @override
  Wallet updatedAt(DateTime updatedAt) => call(updatedAt: updatedAt);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `Wallet(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// Wallet(...).copyWith(id: 12, name: "My name")
  /// ```
  Wallet call({
    Object? id = const $CopyWithPlaceholder(),
    Object? userId = const $CopyWithPlaceholder(),
    Object? balance = const $CopyWithPlaceholder(),
    Object? currency = const $CopyWithPlaceholder(),
    Object? isActive = const $CopyWithPlaceholder(),
    Object? createdAt = const $CopyWithPlaceholder(),
    Object? updatedAt = const $CopyWithPlaceholder(),
  }) {
    return Wallet(
      id: id == const $CopyWithPlaceholder() || id == null
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
      userId: userId == const $CopyWithPlaceholder() || userId == null
          ? _value.userId
          // ignore: cast_nullable_to_non_nullable
          : userId as String,
      balance: balance == const $CopyWithPlaceholder() || balance == null
          ? _value.balance
          // ignore: cast_nullable_to_non_nullable
          : balance as num,
      currency: currency == const $CopyWithPlaceholder() || currency == null
          ? _value.currency
          // ignore: cast_nullable_to_non_nullable
          : currency as Currency,
      isActive: isActive == const $CopyWithPlaceholder() || isActive == null
          ? _value.isActive
          // ignore: cast_nullable_to_non_nullable
          : isActive as bool,
      createdAt: createdAt == const $CopyWithPlaceholder() || createdAt == null
          ? _value.createdAt
          // ignore: cast_nullable_to_non_nullable
          : createdAt as DateTime,
      updatedAt: updatedAt == const $CopyWithPlaceholder() || updatedAt == null
          ? _value.updatedAt
          // ignore: cast_nullable_to_non_nullable
          : updatedAt as DateTime,
    );
  }
}

extension $WalletCopyWith on Wallet {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfWallet.copyWith(...)` or `instanceOfWallet.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$WalletCWProxy get copyWith => _$WalletCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Wallet _$WalletFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('Wallet', json, ($checkedConvert) {
  $checkKeys(
    json,
    requiredKeys: const [
      'id',
      'userId',
      'balance',
      'currency',
      'isActive',
      'createdAt',
      'updatedAt',
    ],
  );
  final val = Wallet(
    id: $checkedConvert('id', (v) => v as String),
    userId: $checkedConvert('userId', (v) => v as String),
    balance: $checkedConvert('balance', (v) => v as num),
    currency: $checkedConvert(
      'currency',
      (v) => $enumDecode(_$CurrencyEnumMap, v),
    ),
    isActive: $checkedConvert('isActive', (v) => v as bool),
    createdAt: $checkedConvert('createdAt', (v) => DateTime.parse(v as String)),
    updatedAt: $checkedConvert('updatedAt', (v) => DateTime.parse(v as String)),
  );
  return val;
});

Map<String, dynamic> _$WalletToJson(Wallet instance) => <String, dynamic>{
  'id': instance.id,
  'userId': instance.userId,
  'balance': instance.balance,
  'currency': _$CurrencyEnumMap[instance.currency]!,
  'isActive': instance.isActive,
  'createdAt': instance.createdAt.toIso8601String(),
  'updatedAt': instance.updatedAt.toIso8601String(),
};

const _$CurrencyEnumMap = {Currency.IDR: 'IDR'};
