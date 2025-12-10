//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/driver_matching_job_payload_pickup_location.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'driver_matching_job_payload.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class DriverMatchingJobPayload {
  /// Returns a new [DriverMatchingJobPayload] instance.
  const DriverMatchingJobPayload({
    required this.orderId,
    required this.pickupLocation,
    required this.orderType,
    this.genderPreference,
    this.userGender,
    this.initialRadiusKm = 5,
    this.maxMatchingDurationMinutes = 15,
    this.currentAttempt = 1,
    this.maxExpansionAttempts = 10,
    this.expansionRate = 0.2,
    this.matchingIntervalSeconds = 30,
    this.paymentId,
    this.wsRoomId,
  });
  @JsonKey(name: r'orderId', required: true, includeIfNull: false)
  final String orderId;

  @JsonKey(name: r'pickupLocation', required: true, includeIfNull: false)
  final DriverMatchingJobPayloadPickupLocation pickupLocation;

  @JsonKey(name: r'orderType', required: true, includeIfNull: false)
  final DriverMatchingJobPayloadOrderTypeEnum orderType;

  @JsonKey(name: r'genderPreference', required: false, includeIfNull: false)
  final DriverMatchingJobPayloadGenderPreferenceEnum? genderPreference;

  @JsonKey(name: r'userGender', required: false, includeIfNull: false)
  final DriverMatchingJobPayloadUserGenderEnum? userGender;

  @JsonKey(
    defaultValue: 5,
    name: r'initialRadiusKm',
    required: false,
    includeIfNull: false,
  )
  final num? initialRadiusKm;

  @JsonKey(
    defaultValue: 15,
    name: r'maxMatchingDurationMinutes',
    required: false,
    includeIfNull: false,
  )
  final num? maxMatchingDurationMinutes;

  // minimum: 1
  // maximum: 9007199254740991
  @JsonKey(
    defaultValue: 1,
    name: r'currentAttempt',
    required: false,
    includeIfNull: false,
  )
  final int? currentAttempt;

  // minimum: -9007199254740991
  // maximum: 9007199254740991
  @JsonKey(
    defaultValue: 10,
    name: r'maxExpansionAttempts',
    required: false,
    includeIfNull: false,
  )
  final int? maxExpansionAttempts;

  @JsonKey(
    defaultValue: 0.2,
    name: r'expansionRate',
    required: false,
    includeIfNull: false,
  )
  final num? expansionRate;

  @JsonKey(
    defaultValue: 30,
    name: r'matchingIntervalSeconds',
    required: false,
    includeIfNull: false,
  )
  final num? matchingIntervalSeconds;

  @JsonKey(name: r'paymentId', required: false, includeIfNull: false)
  final String? paymentId;

  @JsonKey(name: r'wsRoomId', required: false, includeIfNull: false)
  final String? wsRoomId;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DriverMatchingJobPayload &&
          other.orderId == orderId &&
          other.pickupLocation == pickupLocation &&
          other.orderType == orderType &&
          other.genderPreference == genderPreference &&
          other.userGender == userGender &&
          other.initialRadiusKm == initialRadiusKm &&
          other.maxMatchingDurationMinutes == maxMatchingDurationMinutes &&
          other.currentAttempt == currentAttempt &&
          other.maxExpansionAttempts == maxExpansionAttempts &&
          other.expansionRate == expansionRate &&
          other.matchingIntervalSeconds == matchingIntervalSeconds &&
          other.paymentId == paymentId &&
          other.wsRoomId == wsRoomId;

  @override
  int get hashCode =>
      orderId.hashCode +
      pickupLocation.hashCode +
      orderType.hashCode +
      genderPreference.hashCode +
      userGender.hashCode +
      initialRadiusKm.hashCode +
      maxMatchingDurationMinutes.hashCode +
      currentAttempt.hashCode +
      maxExpansionAttempts.hashCode +
      expansionRate.hashCode +
      matchingIntervalSeconds.hashCode +
      paymentId.hashCode +
      wsRoomId.hashCode;

  factory DriverMatchingJobPayload.fromJson(Map<String, dynamic> json) =>
      _$DriverMatchingJobPayloadFromJson(json);

  Map<String, dynamic> toJson() => _$DriverMatchingJobPayloadToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}

enum DriverMatchingJobPayloadOrderTypeEnum {
  @JsonValue(r'RIDE')
  RIDE(r'RIDE'),
  @JsonValue(r'DELIVERY')
  DELIVERY(r'DELIVERY'),
  @JsonValue(r'FOOD')
  FOOD(r'FOOD');

  const DriverMatchingJobPayloadOrderTypeEnum(this.value);

  final String value;

  @override
  String toString() => value;
}

enum DriverMatchingJobPayloadGenderPreferenceEnum {
  @JsonValue(r'SAME')
  SAME(r'SAME'),
  @JsonValue(r'ANY')
  ANY(r'ANY');

  const DriverMatchingJobPayloadGenderPreferenceEnum(this.value);

  final String value;

  @override
  String toString() => value;
}

enum DriverMatchingJobPayloadUserGenderEnum {
  @JsonValue(r'MALE')
  MALE(r'MALE'),
  @JsonValue(r'FEMALE')
  FEMALE(r'FEMALE');

  const DriverMatchingJobPayloadUserGenderEnum(this.value);

  final String value;

  @override
  String toString() => value;
}
