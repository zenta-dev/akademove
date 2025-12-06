// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'driver_quiz_result.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$DriverQuizResultCWProxy {
  DriverQuizResult attemptId(String attemptId);

  DriverQuizResult status(DriverQuizAnswerStatus status);

  DriverQuizResult totalQuestions(int totalQuestions);

  DriverQuizResult correctAnswers(int correctAnswers);

  DriverQuizResult scorePercentage(num scorePercentage);

  DriverQuizResult passed(bool passed);

  DriverQuizResult earnedPoints(int earnedPoints);

  DriverQuizResult totalPoints(int totalPoints);

  DriverQuizResult completedAt(DateTime? completedAt);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `DriverQuizResult(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// DriverQuizResult(...).copyWith(id: 12, name: "My name")
  /// ```
  DriverQuizResult call({
    String attemptId,
    DriverQuizAnswerStatus status,
    int totalQuestions,
    int correctAnswers,
    num scorePercentage,
    bool passed,
    int earnedPoints,
    int totalPoints,
    DateTime? completedAt,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfDriverQuizResult.copyWith(...)` or call `instanceOfDriverQuizResult.copyWith.fieldName(value)` for a single field.
class _$DriverQuizResultCWProxyImpl implements _$DriverQuizResultCWProxy {
  const _$DriverQuizResultCWProxyImpl(this._value);

  final DriverQuizResult _value;

  @override
  DriverQuizResult attemptId(String attemptId) => call(attemptId: attemptId);

  @override
  DriverQuizResult status(DriverQuizAnswerStatus status) =>
      call(status: status);

  @override
  DriverQuizResult totalQuestions(int totalQuestions) =>
      call(totalQuestions: totalQuestions);

  @override
  DriverQuizResult correctAnswers(int correctAnswers) =>
      call(correctAnswers: correctAnswers);

  @override
  DriverQuizResult scorePercentage(num scorePercentage) =>
      call(scorePercentage: scorePercentage);

  @override
  DriverQuizResult passed(bool passed) => call(passed: passed);

  @override
  DriverQuizResult earnedPoints(int earnedPoints) =>
      call(earnedPoints: earnedPoints);

  @override
  DriverQuizResult totalPoints(int totalPoints) =>
      call(totalPoints: totalPoints);

  @override
  DriverQuizResult completedAt(DateTime? completedAt) =>
      call(completedAt: completedAt);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `DriverQuizResult(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// DriverQuizResult(...).copyWith(id: 12, name: "My name")
  /// ```
  DriverQuizResult call({
    Object? attemptId = const $CopyWithPlaceholder(),
    Object? status = const $CopyWithPlaceholder(),
    Object? totalQuestions = const $CopyWithPlaceholder(),
    Object? correctAnswers = const $CopyWithPlaceholder(),
    Object? scorePercentage = const $CopyWithPlaceholder(),
    Object? passed = const $CopyWithPlaceholder(),
    Object? earnedPoints = const $CopyWithPlaceholder(),
    Object? totalPoints = const $CopyWithPlaceholder(),
    Object? completedAt = const $CopyWithPlaceholder(),
  }) {
    return DriverQuizResult(
      attemptId: attemptId == const $CopyWithPlaceholder() || attemptId == null
          ? _value.attemptId
          // ignore: cast_nullable_to_non_nullable
          : attemptId as String,
      status: status == const $CopyWithPlaceholder() || status == null
          ? _value.status
          // ignore: cast_nullable_to_non_nullable
          : status as DriverQuizAnswerStatus,
      totalQuestions:
          totalQuestions == const $CopyWithPlaceholder() ||
              totalQuestions == null
          ? _value.totalQuestions
          // ignore: cast_nullable_to_non_nullable
          : totalQuestions as int,
      correctAnswers:
          correctAnswers == const $CopyWithPlaceholder() ||
              correctAnswers == null
          ? _value.correctAnswers
          // ignore: cast_nullable_to_non_nullable
          : correctAnswers as int,
      scorePercentage:
          scorePercentage == const $CopyWithPlaceholder() ||
              scorePercentage == null
          ? _value.scorePercentage
          // ignore: cast_nullable_to_non_nullable
          : scorePercentage as num,
      passed: passed == const $CopyWithPlaceholder() || passed == null
          ? _value.passed
          // ignore: cast_nullable_to_non_nullable
          : passed as bool,
      earnedPoints:
          earnedPoints == const $CopyWithPlaceholder() || earnedPoints == null
          ? _value.earnedPoints
          // ignore: cast_nullable_to_non_nullable
          : earnedPoints as int,
      totalPoints:
          totalPoints == const $CopyWithPlaceholder() || totalPoints == null
          ? _value.totalPoints
          // ignore: cast_nullable_to_non_nullable
          : totalPoints as int,
      completedAt: completedAt == const $CopyWithPlaceholder()
          ? _value.completedAt
          // ignore: cast_nullable_to_non_nullable
          : completedAt as DateTime?,
    );
  }
}

extension $DriverQuizResultCopyWith on DriverQuizResult {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfDriverQuizResult.copyWith(...)` or `instanceOfDriverQuizResult.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$DriverQuizResultCWProxy get copyWith => _$DriverQuizResultCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DriverQuizResult _$DriverQuizResultFromJson(Map<String, dynamic> json) =>
    $checkedCreate('DriverQuizResult', json, ($checkedConvert) {
      $checkKeys(
        json,
        requiredKeys: const [
          'attemptId',
          'status',
          'totalQuestions',
          'correctAnswers',
          'scorePercentage',
          'passed',
          'earnedPoints',
          'totalPoints',
          'completedAt',
        ],
      );
      final val = DriverQuizResult(
        attemptId: $checkedConvert('attemptId', (v) => v as String),
        status: $checkedConvert(
          'status',
          (v) => $enumDecode(_$DriverQuizAnswerStatusEnumMap, v),
        ),
        totalQuestions: $checkedConvert(
          'totalQuestions',
          (v) => (v as num).toInt(),
        ),
        correctAnswers: $checkedConvert(
          'correctAnswers',
          (v) => (v as num).toInt(),
        ),
        scorePercentage: $checkedConvert('scorePercentage', (v) => v as num),
        passed: $checkedConvert('passed', (v) => v as bool),
        earnedPoints: $checkedConvert(
          'earnedPoints',
          (v) => (v as num).toInt(),
        ),
        totalPoints: $checkedConvert('totalPoints', (v) => (v as num).toInt()),
        completedAt: $checkedConvert(
          'completedAt',
          (v) => v == null ? null : DateTime.parse(v as String),
        ),
      );
      return val;
    });

Map<String, dynamic> _$DriverQuizResultToJson(DriverQuizResult instance) =>
    <String, dynamic>{
      'attemptId': instance.attemptId,
      'status': _$DriverQuizAnswerStatusEnumMap[instance.status]!,
      'totalQuestions': instance.totalQuestions,
      'correctAnswers': instance.correctAnswers,
      'scorePercentage': instance.scorePercentage,
      'passed': instance.passed,
      'earnedPoints': instance.earnedPoints,
      'totalPoints': instance.totalPoints,
      'completedAt': instance.completedAt?.toIso8601String(),
    };

const _$DriverQuizAnswerStatusEnumMap = {
  DriverQuizAnswerStatus.IN_PROGRESS: 'IN_PROGRESS',
  DriverQuizAnswerStatus.COMPLETED: 'COMPLETED',
  DriverQuizAnswerStatus.PASSED: 'PASSED',
  DriverQuizAnswerStatus.FAILED: 'FAILED',
};
