// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bank.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$BankCWProxy {
  Bank provider(BankProviderEnum provider);

  Bank number(num number);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Bank(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Bank(...).copyWith(id: 12, name: "My name")
  /// ````
  Bank call({BankProviderEnum provider, num number});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfBank.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfBank.copyWith.fieldName(...)`
class _$BankCWProxyImpl implements _$BankCWProxy {
  const _$BankCWProxyImpl(this._value);

  final Bank _value;

  @override
  Bank provider(BankProviderEnum provider) => this(provider: provider);

  @override
  Bank number(num number) => this(number: number);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Bank(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Bank(...).copyWith(id: 12, name: "My name")
  /// ````
  Bank call({
    Object? provider = const $CopyWithPlaceholder(),
    Object? number = const $CopyWithPlaceholder(),
  }) {
    return Bank(
      provider: provider == const $CopyWithPlaceholder()
          ? _value.provider
          // ignore: cast_nullable_to_non_nullable
          : provider as BankProviderEnum,
      number: number == const $CopyWithPlaceholder()
          ? _value.number
          // ignore: cast_nullable_to_non_nullable
          : number as num,
    );
  }
}

extension $BankCopyWith on Bank {
  /// Returns a callable class that can be used as follows: `instanceOfBank.copyWith(...)` or like so:`instanceOfBank.copyWith.fieldName(...)`.
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
          (v) => $enumDecode(_$BankProviderEnumEnumMap, v),
        ),
        number: $checkedConvert('number', (v) => v as num),
      );
      return val;
    });

Map<String, dynamic> _$BankToJson(Bank instance) => <String, dynamic>{
  'provider': _$BankProviderEnumEnumMap[instance.provider]!,
  'number': instance.number,
};

const _$BankProviderEnumEnumMap = {
  BankProviderEnum.BCA: 'BCA',
  BankProviderEnum.BNI: 'BNI',
  BankProviderEnum.BRI: 'BRI',
  BankProviderEnum.mandiri: 'Mandiri',
  BankProviderEnum.permata: 'Permata',
  BankProviderEnum.CIMB: 'CIMB',
  BankProviderEnum.danamon: 'Danamon',
};
