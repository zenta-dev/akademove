//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'merchant_deactivate_request.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class MerchantDeactivateRequest {
  /// Returns a new [MerchantDeactivateRequest] instance.
  const MerchantDeactivateRequest({required this.reason});

  /// Reason for deactivation
  @JsonKey(name: r'reason', required: true, includeIfNull: false)
  final String reason;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MerchantDeactivateRequest && other.reason == reason;

  @override
  int get hashCode => reason.hashCode;

  factory MerchantDeactivateRequest.fromJson(Map<String, dynamic> json) =>
      _$MerchantDeactivateRequestFromJson(json);

  Map<String, dynamic> toJson() => _$MerchantDeactivateRequestToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
