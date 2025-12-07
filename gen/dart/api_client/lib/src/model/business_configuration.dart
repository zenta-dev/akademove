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
    required this.highValueOrderThreshold,
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
  
  @JsonKey(name: r'highValueOrderThreshold', required: true, includeIfNull: false)
  final num highValueOrderThreshold;
  
  @override
  bool operator ==(Object other) => identical(this, other) || other is BusinessConfiguration &&
    other.minTransferAmount == minTransferAmount &&
    other.minWithdrawalAmount == minWithdrawalAmount &&
    other.minTopUpAmount == minTopUpAmount &&
    other.quickTopUpAmounts == quickTopUpAmounts &&
    other.userCancellationFeeBeforeAccept == userCancellationFeeBeforeAccept &&
    other.userCancellationFeeAfterAccept == userCancellationFeeAfterAccept &&
    other.noShowFee == noShowFee &&
    other.highValueOrderThreshold == highValueOrderThreshold;

  @override
  int get hashCode =>
      minTransferAmount.hashCode +
      minWithdrawalAmount.hashCode +
      minTopUpAmount.hashCode +
      quickTopUpAmounts.hashCode +
      userCancellationFeeBeforeAccept.hashCode +
      userCancellationFeeAfterAccept.hashCode +
      noShowFee.hashCode +
      highValueOrderThreshold.hashCode;

  factory BusinessConfiguration.fromJson(Map<String, dynamic> json) => _$BusinessConfigurationFromJson(json);

  Map<String, dynamic> toJson() => _$BusinessConfigurationToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

