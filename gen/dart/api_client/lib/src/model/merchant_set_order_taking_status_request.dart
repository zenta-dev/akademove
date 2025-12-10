//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'merchant_set_order_taking_status_request.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class MerchantSetOrderTakingStatusRequest {
  /// Returns a new [MerchantSetOrderTakingStatusRequest] instance.
  const MerchantSetOrderTakingStatusRequest({
    required this.isTakingOrders,
  });
  @JsonKey(name: r'isTakingOrders', required: true, includeIfNull: false)
  final bool isTakingOrders;
  
  @override
  bool operator ==(Object other) => identical(this, other) || other is MerchantSetOrderTakingStatusRequest &&
    other.isTakingOrders == isTakingOrders;

  @override
  int get hashCode =>
      isTakingOrders.hashCode;

  factory MerchantSetOrderTakingStatusRequest.fromJson(Map<String, dynamic> json) => _$MerchantSetOrderTakingStatusRequestFromJson(json);

  Map<String, dynamic> toJson() => _$MerchantSetOrderTakingStatusRequestToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

