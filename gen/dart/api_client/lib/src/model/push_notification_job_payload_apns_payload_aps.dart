//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'push_notification_job_payload_apns_payload_aps.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class PushNotificationJobPayloadApnsPayloadAps {
  /// Returns a new [PushNotificationJobPayloadApnsPayloadAps] instance.
  const PushNotificationJobPayloadApnsPayloadAps({
    this.category,
    this.sound,
    this.badge,
  });
  @JsonKey(name: r'category', required: false, includeIfNull: false)
  final String? category;

  @JsonKey(name: r'sound', required: false, includeIfNull: false)
  final String? sound;

  @JsonKey(name: r'badge', required: false, includeIfNull: false)
  final num? badge;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PushNotificationJobPayloadApnsPayloadAps &&
          other.category == category &&
          other.sound == sound &&
          other.badge == badge;

  @override
  int get hashCode => category.hashCode + sound.hashCode + badge.hashCode;

  factory PushNotificationJobPayloadApnsPayloadAps.fromJson(
    Map<String, dynamic> json,
  ) => _$PushNotificationJobPayloadApnsPayloadApsFromJson(json);

  Map<String, dynamic> toJson() =>
      _$PushNotificationJobPayloadApnsPayloadApsToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
