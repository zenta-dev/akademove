//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'order_upload_delivery_proof_request.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class OrderUploadDeliveryProofRequest {
  /// Returns a new [OrderUploadDeliveryProofRequest] instance.
  const OrderUploadDeliveryProofRequest({required this.file});
  @JsonKey(name: r'file', required: true, includeIfNull: true)
  final Object? file;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OrderUploadDeliveryProofRequest && other.file == file;

  @override
  int get hashCode => (file == null ? 0 : file.hashCode);

  factory OrderUploadDeliveryProofRequest.fromJson(Map<String, dynamic> json) =>
      _$OrderUploadDeliveryProofRequestFromJson(json);

  Map<String, dynamic> toJson() =>
      _$OrderUploadDeliveryProofRequestToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
