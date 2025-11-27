//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'payment_envelope_payload_payment.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class PaymentEnvelopePayloadPayment {
  /// Returns a new [PaymentEnvelopePayloadPayment] instance.
  const PaymentEnvelopePayloadPayment({required this.id, required this.type});

  @JsonKey(name: r'id', required: true, includeIfNull: false)
  final String id;

  @JsonKey(name: r'type', required: true, includeIfNull: false)
  final PaymentEnvelopePayloadPaymentTypeEnum type;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PaymentEnvelopePayloadPayment &&
          other.id == id &&
          other.type == type;

  @override
  int get hashCode => id.hashCode + type.hashCode;

  factory PaymentEnvelopePayloadPayment.fromJson(Map<String, dynamic> json) =>
      _$PaymentEnvelopePayloadPaymentFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentEnvelopePayloadPaymentToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}

enum PaymentEnvelopePayloadPaymentTypeEnum {
  @JsonValue(r'topup')
  topup(r'topup'),
  @JsonValue(r'pay')
  pay(r'pay');

  const PaymentEnvelopePayloadPaymentTypeEnum(this.value);

  final String value;

  @override
  String toString() => value;
}
