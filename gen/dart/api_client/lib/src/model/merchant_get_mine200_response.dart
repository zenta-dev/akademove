//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/merchant_get_mine200_response_body.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'merchant_get_mine200_response.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class MerchantGetMine200Response {
  /// Returns a new [MerchantGetMine200Response] instance.
  const MerchantGetMine200Response({required this.status, required this.body});
  @JsonKey(name: r'status', required: true, includeIfNull: true)
  final Object? status;

  @JsonKey(name: r'body', required: true, includeIfNull: false)
  final MerchantGetMine200ResponseBody body;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MerchantGetMine200Response &&
          other.status == status &&
          other.body == body;

  @override
  int get hashCode => (status == null ? 0 : status.hashCode) + body.hashCode;

  factory MerchantGetMine200Response.fromJson(Map<String, dynamic> json) =>
      _$MerchantGetMine200ResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MerchantGetMine200ResponseToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
