// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_review.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$UpdateReviewCWProxy {
  UpdateReview categories(List<ReviewCategory>? categories);

  UpdateReview score(int? score);

  UpdateReview comment(String? comment);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `UpdateReview(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// UpdateReview(...).copyWith(id: 12, name: "My name")
  /// ```
  UpdateReview call({
    List<ReviewCategory>? categories,
    int? score,
    String? comment,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfUpdateReview.copyWith(...)` or call `instanceOfUpdateReview.copyWith.fieldName(value)` for a single field.
class _$UpdateReviewCWProxyImpl implements _$UpdateReviewCWProxy {
  const _$UpdateReviewCWProxyImpl(this._value);

  final UpdateReview _value;

  @override
  UpdateReview categories(List<ReviewCategory>? categories) =>
      call(categories: categories);

  @override
  UpdateReview score(int? score) => call(score: score);

  @override
  UpdateReview comment(String? comment) => call(comment: comment);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `UpdateReview(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// UpdateReview(...).copyWith(id: 12, name: "My name")
  /// ```
  UpdateReview call({
    Object? categories = const $CopyWithPlaceholder(),
    Object? score = const $CopyWithPlaceholder(),
    Object? comment = const $CopyWithPlaceholder(),
  }) {
    return UpdateReview(
      categories: categories == const $CopyWithPlaceholder()
          ? _value.categories
          // ignore: cast_nullable_to_non_nullable
          : categories as List<ReviewCategory>?,
      score: score == const $CopyWithPlaceholder()
          ? _value.score
          // ignore: cast_nullable_to_non_nullable
          : score as int?,
      comment: comment == const $CopyWithPlaceholder()
          ? _value.comment
          // ignore: cast_nullable_to_non_nullable
          : comment as String?,
    );
  }
}

extension $UpdateReviewCopyWith on UpdateReview {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfUpdateReview.copyWith(...)` or `instanceOfUpdateReview.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$UpdateReviewCWProxy get copyWith => _$UpdateReviewCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateReview _$UpdateReviewFromJson(Map<String, dynamic> json) =>
    $checkedCreate('UpdateReview', json, ($checkedConvert) {
      final val = UpdateReview(
        categories: $checkedConvert(
          'categories',
          (v) => (v as List<dynamic>?)
              ?.map((e) => $enumDecode(_$ReviewCategoryEnumMap, e))
              .toList(),
        ),
        score: $checkedConvert('score', (v) => (v as num?)?.toInt()),
        comment: $checkedConvert('comment', (v) => v as String? ?? ''),
      );
      return val;
    });

Map<String, dynamic> _$UpdateReviewToJson(UpdateReview instance) =>
    <String, dynamic>{
      'categories': ?instance.categories
          ?.map((e) => _$ReviewCategoryEnumMap[e]!)
          .toList(),
      'score': ?instance.score,
      'comment': ?instance.comment,
    };

const _$ReviewCategoryEnumMap = {
  ReviewCategory.CLEANLINESS: 'CLEANLINESS',
  ReviewCategory.COURTESY: 'COURTESY',
  ReviewCategory.PUNCTUALITY: 'PUNCTUALITY',
  ReviewCategory.SAFETY: 'SAFETY',
  ReviewCategory.COMMUNICATION: 'COMMUNICATION',
  ReviewCategory.OTHER: 'OTHER',
};
