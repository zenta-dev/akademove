//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/envelope_target.dart';
import 'package:api_client/src/model/merchant_envelope_payload.dart';
import 'package:api_client/src/model/merchant_envelope_action.dart';
import 'package:api_client/src/model/envelope_sender.dart';
import 'package:api_client/src/model/merchant_envelope_event.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'merchant_envelope.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class MerchantEnvelope {
  /// Returns a new [MerchantEnvelope] instance.
  const MerchantEnvelope({
    this.e,
    this.a,
    this.tg,
    required this.f,
    required this.t,
    required this.p,
  });
  @JsonKey(name: r'e', required: false, includeIfNull: false)
  final MerchantEnvelopeEvent? e;

  @JsonKey(name: r'a', required: false, includeIfNull: false)
  final MerchantEnvelopeAction? a;

  @JsonKey(name: r'tg', required: false, includeIfNull: false)
  final EnvelopeTarget? tg;

  @JsonKey(name: r'f', required: true, includeIfNull: false)
  final EnvelopeSender f;

  @JsonKey(name: r't', required: true, includeIfNull: false)
  final EnvelopeSender t;

  @JsonKey(name: r'p', required: true, includeIfNull: false)
  final MerchantEnvelopePayload p;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MerchantEnvelope &&
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

  factory MerchantEnvelope.fromJson(Map<String, dynamic> json) =>
      _$MerchantEnvelopeFromJson(json);

  Map<String, dynamic> toJson() => _$MerchantEnvelopeToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
