// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_create_request_merchant.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$OrderCreateRequestMerchantCWProxy {
  OrderCreateRequestMerchant id(String? id);

  OrderCreateRequestMerchant userId(String? userId);

  OrderCreateRequestMerchant type(OrderCreateRequestMerchantTypeEnum? type);

  OrderCreateRequestMerchant name(String? name);

  OrderCreateRequestMerchant email(String? email);

  OrderCreateRequestMerchant phone(String? phone);

  OrderCreateRequestMerchant address(String? address);

  OrderCreateRequestMerchant location(Location? location);

  OrderCreateRequestMerchant isActive(bool? isActive);

  OrderCreateRequestMerchant rating(num? rating);

  OrderCreateRequestMerchant document(String? document);

  OrderCreateRequestMerchant createdAt(DateTime? createdAt);

  OrderCreateRequestMerchant updatedAt(DateTime? updatedAt);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `OrderCreateRequestMerchant(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// OrderCreateRequestMerchant(...).copyWith(id: 12, name: "My name")
  /// ````
  OrderCreateRequestMerchant call({
    String? id,
    String? userId,
    OrderCreateRequestMerchantTypeEnum? type,
    String? name,
    String? email,
    String? phone,
    String? address,
    Location? location,
    bool? isActive,
    num? rating,
    String? document,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfOrderCreateRequestMerchant.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfOrderCreateRequestMerchant.copyWith.fieldName(...)`
