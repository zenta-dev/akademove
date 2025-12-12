//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'driver_update_taking_order_status_request.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class DriverUpdateTakingOrderStatusRequest {
  /// Returns a new [DriverUpdateTakingOrderStatusRequest] instance.
  const DriverUpdateTakingOrderStatusRequest({required this.isTakingOrder});
  @JsonKey(name: r'isTakingOrder', required: true, includeIfNull: false)
  final bool isTakingOrder;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DriverUpdateTakingOrderStatusRequest &&
          other.isTakingOrder == isTakingOrder;

  @override
  int get hashCode => isTakingOrder.hashCode;

  factory DriverUpdateTakingOrderStatusRequest.fromJson(
    Map<String, dynamic> json,
  ) => _$DriverUpdateTakingOrderStatusRequestFromJson(json);

  Map<String, dynamic> toJson() =>
      _$DriverUpdateTakingOrderStatusRequestToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
