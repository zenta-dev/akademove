//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'order_envelope_payload_sync_request.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class OrderEnvelopePayloadSyncRequest {
  /// Returns a new [OrderEnvelopePayloadSyncRequest] instance.
  const OrderEnvelopePayloadSyncRequest({
    required this.orderId,
    this.lastKnownVersion,
  });
  @JsonKey(name: r'orderId', required: true, includeIfNull: false)
  final String orderId;

  @JsonKey(name: r'lastKnownVersion', required: false, includeIfNull: false)
  final String? lastKnownVersion;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OrderEnvelopePayloadSyncRequest &&
          other.orderId == orderId &&
          other.lastKnownVersion == lastKnownVersion;

  @override
  int get hashCode => orderId.hashCode + lastKnownVersion.hashCode;

  factory OrderEnvelopePayloadSyncRequest.fromJson(Map<String, dynamic> json) =>
      _$OrderEnvelopePayloadSyncRequestFromJson(json);

  Map<String, dynamic> toJson() =>
      _$OrderEnvelopePayloadSyncRequestToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
