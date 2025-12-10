// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'merchant_best_sellers200_response_data_inner_merchant.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$MerchantBestSellers200ResponseDataInnerMerchantCWProxy {
  MerchantBestSellers200ResponseDataInnerMerchant id(String? id);

  MerchantBestSellers200ResponseDataInnerMerchant name(String? name);

  MerchantBestSellers200ResponseDataInnerMerchant image(String? image);

  MerchantBestSellers200ResponseDataInnerMerchant rating(num rating);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `MerchantBestSellers200ResponseDataInnerMerchant(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// MerchantBestSellers200ResponseDataInnerMerchant(...).copyWith(id: 12, name: "My name")
  /// ```
  MerchantBestSellers200ResponseDataInnerMerchant call({
    String? id,
    String? name,
    String? image,
    num rating,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfMerchantBestSellers200ResponseDataInnerMerchant.copyWith(...)` or call `instanceOfMerchantBestSellers200ResponseDataInnerMerchant.copyWith.fieldName(value)` for a single field.
class _$MerchantBestSellers200ResponseDataInnerMerchantCWProxyImpl
    implements _$MerchantBestSellers200ResponseDataInnerMerchantCWProxy {
  const _$MerchantBestSellers200ResponseDataInnerMerchantCWProxyImpl(
    this._value,
  );

  final MerchantBestSellers200ResponseDataInnerMerchant _value;

  @override
  MerchantBestSellers200ResponseDataInnerMerchant id(String? id) =>
      call(id: id);

  @override
  MerchantBestSellers200ResponseDataInnerMerchant name(String? name) =>
      call(name: name);

  @override
  MerchantBestSellers200ResponseDataInnerMerchant image(String? image) =>
      call(image: image);

  @override
  MerchantBestSellers200ResponseDataInnerMerchant rating(num rating) =>
      call(rating: rating);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `MerchantBestSellers200ResponseDataInnerMerchant(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// MerchantBestSellers200ResponseDataInnerMerchant(...).copyWith(id: 12, name: "My name")
  /// ```
  MerchantBestSellers200ResponseDataInnerMerchant call({
    Object? id = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
    Object? image = const $CopyWithPlaceholder(),
    Object? rating = const $CopyWithPlaceholder(),
  }) {
    return MerchantBestSellers200ResponseDataInnerMerchant(
      id: id == const $CopyWithPlaceholder()
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String?,
      name: name == const $CopyWithPlaceholder()
          ? _value.name
          // ignore: cast_nullable_to_non_nullable
          : name as String?,
      image: image == const $CopyWithPlaceholder()
          ? _value.image
          // ignore: cast_nullable_to_non_nullable
          : image as String?,
      rating: rating == const $CopyWithPlaceholder() || rating == null
          ? _value.rating
          // ignore: cast_nullable_to_non_nullable
          : rating as num,
    );
  }
}

extension $MerchantBestSellers200ResponseDataInnerMerchantCopyWith
    on MerchantBestSellers200ResponseDataInnerMerchant {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfMerchantBestSellers200ResponseDataInnerMerchant.copyWith(...)` or `instanceOfMerchantBestSellers200ResponseDataInnerMerchant.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$MerchantBestSellers200ResponseDataInnerMerchantCWProxy get copyWith =>
      _$MerchantBestSellers200ResponseDataInnerMerchantCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MerchantBestSellers200ResponseDataInnerMerchant
_$MerchantBestSellers200ResponseDataInnerMerchantFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('MerchantBestSellers200ResponseDataInnerMerchant', json, (
  $checkedConvert,
) {
  $checkKeys(json, requiredKeys: const ['id', 'name', 'rating']);
  final val = MerchantBestSellers200ResponseDataInnerMerchant(
    id: $checkedConvert('id', (v) => v as String?),
    name: $checkedConvert('name', (v) => v as String?),
    image: $checkedConvert('image', (v) => v as String?),
    rating: $checkedConvert('rating', (v) => v as num),
  );
  return val;
});

Map<String, dynamic> _$MerchantBestSellers200ResponseDataInnerMerchantToJson(
  MerchantBestSellers200ResponseDataInnerMerchant instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'image': ?instance.image,
  'rating': instance.rating,
};
