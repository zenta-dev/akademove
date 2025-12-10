// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review_check_can_review200_response.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ReviewCheckCanReview200ResponseCWProxy {
  ReviewCheckCanReview200Response message(String? message);

  ReviewCheckCanReview200Response data(
    ReviewCheckCanReview200ResponseData data,
  );

  ReviewCheckCanReview200Response pagination(PaginationResult? pagination);

  ReviewCheckCanReview200Response totalPages(int? totalPages);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `ReviewCheckCanReview200Response(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// ReviewCheckCanReview200Response(...).copyWith(id: 12, name: "My name")
  /// ```
  ReviewCheckCanReview200Response call({
    String? message,
    ReviewCheckCanReview200ResponseData data,
    PaginationResult? pagination,
    int? totalPages,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfReviewCheckCanReview200Response.copyWith(...)` or call `instanceOfReviewCheckCanReview200Response.copyWith.fieldName(value)` for a single field.
class _$ReviewCheckCanReview200ResponseCWProxyImpl
    implements _$ReviewCheckCanReview200ResponseCWProxy {
  const _$ReviewCheckCanReview200ResponseCWProxyImpl(this._value);

  final ReviewCheckCanReview200Response _value;

  @override
  ReviewCheckCanReview200Response message(String? message) =>
      call(message: message);

  @override
  ReviewCheckCanReview200Response data(
    ReviewCheckCanReview200ResponseData data,
  ) => call(data: data);

  @override
  ReviewCheckCanReview200Response pagination(PaginationResult? pagination) =>
      call(pagination: pagination);

  @override
  ReviewCheckCanReview200Response totalPages(int? totalPages) =>
      call(totalPages: totalPages);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `ReviewCheckCanReview200Response(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// ReviewCheckCanReview200Response(...).copyWith(id: 12, name: "My name")
  /// ```
  ReviewCheckCanReview200Response call({
    Object? message = const $CopyWithPlaceholder(),
    Object? data = const $CopyWithPlaceholder(),
    Object? pagination = const $CopyWithPlaceholder(),
    Object? totalPages = const $CopyWithPlaceholder(),
  }) {
    return ReviewCheckCanReview200Response(
      message: message == const $CopyWithPlaceholder()
          ? _value.message
          // ignore: cast_nullable_to_non_nullable
          : message as String?,
      data: data == const $CopyWithPlaceholder() || data == null
          ? _value.data
          // ignore: cast_nullable_to_non_nullable
          : data as ReviewCheckCanReview200ResponseData,
      pagination: pagination == const $CopyWithPlaceholder()
          ? _value.pagination
          // ignore: cast_nullable_to_non_nullable
          : pagination as PaginationResult?,
      totalPages: totalPages == const $CopyWithPlaceholder()
          ? _value.totalPages
          // ignore: cast_nullable_to_non_nullable
          : totalPages as int?,
    );
  }
}

extension $ReviewCheckCanReview200ResponseCopyWith
    on ReviewCheckCanReview200Response {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfReviewCheckCanReview200Response.copyWith(...)` or `instanceOfReviewCheckCanReview200Response.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ReviewCheckCanReview200ResponseCWProxy get copyWith =>
      _$ReviewCheckCanReview200ResponseCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReviewCheckCanReview200Response _$ReviewCheckCanReview200ResponseFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('ReviewCheckCanReview200Response', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['message', 'data']);
  final val = ReviewCheckCanReview200Response(
    message: $checkedConvert('message', (v) => v as String?),
    data: $checkedConvert(
      'data',
      (v) => ReviewCheckCanReview200ResponseData.fromJson(
        v as Map<String, dynamic>,
      ),
    ),
    pagination: $checkedConvert(
      'pagination',
      (v) => v == null
          ? null
          : PaginationResult.fromJson(v as Map<String, dynamic>),
    ),
    totalPages: $checkedConvert('totalPages', (v) => (v as num?)?.toInt()),
  );
  return val;
});

Map<String, dynamic> _$ReviewCheckCanReview200ResponseToJson(
  ReviewCheckCanReview200Response instance,
) => <String, dynamic>{
  'message': instance.message,
  'data': instance.data.toJson(),
  'pagination': ?instance.pagination?.toJson(),
  'totalPages': ?instance.totalPages,
};
