// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'merchant.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$MerchantCWProxy {
  Merchant id(String id);

  Merchant userId(String userId);

  Merchant name(String name);

  Merchant email(String email);

  Merchant phone(Phone? phone);

  Merchant address(String address);

  Merchant location(Coordinate? location);

  Merchant isActive(bool isActive);

  Merchant isOnline(bool isOnline);

  Merchant isTakingOrders(bool isTakingOrders);

  Merchant operatingStatus(MerchantOperatingStatusEnum operatingStatus);

  Merchant rating(num rating);

  Merchant document(String? document);

  Merchant image(String? image);

  Merchant category(MerchantCategory category);

  Merchant categories(List<String> categories);

  Merchant bank(Bank bank);

  Merchant createdAt(DateTime createdAt);

  Merchant updatedAt(DateTime updatedAt);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `Merchant(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// Merchant(...).copyWith(id: 12, name: "My name")
  /// ```
  Merchant call({
    String id,
    String userId,
    String name,
    String email,
    Phone? phone,
    String address,
    Coordinate? location,
    bool isActive,
    bool isOnline,
    bool isTakingOrders,
    MerchantOperatingStatusEnum operatingStatus,
    num rating,
    String? document,
    String? image,
    MerchantCategory category,
    List<String> categories,
    Bank bank,
    DateTime createdAt,
    DateTime updatedAt,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfMerchant.copyWith(...)` or call `instanceOfMerchant.copyWith.fieldName(value)` for a single field.
class _$MerchantCWProxyImpl implements _$MerchantCWProxy {
  const _$MerchantCWProxyImpl(this._value);

  final Merchant _value;

  @override
  Merchant id(String id) => call(id: id);

  @override
  Merchant userId(String userId) => call(userId: userId);

  @override
  Merchant name(String name) => call(name: name);

  @override
  Merchant email(String email) => call(email: email);

  @override
  Merchant phone(Phone? phone) => call(phone: phone);

  @override
  Merchant address(String address) => call(address: address);

  @override
  Merchant location(Coordinate? location) => call(location: location);

  @override
  Merchant isActive(bool isActive) => call(isActive: isActive);

  @override
  Merchant isOnline(bool isOnline) => call(isOnline: isOnline);

  @override
  Merchant isTakingOrders(bool isTakingOrders) =>
      call(isTakingOrders: isTakingOrders);

  @override
  Merchant operatingStatus(MerchantOperatingStatusEnum operatingStatus) =>
      call(operatingStatus: operatingStatus);

  @override
  Merchant rating(num rating) => call(rating: rating);

  @override
  Merchant document(String? document) => call(document: document);

  @override
  Merchant image(String? image) => call(image: image);

  @override
  Merchant category(MerchantCategory category) => call(category: category);

  @override
  Merchant categories(List<String> categories) => call(categories: categories);

  @override
  Merchant bank(Bank bank) => call(bank: bank);

  @override
  Merchant createdAt(DateTime createdAt) => call(createdAt: createdAt);

  @override
  Merchant updatedAt(DateTime updatedAt) => call(updatedAt: updatedAt);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `Merchant(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// Merchant(...).copyWith(id: 12, name: "My name")
  /// ```
  Merchant call({
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
    return Merchant(
      id: id == const $CopyWithPlaceholder() || id == null
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
      userId: userId == const $CopyWithPlaceholder() || userId == null
          ? _value.userId
          // ignore: cast_nullable_to_non_nullable
          : userId as String,
      name: name == const $CopyWithPlaceholder() || name == null
          ? _value.name
          // ignore: cast_nullable_to_non_nullable
          : name as String,
      email: email == const $CopyWithPlaceholder() || email == null
          ? _value.email
          // ignore: cast_nullable_to_non_nullable
          : email as String,
      phone: phone == const $CopyWithPlaceholder()
          ? _value.phone
          // ignore: cast_nullable_to_non_nullable
          : phone as Phone?,
      address: address == const $CopyWithPlaceholder() || address == null
          ? _value.address
          // ignore: cast_nullable_to_non_nullable
          : address as String,
      location: location == const $CopyWithPlaceholder()
          ? _value.location
          // ignore: cast_nullable_to_non_nullable
          : location as Coordinate?,
      isActive: isActive == const $CopyWithPlaceholder() || isActive == null
          ? _value.isActive
          // ignore: cast_nullable_to_non_nullable
          : isActive as bool,
      isOnline: isOnline == const $CopyWithPlaceholder() || isOnline == null
          ? _value.isOnline
          // ignore: cast_nullable_to_non_nullable
          : isOnline as bool,
      isTakingOrders:
          isTakingOrders == const $CopyWithPlaceholder() ||
              isTakingOrders == null
          ? _value.isTakingOrders
          // ignore: cast_nullable_to_non_nullable
          : isTakingOrders as bool,
      operatingStatus:
          operatingStatus == const $CopyWithPlaceholder() ||
              operatingStatus == null
          ? _value.operatingStatus
          // ignore: cast_nullable_to_non_nullable
          : operatingStatus as MerchantOperatingStatusEnum,
      rating: rating == const $CopyWithPlaceholder() || rating == null
          ? _value.rating
          // ignore: cast_nullable_to_non_nullable
          : rating as num,
      document: document == const $CopyWithPlaceholder()
          ? _value.document
          // ignore: cast_nullable_to_non_nullable
          : document as String?,
      image: image == const $CopyWithPlaceholder()
          ? _value.image
          // ignore: cast_nullable_to_non_nullable
          : image as String?,
      category: category == const $CopyWithPlaceholder() || category == null
          ? _value.category
          // ignore: cast_nullable_to_non_nullable
          : category as MerchantCategory,
      categories:
          categories == const $CopyWithPlaceholder() || categories == null
          ? _value.categories
          // ignore: cast_nullable_to_non_nullable
          : categories as List<String>,
      bank: bank == const $CopyWithPlaceholder() || bank == null
          ? _value.bank
          // ignore: cast_nullable_to_non_nullable
          : bank as Bank,
      createdAt: createdAt == const $CopyWithPlaceholder() || createdAt == null
          ? _value.createdAt
          // ignore: cast_nullable_to_non_nullable
          : createdAt as DateTime,
      updatedAt: updatedAt == const $CopyWithPlaceholder() || updatedAt == null
          ? _value.updatedAt
          // ignore: cast_nullable_to_non_nullable
          : updatedAt as DateTime,
    );
  }
}

extension $MerchantCopyWith on Merchant {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfMerchant.copyWith(...)` or `instanceOfMerchant.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$MerchantCWProxy get copyWith => _$MerchantCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Merchant _$MerchantFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('Merchant', json, ($checkedConvert) {
  $checkKeys(
    json,
    requiredKeys: const [
      'id',
      'userId',
      'name',
      'email',
      'address',
      'isActive',
      'isOnline',
      'isTakingOrders',
      'operatingStatus',
      'rating',
      'category',
      'categories',
      'bank',
      'createdAt',
      'updatedAt',
    ],
  );
  final val = Merchant(
    id: $checkedConvert('id', (v) => v as String),
    userId: $checkedConvert('userId', (v) => v as String),
    name: $checkedConvert('name', (v) => v as String),
    email: $checkedConvert('email', (v) => v as String),
    phone: $checkedConvert(
      'phone',
      (v) => v == null ? null : Phone.fromJson(v as Map<String, dynamic>),
    ),
    address: $checkedConvert('address', (v) => v as String),
    location: $checkedConvert(
      'location',
      (v) => v == null ? null : Coordinate.fromJson(v as Map<String, dynamic>),
    ),
    isActive: $checkedConvert('isActive', (v) => v as bool),
    isOnline: $checkedConvert('isOnline', (v) => v as bool),
    isTakingOrders: $checkedConvert('isTakingOrders', (v) => v as bool),
    operatingStatus: $checkedConvert(
      'operatingStatus',
      (v) => $enumDecode(_$MerchantOperatingStatusEnumEnumMap, v),
    ),
    rating: $checkedConvert('rating', (v) => v as num),
    document: $checkedConvert('document', (v) => v as String?),
    image: $checkedConvert('image', (v) => v as String?),
    category: $checkedConvert(
      'category',
      (v) => $enumDecode(_$MerchantCategoryEnumMap, v),
    ),
    categories: $checkedConvert(
      'categories',
      (v) => (v as List<dynamic>).map((e) => e as String).toList(),
    ),
    bank: $checkedConvert(
      'bank',
      (v) => Bank.fromJson(v as Map<String, dynamic>),
    ),
    createdAt: $checkedConvert('createdAt', (v) => DateTime.parse(v as String)),
    updatedAt: $checkedConvert('updatedAt', (v) => DateTime.parse(v as String)),
  );
  return val;
});

Map<String, dynamic> _$MerchantToJson(Merchant instance) => <String, dynamic>{
  'id': instance.id,
  'userId': instance.userId,
  'name': instance.name,
  'email': instance.email,
  'phone': ?instance.phone?.toJson(),
  'address': instance.address,
  'location': ?instance.location?.toJson(),
  'isActive': instance.isActive,
  'isOnline': instance.isOnline,
  'isTakingOrders': instance.isTakingOrders,
  'operatingStatus':
      _$MerchantOperatingStatusEnumEnumMap[instance.operatingStatus]!,
  'rating': instance.rating,
  'document': ?instance.document,
  'image': ?instance.image,
  'category': _$MerchantCategoryEnumMap[instance.category]!,
  'categories': instance.categories,
  'bank': instance.bank.toJson(),
  'createdAt': instance.createdAt.toIso8601String(),
  'updatedAt': instance.updatedAt.toIso8601String(),
};

const _$MerchantOperatingStatusEnumEnumMap = {
  MerchantOperatingStatusEnum.OPEN: 'OPEN',
  MerchantOperatingStatusEnum.CLOSED: 'CLOSED',
  MerchantOperatingStatusEnum.BREAK: 'BREAK',
  MerchantOperatingStatusEnum.MAINTENANCE: 'MAINTENANCE',
};

const _$MerchantCategoryEnumMap = {
  MerchantCategory.ATK: 'ATK',
  MerchantCategory.printing: 'Printing',
  MerchantCategory.food: 'Food',
};
