//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'merchant_envelope_payload_sync_request.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class MerchantEnvelopePayloadSyncRequest {
  /// Returns a new [MerchantEnvelopePayloadSyncRequest] instance.
  const MerchantEnvelopePayloadSyncRequest({
    required this.merchantId,
     this.lastKnownVersion,
  });
  @JsonKey(name: r'merchantId', required: true, includeIfNull: false)
  final String merchantId;
  
  @JsonKey(name: r'lastKnownVersion', required: false, includeIfNull: false)
  final String? lastKnownVersion;
  
  @override
  bool operator ==(Object other) => identical(this, other) || other is MerchantEnvelopePayloadSyncRequest &&
    other.merchantId == merchantId &&
    other.lastKnownVersion == lastKnownVersion;

  @override
  int get hashCode =>
      merchantId.hashCode +
      lastKnownVersion.hashCode;

  factory MerchantEnvelopePayloadSyncRequest.fromJson(Map<String, dynamic> json) => _$MerchantEnvelopePayloadSyncRequestFromJson(json);

  Map<String, dynamic> toJson() => _$MerchantEnvelopePayloadSyncRequestToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

