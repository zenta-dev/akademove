// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'submit_driver_quiz_answer_response.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$SubmitDriverQuizAnswerResponseCWProxy {
  SubmitDriverQuizAnswerResponse isCorrect(bool isCorrect);

  SubmitDriverQuizAnswerResponse pointsEarned(num pointsEarned);

  SubmitDriverQuizAnswerResponse correctOptionId(String? correctOptionId);

  SubmitDriverQuizAnswerResponse explanation(String? explanation);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `SubmitDriverQuizAnswerResponse(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// SubmitDriverQuizAnswerResponse(...).copyWith(id: 12, name: "My name")
  /// ```
  SubmitDriverQuizAnswerResponse call({
    bool isCorrect,
    num pointsEarned,
    String? correctOptionId,
    String? explanation,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfSubmitDriverQuizAnswerResponse.copyWith(...)` or call `instanceOfSubmitDriverQuizAnswerResponse.copyWith.fieldName(value)` for a single field.
class _$SubmitDriverQuizAnswerResponseCWProxyImpl
    implements _$SubmitDriverQuizAnswerResponseCWProxy {
  const _$SubmitDriverQuizAnswerResponseCWProxyImpl(this._value);

  final SubmitDriverQuizAnswerResponse _value;

  @override
  SubmitDriverQuizAnswerResponse isCorrect(bool isCorrect) =>
      call(isCorrect: isCorrect);

  @override
  SubmitDriverQuizAnswerResponse pointsEarned(num pointsEarned) =>
      call(pointsEarned: pointsEarned);

  @override
  SubmitDriverQuizAnswerResponse correctOptionId(String? correctOptionId) =>
      call(correctOptionId: correctOptionId);

  @override
  SubmitDriverQuizAnswerResponse explanation(String? explanation) =>
      call(explanation: explanation);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `SubmitDriverQuizAnswerResponse(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// SubmitDriverQuizAnswerResponse(...).copyWith(id: 12, name: "My name")
  /// ```
  SubmitDriverQuizAnswerResponse call({
    Object? isCorrect = const $CopyWithPlaceholder(),
    Object? pointsEarned = const $CopyWithPlaceholder(),
    Object? correctOptionId = const $CopyWithPlaceholder(),
    Object? explanation = const $CopyWithPlaceholder(),
  }) {
    return SubmitDriverQuizAnswerResponse(
      isCorrect: isCorrect == const $CopyWithPlaceholder() || isCorrect == null
          ? _value.isCorrect
          // ignore: cast_nullable_to_non_nullable
          : isCorrect as bool,
      pointsEarned:
          pointsEarned == const $CopyWithPlaceholder() || pointsEarned == null
          ? _value.pointsEarned
          // ignore: cast_nullable_to_non_nullable
          : pointsEarned as num,
      correctOptionId: correctOptionId == const $CopyWithPlaceholder()
          ? _value.correctOptionId
          // ignore: cast_nullable_to_non_nullable
          : correctOptionId as String?,
      explanation: explanation == const $CopyWithPlaceholder()
          ? _value.explanation
          // ignore: cast_nullable_to_non_nullable
          : explanation as String?,
    );
  }
}

extension $SubmitDriverQuizAnswerResponseCopyWith
    on SubmitDriverQuizAnswerResponse {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfSubmitDriverQuizAnswerResponse.copyWith(...)` or `instanceOfSubmitDriverQuizAnswerResponse.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$SubmitDriverQuizAnswerResponseCWProxy get copyWith =>
      _$SubmitDriverQuizAnswerResponseCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubmitDriverQuizAnswerResponse _$SubmitDriverQuizAnswerResponseFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('SubmitDriverQuizAnswerResponse', json, ($checkedConvert) {
  $checkKeys(
    json,
    requiredKeys: const ['isCorrect', 'pointsEarned', 'explanation'],
  );
  final val = SubmitDriverQuizAnswerResponse(
    isCorrect: $checkedConvert('isCorrect', (v) => v as bool),
    pointsEarned: $checkedConvert('pointsEarned', (v) => v as num),
    correctOptionId: $checkedConvert('correctOptionId', (v) => v as String?),
    explanation: $checkedConvert('explanation', (v) => v as String?),
  );
  return val;
});

Map<String, dynamic> _$SubmitDriverQuizAnswerResponseToJson(
  SubmitDriverQuizAnswerResponse instance,
) => <String, dynamic>{
  'isCorrect': instance.isCorrect,
  'pointsEarned': instance.pointsEarned,
  'correctOptionId': ?instance.correctOptionId,
  'explanation': instance.explanation,
};