class _$OrderCreateRequestMerchantCWProxyImpl
    implements _$OrderCreateRequestMerchantCWProxy {
  const _$OrderCreateRequestMerchantCWProxyImpl(this._value);

  final OrderCreateRequestMerchant _value;

  @override
  OrderCreateRequestMerchant id(String? id) => this(id: id);

  @override
  OrderCreateRequestMerchant userId(String? userId) => this(userId: userId);

  @override
  OrderCreateRequestMerchant type(OrderCreateRequestMerchantTypeEnum? type) =>
      this(type: type);

  @override
  OrderCreateRequestMerchant name(String? name) => this(name: name);

  @override
  OrderCreateRequestMerchant email(String? email) => this(email: email);

  @override
  OrderCreateRequestMerchant phone(String? phone) => this(phone: phone);

  @override
  OrderCreateRequestMerchant address(String? address) => this(address: address);

  @override
  OrderCreateRequestMerchant location(Location? location) =>
      this(location: location);

  @override
  OrderCreateRequestMerchant isActive(bool? isActive) =>
      this(isActive: isActive);

  @override
  OrderCreateRequestMerchant rating(num? rating) => this(rating: rating);

  @override
  OrderCreateRequestMerchant document(String? document) =>
      this(document: document);

  @override
  OrderCreateRequestMerchant createdAt(DateTime? createdAt) =>
      this(createdAt: createdAt);

  @override
  OrderCreateRequestMerchant updatedAt(DateTime? updatedAt) =>
      this(updatedAt: updatedAt);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `OrderCreateRequestMerchant(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// OrderCreateRequestMerchant(...).copyWith(id: 12, name: "My name")
  /// ````
  OrderCreateRequestMerchant call({
    Object? id = const $CopyWithPlaceholder(),
    Object? userId = const $CopyWithPlaceholder(),
    Object? type = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
    Object? email = const $CopyWithPlaceholder(),
    Object? phone = const $CopyWithPlaceholder(),
    Object? address = const $CopyWithPlaceholder(),
    Object? location = const $CopyWithPlaceholder(),
    Object? isActive = const $CopyWithPlaceholder(),
    Object? rating = const $CopyWithPlaceholder(),
    Object? document = const $CopyWithPlaceholder(),
    Object? createdAt = const $CopyWithPlaceholder(),
    Object? updatedAt = const $CopyWithPlaceholder(),
  }) {
    return OrderCreateRequestMerchant(
      id: id == const $CopyWithPlaceholder()
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String?,
      userId: userId == const $CopyWithPlaceholder()
          ? _value.userId
          // ignore: cast_nullable_to_non_nullable
          : userId as String?,
      type: type == const $CopyWithPlaceholder()
          ? _value.type
          // ignore: cast_nullable_to_non_nullable
          : type as OrderCreateRequestMerchantTypeEnum?,
      name: name == const $CopyWithPlaceholder()
          ? _value.name
          // ignore: cast_nullable_to_non_nullable
          : name as String?,
      email: email == const $CopyWithPlaceholder()
          ? _value.email
          // ignore: cast_nullable_to_non_nullable
          : email as String?,
      phone: phone == const $CopyWithPlaceholder()
          ? _value.phone
          // ignore: cast_nullable_to_non_nullable
          : phone as String?,
      address: address == const $CopyWithPlaceholder()
          ? _value.address
          // ignore: cast_nullable_to_non_nullable
          : address as String?,
      location: location == const $CopyWithPlaceholder()
          ? _value.location
          // ignore: cast_nullable_to_non_nullable
          : location as Location?,
      isActive: isActive == const $CopyWithPlaceholder()
          ? _value.isActive
          // ignore: cast_nullable_to_non_nullable
          : isActive as bool?,
      rating: rating == const $CopyWithPlaceholder()
          ? _value.rating
          // ignore: cast_nullable_to_non_nullable
          : rating as num?,
      document: document == const $CopyWithPlaceholder()
          ? _value.document
          // ignore: cast_nullable_to_non_nullable
          : document as String?,
      createdAt: createdAt == const $CopyWithPlaceholder()
          ? _value.createdAt
          // ignore: cast_nullable_to_non_nullable
          : createdAt as DateTime?,
      updatedAt: updatedAt == const $CopyWithPlaceholder()
          ? _value.updatedAt
          // ignore: cast_nullable_to_non_nullable
          : updatedAt as DateTime?,
    );
  }
}

extension $OrderCreateRequestMerchantCopyWith on OrderCreateRequestMerchant {
  /// Returns a callable class that can be used as follows: `instanceOfOrderCreateRequestMerchant.copyWith(...)` or like so:`instanceOfOrderCreateRequestMerchant.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$OrderCreateRequestMerchantCWProxy get copyWith =>
      _$OrderCreateRequestMerchantCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderCreateRequestMerchant _$OrderCreateRequestMerchantFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('OrderCreateRequestMerchant', json, ($checkedConvert) {
  final val = OrderCreateRequestMerchant(
    id: $checkedConvert('id', (v) => v as String?),
    userId: $checkedConvert('userId', (v) => v as String?),
    type: $checkedConvert(
      'type',
      (v) =>
          $enumDecodeNullable(_$OrderCreateRequestMerchantTypeEnumEnumMap, v),
    ),
    name: $checkedConvert('name', (v) => v as String?),
    email: $checkedConvert('email', (v) => v as String?),
    phone: $checkedConvert('phone', (v) => v as String?),
    address: $checkedConvert('address', (v) => v as String?),
    location: $checkedConvert(
      'location',
      (v) => v == null ? null : Location.fromJson(v as Map<String, dynamic>),
    ),
    isActive: $checkedConvert('isActive', (v) => v as bool?),
    rating: $checkedConvert('rating', (v) => v as num?),
    document: $checkedConvert('document', (v) => v as String?),
    createdAt: $checkedConvert(
      'createdAt',
      (v) => v == null ? null : DateTime.parse(v as String),
    ),
    updatedAt: $checkedConvert(
      'updatedAt',
      (v) => v == null ? null : DateTime.parse(v as String),
    ),
  );
  return val;
});

Map<String, dynamic> _$OrderCreateRequestMerchantToJson(
  OrderCreateRequestMerchant instance,
) => <String, dynamic>{
  'id': ?instance.id,
  'userId': ?instance.userId,
  'type': ?_$OrderCreateRequestMerchantTypeEnumEnumMap[instance.type],
  'name': ?instance.name,
  'email': ?instance.email,
  'phone': ?instance.phone,
  'address': ?instance.address,
  'location': ?instance.location?.toJson(),
  'isActive': ?instance.isActive,
  'rating': ?instance.rating,
  'document': ?instance.document,
  'createdAt': ?instance.createdAt?.toIso8601String(),
  'updatedAt': ?instance.updatedAt?.toIso8601String(),
};

const _$OrderCreateRequestMerchantTypeEnumEnumMap = {
  OrderCreateRequestMerchantTypeEnum.merchant: 'merchant',
  OrderCreateRequestMerchantTypeEnum.tenant: 'tenant',
};
