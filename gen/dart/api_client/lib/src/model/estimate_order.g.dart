// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'estimate_order.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$EstimateOrderCWProxy {
  EstimateOrder dropoffLocation(Coordinate dropoffLocation);

  EstimateOrder pickupLocation(Coordinate pickupLocation);

  EstimateOrder pickupAddress(String? pickupAddress);

  EstimateOrder dropoffAddress(String? dropoffAddress);

  EstimateOrder note(OrderNote? note);

  EstimateOrder type(OrderType type);

  EstimateOrder items(List<OrderItem>? items);

  EstimateOrder gender(UserGender? gender);

  EstimateOrder genderPreference(
    EstimateOrderGenderPreferenceEnum? genderPreference,
  );

  EstimateOrder attachmentUrl(String? attachmentUrl);

  EstimateOrder deliveryItemType(DeliveryItemType? deliveryItemType);

  EstimateOrder deliveryItemPhotoUrl(String? deliveryItemPhotoUrl);

  EstimateOrder couponCode(String? couponCode);

  EstimateOrder discountIds(List<int>? discountIds);

  EstimateOrder weight(int? weight);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `EstimateOrder(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// EstimateOrder(...).copyWith(id: 12, name: "My name")
  /// ```
  EstimateOrder call({
    Coordinate dropoffLocation,
    Coordinate pickupLocation,
    String? pickupAddress,
    String? dropoffAddress,
    OrderNote? note,
    OrderType type,
    List<OrderItem>? items,
    UserGender? gender,
    EstimateOrderGenderPreferenceEnum? genderPreference,
    String? attachmentUrl,
    DeliveryItemType? deliveryItemType,
    String? deliveryItemPhotoUrl,
    String? couponCode,
    List<int>? discountIds,
    int? weight,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfEstimateOrder.copyWith(...)` or call `instanceOfEstimateOrder.copyWith.fieldName(value)` for a single field.
class _$EstimateOrderCWProxyImpl implements _$EstimateOrderCWProxy {
  const _$EstimateOrderCWProxyImpl(this._value);

  final EstimateOrder _value;

  @override
  EstimateOrder dropoffLocation(Coordinate dropoffLocation) =>
      call(dropoffLocation: dropoffLocation);

  @override
  EstimateOrder pickupLocation(Coordinate pickupLocation) =>
      call(pickupLocation: pickupLocation);

  @override
  EstimateOrder pickupAddress(String? pickupAddress) =>
      call(pickupAddress: pickupAddress);

  @override
  EstimateOrder dropoffAddress(String? dropoffAddress) =>
      call(dropoffAddress: dropoffAddress);

  @override
  EstimateOrder note(OrderNote? note) => call(note: note);

  @override
  EstimateOrder type(OrderType type) => call(type: type);

  @override
  EstimateOrder items(List<OrderItem>? items) => call(items: items);

  @override
  EstimateOrder gender(UserGender? gender) => call(gender: gender);

  @override
  EstimateOrder genderPreference(
    EstimateOrderGenderPreferenceEnum? genderPreference,
  ) => call(genderPreference: genderPreference);

  @override
  EstimateOrder attachmentUrl(String? attachmentUrl) =>
      call(attachmentUrl: attachmentUrl);

  @override
  EstimateOrder deliveryItemType(DeliveryItemType? deliveryItemType) =>
      call(deliveryItemType: deliveryItemType);

  @override
  EstimateOrder deliveryItemPhotoUrl(String? deliveryItemPhotoUrl) =>
      call(deliveryItemPhotoUrl: deliveryItemPhotoUrl);

  @override
  EstimateOrder couponCode(String? couponCode) => call(couponCode: couponCode);

  @override
  EstimateOrder discountIds(List<int>? discountIds) =>
      call(discountIds: discountIds);

  @override
  EstimateOrder weight(int? weight) => call(weight: weight);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `EstimateOrder(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// EstimateOrder(...).copyWith(id: 12, name: "My name")
  /// ```
  EstimateOrder call({
    Object? dropoffLocation = const $CopyWithPlaceholder(),
    Object? pickupLocation = const $CopyWithPlaceholder(),
    Object? pickupAddress = const $CopyWithPlaceholder(),
    Object? dropoffAddress = const $CopyWithPlaceholder(),
    Object? note = const $CopyWithPlaceholder(),
    Object? type = const $CopyWithPlaceholder(),
    Object? items = const $CopyWithPlaceholder(),
    Object? gender = const $CopyWithPlaceholder(),
    Object? genderPreference = const $CopyWithPlaceholder(),
    Object? attachmentUrl = const $CopyWithPlaceholder(),
    Object? deliveryItemType = const $CopyWithPlaceholder(),
    Object? deliveryItemPhotoUrl = const $CopyWithPlaceholder(),
    Object? couponCode = const $CopyWithPlaceholder(),
    Object? discountIds = const $CopyWithPlaceholder(),
    Object? weight = const $CopyWithPlaceholder(),
  }) {
    return EstimateOrder(
      dropoffLocation:
          dropoffLocation == const $CopyWithPlaceholder() ||
              dropoffLocation == null
          ? _value.dropoffLocation
          // ignore: cast_nullable_to_non_nullable
          : dropoffLocation as Coordinate,
      pickupLocation:
          pickupLocation == const $CopyWithPlaceholder() ||
              pickupLocation == null
          ? _value.pickupLocation
          // ignore: cast_nullable_to_non_nullable
          : pickupLocation as Coordinate,
      pickupAddress: pickupAddress == const $CopyWithPlaceholder()
          ? _value.pickupAddress
          // ignore: cast_nullable_to_non_nullable
          : pickupAddress as String?,
      dropoffAddress: dropoffAddress == const $CopyWithPlaceholder()
          ? _value.dropoffAddress
          // ignore: cast_nullable_to_non_nullable
          : dropoffAddress as String?,
      note: note == const $CopyWithPlaceholder()
          ? _value.note
          // ignore: cast_nullable_to_non_nullable
          : note as OrderNote?,
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
          : genderPreference as EstimateOrderGenderPreferenceEnum?,
      attachmentUrl: attachmentUrl == const $CopyWithPlaceholder()
          ? _value.attachmentUrl
          // ignore: cast_nullable_to_non_nullable
          : attachmentUrl as String?,
      deliveryItemType: deliveryItemType == const $CopyWithPlaceholder()
          ? _value.deliveryItemType
          // ignore: cast_nullable_to_non_nullable
          : deliveryItemType as DeliveryItemType?,
      deliveryItemPhotoUrl: deliveryItemPhotoUrl == const $CopyWithPlaceholder()
          ? _value.deliveryItemPhotoUrl
          // ignore: cast_nullable_to_non_nullable
          : deliveryItemPhotoUrl as String?,
      couponCode: couponCode == const $CopyWithPlaceholder()
          ? _value.couponCode
          // ignore: cast_nullable_to_non_nullable
          : couponCode as String?,
      discountIds: discountIds == const $CopyWithPlaceholder()
          ? _value.discountIds
          // ignore: cast_nullable_to_non_nullable
          : discountIds as List<int>?,
      weight: weight == const $CopyWithPlaceholder()
          ? _value.weight
          // ignore: cast_nullable_to_non_nullable
          : weight as int?,
    );
  }
}

extension $EstimateOrderCopyWith on EstimateOrder {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfEstimateOrder.copyWith(...)` or `instanceOfEstimateOrder.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$EstimateOrderCWProxy get copyWith => _$EstimateOrderCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EstimateOrder _$EstimateOrderFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('EstimateOrder', json, ($checkedConvert) {
  $checkKeys(
    json,
    requiredKeys: const ['dropoffLocation', 'pickupLocation', 'type'],
  );
  final val = EstimateOrder(
    dropoffLocation: $checkedConvert(
      'dropoffLocation',
      (v) => Coordinate.fromJson(v as Map<String, dynamic>),
    ),
    pickupLocation: $checkedConvert(
      'pickupLocation',
      (v) => Coordinate.fromJson(v as Map<String, dynamic>),
    ),
    pickupAddress: $checkedConvert('pickupAddress', (v) => v as String?),
    dropoffAddress: $checkedConvert('dropoffAddress', (v) => v as String?),
    note: $checkedConvert(
      'note',
      (v) => v == null ? null : OrderNote.fromJson(v as Map<String, dynamic>),
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
      (v) => $enumDecodeNullable(_$EstimateOrderGenderPreferenceEnumEnumMap, v),
    ),
    attachmentUrl: $checkedConvert('attachmentUrl', (v) => v as String?),
    deliveryItemType: $checkedConvert(
      'deliveryItemType',
      (v) => $enumDecodeNullable(_$DeliveryItemTypeEnumMap, v),
    ),
    deliveryItemPhotoUrl: $checkedConvert(
      'deliveryItemPhotoUrl',
      (v) => v as String?,
    ),
    couponCode: $checkedConvert('couponCode', (v) => v as String?),
    discountIds: $checkedConvert(
      'discountIds',
      (v) => (v as List<dynamic>?)?.map((e) => (e as num).toInt()).toList(),
    ),
    weight: $checkedConvert('weight', (v) => (v as num?)?.toInt()),
  );
  return val;
});

Map<String, dynamic> _$EstimateOrderToJson(
  EstimateOrder instance,
) => <String, dynamic>{
  'dropoffLocation': instance.dropoffLocation.toJson(),
  'pickupLocation': instance.pickupLocation.toJson(),
  'pickupAddress': ?instance.pickupAddress,
  'dropoffAddress': ?instance.dropoffAddress,
  'note': ?instance.note?.toJson(),
  'type': _$OrderTypeEnumMap[instance.type]!,
  'items': ?instance.items?.map((e) => e.toJson()).toList(),
  'gender': ?_$UserGenderEnumMap[instance.gender],
  'genderPreference':
      ?_$EstimateOrderGenderPreferenceEnumEnumMap[instance.genderPreference],
  'attachmentUrl': ?instance.attachmentUrl,
  'deliveryItemType': ?_$DeliveryItemTypeEnumMap[instance.deliveryItemType],
  'deliveryItemPhotoUrl': ?instance.deliveryItemPhotoUrl,
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

const _$EstimateOrderGenderPreferenceEnumEnumMap = {
  EstimateOrderGenderPreferenceEnum.SAME: 'SAME',
  EstimateOrderGenderPreferenceEnum.ANY: 'ANY',
};

const _$DeliveryItemTypeEnumMap = {
  DeliveryItemType.FOOD: 'FOOD',
  DeliveryItemType.CLOTH: 'CLOTH',
  DeliveryItemType.DOCUMENT: 'DOCUMENT',
  DeliveryItemType.MEDICINE: 'MEDICINE',
  DeliveryItemType.BOOK: 'BOOK',
  DeliveryItemType.OTHER: 'OTHER',
};
