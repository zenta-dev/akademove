// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'driver_quiz_answer_start_quiz201_response_data.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$DriverQuizAnswerStartQuiz201ResponseDataCWProxy {
  DriverQuizAnswerStartQuiz201ResponseData attemptId(String attemptId);

  DriverQuizAnswerStartQuiz201ResponseData questions(
    List<DriverQuizQuestionGetQuizQuestions200ResponseDataInner> questions,
  );

  DriverQuizAnswerStartQuiz201ResponseData totalQuestions(num totalQuestions);

  DriverQuizAnswerStartQuiz201ResponseData totalPoints(num totalPoints);

  DriverQuizAnswerStartQuiz201ResponseData passingScore(num passingScore);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `DriverQuizAnswerStartQuiz201ResponseData(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// DriverQuizAnswerStartQuiz201ResponseData(...).copyWith(id: 12, name: "My name")
  /// ```
  DriverQuizAnswerStartQuiz201ResponseData call({
    String attemptId,
    List<DriverQuizQuestionGetQuizQuestions200ResponseDataInner> questions,
    num totalQuestions,
    num totalPoints,
    num passingScore,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfDriverQuizAnswerStartQuiz201ResponseData.copyWith(...)` or call `instanceOfDriverQuizAnswerStartQuiz201ResponseData.copyWith.fieldName(value)` for a single field.
class _$DriverQuizAnswerStartQuiz201ResponseDataCWProxyImpl
    implements _$DriverQuizAnswerStartQuiz201ResponseDataCWProxy {
  const _$DriverQuizAnswerStartQuiz201ResponseDataCWProxyImpl(this._value);

  final DriverQuizAnswerStartQuiz201ResponseData _value;

  @override
  DriverQuizAnswerStartQuiz201ResponseData attemptId(String attemptId) =>
      call(attemptId: attemptId);

  @override
  DriverQuizAnswerStartQuiz201ResponseData questions(
    List<DriverQuizQuestionGetQuizQuestions200ResponseDataInner> questions,
  ) => call(questions: questions);

  @override
  DriverQuizAnswerStartQuiz201ResponseData totalQuestions(num totalQuestions) =>
      call(totalQuestions: totalQuestions);

  @override
  DriverQuizAnswerStartQuiz201ResponseData totalPoints(num totalPoints) =>
      call(totalPoints: totalPoints);

  @override
  DriverQuizAnswerStartQuiz201ResponseData passingScore(num passingScore) =>
      call(passingScore: passingScore);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `DriverQuizAnswerStartQuiz201ResponseData(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// DriverQuizAnswerStartQuiz201ResponseData(...).copyWith(id: 12, name: "My name")
  /// ```
  DriverQuizAnswerStartQuiz201ResponseData call({
    Object? attemptId = const $CopyWithPlaceholder(),
    Object? questions = const $CopyWithPlaceholder(),
    Object? totalQuestions = const $CopyWithPlaceholder(),
    Object? totalPoints = const $CopyWithPlaceholder(),
    Object? passingScore = const $CopyWithPlaceholder(),
  }) {
    return DriverQuizAnswerStartQuiz201ResponseData(
      attemptId: attemptId == const $CopyWithPlaceholder() || attemptId == null
          ? _value.attemptId
          // ignore: cast_nullable_to_non_nullable
          : attemptId as String,
      questions: questions == const $CopyWithPlaceholder() || questions == null
          ? _value.questions
          // ignore: cast_nullable_to_non_nullable
          : questions
                as List<DriverQuizQuestionGetQuizQuestions200ResponseDataInner>,
      totalQuestions:
          totalQuestions == const $CopyWithPlaceholder() ||
              totalQuestions == null
          ? _value.totalQuestions
          // ignore: cast_nullable_to_non_nullable
          : totalQuestions as num,
      totalPoints:
          totalPoints == const $CopyWithPlaceholder() || totalPoints == null
          ? _value.totalPoints
          // ignore: cast_nullable_to_non_nullable
          : totalPoints as num,
      passingScore:
          passingScore == const $CopyWithPlaceholder() || passingScore == null
          ? _value.passingScore
          // ignore: cast_nullable_to_non_nullable
          : passingScore as num,
    );
  }
}

extension $DriverQuizAnswerStartQuiz201ResponseDataCopyWith
    on DriverQuizAnswerStartQuiz201ResponseData {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfDriverQuizAnswerStartQuiz201ResponseData.copyWith(...)` or `instanceOfDriverQuizAnswerStartQuiz201ResponseData.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$DriverQuizAnswerStartQuiz201ResponseDataCWProxy get copyWith =>
      _$DriverQuizAnswerStartQuiz201ResponseDataCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DriverQuizAnswerStartQuiz201ResponseData
_$DriverQuizAnswerStartQuiz201ResponseDataFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('DriverQuizAnswerStartQuiz201ResponseData', json, (
  $checkedConvert,
) {
  $checkKeys(
    json,
    requiredKeys: const [
      'attemptId',
      'questions',
      'totalQuestions',
      'totalPoints',
      'passingScore',
    ],
  );
  final val = DriverQuizAnswerStartQuiz201ResponseData(
    attemptId: $checkedConvert('attemptId', (v) => v as String),
    questions: $checkedConvert(
      'questions',
      (v) => (v as List<dynamic>)
          .map(
            (e) =>
                DriverQuizQuestionGetQuizQuestions200ResponseDataInner.fromJson(
                  e as Map<String, dynamic>,
                ),
          )
          .toList(),
    ),
    totalQuestions: $checkedConvert('totalQuestions', (v) => v as num),
    totalPoints: $checkedConvert('totalPoints', (v) => v as num),
    passingScore: $checkedConvert('passingScore', (v) => v as num),
  );
  return val;
});

Map<String, dynamic> _$DriverQuizAnswerStartQuiz201ResponseDataToJson(
  DriverQuizAnswerStartQuiz201ResponseData instance,
) => <String, dynamic>{
  'attemptId': instance.attemptId,
  'questions': instance.questions.map((e) => e.toJson()).toList(),
  'totalQuestions': instance.totalQuestions,
  'totalPoints': instance.totalPoints,
  'passingScore': instance.passingScore,
};
