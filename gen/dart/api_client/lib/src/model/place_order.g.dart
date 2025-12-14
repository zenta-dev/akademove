// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'place_order.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$PlaceOrderCWProxy {
  PlaceOrder dropoffLocation(Coordinate dropoffLocation);

  PlaceOrder pickupLocation(Coordinate pickupLocation);

  PlaceOrder pickupAddress(String? pickupAddress);

  PlaceOrder dropoffAddress(String? dropoffAddress);

  PlaceOrder note(OrderNote? note);

  PlaceOrder type(OrderType type);

  PlaceOrder items(List<OrderItem>? items);

  PlaceOrder gender(UserGender? gender);

  PlaceOrder genderPreference(PlaceOrderGenderPreferenceEnum? genderPreference);

  PlaceOrder attachmentUrl(String? attachmentUrl);

  PlaceOrder couponCode(String? couponCode);

  PlaceOrder payment(PlaceOrderPayment payment);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `PlaceOrder(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// PlaceOrder(...).copyWith(id: 12, name: "My name")
  /// ```
  PlaceOrder call({
    Coordinate dropoffLocation,
    Coordinate pickupLocation,
    String? pickupAddress,
    String? dropoffAddress,
    OrderNote? note,
    OrderType type,
    List<OrderItem>? items,
    UserGender? gender,
    PlaceOrderGenderPreferenceEnum? genderPreference,
    String? attachmentUrl,
    String? couponCode,
    PlaceOrderPayment payment,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfPlaceOrder.copyWith(...)` or call `instanceOfPlaceOrder.copyWith.fieldName(value)` for a single field.
class _$PlaceOrderCWProxyImpl implements _$PlaceOrderCWProxy {
  const _$PlaceOrderCWProxyImpl(this._value);

  final PlaceOrder _value;

  @override
  PlaceOrder dropoffLocation(Coordinate dropoffLocation) =>
      call(dropoffLocation: dropoffLocation);

  @override
  PlaceOrder pickupLocation(Coordinate pickupLocation) =>
      call(pickupLocation: pickupLocation);

  @override
  PlaceOrder pickupAddress(String? pickupAddress) =>
      call(pickupAddress: pickupAddress);

  @override
  PlaceOrder dropoffAddress(String? dropoffAddress) =>
      call(dropoffAddress: dropoffAddress);

  @override
  PlaceOrder note(OrderNote? note) => call(note: note);

  @override
  PlaceOrder type(OrderType type) => call(type: type);

  @override
  PlaceOrder items(List<OrderItem>? items) => call(items: items);

  @override
  PlaceOrder gender(UserGender? gender) => call(gender: gender);

  @override
  PlaceOrder genderPreference(
    PlaceOrderGenderPreferenceEnum? genderPreference,
  ) => call(genderPreference: genderPreference);

  @override
  PlaceOrder attachmentUrl(String? attachmentUrl) =>
      call(attachmentUrl: attachmentUrl);

  @override
  PlaceOrder couponCode(String? couponCode) => call(couponCode: couponCode);

  @override
  PlaceOrder payment(PlaceOrderPayment payment) => call(payment: payment);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `PlaceOrder(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// PlaceOrder(...).copyWith(id: 12, name: "My name")
  /// ```
  PlaceOrder call({
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
    Object? couponCode = const $CopyWithPlaceholder(),
    Object? payment = const $CopyWithPlaceholder(),
  }) {
    return PlaceOrder(
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
          : genderPreference as PlaceOrderGenderPreferenceEnum?,
      attachmentUrl: attachmentUrl == const $CopyWithPlaceholder()
          ? _value.attachmentUrl
          // ignore: cast_nullable_to_non_nullable
          : attachmentUrl as String?,
      couponCode: couponCode == const $CopyWithPlaceholder()
          ? _value.couponCode
          // ignore: cast_nullable_to_non_nullable
          : couponCode as String?,
      payment: payment == const $CopyWithPlaceholder() || payment == null
          ? _value.payment
          // ignore: cast_nullable_to_non_nullable
          : payment as PlaceOrderPayment,
    );
  }
}

extension $PlaceOrderCopyWith on PlaceOrder {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfPlaceOrder.copyWith(...)` or `instanceOfPlaceOrder.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$PlaceOrderCWProxy get copyWith => _$PlaceOrderCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlaceOrder _$PlaceOrderFromJson(Map<String, dynamic> json) => $checkedCreate(
  'PlaceOrder',
  json,
  ($checkedConvert) {
    $checkKeys(
      json,
      requiredKeys: const [
        'dropoffLocation',
        'pickupLocation',
        'type',
        'payment',
      ],
    );
    final val = PlaceOrder(
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
        (v) => $enumDecodeNullable(_$PlaceOrderGenderPreferenceEnumEnumMap, v),
      ),
      attachmentUrl: $checkedConvert('attachmentUrl', (v) => v as String?),
      couponCode: $checkedConvert('couponCode', (v) => v as String?),
      payment: $checkedConvert(
        'payment',
        (v) => PlaceOrderPayment.fromJson(v as Map<String, dynamic>),
      ),
    );
    return val;
  },
);

Map<String, dynamic> _$PlaceOrderToJson(PlaceOrder instance) =>
    <String, dynamic>{
      'dropoffLocation': instance.dropoffLocation.toJson(),
      'pickupLocation': instance.pickupLocation.toJson(),
      'pickupAddress': ?instance.pickupAddress,
      'dropoffAddress': ?instance.dropoffAddress,
      'note': ?instance.note?.toJson(),
      'type': _$OrderTypeEnumMap[instance.type]!,
      'items': ?instance.items?.map((e) => e.toJson()).toList(),
      'gender': ?_$UserGenderEnumMap[instance.gender],
      'genderPreference':
          ?_$PlaceOrderGenderPreferenceEnumEnumMap[instance.genderPreference],
      'attachmentUrl': ?instance.attachmentUrl,
      'couponCode': ?instance.couponCode,
      'payment': instance.payment.toJson(),
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

const _$PlaceOrderGenderPreferenceEnumEnumMap = {
  PlaceOrderGenderPreferenceEnum.SAME: 'SAME',
  PlaceOrderGenderPreferenceEnum.ANY: 'ANY',
};
