//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'emergency_with_contact_order_info.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class EmergencyWithContactOrderInfo {
  /// Returns a new [EmergencyWithContactOrderInfo] instance.
  const EmergencyWithContactOrderInfo({
    required this.id,
    required this.type,
    required this.status,
    this.pickupAddress,
    this.dropoffAddress,
  });
  @JsonKey(name: r'id', required: true, includeIfNull: false)
  final String id;

  @JsonKey(name: r'type', required: true, includeIfNull: false)
  final String type;

  @JsonKey(name: r'status', required: true, includeIfNull: false)
  final String status;

  @JsonKey(name: r'pickupAddress', required: false, includeIfNull: false)
  final String? pickupAddress;

  @JsonKey(name: r'dropoffAddress', required: false, includeIfNull: false)
  final String? dropoffAddress;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EmergencyWithContactOrderInfo &&
          other.id == id &&
          other.type == type &&
          other.status == status &&
          other.pickupAddress == pickupAddress &&
          other.dropoffAddress == dropoffAddress;

  @override
  int get hashCode =>
      id.hashCode +
      type.hashCode +
      status.hashCode +
      pickupAddress.hashCode +
      dropoffAddress.hashCode;

  factory EmergencyWithContactOrderInfo.fromJson(Map<String, dynamic> json) =>
      _$EmergencyWithContactOrderInfoFromJson(json);

  Map<String, dynamic> toJson() => _$EmergencyWithContactOrderInfoToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
