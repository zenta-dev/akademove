// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'estimate_order.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$EstimateOrderCWProxy {
  EstimateOrder dropoffLocation(Coordinate dropoffLocation);

  EstimateOrder pickupLocation(Coordinate pickupLocation);

  EstimateOrder note(OrderNote? note);

  EstimateOrder type(OrderType type);

  EstimateOrder items(List<OrderItem>? items);

  EstimateOrder gender(UserGender? gender);

  EstimateOrder discountIds(List<num>? discountIds);

  EstimateOrder weight(num? weight);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `EstimateOrder(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// EstimateOrder(...).copyWith(id: 12, name: "My name")
  /// ````
  EstimateOrder call({
    Coordinate dropoffLocation,
    Coordinate pickupLocation,
    OrderNote? note,
    OrderType type,
    List<OrderItem>? items,
    UserGender? gender,
    List<num>? discountIds,
    num? weight,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfEstimateOrder.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfEstimateOrder.copyWith.fieldName(...)`
class _$EstimateOrderCWProxyImpl implements _$EstimateOrderCWProxy {
  const _$EstimateOrderCWProxyImpl(this._value);

  final EstimateOrder _value;

  @override
  EstimateOrder dropoffLocation(Coordinate dropoffLocation) =>
      this(dropoffLocation: dropoffLocation);

  @override
  EstimateOrder pickupLocation(Coordinate pickupLocation) =>
      this(pickupLocation: pickupLocation);

  @override
  EstimateOrder note(OrderNote? note) => this(note: note);

  @override
  EstimateOrder type(OrderType type) => this(type: type);

  @override
  EstimateOrder items(List<OrderItem>? items) => this(items: items);

  @override
  EstimateOrder gender(UserGender? gender) => this(gender: gender);

  @override
  EstimateOrder discountIds(List<num>? discountIds) =>
      this(discountIds: discountIds);

  @override
  EstimateOrder weight(num? weight) => this(weight: weight);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `EstimateOrder(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// EstimateOrder(...).copyWith(id: 12, name: "My name")
  /// ````
  EstimateOrder call({
    Object? dropoffLocation = const $CopyWithPlaceholder(),
    Object? pickupLocation = const $CopyWithPlaceholder(),
    Object? note = const $CopyWithPlaceholder(),
    Object? type = const $CopyWithPlaceholder(),
    Object? items = const $CopyWithPlaceholder(),
    Object? gender = const $CopyWithPlaceholder(),
    Object? discountIds = const $CopyWithPlaceholder(),
    Object? weight = const $CopyWithPlaceholder(),
  }) {
    return EstimateOrder(
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

extension $EstimateOrderCopyWith on EstimateOrder {
  /// Returns a callable class that can be used as follows: `instanceOfEstimateOrder.copyWith(...)` or like so:`instanceOfEstimateOrder.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$EstimateOrderCWProxy get copyWith => _$EstimateOrderCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EstimateOrder _$EstimateOrderFromJson(Map<String, dynamic> json) =>
    $checkedCreate('EstimateOrder', json, ($checkedConvert) {
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
        discountIds: $checkedConvert(
          'discountIds',
          (v) => (v as List<dynamic>?)?.map((e) => e as num).toList(),
        ),
        weight: $checkedConvert('weight', (v) => v as num?),
      );
      return val;
    });

Map<String, dynamic> _$EstimateOrderToJson(EstimateOrder instance) =>
    <String, dynamic>{
      'dropoffLocation': instance.dropoffLocation.toJson(),
      'pickupLocation': instance.pickupLocation.toJson(),
      'note': ?instance.note?.toJson(),
      'type': _$OrderTypeEnumMap[instance.type]!,
      'items': ?instance.items?.map((e) => e.toJson()).toList(),
      'gender': ?_$UserGenderEnumMap[instance.gender],
      'discountIds': ?instance.discountIds,
      'weight': ?instance.weight,
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
