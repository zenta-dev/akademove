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

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `DriverUpdateRequestBank(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// DriverUpdateRequestBank(...).copyWith(id: 12, name: "My name")
  /// ```
  DriverUpdateRequestBank call({
    DriverUpdateRequestBankProviderEnum provider,
    num number,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfDriverUpdateRequestBank.copyWith(...)` or call `instanceOfDriverUpdateRequestBank.copyWith.fieldName(value)` for a single field.
class _$DriverUpdateRequestBankCWProxyImpl
    implements _$DriverUpdateRequestBankCWProxy {
  const _$DriverUpdateRequestBankCWProxyImpl(this._value);

  final DriverUpdateRequestBank _value;

  @override
  DriverUpdateRequestBank provider(
    DriverUpdateRequestBankProviderEnum provider,
  ) => call(provider: provider);

  @override
  DriverUpdateRequestBank number(num number) => call(number: number);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `DriverUpdateRequestBank(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// DriverUpdateRequestBank(...).copyWith(id: 12, name: "My name")
  /// ```
  DriverUpdateRequestBank call({
    Object? provider = const $CopyWithPlaceholder(),
    Object? number = const $CopyWithPlaceholder(),
  }) {
    return DriverUpdateRequestBank(
      provider: provider == const $CopyWithPlaceholder() || provider == null
          ? _value.provider
          // ignore: cast_nullable_to_non_nullable
          : provider as DriverUpdateRequestBankProviderEnum,
      number: number == const $CopyWithPlaceholder() || number == null
          ? _value.number
          // ignore: cast_nullable_to_non_nullable
          : number as num,
    );
  }
}

extension $DriverUpdateRequestBankCopyWith on DriverUpdateRequestBank {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfDriverUpdateRequestBank.copyWith(...)` or `instanceOfDriverUpdateRequestBank.copyWith.fieldName(...)`.
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
  DriverUpdateRequestBankProviderEnum.BCA: 'BCA',
  DriverUpdateRequestBankProviderEnum.BNI: 'BNI',
  DriverUpdateRequestBankProviderEnum.BRI: 'BRI',
  DriverUpdateRequestBankProviderEnum.MANDIRI: 'MANDIRI',
  DriverUpdateRequestBankProviderEnum.PERMATA: 'PERMATA',
};
