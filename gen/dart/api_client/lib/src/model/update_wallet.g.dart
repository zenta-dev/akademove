// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_wallet.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$UpdatewalletCWProxy {
  Updatewallet userId(String? userId);

  Updatewallet balance(num? balance);

  Updatewallet currency(Currency? currency);

  Updatewallet isActive(bool? isActive);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `Updatewallet(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// Updatewallet(...).copyWith(id: 12, name: "My name")
  /// ```
  Updatewallet call({
    String? userId,
    num? balance,
    Currency? currency,
    bool? isActive,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfUpdatewallet.copyWith(...)` or call `instanceOfUpdatewallet.copyWith.fieldName(value)` for a single field.
class _$UpdatewalletCWProxyImpl implements _$UpdatewalletCWProxy {
  const _$UpdatewalletCWProxyImpl(this._value);

  final Updatewallet _value;

  @override
  Updatewallet userId(String? userId) => call(userId: userId);

  @override
  Updatewallet balance(num? balance) => call(balance: balance);

  @override
  Updatewallet currency(Currency? currency) => call(currency: currency);

  @override
  Updatewallet isActive(bool? isActive) => call(isActive: isActive);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `Updatewallet(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// Updatewallet(...).copyWith(id: 12, name: "My name")
  /// ```
  Updatewallet call({
    Object? userId = const $CopyWithPlaceholder(),
    Object? balance = const $CopyWithPlaceholder(),
    Object? currency = const $CopyWithPlaceholder(),
    Object? isActive = const $CopyWithPlaceholder(),
  }) {
    return Updatewallet(
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

extension $UpdatewalletCopyWith on Updatewallet {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfUpdatewallet.copyWith(...)` or `instanceOfUpdatewallet.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$UpdatewalletCWProxy get copyWith => _$UpdatewalletCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Updatewallet _$UpdatewalletFromJson(Map<String, dynamic> json) =>
    $checkedCreate('Updatewallet', json, ($checkedConvert) {
      final val = Updatewallet(
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

Map<String, dynamic> _$UpdatewalletToJson(Updatewallet instance) =>
    <String, dynamic>{
      'userId': ?instance.userId,
      'balance': ?instance.balance,
      'currency': ?_$CurrencyEnumMap[instance.currency],
      'isActive': ?instance.isActive,
    };

const _$CurrencyEnumMap = {Currency.IDR: 'IDR'};
