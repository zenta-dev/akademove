//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/transaction.dart';
import 'package:api_client/src/model/payment.dart';
import 'package:api_client/src/model/wallet.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'ws_payment_envelope_payload.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class WSPaymentEnvelopePayload {
  /// Returns a new [WSPaymentEnvelopePayload] instance.
  const WSPaymentEnvelopePayload({
    required this.wallet,
    required this.transaction,
    required this.payment,
  });

  @JsonKey(name: r'wallet', required: true, includeIfNull: false)
  final Wallet wallet;

  @JsonKey(name: r'transaction', required: true, includeIfNull: false)
  final Transaction transaction;

  @JsonKey(name: r'payment', required: true, includeIfNull: false)
  final Payment payment;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WSPaymentEnvelopePayload &&
          other.wallet == wallet &&
          other.transaction == transaction &&
          other.payment == payment;

  @override
  int get hashCode => wallet.hashCode + transaction.hashCode + payment.hashCode;

  factory WSPaymentEnvelopePayload.fromJson(Map<String, dynamic> json) =>
      _$WSPaymentEnvelopePayloadFromJson(json);

  Map<String, dynamic> toJson() => _$WSPaymentEnvelopePayloadToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
