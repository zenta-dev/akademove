//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/transaction_status.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'payment_envelope_payload_transaction.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class PaymentEnvelopePayloadTransaction {
  /// Returns a new [PaymentEnvelopePayloadTransaction] instance.
  const PaymentEnvelopePayloadTransaction({
    required this.id,
    required this.status,
  });

  @JsonKey(name: r'id', required: true, includeIfNull: false)
  final String id;

  @JsonKey(name: r'status', required: true, includeIfNull: false)
  final TransactionStatus status;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PaymentEnvelopePayloadTransaction &&
          other.id == id &&
          other.status == status;

  @override
  int get hashCode => id.hashCode + status.hashCode;

  factory PaymentEnvelopePayloadTransaction.fromJson(
    Map<String, dynamic> json,
  ) => _$PaymentEnvelopePayloadTransactionFromJson(json);

  Map<String, dynamic> toJson() =>
      _$PaymentEnvelopePayloadTransactionToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
