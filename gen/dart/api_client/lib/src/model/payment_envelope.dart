//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/envelope_target.dart';
import 'package:api_client/src/model/payment_envelope_payload.dart';
import 'package:api_client/src/model/payment_envelope_event.dart';
import 'package:api_client/src/model/envelope_sender.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'payment_envelope.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class PaymentEnvelope {
  /// Returns a new [PaymentEnvelope] instance.
  const PaymentEnvelope({
     this.e,
     this.a,
     this.tg,
    required this.f,
    required this.t,
    required this.p,
  });
  @JsonKey(name: r'e', required: false, includeIfNull: false)
  final PaymentEnvelopeEvent? e;
  
  @JsonKey(name: r'a', required: false, includeIfNull: false)
  final String? a;
  
  @JsonKey(name: r'tg', required: false, includeIfNull: false)
  final EnvelopeTarget? tg;
  
  @JsonKey(name: r'f', required: true, includeIfNull: false)
  final EnvelopeSender f;
  
  @JsonKey(name: r't', required: true, includeIfNull: false)
  final EnvelopeSender t;
  
  @JsonKey(name: r'p', required: true, includeIfNull: false)
  final PaymentEnvelopePayload p;
  
  @override
  bool operator ==(Object other) => identical(this, other) || other is PaymentEnvelope &&
    other.e == e &&
    other.a == a &&
    other.tg == tg &&
    other.f == f &&
    other.t == t &&
    other.p == p;

  @override
  int get hashCode =>
      e.hashCode +
      a.hashCode +
      tg.hashCode +
      f.hashCode +
      t.hashCode +
      p.hashCode;

  factory PaymentEnvelope.fromJson(Map<String, dynamic> json) => _$PaymentEnvelopeFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentEnvelopeToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

