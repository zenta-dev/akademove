// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'commission_configuration.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$CommissionConfigurationCWProxy {
  CommissionConfiguration rideCommissionRate(num rideCommissionRate);

  CommissionConfiguration deliveryCommissionRate(num deliveryCommissionRate);

  CommissionConfiguration foodCommissionRate(num foodCommissionRate);

  CommissionConfiguration merchantCommissionRate(num merchantCommissionRate);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `CommissionConfiguration(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// CommissionConfiguration(...).copyWith(id: 12, name: "My name")
  /// ```
  CommissionConfiguration call({
    num rideCommissionRate,
    num deliveryCommissionRate,
    num foodCommissionRate,
    num merchantCommissionRate,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfCommissionConfiguration.copyWith(...)` or call `instanceOfCommissionConfiguration.copyWith.fieldName(value)` for a single field.
class _$CommissionConfigurationCWProxyImpl
    implements _$CommissionConfigurationCWProxy {
  const _$CommissionConfigurationCWProxyImpl(this._value);

  final CommissionConfiguration _value;

  @override
  CommissionConfiguration rideCommissionRate(num rideCommissionRate) =>
      call(rideCommissionRate: rideCommissionRate);

  @override
  CommissionConfiguration deliveryCommissionRate(num deliveryCommissionRate) =>
      call(deliveryCommissionRate: deliveryCommissionRate);

  @override
  CommissionConfiguration foodCommissionRate(num foodCommissionRate) =>
      call(foodCommissionRate: foodCommissionRate);

  @override
  CommissionConfiguration merchantCommissionRate(num merchantCommissionRate) =>
      call(merchantCommissionRate: merchantCommissionRate);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `CommissionConfiguration(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// CommissionConfiguration(...).copyWith(id: 12, name: "My name")
  /// ```
  CommissionConfiguration call({
    Object? rideCommissionRate = const $CopyWithPlaceholder(),
    Object? deliveryCommissionRate = const $CopyWithPlaceholder(),
    Object? foodCommissionRate = const $CopyWithPlaceholder(),
    Object? merchantCommissionRate = const $CopyWithPlaceholder(),
  }) {
    return CommissionConfiguration(
      rideCommissionRate:
          rideCommissionRate == const $CopyWithPlaceholder() ||
              rideCommissionRate == null
          ? _value.rideCommissionRate
          // ignore: cast_nullable_to_non_nullable
          : rideCommissionRate as num,
      deliveryCommissionRate:
          deliveryCommissionRate == const $CopyWithPlaceholder() ||
              deliveryCommissionRate == null
          ? _value.deliveryCommissionRate
          // ignore: cast_nullable_to_non_nullable
          : deliveryCommissionRate as num,
      foodCommissionRate:
          foodCommissionRate == const $CopyWithPlaceholder() ||
              foodCommissionRate == null
          ? _value.foodCommissionRate
          // ignore: cast_nullable_to_non_nullable
          : foodCommissionRate as num,
      merchantCommissionRate:
          merchantCommissionRate == const $CopyWithPlaceholder() ||
              merchantCommissionRate == null
          ? _value.merchantCommissionRate
          // ignore: cast_nullable_to_non_nullable
          : merchantCommissionRate as num,
    );
  }
}

extension $CommissionConfigurationCopyWith on CommissionConfiguration {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfCommissionConfiguration.copyWith(...)` or `instanceOfCommissionConfiguration.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$CommissionConfigurationCWProxy get copyWith =>
      _$CommissionConfigurationCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommissionConfiguration _$CommissionConfigurationFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('CommissionConfiguration', json, ($checkedConvert) {
  $checkKeys(
    json,
    requiredKeys: const [
      'rideCommissionRate',
      'deliveryCommissionRate',
      'foodCommissionRate',
      'merchantCommissionRate',
    ],
  );
  final val = CommissionConfiguration(
    rideCommissionRate: $checkedConvert('rideCommissionRate', (v) => v as num),
    deliveryCommissionRate: $checkedConvert(
      'deliveryCommissionRate',
      (v) => v as num,
    ),
    foodCommissionRate: $checkedConvert('foodCommissionRate', (v) => v as num),
    merchantCommissionRate: $checkedConvert(
      'merchantCommissionRate',
      (v) => v as num,
    ),
  );
  return val;
});

Map<String, dynamic> _$CommissionConfigurationToJson(
  CommissionConfiguration instance,
) => <String, dynamic>{
  'rideCommissionRate': instance.rideCommissionRate,
  'deliveryCommissionRate': instance.deliveryCommissionRate,
  'foodCommissionRate': instance.foodCommissionRate,
  'merchantCommissionRate': instance.merchantCommissionRate,
};
