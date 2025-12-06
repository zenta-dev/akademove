// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'driver_quiz_question.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$DriverQuizQuestionCWProxy {
  DriverQuizQuestion id(String id);

  DriverQuizQuestion question(String question);

  DriverQuizQuestion type(DriverQuizQuestionType type);

  DriverQuizQuestion category(DriverQuizQuestionCategory category);

  DriverQuizQuestion options(List<DriverQuizQuestionOption> options);

  DriverQuizQuestion explanation(String? explanation);

  DriverQuizQuestion points(int? points);

  DriverQuizQuestion isActive(bool? isActive);

  DriverQuizQuestion displayOrder(int? displayOrder);

  DriverQuizQuestion createdAt(DateTime createdAt);

  DriverQuizQuestion updatedAt(DateTime updatedAt);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `DriverQuizQuestion(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// DriverQuizQuestion(...).copyWith(id: 12, name: "My name")
  /// ```
  DriverQuizQuestion call({
    String id,
    String question,
    DriverQuizQuestionType type,
    DriverQuizQuestionCategory category,
    List<DriverQuizQuestionOption> options,
    String? explanation,
    int? points,
    bool? isActive,
    int? displayOrder,
    DateTime createdAt,
    DateTime updatedAt,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfDriverQuizQuestion.copyWith(...)` or call `instanceOfDriverQuizQuestion.copyWith.fieldName(value)` for a single field.
class _$DriverQuizQuestionCWProxyImpl implements _$DriverQuizQuestionCWProxy {
  const _$DriverQuizQuestionCWProxyImpl(this._value);

  final DriverQuizQuestion _value;

  @override
  DriverQuizQuestion id(String id) => call(id: id);

  @override
  DriverQuizQuestion question(String question) => call(question: question);

  @override
  DriverQuizQuestion type(DriverQuizQuestionType type) => call(type: type);

  @override
  DriverQuizQuestion category(DriverQuizQuestionCategory category) =>
      call(category: category);

  @override
  DriverQuizQuestion options(List<DriverQuizQuestionOption> options) =>
      call(options: options);

  @override
  DriverQuizQuestion explanation(String? explanation) =>
      call(explanation: explanation);

  @override
  DriverQuizQuestion points(int? points) => call(points: points);

  @override
  DriverQuizQuestion isActive(bool? isActive) => call(isActive: isActive);

  @override
  DriverQuizQuestion displayOrder(int? displayOrder) =>
      call(displayOrder: displayOrder);

  @override
  DriverQuizQuestion createdAt(DateTime createdAt) =>
      call(createdAt: createdAt);

  @override
  DriverQuizQuestion updatedAt(DateTime updatedAt) =>
      call(updatedAt: updatedAt);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `DriverQuizQuestion(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// DriverQuizQuestion(...).copyWith(id: 12, name: "My name")
  /// ```
  DriverQuizQuestion call({
    Object? id = const $CopyWithPlaceholder(),
    Object? question = const $CopyWithPlaceholder(),
    Object? type = const $CopyWithPlaceholder(),
    Object? category = const $CopyWithPlaceholder(),
    Object? options = const $CopyWithPlaceholder(),
    Object? explanation = const $CopyWithPlaceholder(),
    Object? points = const $CopyWithPlaceholder(),
    Object? isActive = const $CopyWithPlaceholder(),
    Object? displayOrder = const $CopyWithPlaceholder(),
    Object? createdAt = const $CopyWithPlaceholder(),
    Object? updatedAt = const $CopyWithPlaceholder(),
  }) {
    return DriverQuizQuestion(
      id: id == const $CopyWithPlaceholder() || id == null
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
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

extension $DriverQuizQuestionCopyWith on DriverQuizQuestion {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfDriverQuizQuestion.copyWith(...)` or `instanceOfDriverQuizQuestion.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$DriverQuizQuestionCWProxy get copyWith =>
      _$DriverQuizQuestionCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DriverQuizQuestion _$DriverQuizQuestionFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('DriverQuizQuestion', json, ($checkedConvert) {
  $checkKeys(
    json,
    requiredKeys: const [
      'id',
      'question',
      'type',
      'category',
      'options',
      'explanation',
      'createdAt',
      'updatedAt',
    ],
  );
  final val = DriverQuizQuestion(
    id: $checkedConvert('id', (v) => v as String),
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
    createdAt: $checkedConvert('createdAt', (v) => DateTime.parse(v as String)),
    updatedAt: $checkedConvert('updatedAt', (v) => DateTime.parse(v as String)),
  );
  return val;
});

Map<String, dynamic> _$DriverQuizQuestionToJson(DriverQuizQuestion instance) =>
    <String, dynamic>{
      'id': instance.id,
      'question': instance.question,
      'type': _$DriverQuizQuestionTypeEnumMap[instance.type]!,
      'category': _$DriverQuizQuestionCategoryEnumMap[instance.category]!,
      'options': instance.options.map((e) => e.toJson()).toList(),
      'explanation': instance.explanation,
      'points': ?instance.points,
      'isActive': ?instance.isActive,
      'displayOrder': ?instance.displayOrder,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
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
