//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'order_envelope_payload_merchant_action.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class OrderEnvelopePayloadMerchantAction {
  /// Returns a new [OrderEnvelopePayloadMerchantAction] instance.
  const OrderEnvelopePayloadMerchantAction({
    required this.orderId,
    required this.merchantId,
     this.reason,
  });
  @JsonKey(name: r'orderId', required: true, includeIfNull: false)
  final String orderId;
  
  @JsonKey(name: r'merchantId', required: true, includeIfNull: false)
  final String merchantId;
  
  @JsonKey(name: r'reason', required: false, includeIfNull: false)
  final String? reason;
  
  @override
  bool operator ==(Object other) => identical(this, other) || other is OrderEnvelopePayloadMerchantAction &&
    other.orderId == orderId &&
    other.merchantId == merchantId &&
    other.reason == reason;

  @override
  int get hashCode =>
      orderId.hashCode +
      merchantId.hashCode +
      reason.hashCode;

  factory OrderEnvelopePayloadMerchantAction.fromJson(Map<String, dynamic> json) => _$OrderEnvelopePayloadMerchantActionFromJson(json);

  Map<String, dynamic> toJson() => _$OrderEnvelopePayloadMerchantActionToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

