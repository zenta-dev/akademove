// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'driver_min_quiz_question.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$DriverMinQuizQuestionCWProxy {
  DriverMinQuizQuestion id(String? id);

  DriverMinQuizQuestion question(String? question);

  DriverMinQuizQuestion type(String? type);

  DriverMinQuizQuestion category(String? category);

  DriverMinQuizQuestion points(num points);

  DriverMinQuizQuestion displayOrder(num displayOrder);

  DriverMinQuizQuestion options(
    List<DriverMinQuizQuestionOptionsInner> options,
  );

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `DriverMinQuizQuestion(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// DriverMinQuizQuestion(...).copyWith(id: 12, name: "My name")
  /// ```
  DriverMinQuizQuestion call({
    String? id,
    String? question,
    String? type,
    String? category,
    num points,
    num displayOrder,
    List<DriverMinQuizQuestionOptionsInner> options,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfDriverMinQuizQuestion.copyWith(...)` or call `instanceOfDriverMinQuizQuestion.copyWith.fieldName(value)` for a single field.
class _$DriverMinQuizQuestionCWProxyImpl
    implements _$DriverMinQuizQuestionCWProxy {
  const _$DriverMinQuizQuestionCWProxyImpl(this._value);

  final DriverMinQuizQuestion _value;

  @override
  DriverMinQuizQuestion id(String? id) => call(id: id);

  @override
  DriverMinQuizQuestion question(String? question) => call(question: question);

  @override
  DriverMinQuizQuestion type(String? type) => call(type: type);

  @override
  DriverMinQuizQuestion category(String? category) => call(category: category);

  @override
  DriverMinQuizQuestion points(num points) => call(points: points);

  @override
  DriverMinQuizQuestion displayOrder(num displayOrder) =>
      call(displayOrder: displayOrder);

  @override
  DriverMinQuizQuestion options(
    List<DriverMinQuizQuestionOptionsInner> options,
  ) => call(options: options);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `DriverMinQuizQuestion(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// DriverMinQuizQuestion(...).copyWith(id: 12, name: "My name")
  /// ```
  DriverMinQuizQuestion call({
    Object? id = const $CopyWithPlaceholder(),
    Object? question = const $CopyWithPlaceholder(),
    Object? type = const $CopyWithPlaceholder(),
    Object? category = const $CopyWithPlaceholder(),
    Object? points = const $CopyWithPlaceholder(),
    Object? displayOrder = const $CopyWithPlaceholder(),
    Object? options = const $CopyWithPlaceholder(),
  }) {
    return DriverMinQuizQuestion(
      id: id == const $CopyWithPlaceholder()
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String?,
      question: question == const $CopyWithPlaceholder()
          ? _value.question
          // ignore: cast_nullable_to_non_nullable
          : question as String?,
      type: type == const $CopyWithPlaceholder()
          ? _value.type
          // ignore: cast_nullable_to_non_nullable
          : type as String?,
      category: category == const $CopyWithPlaceholder()
          ? _value.category
          // ignore: cast_nullable_to_non_nullable
          : category as String?,
      points: points == const $CopyWithPlaceholder() || points == null
          ? _value.points
          // ignore: cast_nullable_to_non_nullable
          : points as num,
      displayOrder:
          displayOrder == const $CopyWithPlaceholder() || displayOrder == null
          ? _value.displayOrder
          // ignore: cast_nullable_to_non_nullable
          : displayOrder as num,
      options: options == const $CopyWithPlaceholder() || options == null
          ? _value.options
          // ignore: cast_nullable_to_non_nullable
          : options as List<DriverMinQuizQuestionOptionsInner>,
    );
  }
}

extension $DriverMinQuizQuestionCopyWith on DriverMinQuizQuestion {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfDriverMinQuizQuestion.copyWith(...)` or `instanceOfDriverMinQuizQuestion.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$DriverMinQuizQuestionCWProxy get copyWith =>
      _$DriverMinQuizQuestionCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DriverMinQuizQuestion _$DriverMinQuizQuestionFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('DriverMinQuizQuestion', json, ($checkedConvert) {
  $checkKeys(
    json,
    requiredKeys: const [
      'id',
      'question',
      'type',
      'category',
      'points',
      'displayOrder',
      'options',
    ],
  );
  final val = DriverMinQuizQuestion(
    id: $checkedConvert('id', (v) => v as String?),
    question: $checkedConvert('question', (v) => v as String?),
    type: $checkedConvert('type', (v) => v as String?),
    category: $checkedConvert('category', (v) => v as String?),
    points: $checkedConvert('points', (v) => v as num),
    displayOrder: $checkedConvert('displayOrder', (v) => v as num),
    options: $checkedConvert(
      'options',
      (v) => (v as List<dynamic>)
          .map(
            (e) => DriverMinQuizQuestionOptionsInner.fromJson(
              e as Map<String, dynamic>,
            ),
          )
          .toList(),
    ),
  );
  return val;
});

Map<String, dynamic> _$DriverMinQuizQuestionToJson(
  DriverMinQuizQuestion instance,
) => <String, dynamic>{
  'id': instance.id,
  'question': instance.question,
  'type': instance.type,
  'category': instance.category,
  'points': instance.points,
  'displayOrder': instance.displayOrder,
  'options': instance.options.map((e) => e.toJson()).toList(),
};
