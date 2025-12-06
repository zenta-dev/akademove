// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'driver_quiz_question_get_quiz_questions200_response_data_inner.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$DriverQuizQuestionGetQuizQuestions200ResponseDataInnerCWProxy {
  DriverQuizQuestionGetQuizQuestions200ResponseDataInner id(String id);

  DriverQuizQuestionGetQuizQuestions200ResponseDataInner question(
    String question,
  );

  DriverQuizQuestionGetQuizQuestions200ResponseDataInner type(String type);

  DriverQuizQuestionGetQuizQuestions200ResponseDataInner category(
    String category,
  );

  DriverQuizQuestionGetQuizQuestions200ResponseDataInner points(num points);

  DriverQuizQuestionGetQuizQuestions200ResponseDataInner displayOrder(
    num displayOrder,
  );

  DriverQuizQuestionGetQuizQuestions200ResponseDataInner options(
    List<DriverQuizQuestionGetQuizQuestions200ResponseDataInnerOptionsInner>
    options,
  );

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `DriverQuizQuestionGetQuizQuestions200ResponseDataInner(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// DriverQuizQuestionGetQuizQuestions200ResponseDataInner(...).copyWith(id: 12, name: "My name")
  /// ```
  DriverQuizQuestionGetQuizQuestions200ResponseDataInner call({
    String id,
    String question,
    String type,
    String category,
    num points,
    num displayOrder,
    List<DriverQuizQuestionGetQuizQuestions200ResponseDataInnerOptionsInner>
    options,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfDriverQuizQuestionGetQuizQuestions200ResponseDataInner.copyWith(...)` or call `instanceOfDriverQuizQuestionGetQuizQuestions200ResponseDataInner.copyWith.fieldName(value)` for a single field.
class _$DriverQuizQuestionGetQuizQuestions200ResponseDataInnerCWProxyImpl
    implements _$DriverQuizQuestionGetQuizQuestions200ResponseDataInnerCWProxy {
  const _$DriverQuizQuestionGetQuizQuestions200ResponseDataInnerCWProxyImpl(
    this._value,
  );

  final DriverQuizQuestionGetQuizQuestions200ResponseDataInner _value;

  @override
  DriverQuizQuestionGetQuizQuestions200ResponseDataInner id(String id) =>
      call(id: id);

  @override
  DriverQuizQuestionGetQuizQuestions200ResponseDataInner question(
    String question,
  ) => call(question: question);

  @override
  DriverQuizQuestionGetQuizQuestions200ResponseDataInner type(String type) =>
      call(type: type);

  @override
  DriverQuizQuestionGetQuizQuestions200ResponseDataInner category(
    String category,
  ) => call(category: category);

  @override
  DriverQuizQuestionGetQuizQuestions200ResponseDataInner points(num points) =>
      call(points: points);

  @override
  DriverQuizQuestionGetQuizQuestions200ResponseDataInner displayOrder(
    num displayOrder,
  ) => call(displayOrder: displayOrder);

  @override
  DriverQuizQuestionGetQuizQuestions200ResponseDataInner options(
    List<DriverQuizQuestionGetQuizQuestions200ResponseDataInnerOptionsInner>
    options,
  ) => call(options: options);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `DriverQuizQuestionGetQuizQuestions200ResponseDataInner(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// DriverQuizQuestionGetQuizQuestions200ResponseDataInner(...).copyWith(id: 12, name: "My name")
  /// ```
  DriverQuizQuestionGetQuizQuestions200ResponseDataInner call({
    Object? id = const $CopyWithPlaceholder(),
    Object? question = const $CopyWithPlaceholder(),
    Object? type = const $CopyWithPlaceholder(),
    Object? category = const $CopyWithPlaceholder(),
    Object? points = const $CopyWithPlaceholder(),
    Object? displayOrder = const $CopyWithPlaceholder(),
    Object? options = const $CopyWithPlaceholder(),
  }) {
    return DriverQuizQuestionGetQuizQuestions200ResponseDataInner(
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
          : type as String,
      category: category == const $CopyWithPlaceholder() || category == null
          ? _value.category
          // ignore: cast_nullable_to_non_nullable
          : category as String,
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
          : options
                as List<
                  DriverQuizQuestionGetQuizQuestions200ResponseDataInnerOptionsInner
                >,
    );
  }
}

extension $DriverQuizQuestionGetQuizQuestions200ResponseDataInnerCopyWith
    on DriverQuizQuestionGetQuizQuestions200ResponseDataInner {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfDriverQuizQuestionGetQuizQuestions200ResponseDataInner.copyWith(...)` or `instanceOfDriverQuizQuestionGetQuizQuestions200ResponseDataInner.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$DriverQuizQuestionGetQuizQuestions200ResponseDataInnerCWProxy
  get copyWith =>
      _$DriverQuizQuestionGetQuizQuestions200ResponseDataInnerCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DriverQuizQuestionGetQuizQuestions200ResponseDataInner
_$DriverQuizQuestionGetQuizQuestions200ResponseDataInnerFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  'DriverQuizQuestionGetQuizQuestions200ResponseDataInner',
  json,
  ($checkedConvert) {
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
    final val = DriverQuizQuestionGetQuizQuestions200ResponseDataInner(
      id: $checkedConvert('id', (v) => v as String),
      question: $checkedConvert('question', (v) => v as String),
      type: $checkedConvert('type', (v) => v as String),
      category: $checkedConvert('category', (v) => v as String),
      points: $checkedConvert('points', (v) => v as num),
      displayOrder: $checkedConvert('displayOrder', (v) => v as num),
      options: $checkedConvert(
        'options',
        (v) => (v as List<dynamic>)
            .map(
              (e) =>
                  DriverQuizQuestionGetQuizQuestions200ResponseDataInnerOptionsInner.fromJson(
                    e as Map<String, dynamic>,
                  ),
            )
            .toList(),
      ),
    );
    return val;
  },
);

Map<String, dynamic>
_$DriverQuizQuestionGetQuizQuestions200ResponseDataInnerToJson(
  DriverQuizQuestionGetQuizQuestions200ResponseDataInner instance,
) => <String, dynamic>{
  'id': instance.id,
  'question': instance.question,
  'type': instance.type,
  'category': instance.category,
  'points': instance.points,
  'displayOrder': instance.displayOrder,
  'options': instance.options.map((e) => e.toJson()).toList(),
};
