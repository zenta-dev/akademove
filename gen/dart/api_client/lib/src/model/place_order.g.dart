// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'place_order.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$PlaceOrderCWProxy {
  PlaceOrder dropoffLocation(Coordinate dropoffLocation);

  PlaceOrder pickupLocation(Coordinate pickupLocation);

  PlaceOrder note(OrderNote? note);

  PlaceOrder type(OrderType type);

  PlaceOrder items(List<OrderItem>? items);

  PlaceOrder gender(UserGender? gender);

  PlaceOrder payment(PlaceOrderPayment payment);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `PlaceOrder(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// PlaceOrder(...).copyWith(id: 12, name: "My name")
  /// ````
  PlaceOrder call({
    Coordinate dropoffLocation,
    Coordinate pickupLocation,
    OrderNote? note,
    OrderType type,
    List<OrderItem>? items,
    UserGender? gender,
    PlaceOrderPayment payment,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfPlaceOrder.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfPlaceOrder.copyWith.fieldName(...)`
class _$PlaceOrderCWProxyImpl implements _$PlaceOrderCWProxy {
  const _$PlaceOrderCWProxyImpl(this._value);

  final PlaceOrder _value;

  @override
  PlaceOrder dropoffLocation(Coordinate dropoffLocation) =>
      this(dropoffLocation: dropoffLocation);

  @override
  PlaceOrder pickupLocation(Coordinate pickupLocation) =>
      this(pickupLocation: pickupLocation);

  @override
  PlaceOrder note(OrderNote? note) => this(note: note);

  @override
  PlaceOrder type(OrderType type) => this(type: type);

  @override
  PlaceOrder items(List<OrderItem>? items) => this(items: items);

  @override
  PlaceOrder gender(UserGender? gender) => this(gender: gender);

  @override
  PlaceOrder payment(PlaceOrderPayment payment) => this(payment: payment);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `PlaceOrder(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// PlaceOrder(...).copyWith(id: 12, name: "My name")
  /// ````
  PlaceOrder call({
    Object? dropoffLocation = const $CopyWithPlaceholder(),
    Object? pickupLocation = const $CopyWithPlaceholder(),
    Object? note = const $CopyWithPlaceholder(),
    Object? type = const $CopyWithPlaceholder(),
    Object? items = const $CopyWithPlaceholder(),
    Object? gender = const $CopyWithPlaceholder(),
    Object? payment = const $CopyWithPlaceholder(),
  }) {
    return PlaceOrder(
      dropoffLocation: dropoffLocation == const $CopyWithPlaceholder()
          ? _value.dropoffLocation
          // ignore: cast_nullable_to_non_nullable
          : dropoffLocation as Coordinate,
      pickupLocation: pickupLocation == const $CopyWithPlaceholder()
          ? _value.pickupLocation
          // ignore: cast_nullable_to_non_nullable
          : pickupLocation as Coordinate,
      note: note == const $CopyWithPlaceholder()
          ? _value.note
          // ignore: cast_nullable_to_non_nullable
          : note as OrderNote?,
      type: type == const $CopyWithPlaceholder()
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
      payment: payment == const $CopyWithPlaceholder()
          ? _value.payment
          // ignore: cast_nullable_to_non_nullable
          : payment as PlaceOrderPayment,
    );
  }
}

extension $PlaceOrderCopyWith on PlaceOrder {
  /// Returns a callable class that can be used as follows: `instanceOfPlaceOrder.copyWith(...)` or like so:`instanceOfPlaceOrder.copyWith.fieldName(...)`.
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
      'note': ?instance.note?.toJson(),
      'type': _$OrderTypeEnumMap[instance.type]!,
      'items': ?instance.items?.map((e) => e.toJson()).toList(),
      'gender': ?_$UserGenderEnumMap[instance.gender],
      'payment': instance.payment.toJson(),
    };

const _$OrderTypeEnumMap = {
  OrderType.ride: 'ride',
  OrderType.delivery: 'delivery',
  OrderType.food: 'food',
};

const _$UserGenderEnumMap = {
  UserGender.male: 'male',
  UserGender.female: 'female',
};
