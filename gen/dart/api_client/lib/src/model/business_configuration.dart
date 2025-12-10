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
  @JsonKey(name: r'userCancellationFeeBeforeAccept', required: true, includeIfNull: false)
  final num userCancellationFeeBeforeAccept;
  
          // minimum: 0
          // maximum: 1
  @JsonKey(name: r'userCancellationFeeAfterAccept', required: true, includeIfNull: false)
  final num userCancellationFeeAfterAccept;
  
          // minimum: 0
          // maximum: 1
  @JsonKey(name: r'noShowFee', required: true, includeIfNull: false)
  final num noShowFee;
  
          // minimum: 0
          // maximum: 1
  @JsonKey(name: r'noShowDriverCompensationRate', required: true, includeIfNull: false)
  final num noShowDriverCompensationRate;
  
  @JsonKey(name: r'highValueOrderThreshold', required: true, includeIfNull: false)
  final num highValueOrderThreshold;
  
  @JsonKey(defaultValue: 15,name: r'driverMatchingTimeoutMinutes', required: false, includeIfNull: false)
  final num? driverMatchingTimeoutMinutes;
  
  @JsonKey(defaultValue: 5,name: r'driverMatchingInitialRadiusKm', required: false, includeIfNull: false)
  final num? driverMatchingInitialRadiusKm;
  
  @JsonKey(defaultValue: 20,name: r'driverMatchingMaxRadiusKm', required: false, includeIfNull: false)
  final num? driverMatchingMaxRadiusKm;
  
  @JsonKey(defaultValue: 0.2,name: r'driverMatchingRadiusExpansionRate', required: false, includeIfNull: false)
  final num? driverMatchingRadiusExpansionRate;
  
  @JsonKey(defaultValue: 30,name: r'driverMatchingIntervalSeconds', required: false, includeIfNull: false)
  final num? driverMatchingIntervalSeconds;
  
          // minimum: -9007199254740991
          // maximum: 9007199254740991
  @JsonKey(defaultValue: 10,name: r'driverMatchingBroadcastLimit', required: false, includeIfNull: false)
  final int? driverMatchingBroadcastLimit;
  
          // minimum: -9007199254740991
          // maximum: 9007199254740991
  @JsonKey(defaultValue: 3,name: r'driverMaxCancellationsPerDay', required: false, includeIfNull: false)
  final int? driverMaxCancellationsPerDay;
  
  @override
  bool operator ==(Object other) => identical(this, other) || other is BusinessConfiguration &&
    other.minTransferAmount == minTransferAmount &&
    other.minWithdrawalAmount == minWithdrawalAmount &&
    other.minTopUpAmount == minTopUpAmount &&
    other.quickTopUpAmounts == quickTopUpAmounts &&
    other.userCancellationFeeBeforeAccept == userCancellationFeeBeforeAccept &&
    other.userCancellationFeeAfterAccept == userCancellationFeeAfterAccept &&
    other.noShowFee == noShowFee &&
    other.noShowDriverCompensationRate == noShowDriverCompensationRate &&
    other.highValueOrderThreshold == highValueOrderThreshold &&
    other.driverMatchingTimeoutMinutes == driverMatchingTimeoutMinutes &&
    other.driverMatchingInitialRadiusKm == driverMatchingInitialRadiusKm &&
    other.driverMatchingMaxRadiusKm == driverMatchingMaxRadiusKm &&
    other.driverMatchingRadiusExpansionRate == driverMatchingRadiusExpansionRate &&
    other.driverMatchingIntervalSeconds == driverMatchingIntervalSeconds &&
    other.driverMatchingBroadcastLimit == driverMatchingBroadcastLimit &&
    other.driverMaxCancellationsPerDay == driverMaxCancellationsPerDay;

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
      driverMaxCancellationsPerDay.hashCode;

  factory BusinessConfiguration.fromJson(Map<String, dynamic> json) => _$BusinessConfigurationFromJson(json);

  Map<String, dynamic> toJson() => _$BusinessConfigurationToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

