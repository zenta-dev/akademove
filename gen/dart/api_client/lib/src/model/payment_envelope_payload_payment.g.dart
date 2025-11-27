// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_envelope_payload_payment.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$PaymentEnvelopePayloadPaymentCWProxy {
  PaymentEnvelopePayloadPayment id(String id);

  PaymentEnvelopePayloadPayment type(
    PaymentEnvelopePayloadPaymentTypeEnum type,
  );

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `PaymentEnvelopePayloadPayment(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// PaymentEnvelopePayloadPayment(...).copyWith(id: 12, name: "My name")
  /// ```
  PaymentEnvelopePayloadPayment call({
    String id,
    PaymentEnvelopePayloadPaymentTypeEnum type,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfPaymentEnvelopePayloadPayment.copyWith(...)` or call `instanceOfPaymentEnvelopePayloadPayment.copyWith.fieldName(value)` for a single field.
class _$PaymentEnvelopePayloadPaymentCWProxyImpl
    implements _$PaymentEnvelopePayloadPaymentCWProxy {
  const _$PaymentEnvelopePayloadPaymentCWProxyImpl(this._value);

  final PaymentEnvelopePayloadPayment _value;

  @override
  PaymentEnvelopePayloadPayment id(String id) => call(id: id);

  @override
  PaymentEnvelopePayloadPayment type(
    PaymentEnvelopePayloadPaymentTypeEnum type,
  ) => call(type: type);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `PaymentEnvelopePayloadPayment(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// PaymentEnvelopePayloadPayment(...).copyWith(id: 12, name: "My name")
  /// ```
  PaymentEnvelopePayloadPayment call({
    Object? id = const $CopyWithPlaceholder(),
    Object? type = const $CopyWithPlaceholder(),
  }) {
    return PaymentEnvelopePayloadPayment(
      id: id == const $CopyWithPlaceholder() || id == null
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
      type: type == const $CopyWithPlaceholder() || type == null
          ? _value.type
          // ignore: cast_nullable_to_non_nullable
          : type as PaymentEnvelopePayloadPaymentTypeEnum,
    );
  }
}

extension $PaymentEnvelopePayloadPaymentCopyWith
    on PaymentEnvelopePayloadPayment {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfPaymentEnvelopePayloadPayment.copyWith(...)` or `instanceOfPaymentEnvelopePayloadPayment.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$PaymentEnvelopePayloadPaymentCWProxy get copyWith =>
      _$PaymentEnvelopePayloadPaymentCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentEnvelopePayloadPayment _$PaymentEnvelopePayloadPaymentFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('PaymentEnvelopePayloadPayment', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['id', 'type']);
  final val = PaymentEnvelopePayloadPayment(
    id: $checkedConvert('id', (v) => v as String),
    type: $checkedConvert(
      'type',
      (v) => $enumDecode(_$PaymentEnvelopePayloadPaymentTypeEnumEnumMap, v),
    ),
  );
  return val;
});

Map<String, dynamic> _$PaymentEnvelopePayloadPaymentToJson(
  PaymentEnvelopePayloadPayment instance,
) => <String, dynamic>{
  'id': instance.id,
  'type': _$PaymentEnvelopePayloadPaymentTypeEnumEnumMap[instance.type]!,
};

const _$PaymentEnvelopePayloadPaymentTypeEnumEnumMap = {
  PaymentEnvelopePayloadPaymentTypeEnum.topup: 'topup',
  PaymentEnvelopePayloadPaymentTypeEnum.pay: 'pay',
};
