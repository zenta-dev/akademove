//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/day_of_week.dart';
import 'package:api_client/src/model/time.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'driver_schedule_create_request.g.dart';

@CopyWith()
@JsonSerializable(checked: true, createToJson: true, disallowUnrecognizedKeys: false, explicitToJson: true)
class DriverScheduleCreateRequest {
  /// Returns a new [DriverScheduleCreateRequest] instance.
  const DriverScheduleCreateRequest({
    required this.name,
    required this.driverId,
    required this.dayOfWeek,
    required this.startTime,
    required this.endTime,
    this.isRecurring = true,
    this.specificDate,
    this.isActive = true,
  });

  @JsonKey(name: r'name', required: true, includeIfNull: false)
  final String name;

  @JsonKey(name: r'driverId', required: true, includeIfNull: false)
  final String driverId;

  @JsonKey(name: r'dayOfWeek', required: true, includeIfNull: false)
  final DayOfWeek dayOfWeek;

  @JsonKey(name: r'startTime', required: true, includeIfNull: false)
  final Time startTime;

  @JsonKey(name: r'endTime', required: true, includeIfNull: false)
  final Time endTime;

  @JsonKey(defaultValue: true, name: r'isRecurring', required: false, includeIfNull: false)
  final bool? isRecurring;

  @JsonKey(name: r'specificDate', required: false, includeIfNull: false)
  final DateTime? specificDate;

  @JsonKey(defaultValue: true, name: r'isActive', required: false, includeIfNull: false)
  final bool? isActive;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DriverScheduleCreateRequest &&
          other.name == name &&
          other.driverId == driverId &&
          other.dayOfWeek == dayOfWeek &&
          other.startTime == startTime &&
          other.endTime == endTime &&
          other.isRecurring == isRecurring &&
          other.specificDate == specificDate &&
          other.isActive == isActive;

  @override
  int get hashCode =>
      name.hashCode +
      driverId.hashCode +
      dayOfWeek.hashCode +
      startTime.hashCode +
      endTime.hashCode +
      isRecurring.hashCode +
      specificDate.hashCode +
      isActive.hashCode;

  factory DriverScheduleCreateRequest.fromJson(Map<String, dynamic> json) =>
      _$DriverScheduleCreateRequestFromJson(json);

  Map<String, dynamic> toJson() => _$DriverScheduleCreateRequestToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
