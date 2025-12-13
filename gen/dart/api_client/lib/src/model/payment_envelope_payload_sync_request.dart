//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'payment_envelope_payload_sync_request.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class PaymentEnvelopePayloadSyncRequest {
  /// Returns a new [PaymentEnvelopePayloadSyncRequest] instance.
  const PaymentEnvelopePayloadSyncRequest({
    required this.paymentId,
     this.lastKnownVersion,
  });
  @JsonKey(name: r'paymentId', required: true, includeIfNull: false)
  final String paymentId;
  
  @JsonKey(name: r'lastKnownVersion', required: false, includeIfNull: false)
  final String? lastKnownVersion;
  
  @override
  bool operator ==(Object other) => identical(this, other) || other is PaymentEnvelopePayloadSyncRequest &&
    other.paymentId == paymentId &&
    other.lastKnownVersion == lastKnownVersion;

  @override
  int get hashCode =>
      paymentId.hashCode +
      lastKnownVersion.hashCode;

  factory PaymentEnvelopePayloadSyncRequest.fromJson(Map<String, dynamic> json) => _$PaymentEnvelopePayloadSyncRequestFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentEnvelopePayloadSyncRequestToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

