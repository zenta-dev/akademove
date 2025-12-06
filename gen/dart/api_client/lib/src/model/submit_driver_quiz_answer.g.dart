// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'submit_driver_quiz_answer.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$SubmitDriverQuizAnswerCWProxy {
  SubmitDriverQuizAnswer attemptId(String attemptId);

  SubmitDriverQuizAnswer questionId(String questionId);

  SubmitDriverQuizAnswer selectedOptionId(String selectedOptionId);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `SubmitDriverQuizAnswer(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// SubmitDriverQuizAnswer(...).copyWith(id: 12, name: "My name")
  /// ```
  SubmitDriverQuizAnswer call({
    String attemptId,
    String questionId,
    String selectedOptionId,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfSubmitDriverQuizAnswer.copyWith(...)` or call `instanceOfSubmitDriverQuizAnswer.copyWith.fieldName(value)` for a single field.
class _$SubmitDriverQuizAnswerCWProxyImpl
    implements _$SubmitDriverQuizAnswerCWProxy {
  const _$SubmitDriverQuizAnswerCWProxyImpl(this._value);

  final SubmitDriverQuizAnswer _value;

  @override
  SubmitDriverQuizAnswer attemptId(String attemptId) =>
      call(attemptId: attemptId);

  @override
  SubmitDriverQuizAnswer questionId(String questionId) =>
      call(questionId: questionId);

  @override
  SubmitDriverQuizAnswer selectedOptionId(String selectedOptionId) =>
      call(selectedOptionId: selectedOptionId);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `SubmitDriverQuizAnswer(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// SubmitDriverQuizAnswer(...).copyWith(id: 12, name: "My name")
  /// ```
  SubmitDriverQuizAnswer call({
    Object? attemptId = const $CopyWithPlaceholder(),
    Object? questionId = const $CopyWithPlaceholder(),
    Object? selectedOptionId = const $CopyWithPlaceholder(),
  }) {
    return SubmitDriverQuizAnswer(
      attemptId: attemptId == const $CopyWithPlaceholder() || attemptId == null
          ? _value.attemptId
          // ignore: cast_nullable_to_non_nullable
          : attemptId as String,
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
    );
  }
}

extension $SubmitDriverQuizAnswerCopyWith on SubmitDriverQuizAnswer {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfSubmitDriverQuizAnswer.copyWith(...)` or `instanceOfSubmitDriverQuizAnswer.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$SubmitDriverQuizAnswerCWProxy get copyWith =>
      _$SubmitDriverQuizAnswerCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubmitDriverQuizAnswer _$SubmitDriverQuizAnswerFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('SubmitDriverQuizAnswer', json, ($checkedConvert) {
  $checkKeys(
    json,
    requiredKeys: const ['attemptId', 'questionId', 'selectedOptionId'],
  );
  final val = SubmitDriverQuizAnswer(
    attemptId: $checkedConvert('attemptId', (v) => v as String),
    questionId: $checkedConvert('questionId', (v) => v as String),
    selectedOptionId: $checkedConvert('selectedOptionId', (v) => v as String),
  );
  return val;
});

Map<String, dynamic> _$SubmitDriverQuizAnswerToJson(
  SubmitDriverQuizAnswer instance,
) => <String, dynamic>{
  'attemptId': instance.attemptId,
  'questionId': instance.questionId,
  'selectedOptionId': instance.selectedOptionId,
};
