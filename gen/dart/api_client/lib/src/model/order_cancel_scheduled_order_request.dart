//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'order_cancel_scheduled_order_request.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class OrderCancelScheduledOrderRequest {
  /// Returns a new [OrderCancelScheduledOrderRequest] instance.
  const OrderCancelScheduledOrderRequest({
     this.reason,
  });
  @JsonKey(name: r'reason', required: false, includeIfNull: false)
  final String? reason;
  
  @override
  bool operator ==(Object other) => identical(this, other) || other is OrderCancelScheduledOrderRequest &&
    other.reason == reason;

  @override
  int get hashCode =>
      reason.hashCode;

  factory OrderCancelScheduledOrderRequest.fromJson(Map<String, dynamic> json) => _$OrderCancelScheduledOrderRequestFromJson(json);

  Map<String, dynamic> toJson() => _$OrderCancelScheduledOrderRequestToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

