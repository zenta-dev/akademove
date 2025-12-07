//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'merchant_set_online_status_request.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class MerchantSetOnlineStatusRequest {
  /// Returns a new [MerchantSetOnlineStatusRequest] instance.
  const MerchantSetOnlineStatusRequest({required this.isOnline});
  @JsonKey(name: r'isOnline', required: true, includeIfNull: false)
  final bool isOnline;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MerchantSetOnlineStatusRequest && other.isOnline == isOnline;

  @override
  int get hashCode => isOnline.hashCode;

  factory MerchantSetOnlineStatusRequest.fromJson(Map<String, dynamic> json) =>
      _$MerchantSetOnlineStatusRequestFromJson(json);

  Map<String, dynamic> toJson() => _$MerchantSetOnlineStatusRequestToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
