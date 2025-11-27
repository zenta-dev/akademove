// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bank.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$BankCWProxy {
  Bank provider(BankProvider provider);

  Bank number(num number);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `Bank(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// Bank(...).copyWith(id: 12, name: "My name")
  /// ```
  Bank call({BankProvider provider, num number});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfBank.copyWith(...)` or call `instanceOfBank.copyWith.fieldName(value)` for a single field.
class _$BankCWProxyImpl implements _$BankCWProxy {
  const _$BankCWProxyImpl(this._value);

  final Bank _value;

  @override
  Bank provider(BankProvider provider) => call(provider: provider);

  @override
  Bank number(num number) => call(number: number);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `Bank(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// Bank(...).copyWith(id: 12, name: "My name")
  /// ```
  Bank call({
    Object? provider = const $CopyWithPlaceholder(),
    Object? number = const $CopyWithPlaceholder(),
  }) {
    return Bank(
      provider: provider == const $CopyWithPlaceholder() || provider == null
          ? _value.provider
          // ignore: cast_nullable_to_non_nullable
          : provider as BankProvider,
      number: number == const $CopyWithPlaceholder() || number == null
          ? _value.number
          // ignore: cast_nullable_to_non_nullable
          : number as num,
    );
  }
}

extension $BankCopyWith on Bank {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfBank.copyWith(...)` or `instanceOfBank.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$BankCWProxy get copyWith => _$BankCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Bank _$BankFromJson(Map<String, dynamic> json) =>
    $checkedCreate('Bank', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['provider', 'number']);
      final val = Bank(
        provider: $checkedConvert(
          'provider',
          (v) => $enumDecode(_$BankProviderEnumMap, v),
        ),
        number: $checkedConvert('number', (v) => v as num),
      );
      return val;
    });

Map<String, dynamic> _$BankToJson(Bank instance) => <String, dynamic>{
  'provider': _$BankProviderEnumMap[instance.provider]!,
  'number': instance.number,
};

const _$BankProviderEnumMap = {
  BankProvider.BCA: 'BCA',
  BankProvider.BNI: 'BNI',
  BankProvider.BRI: 'BRI',
  BankProvider.MANDIRI: 'MANDIRI',
  BankProvider.PERMATA: 'PERMATA',
};
