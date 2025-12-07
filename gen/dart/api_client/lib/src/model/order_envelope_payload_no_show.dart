//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'order_envelope_payload_no_show.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class OrderEnvelopePayloadNoShow {
  /// Returns a new [OrderEnvelopePayloadNoShow] instance.
  const OrderEnvelopePayloadNoShow({
    required this.orderId,
    required this.driverId,
     this.reason,
  });
  @JsonKey(name: r'orderId', required: true, includeIfNull: false)
  final String orderId;
  
  @JsonKey(name: r'driverId', required: true, includeIfNull: false)
  final String driverId;
  
  @JsonKey(name: r'reason', required: false, includeIfNull: false)
  final String? reason;
  
  @override
  bool operator ==(Object other) => identical(this, other) || other is OrderEnvelopePayloadNoShow &&
    other.orderId == orderId &&
    other.driverId == driverId &&
    other.reason == reason;

  @override
  int get hashCode =>
      orderId.hashCode +
      driverId.hashCode +
      reason.hashCode;

  factory OrderEnvelopePayloadNoShow.fromJson(Map<String, dynamic> json) => _$OrderEnvelopePayloadNoShowFromJson(json);

  Map<String, dynamic> toJson() => _$OrderEnvelopePayloadNoShowToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

