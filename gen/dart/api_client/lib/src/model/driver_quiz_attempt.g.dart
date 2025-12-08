// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'driver_quiz_attempt.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$DriverQuizAttemptCWProxy {
  DriverQuizAttempt attemptId(String attemptId);

  DriverQuizAttempt questions(List<DriverMinQuizQuestion> questions);

  DriverQuizAttempt totalQuestions(num totalQuestions);

  DriverQuizAttempt totalPoints(num totalPoints);

  DriverQuizAttempt passingScore(num passingScore);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `DriverQuizAttempt(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// DriverQuizAttempt(...).copyWith(id: 12, name: "My name")
  /// ```
  DriverQuizAttempt call({
    String attemptId,
    List<DriverMinQuizQuestion> questions,
    num totalQuestions,
    num totalPoints,
    num passingScore,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfDriverQuizAttempt.copyWith(...)` or call `instanceOfDriverQuizAttempt.copyWith.fieldName(value)` for a single field.
class _$DriverQuizAttemptCWProxyImpl implements _$DriverQuizAttemptCWProxy {
  const _$DriverQuizAttemptCWProxyImpl(this._value);

  final DriverQuizAttempt _value;

  @override
  DriverQuizAttempt attemptId(String attemptId) => call(attemptId: attemptId);

  @override
  DriverQuizAttempt questions(List<DriverMinQuizQuestion> questions) =>
      call(questions: questions);

  @override
  DriverQuizAttempt totalQuestions(num totalQuestions) =>
      call(totalQuestions: totalQuestions);

  @override
  DriverQuizAttempt totalPoints(num totalPoints) =>
      call(totalPoints: totalPoints);

  @override
  DriverQuizAttempt passingScore(num passingScore) =>
      call(passingScore: passingScore);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `DriverQuizAttempt(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// DriverQuizAttempt(...).copyWith(id: 12, name: "My name")
  /// ```
  DriverQuizAttempt call({
    Object? attemptId = const $CopyWithPlaceholder(),
    Object? questions = const $CopyWithPlaceholder(),
    Object? totalQuestions = const $CopyWithPlaceholder(),
    Object? totalPoints = const $CopyWithPlaceholder(),
    Object? passingScore = const $CopyWithPlaceholder(),
  }) {
    return DriverQuizAttempt(
      attemptId: attemptId == const $CopyWithPlaceholder() || attemptId == null
          ? _value.attemptId
          // ignore: cast_nullable_to_non_nullable
          : attemptId as String,
      questions: questions == const $CopyWithPlaceholder() || questions == null
          ? _value.questions
          // ignore: cast_nullable_to_non_nullable
          : questions as List<DriverMinQuizQuestion>,
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

extension $DriverQuizAttemptCopyWith on DriverQuizAttempt {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfDriverQuizAttempt.copyWith(...)` or `instanceOfDriverQuizAttempt.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$DriverQuizAttemptCWProxy get copyWith =>
      _$DriverQuizAttemptCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DriverQuizAttempt _$DriverQuizAttemptFromJson(Map<String, dynamic> json) =>
    $checkedCreate('DriverQuizAttempt', json, ($checkedConvert) {
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
      final val = DriverQuizAttempt(
        attemptId: $checkedConvert('attemptId', (v) => v as String),
        questions: $checkedConvert(
          'questions',
          (v) => (v as List<dynamic>)
              .map(
                (e) =>
                    DriverMinQuizQuestion.fromJson(e as Map<String, dynamic>),
              )
              .toList(),
        ),
        totalQuestions: $checkedConvert('totalQuestions', (v) => v as num),
        totalPoints: $checkedConvert('totalPoints', (v) => v as num),
        passingScore: $checkedConvert('passingScore', (v) => v as num),
      );
      return val;
    });

Map<String, dynamic> _$DriverQuizAttemptToJson(DriverQuizAttempt instance) =>
    <String, dynamic>{
      'attemptId': instance.attemptId,
      'questions': instance.questions.map((e) => e.toJson()).toList(),
      'totalQuestions': instance.totalQuestions,
      'totalPoints': instance.totalPoints,
      'passingScore': instance.passingScore,
    };
