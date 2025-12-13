//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'update_scheduled_order.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class UpdateScheduledOrder {
  /// Returns a new [UpdateScheduledOrder] instance.
  const UpdateScheduledOrder({
     this.scheduledAt,
     this.cancelReason,
  });
  @JsonKey(name: r'scheduledAt', required: false, includeIfNull: false)
  final DateTime? scheduledAt;
  
  @JsonKey(name: r'cancelReason', required: false, includeIfNull: false)
  final String? cancelReason;
  
  @override
  bool operator ==(Object other) => identical(this, other) || other is UpdateScheduledOrder &&
    other.scheduledAt == scheduledAt &&
    other.cancelReason == cancelReason;

  @override
  int get hashCode =>
      scheduledAt.hashCode +
      cancelReason.hashCode;

  factory UpdateScheduledOrder.fromJson(Map<String, dynamic> json) => _$UpdateScheduledOrderFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateScheduledOrderToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

