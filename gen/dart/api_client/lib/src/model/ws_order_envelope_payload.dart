//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/coordinate.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'ws_order_envelope_payload.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class WSOrderEnvelopePayload {
  /// Returns a new [WSOrderEnvelopePayload] instance.
  const WSOrderEnvelopePayload({this.driverUpdateLocation});

  @JsonKey(name: r'driverUpdateLocation', required: false, includeIfNull: false)
  final Coordinate? driverUpdateLocation;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WSOrderEnvelopePayload &&
          other.driverUpdateLocation == driverUpdateLocation;

  @override
  int get hashCode => driverUpdateLocation.hashCode;

  factory WSOrderEnvelopePayload.fromJson(Map<String, dynamic> json) =>
      _$WSOrderEnvelopePayloadFromJson(json);

  Map<String, dynamic> toJson() => _$WSOrderEnvelopePayloadToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
