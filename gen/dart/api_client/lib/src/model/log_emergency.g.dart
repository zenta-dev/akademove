// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'log_emergency.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$LogEmergencyCWProxy {
  LogEmergency orderId(String orderId);

  LogEmergency location(EmergencyLocation? location);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `LogEmergency(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// LogEmergency(...).copyWith(id: 12, name: "My name")
  /// ```
  LogEmergency call({String orderId, EmergencyLocation? location});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfLogEmergency.copyWith(...)` or call `instanceOfLogEmergency.copyWith.fieldName(value)` for a single field.
class _$LogEmergencyCWProxyImpl implements _$LogEmergencyCWProxy {
  const _$LogEmergencyCWProxyImpl(this._value);

  final LogEmergency _value;

  @override
  LogEmergency orderId(String orderId) => call(orderId: orderId);

  @override
  LogEmergency location(EmergencyLocation? location) =>
      call(location: location);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `LogEmergency(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// LogEmergency(...).copyWith(id: 12, name: "My name")
  /// ```
  LogEmergency call({
    Object? orderId = const $CopyWithPlaceholder(),
    Object? location = const $CopyWithPlaceholder(),
  }) {
    return LogEmergency(
      orderId: orderId == const $CopyWithPlaceholder() || orderId == null
          ? _value.orderId
          // ignore: cast_nullable_to_non_nullable
          : orderId as String,
      location: location == const $CopyWithPlaceholder()
          ? _value.location
          // ignore: cast_nullable_to_non_nullable
          : location as EmergencyLocation?,
    );
  }
}

extension $LogEmergencyCopyWith on LogEmergency {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfLogEmergency.copyWith(...)` or `instanceOfLogEmergency.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$LogEmergencyCWProxy get copyWith => _$LogEmergencyCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LogEmergency _$LogEmergencyFromJson(Map<String, dynamic> json) =>
    $checkedCreate('LogEmergency', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['orderId']);
      final val = LogEmergency(
        orderId: $checkedConvert('orderId', (v) => v as String),
        location: $checkedConvert(
          'location',
          (v) => v == null
              ? null
              : EmergencyLocation.fromJson(v as Map<String, dynamic>),
        ),
      );
      return val;
    });

Map<String, dynamic> _$LogEmergencyToJson(LogEmergency instance) =>
    <String, dynamic>{
      'orderId': instance.orderId,
      'location': ?instance.location?.toJson(),
    };
