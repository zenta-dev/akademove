//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/time.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'schedule_update_request.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class ScheduleUpdateRequest {
  /// Returns a new [ScheduleUpdateRequest] instance.
  ScheduleUpdateRequest({
    this.dayOfWeek,

    this.startTime,

    this.endTime,

    this.isRecurring = true,

    this.specificDate,

    this.isActive = true,
  });

  @JsonKey(name: r'dayOfWeek', required: false, includeIfNull: false)
  final ScheduleUpdateRequestDayOfWeekEnum? dayOfWeek;

  @JsonKey(name: r'startTime', required: false, includeIfNull: false)
  final Time? startTime;

  @JsonKey(name: r'endTime', required: false, includeIfNull: false)
  final Time? endTime;

  @JsonKey(
    defaultValue: true,
    name: r'isRecurring',
    required: false,
    includeIfNull: false,
  )
  final bool? isRecurring;

  @JsonKey(name: r'specificDate', required: false, includeIfNull: false)
  final DateTime? specificDate;

  @JsonKey(
    defaultValue: true,
    name: r'isActive',
    required: false,
    includeIfNull: false,
  )
  final bool? isActive;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ScheduleUpdateRequest &&
          other.dayOfWeek == dayOfWeek &&
          other.startTime == startTime &&
          other.endTime == endTime &&
          other.isRecurring == isRecurring &&
          other.specificDate == specificDate &&
          other.isActive == isActive;

  @override
  int get hashCode =>
      dayOfWeek.hashCode +
      startTime.hashCode +
      endTime.hashCode +
      isRecurring.hashCode +
      specificDate.hashCode +
      isActive.hashCode;

  factory ScheduleUpdateRequest.fromJson(Map<String, dynamic> json) =>
      _$ScheduleUpdateRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ScheduleUpdateRequestToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}

enum ScheduleUpdateRequestDayOfWeekEnum {
  @JsonValue(r'sunday')
  sunday(r'sunday'),
  @JsonValue(r'monday')
  monday(r'monday'),
  @JsonValue(r'tuesday')
  tuesday(r'tuesday'),
  @JsonValue(r'wednesday')
  wednesday(r'wednesday'),
  @JsonValue(r'thursday')
  thursday(r'thursday'),
  @JsonValue(r'friday')
  friday(r'friday'),
  @JsonValue(r'saturday')
  saturday(r'saturday');

  const ScheduleUpdateRequestDayOfWeekEnum(this.value);

  final String value;

  @override
  String toString() => value;
}
