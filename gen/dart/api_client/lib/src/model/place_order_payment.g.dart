// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'place_order_payment.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$PlaceOrderPaymentCWProxy {
  PlaceOrderPayment method(PaymentMethod method);

  PlaceOrderPayment provider(PaymentProvider provider);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `PlaceOrderPayment(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// PlaceOrderPayment(...).copyWith(id: 12, name: "My name")
  /// ```
  PlaceOrderPayment call({PaymentMethod method, PaymentProvider provider});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfPlaceOrderPayment.copyWith(...)` or call `instanceOfPlaceOrderPayment.copyWith.fieldName(value)` for a single field.
class _$PlaceOrderPaymentCWProxyImpl implements _$PlaceOrderPaymentCWProxy {
  const _$PlaceOrderPaymentCWProxyImpl(this._value);

  final PlaceOrderPayment _value;

  @override
  PlaceOrderPayment method(PaymentMethod method) => call(method: method);

  @override
  PlaceOrderPayment provider(PaymentProvider provider) =>
      call(provider: provider);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `PlaceOrderPayment(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// PlaceOrderPayment(...).copyWith(id: 12, name: "My name")
  /// ```
  PlaceOrderPayment call({
    Object? method = const $CopyWithPlaceholder(),
    Object? provider = const $CopyWithPlaceholder(),
  }) {
    return PlaceOrderPayment(
      method: method == const $CopyWithPlaceholder() || method == null
          ? _value.method
          // ignore: cast_nullable_to_non_nullable
          : method as PaymentMethod,
      provider: provider == const $CopyWithPlaceholder() || provider == null
          ? _value.provider
          // ignore: cast_nullable_to_non_nullable
          : provider as PaymentProvider,
    );
  }
}

extension $PlaceOrderPaymentCopyWith on PlaceOrderPayment {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfPlaceOrderPayment.copyWith(...)` or `instanceOfPlaceOrderPayment.copyWith.fieldName(...)`.
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
