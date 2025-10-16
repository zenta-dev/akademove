// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'driver_update_request_bank.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$DriverUpdateRequestBankCWProxy {
  DriverUpdateRequestBank provider(
    DriverUpdateRequestBankProviderEnum provider,
  );

  DriverUpdateRequestBank number(num number);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `DriverUpdateRequestBank(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// DriverUpdateRequestBank(...).copyWith(id: 12, name: "My name")
  /// ````
  DriverUpdateRequestBank call({
    DriverUpdateRequestBankProviderEnum provider,
    num number,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfDriverUpdateRequestBank.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfDriverUpdateRequestBank.copyWith.fieldName(...)`
class _$DriverUpdateRequestBankCWProxyImpl
    implements _$DriverUpdateRequestBankCWProxy {
  const _$DriverUpdateRequestBankCWProxyImpl(this._value);

  final DriverUpdateRequestBank _value;

  @override
  DriverUpdateRequestBank provider(
    DriverUpdateRequestBankProviderEnum provider,
  ) => this(provider: provider);

  @override
  DriverUpdateRequestBank number(num number) => this(number: number);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `DriverUpdateRequestBank(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// DriverUpdateRequestBank(...).copyWith(id: 12, name: "My name")
  /// ````
  DriverUpdateRequestBank call({
    Object? provider = const $CopyWithPlaceholder(),
    Object? number = const $CopyWithPlaceholder(),
  }) {
    return DriverUpdateRequestBank(
      provider: provider == const $CopyWithPlaceholder()
          ? _value.provider
          // ignore: cast_nullable_to_non_nullable
          : provider as DriverUpdateRequestBankProviderEnum,
      number: number == const $CopyWithPlaceholder()
          ? _value.number
          // ignore: cast_nullable_to_non_nullable
          : number as num,
    );
  }
}

extension $DriverUpdateRequestBankCopyWith on DriverUpdateRequestBank {
  /// Returns a callable class that can be used as follows: `instanceOfDriverUpdateRequestBank.copyWith(...)` or like so:`instanceOfDriverUpdateRequestBank.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$DriverUpdateRequestBankCWProxy get copyWith =>
      _$DriverUpdateRequestBankCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DriverUpdateRequestBank _$DriverUpdateRequestBankFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('DriverUpdateRequestBank', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['provider', 'number']);
  final val = DriverUpdateRequestBank(
    provider: $checkedConvert(
      'provider',
      (v) => $enumDecode(_$DriverUpdateRequestBankProviderEnumEnumMap, v),
    ),
    number: $checkedConvert('number', (v) => v as num),
  );
  return val;
});

Map<String, dynamic> _$DriverUpdateRequestBankToJson(
  DriverUpdateRequestBank instance,
) => <String, dynamic>{
  'provider': _$DriverUpdateRequestBankProviderEnumEnumMap[instance.provider]!,
  'number': instance.number,
};

const _$DriverUpdateRequestBankProviderEnumEnumMap = {
  DriverUpdateRequestBankProviderEnum.bca: 'bca',
  DriverUpdateRequestBankProviderEnum.bni: 'bni',
  DriverUpdateRequestBankProviderEnum.mandiri: 'mandiri',
};
