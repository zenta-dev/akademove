//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/ws_envelope_type.dart';
import 'package:api_client/src/model/ws_top_up_envelope_payload.dart';
import 'package:api_client/src/model/ws_envelope_sender.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'ws_top_up_envelope.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class WSTopUpEnvelope {
  /// Returns a new [WSTopUpEnvelope] instance.
  const WSTopUpEnvelope({
    required this.type,
    required this.from,
    required this.to,
    required this.payload,
  });

  @JsonKey(name: r'type', required: true, includeIfNull: false)
  final WSEnvelopeType type;

  @JsonKey(name: r'from', required: true, includeIfNull: false)
  final WSEnvelopeSender from;

  @JsonKey(name: r'to', required: true, includeIfNull: false)
  final WSEnvelopeSender to;

  @JsonKey(name: r'payload', required: true, includeIfNull: false)
  final WSTopUpEnvelopePayload payload;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WSTopUpEnvelope &&
          other.type == type &&
          other.from == from &&
          other.to == to &&
          other.payload == payload;

  @override
  int get hashCode =>
      type.hashCode + from.hashCode + to.hashCode + payload.hashCode;

  factory WSTopUpEnvelope.fromJson(Map<String, dynamic> json) =>
      _$WSTopUpEnvelopeFromJson(json);

  Map<String, dynamic> toJson() => _$WSTopUpEnvelopeToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
