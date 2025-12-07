// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'business_configuration.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$BusinessConfigurationCWProxy {
  BusinessConfiguration minTransferAmount(num minTransferAmount);

  BusinessConfiguration minWithdrawalAmount(num minWithdrawalAmount);

  BusinessConfiguration minTopUpAmount(num minTopUpAmount);

  BusinessConfiguration quickTopUpAmounts(List<num> quickTopUpAmounts);

  BusinessConfiguration userCancellationFeeBeforeAccept(
    num userCancellationFeeBeforeAccept,
  );

  BusinessConfiguration userCancellationFeeAfterAccept(
    num userCancellationFeeAfterAccept,
  );

  BusinessConfiguration noShowFee(num noShowFee);

  BusinessConfiguration highValueOrderThreshold(num highValueOrderThreshold);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `BusinessConfiguration(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// BusinessConfiguration(...).copyWith(id: 12, name: "My name")
  /// ```
  BusinessConfiguration call({
    num minTransferAmount,
    num minWithdrawalAmount,
    num minTopUpAmount,
    List<num> quickTopUpAmounts,
    num userCancellationFeeBeforeAccept,
    num userCancellationFeeAfterAccept,
    num noShowFee,
    num highValueOrderThreshold,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfBusinessConfiguration.copyWith(...)` or call `instanceOfBusinessConfiguration.copyWith.fieldName(value)` for a single field.
class _$BusinessConfigurationCWProxyImpl
    implements _$BusinessConfigurationCWProxy {
  const _$BusinessConfigurationCWProxyImpl(this._value);

  final BusinessConfiguration _value;

  @override
  BusinessConfiguration minTransferAmount(num minTransferAmount) =>
      call(minTransferAmount: minTransferAmount);

  @override
  BusinessConfiguration minWithdrawalAmount(num minWithdrawalAmount) =>
      call(minWithdrawalAmount: minWithdrawalAmount);

  @override
  BusinessConfiguration minTopUpAmount(num minTopUpAmount) =>
      call(minTopUpAmount: minTopUpAmount);

  @override
  BusinessConfiguration quickTopUpAmounts(List<num> quickTopUpAmounts) =>
      call(quickTopUpAmounts: quickTopUpAmounts);

  @override
  BusinessConfiguration userCancellationFeeBeforeAccept(
    num userCancellationFeeBeforeAccept,
  ) => call(userCancellationFeeBeforeAccept: userCancellationFeeBeforeAccept);

  @override
  BusinessConfiguration userCancellationFeeAfterAccept(
    num userCancellationFeeAfterAccept,
  ) => call(userCancellationFeeAfterAccept: userCancellationFeeAfterAccept);

  @override
  BusinessConfiguration noShowFee(num noShowFee) => call(noShowFee: noShowFee);

  @override
  BusinessConfiguration highValueOrderThreshold(num highValueOrderThreshold) =>
      call(highValueOrderThreshold: highValueOrderThreshold);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `BusinessConfiguration(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// BusinessConfiguration(...).copyWith(id: 12, name: "My name")
  /// ```
  BusinessConfiguration call({
    Object? minTransferAmount = const $CopyWithPlaceholder(),
    Object? minWithdrawalAmount = const $CopyWithPlaceholder(),
    Object? minTopUpAmount = const $CopyWithPlaceholder(),
    Object? quickTopUpAmounts = const $CopyWithPlaceholder(),
    Object? userCancellationFeeBeforeAccept = const $CopyWithPlaceholder(),
    Object? userCancellationFeeAfterAccept = const $CopyWithPlaceholder(),
    Object? noShowFee = const $CopyWithPlaceholder(),
    Object? highValueOrderThreshold = const $CopyWithPlaceholder(),
  }) {
    return BusinessConfiguration(
      minTransferAmount:
          minTransferAmount == const $CopyWithPlaceholder() ||
              minTransferAmount == null
          ? _value.minTransferAmount
          // ignore: cast_nullable_to_non_nullable
          : minTransferAmount as num,
      minWithdrawalAmount:
          minWithdrawalAmount == const $CopyWithPlaceholder() ||
              minWithdrawalAmount == null
          ? _value.minWithdrawalAmount
          // ignore: cast_nullable_to_non_nullable
          : minWithdrawalAmount as num,
      minTopUpAmount:
          minTopUpAmount == const $CopyWithPlaceholder() ||
              minTopUpAmount == null
          ? _value.minTopUpAmount
          // ignore: cast_nullable_to_non_nullable
          : minTopUpAmount as num,
      quickTopUpAmounts:
          quickTopUpAmounts == const $CopyWithPlaceholder() ||
              quickTopUpAmounts == null
          ? _value.quickTopUpAmounts
          // ignore: cast_nullable_to_non_nullable
          : quickTopUpAmounts as List<num>,
      userCancellationFeeBeforeAccept:
          userCancellationFeeBeforeAccept == const $CopyWithPlaceholder() ||
              userCancellationFeeBeforeAccept == null
          ? _value.userCancellationFeeBeforeAccept
          // ignore: cast_nullable_to_non_nullable
          : userCancellationFeeBeforeAccept as num,
      userCancellationFeeAfterAccept:
          userCancellationFeeAfterAccept == const $CopyWithPlaceholder() ||
              userCancellationFeeAfterAccept == null
          ? _value.userCancellationFeeAfterAccept
          // ignore: cast_nullable_to_non_nullable
          : userCancellationFeeAfterAccept as num,
      noShowFee: noShowFee == const $CopyWithPlaceholder() || noShowFee == null
          ? _value.noShowFee
          // ignore: cast_nullable_to_non_nullable
          : noShowFee as num,
      highValueOrderThreshold:
          highValueOrderThreshold == const $CopyWithPlaceholder() ||
              highValueOrderThreshold == null
          ? _value.highValueOrderThreshold
          // ignore: cast_nullable_to_non_nullable
          : highValueOrderThreshold as num,
    );
  }
}

extension $BusinessConfigurationCopyWith on BusinessConfiguration {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfBusinessConfiguration.copyWith(...)` or `instanceOfBusinessConfiguration.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$BusinessConfigurationCWProxy get copyWith =>
      _$BusinessConfigurationCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BusinessConfiguration _$BusinessConfigurationFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('BusinessConfiguration', json, ($checkedConvert) {
  $checkKeys(
    json,
    requiredKeys: const [
      'minTransferAmount',
      'minWithdrawalAmount',
      'minTopUpAmount',
      'quickTopUpAmounts',
      'userCancellationFeeBeforeAccept',
      'userCancellationFeeAfterAccept',
      'noShowFee',
      'highValueOrderThreshold',
    ],
  );
  final val = BusinessConfiguration(
    minTransferAmount: $checkedConvert('minTransferAmount', (v) => v as num),
    minWithdrawalAmount: $checkedConvert(
      'minWithdrawalAmount',
      (v) => v as num,
    ),
    minTopUpAmount: $checkedConvert('minTopUpAmount', (v) => v as num),
    quickTopUpAmounts: $checkedConvert(
      'quickTopUpAmounts',
      (v) => (v as List<dynamic>).map((e) => e as num).toList(),
    ),
    userCancellationFeeBeforeAccept: $checkedConvert(
      'userCancellationFeeBeforeAccept',
      (v) => v as num,
    ),
    userCancellationFeeAfterAccept: $checkedConvert(
      'userCancellationFeeAfterAccept',
      (v) => v as num,
    ),
    noShowFee: $checkedConvert('noShowFee', (v) => v as num),
    highValueOrderThreshold: $checkedConvert(
      'highValueOrderThreshold',
      (v) => v as num,
    ),
  );
  return val;
});

Map<String, dynamic> _$BusinessConfigurationToJson(
  BusinessConfiguration instance,
) => <String, dynamic>{
  'minTransferAmount': instance.minTransferAmount,
  'minWithdrawalAmount': instance.minWithdrawalAmount,
  'minTopUpAmount': instance.minTopUpAmount,
  'quickTopUpAmounts': instance.quickTopUpAmounts,
  'userCancellationFeeBeforeAccept': instance.userCancellationFeeBeforeAccept,
  'userCancellationFeeAfterAccept': instance.userCancellationFeeAfterAccept,
  'noShowFee': instance.noShowFee,
  'highValueOrderThreshold': instance.highValueOrderThreshold,
};
