//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/transaction.dart';
import 'package:api_client/src/model/order.dart';
import 'package:api_client/src/model/payment.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'order_envelope_payload_detail.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class OrderEnvelopePayloadDetail {
  /// Returns a new [OrderEnvelopePayloadDetail] instance.
  const OrderEnvelopePayloadDetail({
    required this.order,
    required this.payment,
    required this.transaction,
  });
  @JsonKey(name: r'order', required: true, includeIfNull: false)
  final Order order;

  @JsonKey(name: r'payment', required: true, includeIfNull: true)
  final Payment? payment;

  @JsonKey(name: r'transaction', required: true, includeIfNull: true)
  final Transaction? transaction;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OrderEnvelopePayloadDetail &&
          other.order == order &&
          other.payment == payment &&
          other.transaction == transaction;

  @override
  int get hashCode =>
      order.hashCode +
      (payment == null ? 0 : payment.hashCode) +
      (transaction == null ? 0 : transaction.hashCode);

  factory OrderEnvelopePayloadDetail.fromJson(Map<String, dynamic> json) =>
      _$OrderEnvelopePayloadDetailFromJson(json);

  Map<String, dynamic> toJson() => _$OrderEnvelopePayloadDetailToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
