// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_merchant.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$OrderMerchantCWProxy {
  OrderMerchant id(String? id);

  OrderMerchant userId(String? userId);

  OrderMerchant name(String? name);

  OrderMerchant email(String? email);

  OrderMerchant phone(Phone? phone);

  OrderMerchant address(String? address);

  OrderMerchant location(Coordinate? location);

  OrderMerchant isActive(bool? isActive);

  OrderMerchant isOnline(bool? isOnline);

  OrderMerchant isTakingOrders(bool? isTakingOrders);

  OrderMerchant operatingStatus(
    OrderMerchantOperatingStatusEnum? operatingStatus,
  );

  OrderMerchant rating(num? rating);

  OrderMerchant document(String? document);

  OrderMerchant image(String? image);

  OrderMerchant category(MerchantCategory? category);

  OrderMerchant categories(List<String>? categories);

  OrderMerchant bank(Bank? bank);

  OrderMerchant createdAt(DateTime? createdAt);

  OrderMerchant updatedAt(DateTime? updatedAt);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `OrderMerchant(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// OrderMerchant(...).copyWith(id: 12, name: "My name")
  /// ```
  OrderMerchant call({
    String? id,
    String? userId,
    String? name,
    String? email,
    Phone? phone,
    String? address,
    Coordinate? location,
    bool? isActive,
    bool? isOnline,
    bool? isTakingOrders,
    OrderMerchantOperatingStatusEnum? operatingStatus,
    num? rating,
    String? document,
    String? image,
    MerchantCategory? category,
    List<String>? categories,
    Bank? bank,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfOrderMerchant.copyWith(...)` or call `instanceOfOrderMerchant.copyWith.fieldName(value)` for a single field.
class _$OrderMerchantCWProxyImpl implements _$OrderMerchantCWProxy {
  const _$OrderMerchantCWProxyImpl(this._value);

  final OrderMerchant _value;

  @override
  OrderMerchant id(String? id) => call(id: id);

  @override
  OrderMerchant userId(String? userId) => call(userId: userId);

  @override
  OrderMerchant name(String? name) => call(name: name);

  @override
  OrderMerchant email(String? email) => call(email: email);

  @override
  OrderMerchant phone(Phone? phone) => call(phone: phone);

  @override
  OrderMerchant address(String? address) => call(address: address);

  @override
  OrderMerchant location(Coordinate? location) => call(location: location);

  @override
  OrderMerchant isActive(bool? isActive) => call(isActive: isActive);

  @override
  OrderMerchant isOnline(bool? isOnline) => call(isOnline: isOnline);

  @override
  OrderMerchant isTakingOrders(bool? isTakingOrders) =>
      call(isTakingOrders: isTakingOrders);

  @override
  OrderMerchant operatingStatus(
    OrderMerchantOperatingStatusEnum? operatingStatus,
  ) => call(operatingStatus: operatingStatus);

  @override
  OrderMerchant rating(num? rating) => call(rating: rating);

  @override
  OrderMerchant document(String? document) => call(document: document);

  @override
  OrderMerchant image(String? image) => call(image: image);

  @override
  OrderMerchant category(MerchantCategory? category) =>
      call(category: category);

  @override
  OrderMerchant categories(List<String>? categories) =>
      call(categories: categories);

  @override
  OrderMerchant bank(Bank? bank) => call(bank: bank);

  @override
  OrderMerchant createdAt(DateTime? createdAt) => call(createdAt: createdAt);

  @override
  OrderMerchant updatedAt(DateTime? updatedAt) => call(updatedAt: updatedAt);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `OrderMerchant(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// OrderMerchant(...).copyWith(id: 12, name: "My name")
  /// ```
  OrderMerchant call({
    Object? id = const $CopyWithPlaceholder(),
    Object? userId = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
    Object? email = const $CopyWithPlaceholder(),
    Object? phone = const $CopyWithPlaceholder(),
    Object? address = const $CopyWithPlaceholder(),
    Object? location = const $CopyWithPlaceholder(),
    Object? isActive = const $CopyWithPlaceholder(),
    Object? isOnline = const $CopyWithPlaceholder(),
    Object? isTakingOrders = const $CopyWithPlaceholder(),
    Object? operatingStatus = const $CopyWithPlaceholder(),
    Object? rating = const $CopyWithPlaceholder(),
    Object? document = const $CopyWithPlaceholder(),
    Object? image = const $CopyWithPlaceholder(),
    Object? category = const $CopyWithPlaceholder(),
    Object? categories = const $CopyWithPlaceholder(),
    Object? bank = const $CopyWithPlaceholder(),
    Object? createdAt = const $CopyWithPlaceholder(),
    Object? updatedAt = const $CopyWithPlaceholder(),
  }) {
    return OrderMerchant(
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
          : location as Coordinate?,
      isActive: isActive == const $CopyWithPlaceholder()
          ? _value.isActive
          // ignore: cast_nullable_to_non_nullable
          : isActive as bool?,
      isOnline: isOnline == const $CopyWithPlaceholder()
          ? _value.isOnline
          // ignore: cast_nullable_to_non_nullable
          : isOnline as bool?,
      isTakingOrders: isTakingOrders == const $CopyWithPlaceholder()
          ? _value.isTakingOrders
          // ignore: cast_nullable_to_non_nullable
          : isTakingOrders as bool?,
      operatingStatus: operatingStatus == const $CopyWithPlaceholder()
          ? _value.operatingStatus
          // ignore: cast_nullable_to_non_nullable
          : operatingStatus as OrderMerchantOperatingStatusEnum?,
      rating: rating == const $CopyWithPlaceholder()
          ? _value.rating
          // ignore: cast_nullable_to_non_nullable
          : rating as num?,
      document: document == const $CopyWithPlaceholder()
          ? _value.document
          // ignore: cast_nullable_to_non_nullable
          : document as String?,
      image: image == const $CopyWithPlaceholder()
          ? _value.image
          // ignore: cast_nullable_to_non_nullable
          : image as String?,
      category: category == const $CopyWithPlaceholder()
          ? _value.category
          // ignore: cast_nullable_to_non_nullable
          : category as MerchantCategory?,
      categories: categories == const $CopyWithPlaceholder()
          ? _value.categories
          // ignore: cast_nullable_to_non_nullable
          : categories as List<String>?,
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

extension $OrderMerchantCopyWith on OrderMerchant {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfOrderMerchant.copyWith(...)` or `instanceOfOrderMerchant.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$OrderMerchantCWProxy get copyWith => _$OrderMerchantCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderMerchant _$OrderMerchantFromJson(Map<String, dynamic> json) =>
    $checkedCreate('OrderMerchant', json, ($checkedConvert) {
      final val = OrderMerchant(
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
          (v) =>
              v == null ? null : Coordinate.fromJson(v as Map<String, dynamic>),
        ),
        isActive: $checkedConvert('isActive', (v) => v as bool?),
        isOnline: $checkedConvert('isOnline', (v) => v as bool?),
        isTakingOrders: $checkedConvert('isTakingOrders', (v) => v as bool?),
        operatingStatus: $checkedConvert(
          'operatingStatus',
          (v) =>
              $enumDecodeNullable(_$OrderMerchantOperatingStatusEnumEnumMap, v),
        ),
        rating: $checkedConvert('rating', (v) => v as num?),
        document: $checkedConvert('document', (v) => v as String?),
        image: $checkedConvert('image', (v) => v as String?),
        category: $checkedConvert(
          'category',
          (v) => $enumDecodeNullable(_$MerchantCategoryEnumMap, v),
        ),
        categories: $checkedConvert(
          'categories',
          (v) => (v as List<dynamic>?)?.map((e) => e as String).toList(),
        ),
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

Map<String, dynamic> _$OrderMerchantToJson(OrderMerchant instance) =>
    <String, dynamic>{
      'id': ?instance.id,
      'userId': ?instance.userId,
      'name': ?instance.name,
      'email': ?instance.email,
      'phone': ?instance.phone?.toJson(),
      'address': ?instance.address,
      'location': ?instance.location?.toJson(),
      'isActive': ?instance.isActive,
      'isOnline': ?instance.isOnline,
      'isTakingOrders': ?instance.isTakingOrders,
      'operatingStatus':
          ?_$OrderMerchantOperatingStatusEnumEnumMap[instance.operatingStatus],
      'rating': ?instance.rating,
      'document': ?instance.document,
      'image': ?instance.image,
      'category': ?_$MerchantCategoryEnumMap[instance.category],
      'categories': ?instance.categories,
      'bank': ?instance.bank?.toJson(),
      'createdAt': ?instance.createdAt?.toIso8601String(),
      'updatedAt': ?instance.updatedAt?.toIso8601String(),
    };

const _$OrderMerchantOperatingStatusEnumEnumMap = {
  OrderMerchantOperatingStatusEnum.OPEN: 'OPEN',
  OrderMerchantOperatingStatusEnum.CLOSED: 'CLOSED',
  OrderMerchantOperatingStatusEnum.BREAK: 'BREAK',
  OrderMerchantOperatingStatusEnum.MAINTENANCE: 'MAINTENANCE',
};

const _$MerchantCategoryEnumMap = {
  MerchantCategory.ATK: 'ATK',
  MerchantCategory.printing: 'Printing',
  MerchantCategory.food: 'Food',
};
