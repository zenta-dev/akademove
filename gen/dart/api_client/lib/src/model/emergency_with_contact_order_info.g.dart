// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'emergency_with_contact_order_info.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$EmergencyWithContactOrderInfoCWProxy {
  EmergencyWithContactOrderInfo id(String id);

  EmergencyWithContactOrderInfo type(String type);

  EmergencyWithContactOrderInfo status(String status);

  EmergencyWithContactOrderInfo pickupAddress(String? pickupAddress);

  EmergencyWithContactOrderInfo dropoffAddress(String? dropoffAddress);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `EmergencyWithContactOrderInfo(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// EmergencyWithContactOrderInfo(...).copyWith(id: 12, name: "My name")
  /// ```
  EmergencyWithContactOrderInfo call({
    String id,
    String type,
    String status,
    String? pickupAddress,
    String? dropoffAddress,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfEmergencyWithContactOrderInfo.copyWith(...)` or call `instanceOfEmergencyWithContactOrderInfo.copyWith.fieldName(value)` for a single field.
class _$EmergencyWithContactOrderInfoCWProxyImpl
    implements _$EmergencyWithContactOrderInfoCWProxy {
  const _$EmergencyWithContactOrderInfoCWProxyImpl(this._value);

  final EmergencyWithContactOrderInfo _value;

  @override
  EmergencyWithContactOrderInfo id(String id) => call(id: id);

  @override
  EmergencyWithContactOrderInfo type(String type) => call(type: type);

  @override
  EmergencyWithContactOrderInfo status(String status) => call(status: status);

  @override
  EmergencyWithContactOrderInfo pickupAddress(String? pickupAddress) =>
      call(pickupAddress: pickupAddress);

  @override
  EmergencyWithContactOrderInfo dropoffAddress(String? dropoffAddress) =>
      call(dropoffAddress: dropoffAddress);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `EmergencyWithContactOrderInfo(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// EmergencyWithContactOrderInfo(...).copyWith(id: 12, name: "My name")
  /// ```
  EmergencyWithContactOrderInfo call({
    Object? id = const $CopyWithPlaceholder(),
    Object? type = const $CopyWithPlaceholder(),
    Object? status = const $CopyWithPlaceholder(),
    Object? pickupAddress = const $CopyWithPlaceholder(),
    Object? dropoffAddress = const $CopyWithPlaceholder(),
  }) {
    return EmergencyWithContactOrderInfo(
      id: id == const $CopyWithPlaceholder() || id == null
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
      type: type == const $CopyWithPlaceholder() || type == null
          ? _value.type
          // ignore: cast_nullable_to_non_nullable
          : type as String,
      status: status == const $CopyWithPlaceholder() || status == null
          ? _value.status
          // ignore: cast_nullable_to_non_nullable
          : status as String,
      pickupAddress: pickupAddress == const $CopyWithPlaceholder()
          ? _value.pickupAddress
          // ignore: cast_nullable_to_non_nullable
          : pickupAddress as String?,
      dropoffAddress: dropoffAddress == const $CopyWithPlaceholder()
          ? _value.dropoffAddress
          // ignore: cast_nullable_to_non_nullable
          : dropoffAddress as String?,
    );
  }
}

extension $EmergencyWithContactOrderInfoCopyWith
    on EmergencyWithContactOrderInfo {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfEmergencyWithContactOrderInfo.copyWith(...)` or `instanceOfEmergencyWithContactOrderInfo.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$EmergencyWithContactOrderInfoCWProxy get copyWith =>
      _$EmergencyWithContactOrderInfoCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EmergencyWithContactOrderInfo _$EmergencyWithContactOrderInfoFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('EmergencyWithContactOrderInfo', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['id', 'type', 'status']);
  final val = EmergencyWithContactOrderInfo(
    id: $checkedConvert('id', (v) => v as String),
    type: $checkedConvert('type', (v) => v as String),
    status: $checkedConvert('status', (v) => v as String),
    pickupAddress: $checkedConvert('pickupAddress', (v) => v as String?),
    dropoffAddress: $checkedConvert('dropoffAddress', (v) => v as String?),
  );
  return val;
});

Map<String, dynamic> _$EmergencyWithContactOrderInfoToJson(
  EmergencyWithContactOrderInfo instance,
) => <String, dynamic>{
  'id': instance.id,
  'type': instance.type,
  'status': instance.status,
  'pickupAddress': ?instance.pickupAddress,
  'dropoffAddress': ?instance.dropoffAddress,
};
