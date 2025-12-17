//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'business_configuration.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class BusinessConfiguration {
  /// Returns a new [BusinessConfiguration] instance.
  const BusinessConfiguration({
    required this.minTransferAmount,
    required this.minWithdrawalAmount,
    required this.minTopUpAmount,
    required this.quickTopUpAmounts,
    required this.userCancellationFeeBeforeAccept,
    required this.userCancellationFeeAfterAccept,
    required this.noShowFee,
    required this.noShowDriverCompensationRate,
    required this.highValueOrderThreshold,
    this.driverMatchingTimeoutMinutes = 15,
    this.driverMatchingInitialRadiusKm = 5,
    this.driverMatchingMaxRadiusKm = 20,
    this.driverMatchingRadiusExpansionRate = 0.2,
    this.driverMatchingIntervalSeconds = 30,
    this.driverMatchingBroadcastLimit = 10,
    this.driverMaxCancellationsPerDay = 3,
    this.paymentPendingTimeoutMinutes = 15,
    this.orderCompletionTimeoutMinutes = 60,
    this.noShowTimeoutMinutes = 30,
    this.orderStaleTimestampMinutes = 5,
    this.driverLocationStaleThresholdMinutes = 15,
    this.driverRebroadcastIntervalMinutes = 2,
    this.driverRebroadcastRadiusMultiplier = 1.5,
    this.maxBadgeCommissionReduction = 0.5,
    this.scheduledOrderMinAdvanceMinutes = 30,
    this.scheduledOrderMaxAdvanceDays = 7,
    this.scheduledOrderMatchingLeadTimeMinutes = 15,
    this.scheduledOrderMinRescheduleHours = 1,
    this.onTimeDeliveryThresholdMinutes = 10,
  });
  @JsonKey(name: r'minTransferAmount', required: true, includeIfNull: false)
  final num minTransferAmount;

  @JsonKey(name: r'minWithdrawalAmount', required: true, includeIfNull: false)
  final num minWithdrawalAmount;

  @JsonKey(name: r'minTopUpAmount', required: true, includeIfNull: false)
  final num minTopUpAmount;

  @JsonKey(name: r'quickTopUpAmounts', required: true, includeIfNull: false)
  final List<num> quickTopUpAmounts;

  // minimum: 0
  // maximum: 1
  @JsonKey(
    name: r'userCancellationFeeBeforeAccept',
    required: true,
    includeIfNull: false,
  )
  final num userCancellationFeeBeforeAccept;

  // minimum: 0
  // maximum: 1
  @JsonKey(
    name: r'userCancellationFeeAfterAccept',
    required: true,
    includeIfNull: false,
  )
  final num userCancellationFeeAfterAccept;

  // minimum: 0
  // maximum: 1
  @JsonKey(name: r'noShowFee', required: true, includeIfNull: false)
  final num noShowFee;

  // minimum: 0
  // maximum: 1
  @JsonKey(
    name: r'noShowDriverCompensationRate',
    required: true,
    includeIfNull: false,
  )
  final num noShowDriverCompensationRate;

  @JsonKey(
    name: r'highValueOrderThreshold',
    required: true,
    includeIfNull: false,
  )
  final num highValueOrderThreshold;

  @JsonKey(
    defaultValue: 15,
    name: r'driverMatchingTimeoutMinutes',
    required: false,
    includeIfNull: false,
  )
  final num? driverMatchingTimeoutMinutes;

  @JsonKey(
    defaultValue: 5,
    name: r'driverMatchingInitialRadiusKm',
    required: false,
    includeIfNull: false,
  )
  final num? driverMatchingInitialRadiusKm;

  @JsonKey(
    defaultValue: 20,
    name: r'driverMatchingMaxRadiusKm',
    required: false,
    includeIfNull: false,
  )
  final num? driverMatchingMaxRadiusKm;

  @JsonKey(
    defaultValue: 0.2,
    name: r'driverMatchingRadiusExpansionRate',
    required: false,
    includeIfNull: false,
  )
  final num? driverMatchingRadiusExpansionRate;

  @JsonKey(
    defaultValue: 30,
    name: r'driverMatchingIntervalSeconds',
    required: false,
    includeIfNull: false,
  )
  final num? driverMatchingIntervalSeconds;

  // minimum: -9007199254740991
  // maximum: 9007199254740991
  @JsonKey(
    defaultValue: 10,
    name: r'driverMatchingBroadcastLimit',
    required: false,
    includeIfNull: false,
  )
  final int? driverMatchingBroadcastLimit;

  // minimum: -9007199254740991
  // maximum: 9007199254740991
  @JsonKey(
    defaultValue: 3,
    name: r'driverMaxCancellationsPerDay',
    required: false,
    includeIfNull: false,
  )
  final int? driverMaxCancellationsPerDay;

  @JsonKey(
    defaultValue: 15,
    name: r'paymentPendingTimeoutMinutes',
    required: false,
    includeIfNull: false,
  )
  final num? paymentPendingTimeoutMinutes;

  @JsonKey(
    defaultValue: 60,
    name: r'orderCompletionTimeoutMinutes',
    required: false,
    includeIfNull: false,
  )
  final num? orderCompletionTimeoutMinutes;

  @JsonKey(
    defaultValue: 30,
    name: r'noShowTimeoutMinutes',
    required: false,
    includeIfNull: false,
  )
  final num? noShowTimeoutMinutes;

  @JsonKey(
    defaultValue: 5,
    name: r'orderStaleTimestampMinutes',
    required: false,
    includeIfNull: false,
  )
  final num? orderStaleTimestampMinutes;

  @JsonKey(
    defaultValue: 15,
    name: r'driverLocationStaleThresholdMinutes',
    required: false,
    includeIfNull: false,
  )
  final num? driverLocationStaleThresholdMinutes;

  @JsonKey(
    defaultValue: 2,
    name: r'driverRebroadcastIntervalMinutes',
    required: false,
    includeIfNull: false,
  )
  final num? driverRebroadcastIntervalMinutes;

  @JsonKey(
    defaultValue: 1.5,
    name: r'driverRebroadcastRadiusMultiplier',
    required: false,
    includeIfNull: false,
  )
  final num? driverRebroadcastRadiusMultiplier;

  // minimum: 0
  // maximum: 1
  @JsonKey(
    defaultValue: 0.5,
    name: r'maxBadgeCommissionReduction',
    required: false,
    includeIfNull: false,
  )
  final num? maxBadgeCommissionReduction;

  @JsonKey(
    defaultValue: 30,
    name: r'scheduledOrderMinAdvanceMinutes',
    required: false,
    includeIfNull: false,
  )
  final num? scheduledOrderMinAdvanceMinutes;

  @JsonKey(
    defaultValue: 7,
    name: r'scheduledOrderMaxAdvanceDays',
    required: false,
    includeIfNull: false,
  )
  final num? scheduledOrderMaxAdvanceDays;

  @JsonKey(
    defaultValue: 15,
    name: r'scheduledOrderMatchingLeadTimeMinutes',
    required: false,
    includeIfNull: false,
  )
  final num? scheduledOrderMatchingLeadTimeMinutes;

  @JsonKey(
    defaultValue: 1,
    name: r'scheduledOrderMinRescheduleHours',
    required: false,
    includeIfNull: false,
  )
  final num? scheduledOrderMinRescheduleHours;

  @JsonKey(
    defaultValue: 10,
    name: r'onTimeDeliveryThresholdMinutes',
    required: false,
    includeIfNull: false,
  )
  final num? onTimeDeliveryThresholdMinutes;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BusinessConfiguration &&
          other.minTransferAmount == minTransferAmount &&
          other.minWithdrawalAmount == minWithdrawalAmount &&
          other.minTopUpAmount == minTopUpAmount &&
          other.quickTopUpAmounts == quickTopUpAmounts &&
          other.userCancellationFeeBeforeAccept ==
              userCancellationFeeBeforeAccept &&
          other.userCancellationFeeAfterAccept ==
              userCancellationFeeAfterAccept &&
          other.noShowFee == noShowFee &&
          other.noShowDriverCompensationRate == noShowDriverCompensationRate &&
          other.highValueOrderThreshold == highValueOrderThreshold &&
          other.driverMatchingTimeoutMinutes == driverMatchingTimeoutMinutes &&
          other.driverMatchingInitialRadiusKm ==
              driverMatchingInitialRadiusKm &&
          other.driverMatchingMaxRadiusKm == driverMatchingMaxRadiusKm &&
          other.driverMatchingRadiusExpansionRate ==
              driverMatchingRadiusExpansionRate &&
          other.driverMatchingIntervalSeconds ==
              driverMatchingIntervalSeconds &&
          other.driverMatchingBroadcastLimit == driverMatchingBroadcastLimit &&
          other.driverMaxCancellationsPerDay == driverMaxCancellationsPerDay &&
          other.paymentPendingTimeoutMinutes == paymentPendingTimeoutMinutes &&
          other.orderCompletionTimeoutMinutes ==
              orderCompletionTimeoutMinutes &&
          other.noShowTimeoutMinutes == noShowTimeoutMinutes &&
          other.orderStaleTimestampMinutes == orderStaleTimestampMinutes &&
          other.driverLocationStaleThresholdMinutes ==
              driverLocationStaleThresholdMinutes &&
          other.driverRebroadcastIntervalMinutes ==
              driverRebroadcastIntervalMinutes &&
          other.driverRebroadcastRadiusMultiplier ==
              driverRebroadcastRadiusMultiplier &&
          other.maxBadgeCommissionReduction == maxBadgeCommissionReduction &&
          other.scheduledOrderMinAdvanceMinutes ==
              scheduledOrderMinAdvanceMinutes &&
          other.scheduledOrderMaxAdvanceDays == scheduledOrderMaxAdvanceDays &&
          other.scheduledOrderMatchingLeadTimeMinutes ==
              scheduledOrderMatchingLeadTimeMinutes &&
          other.scheduledOrderMinRescheduleHours ==
              scheduledOrderMinRescheduleHours &&
          other.onTimeDeliveryThresholdMinutes ==
              onTimeDeliveryThresholdMinutes;

  @override
  int get hashCode =>
      minTransferAmount.hashCode +
      minWithdrawalAmount.hashCode +
      minTopUpAmount.hashCode +
      quickTopUpAmounts.hashCode +
      userCancellationFeeBeforeAccept.hashCode +
      userCancellationFeeAfterAccept.hashCode +
      noShowFee.hashCode +
      noShowDriverCompensationRate.hashCode +
      highValueOrderThreshold.hashCode +
      driverMatchingTimeoutMinutes.hashCode +
      driverMatchingInitialRadiusKm.hashCode +
      driverMatchingMaxRadiusKm.hashCode +
      driverMatchingRadiusExpansionRate.hashCode +
      driverMatchingIntervalSeconds.hashCode +
      driverMatchingBroadcastLimit.hashCode +
      driverMaxCancellationsPerDay.hashCode +
      paymentPendingTimeoutMinutes.hashCode +
      orderCompletionTimeoutMinutes.hashCode +
      noShowTimeoutMinutes.hashCode +
      orderStaleTimestampMinutes.hashCode +
      driverLocationStaleThresholdMinutes.hashCode +
      driverRebroadcastIntervalMinutes.hashCode +
      driverRebroadcastRadiusMultiplier.hashCode +
      maxBadgeCommissionReduction.hashCode +
      scheduledOrderMinAdvanceMinutes.hashCode +
      scheduledOrderMaxAdvanceDays.hashCode +
      scheduledOrderMatchingLeadTimeMinutes.hashCode +
      scheduledOrderMinRescheduleHours.hashCode +
      onTimeDeliveryThresholdMinutes.hashCode;

  factory BusinessConfiguration.fromJson(Map<String, dynamic> json) =>
      _$BusinessConfigurationFromJson(json);

  Map<String, dynamic> toJson() => _$BusinessConfigurationToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
