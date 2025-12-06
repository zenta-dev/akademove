// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'driver_quiz_question_answer.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$DriverQuizQuestionAnswerCWProxy {
  DriverQuizQuestionAnswer questionId(String questionId);

  DriverQuizQuestionAnswer selectedOptionId(String selectedOptionId);

  DriverQuizQuestionAnswer isCorrect(bool isCorrect);

  DriverQuizQuestionAnswer pointsEarned(int pointsEarned);

  DriverQuizQuestionAnswer answeredAt(DateTime answeredAt);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `DriverQuizQuestionAnswer(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// DriverQuizQuestionAnswer(...).copyWith(id: 12, name: "My name")
  /// ```
  DriverQuizQuestionAnswer call({
    String questionId,
    String selectedOptionId,
    bool isCorrect,
    int pointsEarned,
    DateTime answeredAt,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfDriverQuizQuestionAnswer.copyWith(...)` or call `instanceOfDriverQuizQuestionAnswer.copyWith.fieldName(value)` for a single field.
class _$DriverQuizQuestionAnswerCWProxyImpl
    implements _$DriverQuizQuestionAnswerCWProxy {
  const _$DriverQuizQuestionAnswerCWProxyImpl(this._value);

  final DriverQuizQuestionAnswer _value;

  @override
  DriverQuizQuestionAnswer questionId(String questionId) =>
      call(questionId: questionId);

  @override
  DriverQuizQuestionAnswer selectedOptionId(String selectedOptionId) =>
      call(selectedOptionId: selectedOptionId);

  @override
  DriverQuizQuestionAnswer isCorrect(bool isCorrect) =>
      call(isCorrect: isCorrect);

  @override
  DriverQuizQuestionAnswer pointsEarned(int pointsEarned) =>
      call(pointsEarned: pointsEarned);

  @override
  DriverQuizQuestionAnswer answeredAt(DateTime answeredAt) =>
      call(answeredAt: answeredAt);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `DriverQuizQuestionAnswer(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// DriverQuizQuestionAnswer(...).copyWith(id: 12, name: "My name")
  /// ```
  DriverQuizQuestionAnswer call({
    Object? questionId = const $CopyWithPlaceholder(),
    Object? selectedOptionId = const $CopyWithPlaceholder(),
    Object? isCorrect = const $CopyWithPlaceholder(),
    Object? pointsEarned = const $CopyWithPlaceholder(),
    Object? answeredAt = const $CopyWithPlaceholder(),
  }) {
    return DriverQuizQuestionAnswer(
      questionId:
          questionId == const $CopyWithPlaceholder() || questionId == null
          ? _value.questionId
          // ignore: cast_nullable_to_non_nullable
          : questionId as String,
      selectedOptionId:
          selectedOptionId == const $CopyWithPlaceholder() ||
              selectedOptionId == null
          ? _value.selectedOptionId
          // ignore: cast_nullable_to_non_nullable
          : selectedOptionId as String,
      isCorrect: isCorrect == const $CopyWithPlaceholder() || isCorrect == null
          ? _value.isCorrect
          // ignore: cast_nullable_to_non_nullable
          : isCorrect as bool,
      pointsEarned:
          pointsEarned == const $CopyWithPlaceholder() || pointsEarned == null
          ? _value.pointsEarned
          // ignore: cast_nullable_to_non_nullable
          : pointsEarned as int,
      answeredAt:
          answeredAt == const $CopyWithPlaceholder() || answeredAt == null
          ? _value.answeredAt
          // ignore: cast_nullable_to_non_nullable
          : answeredAt as DateTime,
    );
  }
}

extension $DriverQuizQuestionAnswerCopyWith on DriverQuizQuestionAnswer {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfDriverQuizQuestionAnswer.copyWith(...)` or `instanceOfDriverQuizQuestionAnswer.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$DriverQuizQuestionAnswerCWProxy get copyWith =>
      _$DriverQuizQuestionAnswerCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DriverQuizQuestionAnswer _$DriverQuizQuestionAnswerFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('DriverQuizQuestionAnswer', json, ($checkedConvert) {
  $checkKeys(
    json,
    requiredKeys: const [
      'questionId',
      'selectedOptionId',
      'isCorrect',
      'pointsEarned',
      'answeredAt',
    ],
  );
  final val = DriverQuizQuestionAnswer(
    questionId: $checkedConvert('questionId', (v) => v as String),
    selectedOptionId: $checkedConvert('selectedOptionId', (v) => v as String),
    isCorrect: $checkedConvert('isCorrect', (v) => v as bool),
    pointsEarned: $checkedConvert('pointsEarned', (v) => (v as num).toInt()),
    answeredAt: $checkedConvert(
      'answeredAt',
      (v) => DateTime.parse(v as String),
    ),
  );
  return val;
});

Map<String, dynamic> _$DriverQuizQuestionAnswerToJson(
  DriverQuizQuestionAnswer instance,
) => <String, dynamic>{
  'questionId': instance.questionId,
  'selectedOptionId': instance.selectedOptionId,
  'isCorrect': instance.isCorrect,
  'pointsEarned': instance.pointsEarned,
  'answeredAt': instance.answeredAt.toIso8601String(),
};
