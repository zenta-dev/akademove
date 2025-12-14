// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'emergency_log200_response_data.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$EmergencyLog200ResponseDataCWProxy {
  EmergencyLog200ResponseData logged(bool logged);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `EmergencyLog200ResponseData(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// EmergencyLog200ResponseData(...).copyWith(id: 12, name: "My name")
  /// ```
  EmergencyLog200ResponseData call({bool logged});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfEmergencyLog200ResponseData.copyWith(...)` or call `instanceOfEmergencyLog200ResponseData.copyWith.fieldName(value)` for a single field.
class _$EmergencyLog200ResponseDataCWProxyImpl
    implements _$EmergencyLog200ResponseDataCWProxy {
  const _$EmergencyLog200ResponseDataCWProxyImpl(this._value);

  final EmergencyLog200ResponseData _value;

  @override
  EmergencyLog200ResponseData logged(bool logged) => call(logged: logged);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `EmergencyLog200ResponseData(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// EmergencyLog200ResponseData(...).copyWith(id: 12, name: "My name")
  /// ```
  EmergencyLog200ResponseData call({
    Object? logged = const $CopyWithPlaceholder(),
  }) {
    return EmergencyLog200ResponseData(
      logged: logged == const $CopyWithPlaceholder() || logged == null
          ? _value.logged
          // ignore: cast_nullable_to_non_nullable
          : logged as bool,
    );
  }
}

extension $EmergencyLog200ResponseDataCopyWith on EmergencyLog200ResponseData {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfEmergencyLog200ResponseData.copyWith(...)` or `instanceOfEmergencyLog200ResponseData.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$EmergencyLog200ResponseDataCWProxy get copyWith =>
      _$EmergencyLog200ResponseDataCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EmergencyLog200ResponseData _$EmergencyLog200ResponseDataFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('EmergencyLog200ResponseData', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['logged']);
  final val = EmergencyLog200ResponseData(
    logged: $checkedConvert('logged', (v) => v as bool),
  );
  return val;
});

Map<String, dynamic> _$EmergencyLog200ResponseDataToJson(
  EmergencyLog200ResponseData instance,
) => <String, dynamic>{'logged': instance.logged};
