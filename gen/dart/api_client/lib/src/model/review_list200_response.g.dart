// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review_list200_response.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ReviewList200ResponseCWProxy {
  ReviewList200Response message(String message);

  ReviewList200Response data(List<Review> data);

  ReviewList200Response totalPages(int? totalPages);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ReviewList200Response(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ReviewList200Response(...).copyWith(id: 12, name: "My name")
  /// ````
  ReviewList200Response call({
    String message,
    List<Review> data,
    int? totalPages,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfReviewList200Response.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfReviewList200Response.copyWith.fieldName(...)`
class _$ReviewList200ResponseCWProxyImpl
    implements _$ReviewList200ResponseCWProxy {
  const _$ReviewList200ResponseCWProxyImpl(this._value);

  final ReviewList200Response _value;

  @override
  ReviewList200Response message(String message) => this(message: message);

  @override
  ReviewList200Response data(List<Review> data) => this(data: data);

  @override
  ReviewList200Response totalPages(int? totalPages) =>
      this(totalPages: totalPages);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ReviewList200Response(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ReviewList200Response(...).copyWith(id: 12, name: "My name")
  /// ````
  ReviewList200Response call({
    Object? message = const $CopyWithPlaceholder(),
    Object? data = const $CopyWithPlaceholder(),
    Object? totalPages = const $CopyWithPlaceholder(),
  }) {
    return ReviewList200Response(
      message: message == const $CopyWithPlaceholder()
          ? _value.message
          // ignore: cast_nullable_to_non_nullable
          : message as String,
      data: data == const $CopyWithPlaceholder()
          ? _value.data
          // ignore: cast_nullable_to_non_nullable
          : data as List<Review>,
      totalPages: totalPages == const $CopyWithPlaceholder()
          ? _value.totalPages
          // ignore: cast_nullable_to_non_nullable
          : totalPages as int?,
    );
  }
}

extension $ReviewList200ResponseCopyWith on ReviewList200Response {
  /// Returns a callable class that can be used as follows: `instanceOfReviewList200Response.copyWith(...)` or like so:`instanceOfReviewList200Response.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ReviewList200ResponseCWProxy get copyWith =>
      _$ReviewList200ResponseCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReviewList200Response _$ReviewList200ResponseFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('ReviewList200Response', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['message', 'data']);
  final val = ReviewList200Response(
    message: $checkedConvert('message', (v) => v as String),
    data: $checkedConvert(
      'data',
      (v) => (v as List<dynamic>)
          .map((e) => Review.fromJson(e as Map<String, dynamic>))
          .toList(),
    ),
    totalPages: $checkedConvert('totalPages', (v) => (v as num?)?.toInt()),
  );
  return val;
});

Map<String, dynamic> _$ReviewList200ResponseToJson(
  ReviewList200Response instance,
) => <String, dynamic>{
  'message': instance.message,
  'data': instance.data.map((e) => e.toJson()).toList(),
  'totalPages': ?instance.totalPages,
};
