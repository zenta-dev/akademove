// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'place_order_payment.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$PlaceOrderPaymentCWProxy {
  PlaceOrderPayment method(PaymentMethod method);

  PlaceOrderPayment provider(PaymentProvider provider);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `PlaceOrderPayment(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// PlaceOrderPayment(...).copyWith(id: 12, name: "My name")
  /// ````
  PlaceOrderPayment call({PaymentMethod method, PaymentProvider provider});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfPlaceOrderPayment.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfPlaceOrderPayment.copyWith.fieldName(...)`
class _$PlaceOrderPaymentCWProxyImpl implements _$PlaceOrderPaymentCWProxy {
  const _$PlaceOrderPaymentCWProxyImpl(this._value);

  final PlaceOrderPayment _value;

  @override
  PlaceOrderPayment method(PaymentMethod method) => this(method: method);

  @override
  PlaceOrderPayment provider(PaymentProvider provider) =>
      this(provider: provider);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `PlaceOrderPayment(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// PlaceOrderPayment(...).copyWith(id: 12, name: "My name")
  /// ````
  PlaceOrderPayment call({
    Object? method = const $CopyWithPlaceholder(),
    Object? provider = const $CopyWithPlaceholder(),
  }) {
    return PlaceOrderPayment(
      method: method == const $CopyWithPlaceholder()
          ? _value.method
          // ignore: cast_nullable_to_non_nullable
          : method as PaymentMethod,
      provider: provider == const $CopyWithPlaceholder()
          ? _value.provider
          // ignore: cast_nullable_to_non_nullable
          : provider as PaymentProvider,
    );
  }
}

extension $PlaceOrderPaymentCopyWith on PlaceOrderPayment {
  /// Returns a callable class that can be used as follows: `instanceOfPlaceOrderPayment.copyWith(...)` or like so:`instanceOfPlaceOrderPayment.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$PlaceOrderPaymentCWProxy get copyWith =>
      _$PlaceOrderPaymentCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlaceOrderPayment _$PlaceOrderPaymentFromJson(Map<String, dynamic> json) =>
    $checkedCreate('PlaceOrderPayment', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['method', 'provider']);
      final val = PlaceOrderPayment(
        method: $checkedConvert(
          'method',
          (v) => $enumDecode(_$PaymentMethodEnumMap, v),
        ),
        provider: $checkedConvert(
          'provider',
          (v) => $enumDecode(_$PaymentProviderEnumMap, v),
        ),
      );
      return val;
    });

Map<String, dynamic> _$PlaceOrderPaymentToJson(PlaceOrderPayment instance) =>
    <String, dynamic>{
      'method': _$PaymentMethodEnumMap[instance.method]!,
      'provider': _$PaymentProviderEnumMap[instance.provider]!,
    };

const _$PaymentMethodEnumMap = {
  PaymentMethod.QRIS: 'QRIS',
  PaymentMethod.VA: 'VA',
  PaymentMethod.BANK_TRANSFER: 'BANK_TRANSFER',
  PaymentMethod.WALLET: 'WALLET',
};

const _$PaymentProviderEnumMap = {
  PaymentProvider.MIDTRANS: 'MIDTRANS',
  PaymentProvider.MANUAL: 'MANUAL',
};
