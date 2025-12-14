// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'emergency_with_contact.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$EmergencyWithContactCWProxy {
  EmergencyWithContact emergency(EmergencyWithContactEmergency emergency);

  EmergencyWithContact contacts(List<EmergencyContact> contacts);

  EmergencyWithContact orderInfo(EmergencyWithContactOrderInfo orderInfo);

  EmergencyWithContact userInfo(EmergencyWithContactUserInfo userInfo);

  EmergencyWithContact driverInfo(EmergencyWithContactDriverInfo? driverInfo);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `EmergencyWithContact(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// EmergencyWithContact(...).copyWith(id: 12, name: "My name")
  /// ```
  EmergencyWithContact call({
    EmergencyWithContactEmergency emergency,
    List<EmergencyContact> contacts,
    EmergencyWithContactOrderInfo orderInfo,
    EmergencyWithContactUserInfo userInfo,
    EmergencyWithContactDriverInfo? driverInfo,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfEmergencyWithContact.copyWith(...)` or call `instanceOfEmergencyWithContact.copyWith.fieldName(value)` for a single field.
class _$EmergencyWithContactCWProxyImpl
    implements _$EmergencyWithContactCWProxy {
  const _$EmergencyWithContactCWProxyImpl(this._value);

  final EmergencyWithContact _value;

  @override
  EmergencyWithContact emergency(EmergencyWithContactEmergency emergency) =>
      call(emergency: emergency);

  @override
  EmergencyWithContact contacts(List<EmergencyContact> contacts) =>
      call(contacts: contacts);

  @override
  EmergencyWithContact orderInfo(EmergencyWithContactOrderInfo orderInfo) =>
      call(orderInfo: orderInfo);

  @override
  EmergencyWithContact userInfo(EmergencyWithContactUserInfo userInfo) =>
      call(userInfo: userInfo);

  @override
  EmergencyWithContact driverInfo(EmergencyWithContactDriverInfo? driverInfo) =>
      call(driverInfo: driverInfo);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `EmergencyWithContact(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// EmergencyWithContact(...).copyWith(id: 12, name: "My name")
  /// ```
  EmergencyWithContact call({
    Object? emergency = const $CopyWithPlaceholder(),
    Object? contacts = const $CopyWithPlaceholder(),
    Object? orderInfo = const $CopyWithPlaceholder(),
    Object? userInfo = const $CopyWithPlaceholder(),
    Object? driverInfo = const $CopyWithPlaceholder(),
  }) {
    return EmergencyWithContact(
      emergency: emergency == const $CopyWithPlaceholder() || emergency == null
          ? _value.emergency
          // ignore: cast_nullable_to_non_nullable
          : emergency as EmergencyWithContactEmergency,
      contacts: contacts == const $CopyWithPlaceholder() || contacts == null
          ? _value.contacts
          // ignore: cast_nullable_to_non_nullable
          : contacts as List<EmergencyContact>,
      orderInfo: orderInfo == const $CopyWithPlaceholder() || orderInfo == null
          ? _value.orderInfo
          // ignore: cast_nullable_to_non_nullable
          : orderInfo as EmergencyWithContactOrderInfo,
      userInfo: userInfo == const $CopyWithPlaceholder() || userInfo == null
          ? _value.userInfo
          // ignore: cast_nullable_to_non_nullable
          : userInfo as EmergencyWithContactUserInfo,
      driverInfo: driverInfo == const $CopyWithPlaceholder()
          ? _value.driverInfo
          // ignore: cast_nullable_to_non_nullable
          : driverInfo as EmergencyWithContactDriverInfo?,
    );
  }
}

extension $EmergencyWithContactCopyWith on EmergencyWithContact {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfEmergencyWithContact.copyWith(...)` or `instanceOfEmergencyWithContact.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$EmergencyWithContactCWProxy get copyWith =>
      _$EmergencyWithContactCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EmergencyWithContact _$EmergencyWithContactFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('EmergencyWithContact', json, ($checkedConvert) {
  $checkKeys(
    json,
    requiredKeys: const ['emergency', 'contacts', 'orderInfo', 'userInfo'],
  );
  final val = EmergencyWithContact(
    emergency: $checkedConvert(
      'emergency',
      (v) => EmergencyWithContactEmergency.fromJson(v as Map<String, dynamic>),
    ),
    contacts: $checkedConvert(
      'contacts',
      (v) => (v as List<dynamic>)
          .map((e) => EmergencyContact.fromJson(e as Map<String, dynamic>))
          .toList(),
    ),
    orderInfo: $checkedConvert(
      'orderInfo',
      (v) => EmergencyWithContactOrderInfo.fromJson(v as Map<String, dynamic>),
    ),
    userInfo: $checkedConvert(
      'userInfo',
      (v) => EmergencyWithContactUserInfo.fromJson(v as Map<String, dynamic>),
    ),
    driverInfo: $checkedConvert(
      'driverInfo',
      (v) => v == null
          ? null
          : EmergencyWithContactDriverInfo.fromJson(v as Map<String, dynamic>),
    ),
  );
  return val;
});

Map<String, dynamic> _$EmergencyWithContactToJson(
  EmergencyWithContact instance,
) => <String, dynamic>{
  'emergency': instance.emergency.toJson(),
  'contacts': instance.contacts.map((e) => e.toJson()).toList(),
  'orderInfo': instance.orderInfo.toJson(),
  'userInfo': instance.userInfo.toJson(),
  'driverInfo': ?instance.driverInfo?.toJson(),
};
