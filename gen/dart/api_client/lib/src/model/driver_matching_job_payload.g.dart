// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'driver_matching_job_payload.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$DriverMatchingJobPayloadCWProxy {
  DriverMatchingJobPayload orderId(String orderId);

  DriverMatchingJobPayload pickupLocation(
    DriverMatchingJobPayloadPickupLocation pickupLocation,
  );

  DriverMatchingJobPayload orderType(
    DriverMatchingJobPayloadOrderTypeEnum orderType,
  );

  DriverMatchingJobPayload genderPreference(
    DriverMatchingJobPayloadGenderPreferenceEnum? genderPreference,
  );

  DriverMatchingJobPayload userGender(
    DriverMatchingJobPayloadUserGenderEnum? userGender,
  );

  DriverMatchingJobPayload initialRadiusKm(num? initialRadiusKm);

  DriverMatchingJobPayload maxMatchingDurationMinutes(
    num? maxMatchingDurationMinutes,
  );

  DriverMatchingJobPayload currentAttempt(int? currentAttempt);

  DriverMatchingJobPayload maxExpansionAttempts(int? maxExpansionAttempts);

  DriverMatchingJobPayload expansionRate(num? expansionRate);

  DriverMatchingJobPayload matchingIntervalSeconds(
    num? matchingIntervalSeconds,
  );

  DriverMatchingJobPayload paymentId(String? paymentId);

  DriverMatchingJobPayload wsRoomId(String? wsRoomId);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `DriverMatchingJobPayload(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// DriverMatchingJobPayload(...).copyWith(id: 12, name: "My name")
  /// ```
  DriverMatchingJobPayload call({
    String orderId,
    DriverMatchingJobPayloadPickupLocation pickupLocation,
    DriverMatchingJobPayloadOrderTypeEnum orderType,
    DriverMatchingJobPayloadGenderPreferenceEnum? genderPreference,
    DriverMatchingJobPayloadUserGenderEnum? userGender,
    num? initialRadiusKm,
    num? maxMatchingDurationMinutes,
    int? currentAttempt,
    int? maxExpansionAttempts,
    num? expansionRate,
    num? matchingIntervalSeconds,
    String? paymentId,
    String? wsRoomId,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfDriverMatchingJobPayload.copyWith(...)` or call `instanceOfDriverMatchingJobPayload.copyWith.fieldName(value)` for a single field.
class _$DriverMatchingJobPayloadCWProxyImpl
    implements _$DriverMatchingJobPayloadCWProxy {
  const _$DriverMatchingJobPayloadCWProxyImpl(this._value);

  final DriverMatchingJobPayload _value;

  @override
  DriverMatchingJobPayload orderId(String orderId) => call(orderId: orderId);

  @override
  DriverMatchingJobPayload pickupLocation(
    DriverMatchingJobPayloadPickupLocation pickupLocation,
  ) => call(pickupLocation: pickupLocation);

  @override
  DriverMatchingJobPayload orderType(
    DriverMatchingJobPayloadOrderTypeEnum orderType,
  ) => call(orderType: orderType);

  @override
  DriverMatchingJobPayload genderPreference(
    DriverMatchingJobPayloadGenderPreferenceEnum? genderPreference,
  ) => call(genderPreference: genderPreference);

  @override
  DriverMatchingJobPayload userGender(
    DriverMatchingJobPayloadUserGenderEnum? userGender,
  ) => call(userGender: userGender);

  @override
  DriverMatchingJobPayload initialRadiusKm(num? initialRadiusKm) =>
      call(initialRadiusKm: initialRadiusKm);

  @override
  DriverMatchingJobPayload maxMatchingDurationMinutes(
    num? maxMatchingDurationMinutes,
  ) => call(maxMatchingDurationMinutes: maxMatchingDurationMinutes);

  @override
  DriverMatchingJobPayload currentAttempt(int? currentAttempt) =>
      call(currentAttempt: currentAttempt);

  @override
  DriverMatchingJobPayload maxExpansionAttempts(int? maxExpansionAttempts) =>
      call(maxExpansionAttempts: maxExpansionAttempts);

  @override
  DriverMatchingJobPayload expansionRate(num? expansionRate) =>
      call(expansionRate: expansionRate);

  @override
  DriverMatchingJobPayload matchingIntervalSeconds(
    num? matchingIntervalSeconds,
  ) => call(matchingIntervalSeconds: matchingIntervalSeconds);

  @override
  DriverMatchingJobPayload paymentId(String? paymentId) =>
      call(paymentId: paymentId);

  @override
  DriverMatchingJobPayload wsRoomId(String? wsRoomId) =>
      call(wsRoomId: wsRoomId);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `DriverMatchingJobPayload(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// DriverMatchingJobPayload(...).copyWith(id: 12, name: "My name")
  /// ```
  DriverMatchingJobPayload call({
    Object? orderId = const $CopyWithPlaceholder(),
    Object? pickupLocation = const $CopyWithPlaceholder(),
    Object? orderType = const $CopyWithPlaceholder(),
    Object? genderPreference = const $CopyWithPlaceholder(),
    Object? userGender = const $CopyWithPlaceholder(),
    Object? initialRadiusKm = const $CopyWithPlaceholder(),
    Object? maxMatchingDurationMinutes = const $CopyWithPlaceholder(),
    Object? currentAttempt = const $CopyWithPlaceholder(),
    Object? maxExpansionAttempts = const $CopyWithPlaceholder(),
    Object? expansionRate = const $CopyWithPlaceholder(),
    Object? matchingIntervalSeconds = const $CopyWithPlaceholder(),
    Object? paymentId = const $CopyWithPlaceholder(),
    Object? wsRoomId = const $CopyWithPlaceholder(),
  }) {
    return DriverMatchingJobPayload(
      orderId: orderId == const $CopyWithPlaceholder() || orderId == null
          ? _value.orderId
          // ignore: cast_nullable_to_non_nullable
          : orderId as String,
      pickupLocation:
          pickupLocation == const $CopyWithPlaceholder() ||
              pickupLocation == null
          ? _value.pickupLocation
          // ignore: cast_nullable_to_non_nullable
          : pickupLocation as DriverMatchingJobPayloadPickupLocation,
      orderType: orderType == const $CopyWithPlaceholder() || orderType == null
          ? _value.orderType
          // ignore: cast_nullable_to_non_nullable
          : orderType as DriverMatchingJobPayloadOrderTypeEnum,
      genderPreference: genderPreference == const $CopyWithPlaceholder()
          ? _value.genderPreference
          // ignore: cast_nullable_to_non_nullable
          : genderPreference as DriverMatchingJobPayloadGenderPreferenceEnum?,
      userGender: userGender == const $CopyWithPlaceholder()
          ? _value.userGender
          // ignore: cast_nullable_to_non_nullable
          : userGender as DriverMatchingJobPayloadUserGenderEnum?,
      initialRadiusKm: initialRadiusKm == const $CopyWithPlaceholder()
          ? _value.initialRadiusKm
          // ignore: cast_nullable_to_non_nullable
          : initialRadiusKm as num?,
      maxMatchingDurationMinutes:
          maxMatchingDurationMinutes == const $CopyWithPlaceholder()
          ? _value.maxMatchingDurationMinutes
          // ignore: cast_nullable_to_non_nullable
          : maxMatchingDurationMinutes as num?,
      currentAttempt: currentAttempt == const $CopyWithPlaceholder()
          ? _value.currentAttempt
          // ignore: cast_nullable_to_non_nullable
          : currentAttempt as int?,
      maxExpansionAttempts: maxExpansionAttempts == const $CopyWithPlaceholder()
          ? _value.maxExpansionAttempts
          // ignore: cast_nullable_to_non_nullable
          : maxExpansionAttempts as int?,
      expansionRate: expansionRate == const $CopyWithPlaceholder()
          ? _value.expansionRate
          // ignore: cast_nullable_to_non_nullable
          : expansionRate as num?,
      matchingIntervalSeconds:
          matchingIntervalSeconds == const $CopyWithPlaceholder()
          ? _value.matchingIntervalSeconds
          // ignore: cast_nullable_to_non_nullable
          : matchingIntervalSeconds as num?,
      paymentId: paymentId == const $CopyWithPlaceholder()
          ? _value.paymentId
          // ignore: cast_nullable_to_non_nullable
          : paymentId as String?,
      wsRoomId: wsRoomId == const $CopyWithPlaceholder()
          ? _value.wsRoomId
          // ignore: cast_nullable_to_non_nullable
          : wsRoomId as String?,
    );
  }
}

extension $DriverMatchingJobPayloadCopyWith on DriverMatchingJobPayload {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfDriverMatchingJobPayload.copyWith(...)` or `instanceOfDriverMatchingJobPayload.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$DriverMatchingJobPayloadCWProxy get copyWith =>
      _$DriverMatchingJobPayloadCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DriverMatchingJobPayload _$DriverMatchingJobPayloadFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('DriverMatchingJobPayload', json, ($checkedConvert) {
  $checkKeys(
    json,
    requiredKeys: const ['orderId', 'pickupLocation', 'orderType'],
  );
  final val = DriverMatchingJobPayload(
    orderId: $checkedConvert('orderId', (v) => v as String),
    pickupLocation: $checkedConvert(
      'pickupLocation',
      (v) => DriverMatchingJobPayloadPickupLocation.fromJson(
        v as Map<String, dynamic>,
      ),
    ),
    orderType: $checkedConvert(
      'orderType',
      (v) => $enumDecode(_$DriverMatchingJobPayloadOrderTypeEnumEnumMap, v),
    ),
    genderPreference: $checkedConvert(
      'genderPreference',
      (v) => $enumDecodeNullable(
        _$DriverMatchingJobPayloadGenderPreferenceEnumEnumMap,
        v,
      ),
    ),
    userGender: $checkedConvert(
      'userGender',
      (v) => $enumDecodeNullable(
        _$DriverMatchingJobPayloadUserGenderEnumEnumMap,
        v,
      ),
    ),
    initialRadiusKm: $checkedConvert('initialRadiusKm', (v) => v as num? ?? 5),
    maxMatchingDurationMinutes: $checkedConvert(
      'maxMatchingDurationMinutes',
      (v) => v as num? ?? 15,
    ),
    currentAttempt: $checkedConvert(
      'currentAttempt',
      (v) => (v as num?)?.toInt() ?? 1,
    ),
    maxExpansionAttempts: $checkedConvert(
      'maxExpansionAttempts',
      (v) => (v as num?)?.toInt() ?? 10,
    ),
    expansionRate: $checkedConvert('expansionRate', (v) => v as num? ?? 0.2),
    matchingIntervalSeconds: $checkedConvert(
      'matchingIntervalSeconds',
      (v) => v as num? ?? 30,
    ),
    paymentId: $checkedConvert('paymentId', (v) => v as String?),
    wsRoomId: $checkedConvert('wsRoomId', (v) => v as String?),
  );
  return val;
});

Map<String, dynamic> _$DriverMatchingJobPayloadToJson(
  DriverMatchingJobPayload instance,
) => <String, dynamic>{
  'orderId': instance.orderId,
  'pickupLocation': instance.pickupLocation.toJson(),
  'orderType':
      _$DriverMatchingJobPayloadOrderTypeEnumEnumMap[instance.orderType]!,
  'genderPreference':
      ?_$DriverMatchingJobPayloadGenderPreferenceEnumEnumMap[instance
          .genderPreference],
  'userGender':
      ?_$DriverMatchingJobPayloadUserGenderEnumEnumMap[instance.userGender],
  'initialRadiusKm': ?instance.initialRadiusKm,
  'maxMatchingDurationMinutes': ?instance.maxMatchingDurationMinutes,
  'currentAttempt': ?instance.currentAttempt,
  'maxExpansionAttempts': ?instance.maxExpansionAttempts,
  'expansionRate': ?instance.expansionRate,
  'matchingIntervalSeconds': ?instance.matchingIntervalSeconds,
  'paymentId': ?instance.paymentId,
  'wsRoomId': ?instance.wsRoomId,
};

const _$DriverMatchingJobPayloadOrderTypeEnumEnumMap = {
  DriverMatchingJobPayloadOrderTypeEnum.RIDE: 'RIDE',
  DriverMatchingJobPayloadOrderTypeEnum.DELIVERY: 'DELIVERY',
  DriverMatchingJobPayloadOrderTypeEnum.FOOD: 'FOOD',
};

const _$DriverMatchingJobPayloadGenderPreferenceEnumEnumMap = {
  DriverMatchingJobPayloadGenderPreferenceEnum.SAME: 'SAME',
  DriverMatchingJobPayloadGenderPreferenceEnum.ANY: 'ANY',
};

const _$DriverMatchingJobPayloadUserGenderEnumEnumMap = {
  DriverMatchingJobPayloadUserGenderEnum.MALE: 'MALE',
  DriverMatchingJobPayloadUserGenderEnum.FEMALE: 'FEMALE',
};
