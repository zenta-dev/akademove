//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/day_of_week.dart';
import 'package:api_client/src/model/time.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'driver_schedule.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class DriverSchedule {
  /// Returns a new [DriverSchedule] instance.
  const DriverSchedule({
    required this.id,
    required this.driverId,
    required this.dayOfWeek,
    required this.startTime,
    required this.endTime,
    this.isRecurring = true,
    this.specificDate,
    this.isActive = true,
    required this.createdAt,
    required this.updatedAt,
  });

  @JsonKey(name: r'id', required: true, includeIfNull: false)
  final String id;

  @JsonKey(name: r'driverId', required: true, includeIfNull: false)
  final String driverId;

  @JsonKey(name: r'dayOfWeek', required: true, includeIfNull: false)
  final DayOfWeek dayOfWeek;

  @JsonKey(name: r'startTime', required: true, includeIfNull: false)
  final Time startTime;

  @JsonKey(name: r'endTime', required: true, includeIfNull: false)
  final Time endTime;

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

  @JsonKey(name: r'createdAt', required: true, includeIfNull: false)
  final DateTime createdAt;

  @JsonKey(name: r'updatedAt', required: true, includeIfNull: false)
  final DateTime updatedAt;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DriverSchedule &&
          other.id == id &&
          other.driverId == driverId &&
          other.dayOfWeek == dayOfWeek &&
          other.startTime == startTime &&
          other.endTime == endTime &&
          other.isRecurring == isRecurring &&
          other.specificDate == specificDate &&
          other.isActive == isActive &&
          other.createdAt == createdAt &&
          other.updatedAt == updatedAt;

  @override
  int get hashCode =>
      id.hashCode +
      driverId.hashCode +
      dayOfWeek.hashCode +
      startTime.hashCode +
      endTime.hashCode +
      isRecurring.hashCode +
      specificDate.hashCode +
      isActive.hashCode +
      createdAt.hashCode +
      updatedAt.hashCode;

  factory DriverSchedule.fromJson(Map<String, dynamic> json) =>
      _$DriverScheduleFromJson(json);

  Map<String, dynamic> toJson() => _$DriverScheduleToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
