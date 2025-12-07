//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/transaction.dart';
import 'package:api_client/src/model/payment.dart';
import 'package:api_client/src/model/wallet.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'payment_envelope_payload.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class PaymentEnvelopePayload {
  /// Returns a new [PaymentEnvelopePayload] instance.
  const PaymentEnvelopePayload({
     this.failReason,
    required this.payment,
    required this.transaction,
     this.wallet,
  });
  @JsonKey(name: r'failReason', required: false, includeIfNull: false)
  final String? failReason;
  
  @JsonKey(name: r'payment', required: true, includeIfNull: false)
  final Payment payment;
  
  @JsonKey(name: r'transaction', required: true, includeIfNull: false)
  final Transaction transaction;
  
  @JsonKey(name: r'wallet', required: false, includeIfNull: false)
  final Wallet? wallet;
  
  @override
  bool operator ==(Object other) => identical(this, other) || other is PaymentEnvelopePayload &&
    other.failReason == failReason &&
    other.payment == payment &&
    other.transaction == transaction &&
    other.wallet == wallet;

  @override
  int get hashCode =>
      failReason.hashCode +
      payment.hashCode +
      transaction.hashCode +
      wallet.hashCode;

  factory PaymentEnvelopePayload.fromJson(Map<String, dynamic> json) => _$PaymentEnvelopePayloadFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentEnvelopePayloadToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

