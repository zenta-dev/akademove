//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'order_upload_delivery_proof200_response_data.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class OrderUploadDeliveryProof200ResponseData {
  /// Returns a new [OrderUploadDeliveryProof200ResponseData] instance.
  const OrderUploadDeliveryProof200ResponseData({required this.url});

  @JsonKey(name: r'url', required: true, includeIfNull: false)
  final String url;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OrderUploadDeliveryProof200ResponseData && other.url == url;

  @override
  int get hashCode => url.hashCode;

  factory OrderUploadDeliveryProof200ResponseData.fromJson(
    Map<String, dynamic> json,
  ) => _$OrderUploadDeliveryProof200ResponseDataFromJson(json);

  Map<String, dynamic> toJson() =>
      _$OrderUploadDeliveryProof200ResponseDataToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
