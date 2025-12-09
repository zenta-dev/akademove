//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'notification_get_unread_count200_response_data.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class NotificationGetUnreadCount200ResponseData {
  /// Returns a new [NotificationGetUnreadCount200ResponseData] instance.
  const NotificationGetUnreadCount200ResponseData({
    required this.count,
  });
  @JsonKey(name: r'count', required: true, includeIfNull: false)
  final num count;
  
  @override
  bool operator ==(Object other) => identical(this, other) || other is NotificationGetUnreadCount200ResponseData &&
    other.count == count;

  @override
  int get hashCode =>
      count.hashCode;

  factory NotificationGetUnreadCount200ResponseData.fromJson(Map<String, dynamic> json) => _$NotificationGetUnreadCount200ResponseDataFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationGetUnreadCount200ResponseDataToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

