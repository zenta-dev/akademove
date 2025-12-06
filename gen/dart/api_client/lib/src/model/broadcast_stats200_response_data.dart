//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'broadcast_stats200_response_data.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class BroadcastStats200ResponseData {
  /// Returns a new [BroadcastStats200ResponseData] instance.
  const BroadcastStats200ResponseData({
    required this.total,
    required this.pending,
    required this.sending,
    required this.sent,
    required this.failed,
  });
  // minimum: -9007199254740991
  // maximum: 9007199254740991
  @JsonKey(name: r'total', required: true, includeIfNull: false)
  final int total;

  // minimum: -9007199254740991
  // maximum: 9007199254740991
  @JsonKey(name: r'pending', required: true, includeIfNull: false)
  final int pending;

  // minimum: -9007199254740991
  // maximum: 9007199254740991
  @JsonKey(name: r'sending', required: true, includeIfNull: false)
  final int sending;

  // minimum: -9007199254740991
  // maximum: 9007199254740991
  @JsonKey(name: r'sent', required: true, includeIfNull: false)
  final int sent;

  // minimum: -9007199254740991
  // maximum: 9007199254740991
  @JsonKey(name: r'failed', required: true, includeIfNull: false)
  final int failed;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BroadcastStats200ResponseData &&
          other.total == total &&
          other.pending == pending &&
          other.sending == sending &&
          other.sent == sent &&
          other.failed == failed;

  @override
  int get hashCode =>
      total.hashCode +
      pending.hashCode +
      sending.hashCode +
      sent.hashCode +
      failed.hashCode;

  factory BroadcastStats200ResponseData.fromJson(Map<String, dynamic> json) =>
      _$BroadcastStats200ResponseDataFromJson(json);

  Map<String, dynamic> toJson() => _$BroadcastStats200ResponseDataToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
