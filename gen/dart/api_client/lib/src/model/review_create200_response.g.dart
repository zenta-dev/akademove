// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review_create200_response.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ReviewCreate200ResponseCWProxy {
  ReviewCreate200Response message(String message);

  ReviewCreate200Response data(Review data);

  ReviewCreate200Response totalPages(num? totalPages);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ReviewCreate200Response(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ReviewCreate200Response(...).copyWith(id: 12, name: "My name")
  /// ````
  ReviewCreate200Response call({String message, Review data, num? totalPages});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfReviewCreate200Response.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfReviewCreate200Response.copyWith.fieldName(...)`
class _$ReviewCreate200ResponseCWProxyImpl
    implements _$ReviewCreate200ResponseCWProxy {
  const _$ReviewCreate200ResponseCWProxyImpl(this._value);

  final ReviewCreate200Response _value;

  @override
  ReviewCreate200Response message(String message) => this(message: message);

  @override
  ReviewCreate200Response data(Review data) => this(data: data);

  @override
  ReviewCreate200Response totalPages(num? totalPages) =>
      this(totalPages: totalPages);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ReviewCreate200Response(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ReviewCreate200Response(...).copyWith(id: 12, name: "My name")
  /// ````
  ReviewCreate200Response call({
    Object? message = const $CopyWithPlaceholder(),
    Object? data = const $CopyWithPlaceholder(),
    Object? totalPages = const $CopyWithPlaceholder(),
  }) {
    return ReviewCreate200Response(
      message: message == const $CopyWithPlaceholder()
          ? _value.message
          // ignore: cast_nullable_to_non_nullable
          : message as String,
      data: data == const $CopyWithPlaceholder()
          ? _value.data
          // ignore: cast_nullable_to_non_nullable
          : data as Review,
      totalPages: totalPages == const $CopyWithPlaceholder()
          ? _value.totalPages
          // ignore: cast_nullable_to_non_nullable
          : totalPages as num?,
    );
  }
}

extension $ReviewCreate200ResponseCopyWith on ReviewCreate200Response {
  /// Returns a callable class that can be used as follows: `instanceOfReviewCreate200Response.copyWith(...)` or like so:`instanceOfReviewCreate200Response.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ReviewCreate200ResponseCWProxy get copyWith =>
      _$ReviewCreate200ResponseCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReviewCreate200Response _$ReviewCreate200ResponseFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('ReviewCreate200Response', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['message', 'data']);
  final val = ReviewCreate200Response(
    message: $checkedConvert('message', (v) => v as String),
    data: $checkedConvert(
      'data',
      (v) => Review.fromJson(v as Map<String, dynamic>),
    ),
    totalPages: $checkedConvert('totalPages', (v) => v as num?),
  );
  return val;
});

Map<String, dynamic> _$ReviewCreate200ResponseToJson(
  ReviewCreate200Response instance,
) => <String, dynamic>{
  'message': instance.message,
  'data': instance.data.toJson(),
  'totalPages': ?instance.totalPages,
};
