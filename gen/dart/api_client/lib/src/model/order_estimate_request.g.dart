// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_estimate_request.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$OrderEstimateRequestCWProxy {
  OrderEstimateRequest dropoffLocationX(num dropoffLocationX);

  OrderEstimateRequest dropoffLocationY(num dropoffLocationY);

  OrderEstimateRequest pickupLocationX(num pickupLocationX);

  OrderEstimateRequest pickupLocationY(num pickupLocationY);

  OrderEstimateRequest notePickup(String? notePickup);

  OrderEstimateRequest noteSenderName(String? noteSenderName);

  OrderEstimateRequest noteSenderPhone(String? noteSenderPhone);

  OrderEstimateRequest notePickupInstructions(String? notePickupInstructions);

  OrderEstimateRequest noteDropoff(String? noteDropoff);

  OrderEstimateRequest noteRecevierName(String? noteRecevierName);

  OrderEstimateRequest noteRecevierPhone(String? noteRecevierPhone);

  OrderEstimateRequest noteDropoffInstructions(String? noteDropoffInstructions);

  OrderEstimateRequest type(OrderType type);

  OrderEstimateRequest items(List<OrderItem>? items);

  OrderEstimateRequest gender(UserGender? gender);

  OrderEstimateRequest genderPreference(
    OrderEstimateRequestGenderPreferenceEnum? genderPreference,
  );

  OrderEstimateRequest couponCode(String? couponCode);

  OrderEstimateRequest discountIds(List<num>? discountIds);

  OrderEstimateRequest weight(num? weight);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `OrderEstimateRequest(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// OrderEstimateRequest(...).copyWith(id: 12, name: "My name")
  /// ```
  OrderEstimateRequest call({
    num dropoffLocationX,
    num dropoffLocationY,
    num pickupLocationX,
    num pickupLocationY,
    String? notePickup,
    String? noteSenderName,
    String? noteSenderPhone,
    String? notePickupInstructions,
    String? noteDropoff,
    String? noteRecevierName,
    String? noteRecevierPhone,
    String? noteDropoffInstructions,
    OrderType type,
    List<OrderItem>? items,
    UserGender? gender,
    OrderEstimateRequestGenderPreferenceEnum? genderPreference,
    String? couponCode,
    List<num>? discountIds,
    num? weight,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfOrderEstimateRequest.copyWith(...)` or call `instanceOfOrderEstimateRequest.copyWith.fieldName(value)` for a single field.
class _$OrderEstimateRequestCWProxyImpl
    implements _$OrderEstimateRequestCWProxy {
  const _$OrderEstimateRequestCWProxyImpl(this._value);

  final OrderEstimateRequest _value;

  @override
  OrderEstimateRequest dropoffLocationX(num dropoffLocationX) =>
      call(dropoffLocationX: dropoffLocationX);

  @override
  OrderEstimateRequest dropoffLocationY(num dropoffLocationY) =>
      call(dropoffLocationY: dropoffLocationY);

  @override
  OrderEstimateRequest pickupLocationX(num pickupLocationX) =>
      call(pickupLocationX: pickupLocationX);

  @override
  OrderEstimateRequest pickupLocationY(num pickupLocationY) =>
      call(pickupLocationY: pickupLocationY);

  @override
  OrderEstimateRequest notePickup(String? notePickup) =>
      call(notePickup: notePickup);

  @override
  OrderEstimateRequest noteSenderName(String? noteSenderName) =>
      call(noteSenderName: noteSenderName);

  @override
  OrderEstimateRequest noteSenderPhone(String? noteSenderPhone) =>
      call(noteSenderPhone: noteSenderPhone);

  @override
  OrderEstimateRequest notePickupInstructions(String? notePickupInstructions) =>
      call(notePickupInstructions: notePickupInstructions);

  @override
  OrderEstimateRequest noteDropoff(String? noteDropoff) =>
      call(noteDropoff: noteDropoff);

  @override
  OrderEstimateRequest noteRecevierName(String? noteRecevierName) =>
      call(noteRecevierName: noteRecevierName);

  @override
  OrderEstimateRequest noteRecevierPhone(String? noteRecevierPhone) =>
      call(noteRecevierPhone: noteRecevierPhone);

  @override
  OrderEstimateRequest noteDropoffInstructions(
    String? noteDropoffInstructions,
  ) => call(noteDropoffInstructions: noteDropoffInstructions);

  @override
  OrderEstimateRequest type(OrderType type) => call(type: type);

  @override
  OrderEstimateRequest items(List<OrderItem>? items) => call(items: items);

  @override
  OrderEstimateRequest gender(UserGender? gender) => call(gender: gender);

  @override
  OrderEstimateRequest genderPreference(
    OrderEstimateRequestGenderPreferenceEnum? genderPreference,
  ) => call(genderPreference: genderPreference);

  @override
  OrderEstimateRequest couponCode(String? couponCode) =>
      call(couponCode: couponCode);

  @override
  OrderEstimateRequest discountIds(List<num>? discountIds) =>
      call(discountIds: discountIds);

  @override
  OrderEstimateRequest weight(num? weight) => call(weight: weight);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `OrderEstimateRequest(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// OrderEstimateRequest(...).copyWith(id: 12, name: "My name")
  /// ```
  OrderEstimateRequest call({
    Object? dropoffLocationX = const $CopyWithPlaceholder(),
    Object? dropoffLocationY = const $CopyWithPlaceholder(),
    Object? pickupLocationX = const $CopyWithPlaceholder(),
    Object? pickupLocationY = const $CopyWithPlaceholder(),
    Object? notePickup = const $CopyWithPlaceholder(),
    Object? noteSenderName = const $CopyWithPlaceholder(),
    Object? noteSenderPhone = const $CopyWithPlaceholder(),
    Object? notePickupInstructions = const $CopyWithPlaceholder(),
    Object? noteDropoff = const $CopyWithPlaceholder(),
    Object? noteRecevierName = const $CopyWithPlaceholder(),
    Object? noteRecevierPhone = const $CopyWithPlaceholder(),
    Object? noteDropoffInstructions = const $CopyWithPlaceholder(),
    Object? type = const $CopyWithPlaceholder(),
    Object? items = const $CopyWithPlaceholder(),
    Object? gender = const $CopyWithPlaceholder(),
    Object? genderPreference = const $CopyWithPlaceholder(),
    Object? couponCode = const $CopyWithPlaceholder(),
    Object? discountIds = const $CopyWithPlaceholder(),
    Object? weight = const $CopyWithPlaceholder(),
  }) {
    return OrderEstimateRequest(
      dropoffLocationX:
          dropoffLocationX == const $CopyWithPlaceholder() ||
              dropoffLocationX == null
          ? _value.dropoffLocationX
          // ignore: cast_nullable_to_non_nullable
          : dropoffLocationX as num,
      dropoffLocationY:
          dropoffLocationY == const $CopyWithPlaceholder() ||
              dropoffLocationY == null
          ? _value.dropoffLocationY
          // ignore: cast_nullable_to_non_nullable
          : dropoffLocationY as num,
      pickupLocationX:
          pickupLocationX == const $CopyWithPlaceholder() ||
              pickupLocationX == null
          ? _value.pickupLocationX
          // ignore: cast_nullable_to_non_nullable
          : pickupLocationX as num,
      pickupLocationY:
          pickupLocationY == const $CopyWithPlaceholder() ||
              pickupLocationY == null
          ? _value.pickupLocationY
          // ignore: cast_nullable_to_non_nullable
          : pickupLocationY as num,
      notePickup: notePickup == const $CopyWithPlaceholder()
          ? _value.notePickup
          // ignore: cast_nullable_to_non_nullable
          : notePickup as String?,
      noteSenderName: noteSenderName == const $CopyWithPlaceholder()
          ? _value.noteSenderName
          // ignore: cast_nullable_to_non_nullable
          : noteSenderName as String?,
      noteSenderPhone: noteSenderPhone == const $CopyWithPlaceholder()
          ? _value.noteSenderPhone
          // ignore: cast_nullable_to_non_nullable
          : noteSenderPhone as String?,
      notePickupInstructions:
          notePickupInstructions == const $CopyWithPlaceholder()
          ? _value.notePickupInstructions
          // ignore: cast_nullable_to_non_nullable
          : notePickupInstructions as String?,
      noteDropoff: noteDropoff == const $CopyWithPlaceholder()
          ? _value.noteDropoff
          // ignore: cast_nullable_to_non_nullable
          : noteDropoff as String?,
      noteRecevierName: noteRecevierName == const $CopyWithPlaceholder()
          ? _value.noteRecevierName
          // ignore: cast_nullable_to_non_nullable
          : noteRecevierName as String?,
      noteRecevierPhone: noteRecevierPhone == const $CopyWithPlaceholder()
          ? _value.noteRecevierPhone
          // ignore: cast_nullable_to_non_nullable
          : noteRecevierPhone as String?,
      noteDropoffInstructions:
          noteDropoffInstructions == const $CopyWithPlaceholder()
          ? _value.noteDropoffInstructions
          // ignore: cast_nullable_to_non_nullable
          : noteDropoffInstructions as String?,
      type: type == const $CopyWithPlaceholder() || type == null
          ? _value.type
          // ignore: cast_nullable_to_non_nullable
          : type as OrderType,
      items: items == const $CopyWithPlaceholder()
          ? _value.items
          // ignore: cast_nullable_to_non_nullable
          : items as List<OrderItem>?,
      gender: gender == const $CopyWithPlaceholder()
          ? _value.gender
          // ignore: cast_nullable_to_non_nullable
          : gender as UserGender?,
      genderPreference: genderPreference == const $CopyWithPlaceholder()
          ? _value.genderPreference
          // ignore: cast_nullable_to_non_nullable
          : genderPreference as OrderEstimateRequestGenderPreferenceEnum?,
      couponCode: couponCode == const $CopyWithPlaceholder()
          ? _value.couponCode
          // ignore: cast_nullable_to_non_nullable
          : couponCode as String?,
      discountIds: discountIds == const $CopyWithPlaceholder()
          ? _value.discountIds
          // ignore: cast_nullable_to_non_nullable
          : discountIds as List<num>?,
      weight: weight == const $CopyWithPlaceholder()
          ? _value.weight
          // ignore: cast_nullable_to_non_nullable
          : weight as num?,
    );
  }
}

extension $OrderEstimateRequestCopyWith on OrderEstimateRequest {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfOrderEstimateRequest.copyWith(...)` or `instanceOfOrderEstimateRequest.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$OrderEstimateRequestCWProxy get copyWith =>
      _$OrderEstimateRequestCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderEstimateRequest _$OrderEstimateRequestFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  'OrderEstimateRequest',
  json,
  ($checkedConvert) {
    $checkKeys(
      json,
      requiredKeys: const [
        'dropoffLocation_x',
        'dropoffLocation_y',
        'pickupLocation_x',
        'pickupLocation_y',
        'type',
      ],
    );
    final val = OrderEstimateRequest(
      dropoffLocationX: $checkedConvert('dropoffLocation_x', (v) => v as num),
      dropoffLocationY: $checkedConvert('dropoffLocation_y', (v) => v as num),
      pickupLocationX: $checkedConvert('pickupLocation_x', (v) => v as num),
      pickupLocationY: $checkedConvert('pickupLocation_y', (v) => v as num),
      notePickup: $checkedConvert('note_pickup', (v) => v as String?),
      noteSenderName: $checkedConvert('note_senderName', (v) => v as String?),
      noteSenderPhone: $checkedConvert('note_senderPhone', (v) => v as String?),
      notePickupInstructions: $checkedConvert(
        'note_pickupInstructions',
        (v) => v as String?,
      ),
      noteDropoff: $checkedConvert('note_dropoff', (v) => v as String?),
      noteRecevierName: $checkedConvert(
        'note_recevierName',
        (v) => v as String?,
      ),
      noteRecevierPhone: $checkedConvert(
        'note_recevierPhone',
        (v) => v as String?,
      ),
      noteDropoffInstructions: $checkedConvert(
        'note_dropoffInstructions',
        (v) => v as String?,
      ),
      type: $checkedConvert('type', (v) => $enumDecode(_$OrderTypeEnumMap, v)),
      items: $checkedConvert(
        'items',
        (v) => (v as List<dynamic>?)
            ?.map((e) => OrderItem.fromJson(e as Map<String, dynamic>))
            .toList(),
      ),
      gender: $checkedConvert(
        'gender',
        (v) => $enumDecodeNullable(_$UserGenderEnumMap, v),
      ),
      genderPreference: $checkedConvert(
        'genderPreference',
        (v) => $enumDecodeNullable(
          _$OrderEstimateRequestGenderPreferenceEnumEnumMap,
          v,
        ),
      ),
      couponCode: $checkedConvert('couponCode', (v) => v as String?),
      discountIds: $checkedConvert(
        'discountIds',
        (v) => (v as List<dynamic>?)?.map((e) => e as num).toList(),
      ),
      weight: $checkedConvert('weight', (v) => v as num?),
    );
    return val;
  },
  fieldKeyMap: const {
    'dropoffLocationX': 'dropoffLocation_x',
    'dropoffLocationY': 'dropoffLocation_y',
    'pickupLocationX': 'pickupLocation_x',
    'pickupLocationY': 'pickupLocation_y',
    'notePickup': 'note_pickup',
    'noteSenderName': 'note_senderName',
    'noteSenderPhone': 'note_senderPhone',
    'notePickupInstructions': 'note_pickupInstructions',
    'noteDropoff': 'note_dropoff',
    'noteRecevierName': 'note_recevierName',
    'noteRecevierPhone': 'note_recevierPhone',
    'noteDropoffInstructions': 'note_dropoffInstructions',
  },
);

Map<String, dynamic> _$OrderEstimateRequestToJson(
  OrderEstimateRequest instance,
) => <String, dynamic>{
  'dropoffLocation_x': instance.dropoffLocationX,
  'dropoffLocation_y': instance.dropoffLocationY,
  'pickupLocation_x': instance.pickupLocationX,
  'pickupLocation_y': instance.pickupLocationY,
  'note_pickup': ?instance.notePickup,
  'note_senderName': ?instance.noteSenderName,
  'note_senderPhone': ?instance.noteSenderPhone,
  'note_pickupInstructions': ?instance.notePickupInstructions,
  'note_dropoff': ?instance.noteDropoff,
  'note_recevierName': ?instance.noteRecevierName,
  'note_recevierPhone': ?instance.noteRecevierPhone,
  'note_dropoffInstructions': ?instance.noteDropoffInstructions,
  'type': _$OrderTypeEnumMap[instance.type]!,
  'items': ?instance.items?.map((e) => e.toJson()).toList(),
  'gender': ?_$UserGenderEnumMap[instance.gender],
  'genderPreference':
      ?_$OrderEstimateRequestGenderPreferenceEnumEnumMap[instance
          .genderPreference],
  'couponCode': ?instance.couponCode,
  'discountIds': ?instance.discountIds,
  'weight': ?instance.weight,
};

const _$OrderTypeEnumMap = {
  OrderType.RIDE: 'RIDE',
  OrderType.DELIVERY: 'DELIVERY',
  OrderType.FOOD: 'FOOD',
};

const _$UserGenderEnumMap = {
  UserGender.MALE: 'MALE',
  UserGender.FEMALE: 'FEMALE',
};

const _$OrderEstimateRequestGenderPreferenceEnumEnumMap = {
  OrderEstimateRequestGenderPreferenceEnum.SAME: 'SAME',
  OrderEstimateRequestGenderPreferenceEnum.ANY: 'ANY',
};
