//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'payment_envelope_payload_wallet.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class PaymentEnvelopePayloadWallet {
  /// Returns a new [PaymentEnvelopePayloadWallet] instance.
  const PaymentEnvelopePayloadWallet({required this.id, required this.balance});

  @JsonKey(name: r'id', required: true, includeIfNull: false)
  final String id;

  @JsonKey(name: r'balance', required: true, includeIfNull: false)
  final num balance;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PaymentEnvelopePayloadWallet &&
          other.id == id &&
          other.balance == balance;

  @override
  int get hashCode => id.hashCode + balance.hashCode;

  factory PaymentEnvelopePayloadWallet.fromJson(Map<String, dynamic> json) =>
      _$PaymentEnvelopePayloadWalletFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentEnvelopePayloadWalletToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
