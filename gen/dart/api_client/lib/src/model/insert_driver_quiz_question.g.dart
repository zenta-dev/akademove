// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'insert_driver_quiz_question.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$InsertDriverQuizQuestionCWProxy {
  InsertDriverQuizQuestion question(String question);

  InsertDriverQuizQuestion type(DriverQuizQuestionType type);

  InsertDriverQuizQuestion category(DriverQuizQuestionCategory category);

  InsertDriverQuizQuestion options(List<DriverQuizQuestionOption> options);

  InsertDriverQuizQuestion explanation(String? explanation);

  InsertDriverQuizQuestion points(int? points);

  InsertDriverQuizQuestion isActive(bool? isActive);

  InsertDriverQuizQuestion displayOrder(int? displayOrder);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `InsertDriverQuizQuestion(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// InsertDriverQuizQuestion(...).copyWith(id: 12, name: "My name")
  /// ```
  InsertDriverQuizQuestion call({
    String question,
    DriverQuizQuestionType type,
    DriverQuizQuestionCategory category,
    List<DriverQuizQuestionOption> options,
    String? explanation,
    int? points,
    bool? isActive,
    int? displayOrder,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfInsertDriverQuizQuestion.copyWith(...)` or call `instanceOfInsertDriverQuizQuestion.copyWith.fieldName(value)` for a single field.
class _$InsertDriverQuizQuestionCWProxyImpl
    implements _$InsertDriverQuizQuestionCWProxy {
  const _$InsertDriverQuizQuestionCWProxyImpl(this._value);

  final InsertDriverQuizQuestion _value;

  @override
  InsertDriverQuizQuestion question(String question) =>
      call(question: question);

  @override
  InsertDriverQuizQuestion type(DriverQuizQuestionType type) =>
      call(type: type);

  @override
  InsertDriverQuizQuestion category(DriverQuizQuestionCategory category) =>
      call(category: category);

  @override
  InsertDriverQuizQuestion options(List<DriverQuizQuestionOption> options) =>
      call(options: options);

  @override
  InsertDriverQuizQuestion explanation(String? explanation) =>
      call(explanation: explanation);

  @override
  InsertDriverQuizQuestion points(int? points) => call(points: points);

  @override
  InsertDriverQuizQuestion isActive(bool? isActive) => call(isActive: isActive);

  @override
  InsertDriverQuizQuestion displayOrder(int? displayOrder) =>
      call(displayOrder: displayOrder);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `InsertDriverQuizQuestion(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// InsertDriverQuizQuestion(...).copyWith(id: 12, name: "My name")
  /// ```
  InsertDriverQuizQuestion call({
    Object? question = const $CopyWithPlaceholder(),
    Object? type = const $CopyWithPlaceholder(),
    Object? category = const $CopyWithPlaceholder(),
    Object? options = const $CopyWithPlaceholder(),
    Object? explanation = const $CopyWithPlaceholder(),
    Object? points = const $CopyWithPlaceholder(),
    Object? isActive = const $CopyWithPlaceholder(),
    Object? displayOrder = const $CopyWithPlaceholder(),
  }) {
    return InsertDriverQuizQuestion(
      question: question == const $CopyWithPlaceholder() || question == null
          ? _value.question
          // ignore: cast_nullable_to_non_nullable
          : question as String,
      type: type == const $CopyWithPlaceholder() || type == null
          ? _value.type
          // ignore: cast_nullable_to_non_nullable
          : type as DriverQuizQuestionType,
      category: category == const $CopyWithPlaceholder() || category == null
          ? _value.category
          // ignore: cast_nullable_to_non_nullable
          : category as DriverQuizQuestionCategory,
      options: options == const $CopyWithPlaceholder() || options == null
          ? _value.options
          // ignore: cast_nullable_to_non_nullable
          : options as List<DriverQuizQuestionOption>,
      explanation: explanation == const $CopyWithPlaceholder()
          ? _value.explanation
          // ignore: cast_nullable_to_non_nullable
          : explanation as String?,
      points: points == const $CopyWithPlaceholder()
          ? _value.points
          // ignore: cast_nullable_to_non_nullable
          : points as int?,
      isActive: isActive == const $CopyWithPlaceholder()
          ? _value.isActive
          // ignore: cast_nullable_to_non_nullable
          : isActive as bool?,
      displayOrder: displayOrder == const $CopyWithPlaceholder()
          ? _value.displayOrder
          // ignore: cast_nullable_to_non_nullable
          : displayOrder as int?,
    );
  }
}

extension $InsertDriverQuizQuestionCopyWith on InsertDriverQuizQuestion {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfInsertDriverQuizQuestion.copyWith(...)` or `instanceOfInsertDriverQuizQuestion.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$InsertDriverQuizQuestionCWProxy get copyWith =>
      _$InsertDriverQuizQuestionCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InsertDriverQuizQuestion _$InsertDriverQuizQuestionFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('InsertDriverQuizQuestion', json, ($checkedConvert) {
  $checkKeys(
    json,
    requiredKeys: const [
      'question',
      'type',
      'category',
      'options',
      'explanation',
    ],
  );
  final val = InsertDriverQuizQuestion(
    question: $checkedConvert('question', (v) => v as String),
    type: $checkedConvert(
      'type',
      (v) => $enumDecode(_$DriverQuizQuestionTypeEnumMap, v),
    ),
    category: $checkedConvert(
      'category',
      (v) => $enumDecode(_$DriverQuizQuestionCategoryEnumMap, v),
    ),
    options: $checkedConvert(
      'options',
      (v) => (v as List<dynamic>)
          .map(
            (e) => DriverQuizQuestionOption.fromJson(e as Map<String, dynamic>),
          )
          .toList(),
    ),
    explanation: $checkedConvert('explanation', (v) => v as String?),
    points: $checkedConvert('points', (v) => (v as num?)?.toInt() ?? 10),
    isActive: $checkedConvert('isActive', (v) => v as bool? ?? true),
    displayOrder: $checkedConvert(
      'displayOrder',
      (v) => (v as num?)?.toInt() ?? 0,
    ),
  );
  return val;
});

Map<String, dynamic> _$InsertDriverQuizQuestionToJson(
  InsertDriverQuizQuestion instance,
) => <String, dynamic>{
  'question': instance.question,
  'type': _$DriverQuizQuestionTypeEnumMap[instance.type]!,
  'category': _$DriverQuizQuestionCategoryEnumMap[instance.category]!,
  'options': instance.options.map((e) => e.toJson()).toList(),
  'explanation': instance.explanation,
  'points': ?instance.points,
  'isActive': ?instance.isActive,
  'displayOrder': ?instance.displayOrder,
};

const _$DriverQuizQuestionTypeEnumMap = {
  DriverQuizQuestionType.MULTIPLE_CHOICE: 'MULTIPLE_CHOICE',
  DriverQuizQuestionType.TRUE_FALSE: 'TRUE_FALSE',
};

const _$DriverQuizQuestionCategoryEnumMap = {
  DriverQuizQuestionCategory.SAFETY: 'SAFETY',
  DriverQuizQuestionCategory.NAVIGATION: 'NAVIGATION',
  DriverQuizQuestionCategory.CUSTOMER_SERVICE: 'CUSTOMER_SERVICE',
  DriverQuizQuestionCategory.PLATFORM_RULES: 'PLATFORM_RULES',
  DriverQuizQuestionCategory.EMERGENCY_PROCEDURES: 'EMERGENCY_PROCEDURES',
  DriverQuizQuestionCategory.VEHICLE_MAINTENANCE: 'VEHICLE_MAINTENANCE',
  DriverQuizQuestionCategory.GENERAL: 'GENERAL',
};
