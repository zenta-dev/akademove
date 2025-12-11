//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/order.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'merchant_envelope_payload.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class MerchantEnvelopePayload {
  /// Returns a new [MerchantEnvelopePayload] instance.
  const MerchantEnvelopePayload({
     this.order,
     this.orderId,
     this.merchantId,
     this.itemCount,
     this.totalAmount,
     this.cancelReason,
     this.driverName,
     this.newStatus,
  });
  @JsonKey(name: r'order', required: false, includeIfNull: false)
  final Order? order;
  
  @JsonKey(name: r'orderId', required: false, includeIfNull: false)
  final String? orderId;
  
  @JsonKey(name: r'merchantId', required: false, includeIfNull: false)
  final String? merchantId;
  
  @JsonKey(name: r'itemCount', required: false, includeIfNull: false)
  final num? itemCount;
  
  @JsonKey(name: r'totalAmount', required: false, includeIfNull: false)
  final num? totalAmount;
  
  @JsonKey(name: r'cancelReason', required: false, includeIfNull: false)
  final String? cancelReason;
  
  @JsonKey(name: r'driverName', required: false, includeIfNull: false)
  final String? driverName;
  
  @JsonKey(name: r'newStatus', required: false, includeIfNull: false)
  final String? newStatus;
  
  @override
  bool operator ==(Object other) => identical(this, other) || other is MerchantEnvelopePayload &&
    other.order == order &&
    other.orderId == orderId &&
    other.merchantId == merchantId &&
    other.itemCount == itemCount &&
    other.totalAmount == totalAmount &&
    other.cancelReason == cancelReason &&
    other.driverName == driverName &&
    other.newStatus == newStatus;

  @override
  int get hashCode =>
      order.hashCode +
      orderId.hashCode +
      merchantId.hashCode +
      itemCount.hashCode +
      totalAmount.hashCode +
      cancelReason.hashCode +
      driverName.hashCode +
      newStatus.hashCode;

  factory MerchantEnvelopePayload.fromJson(Map<String, dynamic> json) => _$MerchantEnvelopePayloadFromJson(json);

  Map<String, dynamic> toJson() => _$MerchantEnvelopePayloadToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

