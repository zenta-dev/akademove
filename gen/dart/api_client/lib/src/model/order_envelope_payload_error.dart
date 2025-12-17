//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'order_envelope_payload_error.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class OrderEnvelopePayloadError {
  /// Returns a new [OrderEnvelopePayloadError] instance.
  const OrderEnvelopePayloadError({required this.code, required this.message});
  @JsonKey(name: r'code', required: true, includeIfNull: false)
  final String code;

  @JsonKey(name: r'message', required: true, includeIfNull: false)
  final String message;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OrderEnvelopePayloadError &&
          other.code == code &&
          other.message == message;

  @override
  int get hashCode => code.hashCode + message.hashCode;

  factory OrderEnvelopePayloadError.fromJson(Map<String, dynamic> json) =>
      _$OrderEnvelopePayloadErrorFromJson(json);

  Map<String, dynamic> toJson() => _$OrderEnvelopePayloadErrorToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
