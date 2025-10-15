//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/merchant.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'merchant_get_mine200_response_body.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class MerchantGetMine200ResponseBody {
  /// Returns a new [MerchantGetMine200ResponseBody] instance.
  MerchantGetMine200ResponseBody({
    required this.message,

    required this.data,

    this.totalPages,
  });

  @JsonKey(name: r'message', required: true, includeIfNull: false)
  final String message;

  @JsonKey(name: r'data', required: true, includeIfNull: false)
  final Merchant data;

  @JsonKey(name: r'totalPages', required: false, includeIfNull: false)
  final num? totalPages;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MerchantGetMine200ResponseBody &&
          other.message == message &&
          other.data == data &&
          other.totalPages == totalPages;

  @override
  int get hashCode => message.hashCode + data.hashCode + totalPages.hashCode;

  factory MerchantGetMine200ResponseBody.fromJson(Map<String, dynamic> json) =>
      _$MerchantGetMine200ResponseBodyFromJson(json);

  Map<String, dynamic> toJson() => _$MerchantGetMine200ResponseBodyToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
