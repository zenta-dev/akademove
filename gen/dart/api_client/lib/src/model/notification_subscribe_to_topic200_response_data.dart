//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'notification_subscribe_to_topic200_response_data.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class NotificationSubscribeToTopic200ResponseData {
  /// Returns a new [NotificationSubscribeToTopic200ResponseData] instance.
  const NotificationSubscribeToTopic200ResponseData({
    required this.successCount,
    required this.failureCount,
    this.errors,
  });

  @JsonKey(name: r'successCount', required: true, includeIfNull: false)
  final num successCount;

  @JsonKey(name: r'failureCount', required: true, includeIfNull: false)
  final num failureCount;

  @JsonKey(name: r'errors', required: false, includeIfNull: false)
  final Object? errors;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NotificationSubscribeToTopic200ResponseData &&
          other.successCount == successCount &&
          other.failureCount == failureCount &&
          other.errors == errors;

  @override
  int get hashCode =>
      successCount.hashCode +
      failureCount.hashCode +
      (errors == null ? 0 : errors.hashCode);

  factory NotificationSubscribeToTopic200ResponseData.fromJson(
    Map<String, dynamic> json,
  ) => _$NotificationSubscribeToTopic200ResponseDataFromJson(json);

  Map<String, dynamic> toJson() =>
      _$NotificationSubscribeToTopic200ResponseDataToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
