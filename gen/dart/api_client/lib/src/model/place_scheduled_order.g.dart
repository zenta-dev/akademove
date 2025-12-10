// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'place_scheduled_order.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$PlaceScheduledOrderCWProxy {
  PlaceScheduledOrder dropoffLocation(Coordinate dropoffLocation);

  PlaceScheduledOrder pickupLocation(Coordinate pickupLocation);

  PlaceScheduledOrder note(OrderNote? note);

  PlaceScheduledOrder type(OrderType type);

  PlaceScheduledOrder items(List<OrderItem>? items);

  PlaceScheduledOrder gender(UserGender? gender);

  PlaceScheduledOrder genderPreference(
    PlaceScheduledOrderGenderPreferenceEnum? genderPreference,
  );

  PlaceScheduledOrder couponCode(String? couponCode);

  PlaceScheduledOrder payment(PlaceOrderPayment payment);

  PlaceScheduledOrder scheduledAt(DateTime scheduledAt);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `PlaceScheduledOrder(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// PlaceScheduledOrder(...).copyWith(id: 12, name: "My name")
  /// ```
  PlaceScheduledOrder call({
    Coordinate dropoffLocation,
    Coordinate pickupLocation,
    OrderNote? note,
    OrderType type,
    List<OrderItem>? items,
    UserGender? gender,
    PlaceScheduledOrderGenderPreferenceEnum? genderPreference,
    String? couponCode,
    PlaceOrderPayment payment,
    DateTime scheduledAt,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfPlaceScheduledOrder.copyWith(...)` or call `instanceOfPlaceScheduledOrder.copyWith.fieldName(value)` for a single field.
class _$PlaceScheduledOrderCWProxyImpl implements _$PlaceScheduledOrderCWProxy {
  const _$PlaceScheduledOrderCWProxyImpl(this._value);

  final PlaceScheduledOrder _value;

  @override
  PlaceScheduledOrder dropoffLocation(Coordinate dropoffLocation) =>
      call(dropoffLocation: dropoffLocation);

  @override
  PlaceScheduledOrder pickupLocation(Coordinate pickupLocation) =>
      call(pickupLocation: pickupLocation);

  @override
  PlaceScheduledOrder note(OrderNote? note) => call(note: note);

  @override
  PlaceScheduledOrder type(OrderType type) => call(type: type);

  @override
  PlaceScheduledOrder items(List<OrderItem>? items) => call(items: items);

  @override
  PlaceScheduledOrder gender(UserGender? gender) => call(gender: gender);

  @override
  PlaceScheduledOrder genderPreference(
    PlaceScheduledOrderGenderPreferenceEnum? genderPreference,
  ) => call(genderPreference: genderPreference);

  @override
  PlaceScheduledOrder couponCode(String? couponCode) =>
      call(couponCode: couponCode);

  @override
  PlaceScheduledOrder payment(PlaceOrderPayment payment) =>
      call(payment: payment);

  @override
  PlaceScheduledOrder scheduledAt(DateTime scheduledAt) =>
      call(scheduledAt: scheduledAt);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `PlaceScheduledOrder(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// PlaceScheduledOrder(...).copyWith(id: 12, name: "My name")
  /// ```
  PlaceScheduledOrder call({
    Object? dropoffLocation = const $CopyWithPlaceholder(),
    Object? pickupLocation = const $CopyWithPlaceholder(),
    Object? note = const $CopyWithPlaceholder(),
    Object? type = const $CopyWithPlaceholder(),
    Object? items = const $CopyWithPlaceholder(),
    Object? gender = const $CopyWithPlaceholder(),
    Object? genderPreference = const $CopyWithPlaceholder(),
    Object? couponCode = const $CopyWithPlaceholder(),
    Object? payment = const $CopyWithPlaceholder(),
    Object? scheduledAt = const $CopyWithPlaceholder(),
  }) {
    return PlaceScheduledOrder(
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
          : genderPreference as PlaceScheduledOrderGenderPreferenceEnum?,
      couponCode: couponCode == const $CopyWithPlaceholder()
          ? _value.couponCode
          // ignore: cast_nullable_to_non_nullable
          : couponCode as String?,
      payment: payment == const $CopyWithPlaceholder() || payment == null
          ? _value.payment
          // ignore: cast_nullable_to_non_nullable
          : payment as PlaceOrderPayment,
      scheduledAt:
          scheduledAt == const $CopyWithPlaceholder() || scheduledAt == null
          ? _value.scheduledAt
          // ignore: cast_nullable_to_non_nullable
          : scheduledAt as DateTime,
    );
  }
}

extension $PlaceScheduledOrderCopyWith on PlaceScheduledOrder {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfPlaceScheduledOrder.copyWith(...)` or `instanceOfPlaceScheduledOrder.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$PlaceScheduledOrderCWProxy get copyWith =>
      _$PlaceScheduledOrderCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlaceScheduledOrder _$PlaceScheduledOrderFromJson(Map<String, dynamic> json) =>
    $checkedCreate('PlaceScheduledOrder', json, ($checkedConvert) {
      $checkKeys(
        json,
        requiredKeys: const [
          'dropoffLocation',
          'pickupLocation',
          'type',
          'payment',
          'scheduledAt',
        ],
      );
      final val = PlaceScheduledOrder(
        dropoffLocation: $checkedConvert(
          'dropoffLocation',
          (v) => Coordinate.fromJson(v as Map<String, dynamic>),
        ),
        pickupLocation: $checkedConvert(
          'pickupLocation',
          (v) => Coordinate.fromJson(v as Map<String, dynamic>),
        ),
        note: $checkedConvert(
          'note',
          (v) =>
              v == null ? null : OrderNote.fromJson(v as Map<String, dynamic>),
        ),
        type: $checkedConvert(
          'type',
          (v) => $enumDecode(_$OrderTypeEnumMap, v),
        ),
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
            _$PlaceScheduledOrderGenderPreferenceEnumEnumMap,
            v,
          ),
        ),
        couponCode: $checkedConvert('couponCode', (v) => v as String?),
        payment: $checkedConvert(
          'payment',
          (v) => PlaceOrderPayment.fromJson(v as Map<String, dynamic>),
        ),
        scheduledAt: $checkedConvert(
          'scheduledAt',
          (v) => DateTime.parse(v as String),
        ),
      );
      return val;
    });

Map<String, dynamic> _$PlaceScheduledOrderToJson(
  PlaceScheduledOrder instance,
) => <String, dynamic>{
  'dropoffLocation': instance.dropoffLocation.toJson(),
  'pickupLocation': instance.pickupLocation.toJson(),
  'note': ?instance.note?.toJson(),
  'type': _$OrderTypeEnumMap[instance.type]!,
  'items': ?instance.items?.map((e) => e.toJson()).toList(),
  'gender': ?_$UserGenderEnumMap[instance.gender],
  'genderPreference':
      ?_$PlaceScheduledOrderGenderPreferenceEnumEnumMap[instance
          .genderPreference],
  'couponCode': ?instance.couponCode,
  'payment': instance.payment.toJson(),
  'scheduledAt': instance.scheduledAt.toIso8601String(),
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

const _$PlaceScheduledOrderGenderPreferenceEnumEnumMap = {
  PlaceScheduledOrderGenderPreferenceEnum.SAME: 'SAME',
  PlaceScheduledOrderGenderPreferenceEnum.ANY: 'ANY',
};
