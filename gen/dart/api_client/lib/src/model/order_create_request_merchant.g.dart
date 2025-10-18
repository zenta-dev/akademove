// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_create_request_merchant.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$OrderCreateRequestMerchantCWProxy {
  OrderCreateRequestMerchant id(String? id);

  OrderCreateRequestMerchant userId(String? userId);

  OrderCreateRequestMerchant name(String? name);

  OrderCreateRequestMerchant email(String? email);

  OrderCreateRequestMerchant phone(Phone? phone);

  OrderCreateRequestMerchant address(String? address);

  OrderCreateRequestMerchant location(Location? location);

  OrderCreateRequestMerchant isActive(bool? isActive);

  OrderCreateRequestMerchant rating(num? rating);

  OrderCreateRequestMerchant document(String? document);

  OrderCreateRequestMerchant bank(Bank? bank);

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
    String? name,
    String? email,
    Phone? phone,
    String? address,
    Location? location,
    bool? isActive,
    num? rating,
    String? document,
    Bank? bank,
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
  OrderCreateRequestMerchant name(String? name) => this(name: name);

  @override
  OrderCreateRequestMerchant email(String? email) => this(email: email);

  @override
  OrderCreateRequestMerchant phone(Phone? phone) => this(phone: phone);

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
  OrderCreateRequestMerchant bank(Bank? bank) => this(bank: bank);

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
    Object? name = const $CopyWithPlaceholder(),
    Object? email = const $CopyWithPlaceholder(),
    Object? phone = const $CopyWithPlaceholder(),
    Object? address = const $CopyWithPlaceholder(),
    Object? location = const $CopyWithPlaceholder(),
    Object? isActive = const $CopyWithPlaceholder(),
    Object? rating = const $CopyWithPlaceholder(),
    Object? document = const $CopyWithPlaceholder(),
    Object? bank = const $CopyWithPlaceholder(),
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
          : phone as Phone?,
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
      bank: bank == const $CopyWithPlaceholder()
          ? _value.bank
          // ignore: cast_nullable_to_non_nullable
          : bank as Bank?,
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
    name: $checkedConvert('name', (v) => v as String?),
    email: $checkedConvert('email', (v) => v as String?),
    phone: $checkedConvert(
      'phone',
      (v) => v == null ? null : Phone.fromJson(v as Map<String, dynamic>),
    ),
    address: $checkedConvert('address', (v) => v as String?),
    location: $checkedConvert(
      'location',
      (v) => v == null ? null : Location.fromJson(v as Map<String, dynamic>),
    ),
    isActive: $checkedConvert('isActive', (v) => v as bool?),
    rating: $checkedConvert('rating', (v) => v as num?),
    document: $checkedConvert('document', (v) => v as String?),
    bank: $checkedConvert(
      'bank',
      (v) => v == null ? null : Bank.fromJson(v as Map<String, dynamic>),
    ),
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
  'name': ?instance.name,
  'email': ?instance.email,
  'phone': ?instance.phone?.toJson(),
  'address': ?instance.address,
  'location': ?instance.location?.toJson(),
  'isActive': ?instance.isActive,
  'rating': ?instance.rating,
  'document': ?instance.document,
  'bank': ?instance.bank?.toJson(),
  'createdAt': ?instance.createdAt?.toIso8601String(),
  'updatedAt': ?instance.updatedAt?.toIso8601String(),
};
