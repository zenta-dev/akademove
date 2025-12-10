// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'driver_metrics_job_payload.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$DriverMetricsJobPayloadCWProxy {
  DriverMetricsJobPayload driverId(String driverId);

  DriverMetricsJobPayload orderId(String orderId);

  DriverMetricsJobPayload metricsType(
    DriverMetricsJobPayloadMetricsTypeEnum metricsType,
  );

  DriverMetricsJobPayload value(num? value);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `DriverMetricsJobPayload(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// DriverMetricsJobPayload(...).copyWith(id: 12, name: "My name")
  /// ```
  DriverMetricsJobPayload call({
    String driverId,
    String orderId,
    DriverMetricsJobPayloadMetricsTypeEnum metricsType,
    num? value,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfDriverMetricsJobPayload.copyWith(...)` or call `instanceOfDriverMetricsJobPayload.copyWith.fieldName(value)` for a single field.
class _$DriverMetricsJobPayloadCWProxyImpl
    implements _$DriverMetricsJobPayloadCWProxy {
  const _$DriverMetricsJobPayloadCWProxyImpl(this._value);

  final DriverMetricsJobPayload _value;

  @override
  DriverMetricsJobPayload driverId(String driverId) => call(driverId: driverId);

  @override
  DriverMetricsJobPayload orderId(String orderId) => call(orderId: orderId);

  @override
  DriverMetricsJobPayload metricsType(
    DriverMetricsJobPayloadMetricsTypeEnum metricsType,
  ) => call(metricsType: metricsType);

  @override
  DriverMetricsJobPayload value(num? value) => call(value: value);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `DriverMetricsJobPayload(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// DriverMetricsJobPayload(...).copyWith(id: 12, name: "My name")
  /// ```
  DriverMetricsJobPayload call({
    Object? driverId = const $CopyWithPlaceholder(),
    Object? orderId = const $CopyWithPlaceholder(),
    Object? metricsType = const $CopyWithPlaceholder(),
    Object? value = const $CopyWithPlaceholder(),
  }) {
    return DriverMetricsJobPayload(
      driverId: driverId == const $CopyWithPlaceholder() || driverId == null
          ? _value.driverId
          // ignore: cast_nullable_to_non_nullable
          : driverId as String,
      orderId: orderId == const $CopyWithPlaceholder() || orderId == null
          ? _value.orderId
          // ignore: cast_nullable_to_non_nullable
          : orderId as String,
      metricsType:
          metricsType == const $CopyWithPlaceholder() || metricsType == null
          ? _value.metricsType
          // ignore: cast_nullable_to_non_nullable
          : metricsType as DriverMetricsJobPayloadMetricsTypeEnum,
      value: value == const $CopyWithPlaceholder()
          ? _value.value
          // ignore: cast_nullable_to_non_nullable
          : value as num?,
    );
  }
}

extension $DriverMetricsJobPayloadCopyWith on DriverMetricsJobPayload {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfDriverMetricsJobPayload.copyWith(...)` or `instanceOfDriverMetricsJobPayload.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$DriverMetricsJobPayloadCWProxy get copyWith =>
      _$DriverMetricsJobPayloadCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DriverMetricsJobPayload _$DriverMetricsJobPayloadFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('DriverMetricsJobPayload', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['driverId', 'orderId', 'metricsType']);
  final val = DriverMetricsJobPayload(
    driverId: $checkedConvert('driverId', (v) => v as String),
    orderId: $checkedConvert('orderId', (v) => v as String),
    metricsType: $checkedConvert(
      'metricsType',
      (v) => $enumDecode(_$DriverMetricsJobPayloadMetricsTypeEnumEnumMap, v),
    ),
    value: $checkedConvert('value', (v) => v as num?),
  );
  return val;
});

Map<String, dynamic> _$DriverMetricsJobPayloadToJson(
  DriverMetricsJobPayload instance,
) => <String, dynamic>{
  'driverId': instance.driverId,
  'orderId': instance.orderId,
  'metricsType':
      _$DriverMetricsJobPayloadMetricsTypeEnumEnumMap[instance.metricsType]!,
  'value': ?instance.value,
};

const _$DriverMetricsJobPayloadMetricsTypeEnumEnumMap = {
  DriverMetricsJobPayloadMetricsTypeEnum.ORDER_COMPLETED: 'ORDER_COMPLETED',
  DriverMetricsJobPayloadMetricsTypeEnum.ORDER_CANCELLED: 'ORDER_CANCELLED',
  DriverMetricsJobPayloadMetricsTypeEnum.RATING_RECEIVED: 'RATING_RECEIVED',
  DriverMetricsJobPayloadMetricsTypeEnum.NO_SHOW_REPORTED: 'NO_SHOW_REPORTED',
};
