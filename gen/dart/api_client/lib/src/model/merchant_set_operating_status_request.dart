//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'merchant_set_operating_status_request.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class MerchantSetOperatingStatusRequest {
  /// Returns a new [MerchantSetOperatingStatusRequest] instance.
  const MerchantSetOperatingStatusRequest({required this.operatingStatus});

  /// Merchant operating status
  @JsonKey(name: r'operatingStatus', required: true, includeIfNull: false)
  final MerchantSetOperatingStatusRequestOperatingStatusEnum operatingStatus;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MerchantSetOperatingStatusRequest &&
          other.operatingStatus == operatingStatus;

  @override
  int get hashCode => operatingStatus.hashCode;

  factory MerchantSetOperatingStatusRequest.fromJson(
    Map<String, dynamic> json,
  ) => _$MerchantSetOperatingStatusRequestFromJson(json);

  Map<String, dynamic> toJson() =>
      _$MerchantSetOperatingStatusRequestToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}

/// Merchant operating status
enum MerchantSetOperatingStatusRequestOperatingStatusEnum {
  /// Merchant operating status
  @JsonValue(r'OPEN')
  OPEN(r'OPEN'),

  /// Merchant operating status
  @JsonValue(r'CLOSED')
  CLOSED(r'CLOSED'),

  /// Merchant operating status
  @JsonValue(r'BREAK')
  BREAK(r'BREAK'),

  /// Merchant operating status
  @JsonValue(r'MAINTENANCE')
  MAINTENANCE(r'MAINTENANCE');

  const MerchantSetOperatingStatusRequestOperatingStatusEnum(this.value);

  final String value;

  @override
  String toString() => value;
}
