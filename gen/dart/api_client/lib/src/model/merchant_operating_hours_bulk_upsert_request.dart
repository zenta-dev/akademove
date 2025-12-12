//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/merchant_operating_hours_create_request.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'merchant_operating_hours_bulk_upsert_request.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class MerchantOperatingHoursBulkUpsertRequest {
  /// Returns a new [MerchantOperatingHoursBulkUpsertRequest] instance.
  const MerchantOperatingHoursBulkUpsertRequest({required this.hours});
  @JsonKey(name: r'hours', required: true, includeIfNull: false)
  final List<MerchantOperatingHoursCreateRequest> hours;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MerchantOperatingHoursBulkUpsertRequest && other.hours == hours;

  @override
  int get hashCode => hours.hashCode;

  factory MerchantOperatingHoursBulkUpsertRequest.fromJson(
    Map<String, dynamic> json,
  ) => _$MerchantOperatingHoursBulkUpsertRequestFromJson(json);

  Map<String, dynamic> toJson() =>
      _$MerchantOperatingHoursBulkUpsertRequestToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
