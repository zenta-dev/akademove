//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/day_of_week.dart';
import 'package:api_client/src/model/time.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'update_driver_schedule_request.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class UpdateDriverScheduleRequest {
  /// Returns a new [UpdateDriverScheduleRequest] instance.
  const UpdateDriverScheduleRequest({
    this.name,
    this.dayOfWeek,
    this.startTime,
    this.endTime,
    this.isRecurring = true,
    this.specificDate,
    this.isActive = true,
  });

  @JsonKey(name: r'name', required: false, includeIfNull: false)
  final String? name;

  @JsonKey(name: r'dayOfWeek', required: false, includeIfNull: false)
  final DayOfWeek? dayOfWeek;

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
      other is UpdateDriverScheduleRequest &&
          other.name == name &&
          other.dayOfWeek == dayOfWeek &&
          other.startTime == startTime &&
          other.endTime == endTime &&
          other.isRecurring == isRecurring &&
          other.specificDate == specificDate &&
          other.isActive == isActive;

  @override
  int get hashCode =>
      name.hashCode +
      dayOfWeek.hashCode +
      startTime.hashCode +
      endTime.hashCode +
      isRecurring.hashCode +
      specificDate.hashCode +
      isActive.hashCode;

  factory UpdateDriverScheduleRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateDriverScheduleRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateDriverScheduleRequestToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
