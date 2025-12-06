// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'start_driver_quiz.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$StartDriverQuizCWProxy {
  StartDriverQuiz questionIds(List<String>? questionIds);

  StartDriverQuiz category(StartDriverQuizCategoryEnum? category);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `StartDriverQuiz(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// StartDriverQuiz(...).copyWith(id: 12, name: "My name")
  /// ```
  StartDriverQuiz call({
    List<String>? questionIds,
    StartDriverQuizCategoryEnum? category,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfStartDriverQuiz.copyWith(...)` or call `instanceOfStartDriverQuiz.copyWith.fieldName(value)` for a single field.
class _$StartDriverQuizCWProxyImpl implements _$StartDriverQuizCWProxy {
  const _$StartDriverQuizCWProxyImpl(this._value);

  final StartDriverQuiz _value;

  @override
  StartDriverQuiz questionIds(List<String>? questionIds) =>
      call(questionIds: questionIds);

  @override
  StartDriverQuiz category(StartDriverQuizCategoryEnum? category) =>
      call(category: category);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `StartDriverQuiz(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// StartDriverQuiz(...).copyWith(id: 12, name: "My name")
  /// ```
  StartDriverQuiz call({
    Object? questionIds = const $CopyWithPlaceholder(),
    Object? category = const $CopyWithPlaceholder(),
  }) {
    return StartDriverQuiz(
      questionIds: questionIds == const $CopyWithPlaceholder()
          ? _value.questionIds
          // ignore: cast_nullable_to_non_nullable
          : questionIds as List<String>?,
      category: category == const $CopyWithPlaceholder()
          ? _value.category
          // ignore: cast_nullable_to_non_nullable
          : category as StartDriverQuizCategoryEnum?,
    );
  }
}

extension $StartDriverQuizCopyWith on StartDriverQuiz {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfStartDriverQuiz.copyWith(...)` or `instanceOfStartDriverQuiz.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$StartDriverQuizCWProxy get copyWith => _$StartDriverQuizCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StartDriverQuiz _$StartDriverQuizFromJson(Map<String, dynamic> json) =>
    $checkedCreate('StartDriverQuiz', json, ($checkedConvert) {
      final val = StartDriverQuiz(
        questionIds: $checkedConvert(
          'questionIds',
          (v) => (v as List<dynamic>?)?.map((e) => e as String).toList(),
        ),
        category: $checkedConvert(
          'category',
          (v) => $enumDecodeNullable(_$StartDriverQuizCategoryEnumEnumMap, v),
        ),
      );
      return val;
    });

Map<String, dynamic> _$StartDriverQuizToJson(StartDriverQuiz instance) =>
    <String, dynamic>{
      'questionIds': ?instance.questionIds,
      'category': ?_$StartDriverQuizCategoryEnumEnumMap[instance.category],
    };

const _$StartDriverQuizCategoryEnumEnumMap = {
  StartDriverQuizCategoryEnum.SAFETY: 'SAFETY',
  StartDriverQuizCategoryEnum.NAVIGATION: 'NAVIGATION',
  StartDriverQuizCategoryEnum.CUSTOMER_SERVICE: 'CUSTOMER_SERVICE',
  StartDriverQuizCategoryEnum.PLATFORM_RULES: 'PLATFORM_RULES',
  StartDriverQuizCategoryEnum.EMERGENCY_PROCEDURES: 'EMERGENCY_PROCEDURES',
  StartDriverQuizCategoryEnum.VEHICLE_MAINTENANCE: 'VEHICLE_MAINTENANCE',
  StartDriverQuizCategoryEnum.GENERAL: 'GENERAL',
};
