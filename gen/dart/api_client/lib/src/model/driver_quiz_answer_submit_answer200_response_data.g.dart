// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'driver_quiz_answer_submit_answer200_response_data.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$DriverQuizAnswerSubmitAnswer200ResponseDataCWProxy {
  DriverQuizAnswerSubmitAnswer200ResponseData isCorrect(bool isCorrect);

  DriverQuizAnswerSubmitAnswer200ResponseData pointsEarned(num pointsEarned);

  DriverQuizAnswerSubmitAnswer200ResponseData correctOptionId(
    String? correctOptionId,
  );

  DriverQuizAnswerSubmitAnswer200ResponseData explanation(String? explanation);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `DriverQuizAnswerSubmitAnswer200ResponseData(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// DriverQuizAnswerSubmitAnswer200ResponseData(...).copyWith(id: 12, name: "My name")
  /// ```
  DriverQuizAnswerSubmitAnswer200ResponseData call({
    bool isCorrect,
    num pointsEarned,
    String? correctOptionId,
    String? explanation,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfDriverQuizAnswerSubmitAnswer200ResponseData.copyWith(...)` or call `instanceOfDriverQuizAnswerSubmitAnswer200ResponseData.copyWith.fieldName(value)` for a single field.
class _$DriverQuizAnswerSubmitAnswer200ResponseDataCWProxyImpl
    implements _$DriverQuizAnswerSubmitAnswer200ResponseDataCWProxy {
  const _$DriverQuizAnswerSubmitAnswer200ResponseDataCWProxyImpl(this._value);

  final DriverQuizAnswerSubmitAnswer200ResponseData _value;

  @override
  DriverQuizAnswerSubmitAnswer200ResponseData isCorrect(bool isCorrect) =>
      call(isCorrect: isCorrect);

  @override
  DriverQuizAnswerSubmitAnswer200ResponseData pointsEarned(num pointsEarned) =>
      call(pointsEarned: pointsEarned);

  @override
  DriverQuizAnswerSubmitAnswer200ResponseData correctOptionId(
    String? correctOptionId,
  ) => call(correctOptionId: correctOptionId);

  @override
  DriverQuizAnswerSubmitAnswer200ResponseData explanation(
    String? explanation,
  ) => call(explanation: explanation);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `DriverQuizAnswerSubmitAnswer200ResponseData(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// DriverQuizAnswerSubmitAnswer200ResponseData(...).copyWith(id: 12, name: "My name")
  /// ```
  DriverQuizAnswerSubmitAnswer200ResponseData call({
    Object? isCorrect = const $CopyWithPlaceholder(),
    Object? pointsEarned = const $CopyWithPlaceholder(),
    Object? correctOptionId = const $CopyWithPlaceholder(),
    Object? explanation = const $CopyWithPlaceholder(),
  }) {
    return DriverQuizAnswerSubmitAnswer200ResponseData(
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

extension $DriverQuizAnswerSubmitAnswer200ResponseDataCopyWith
    on DriverQuizAnswerSubmitAnswer200ResponseData {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfDriverQuizAnswerSubmitAnswer200ResponseData.copyWith(...)` or `instanceOfDriverQuizAnswerSubmitAnswer200ResponseData.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$DriverQuizAnswerSubmitAnswer200ResponseDataCWProxy get copyWith =>
      _$DriverQuizAnswerSubmitAnswer200ResponseDataCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DriverQuizAnswerSubmitAnswer200ResponseData
_$DriverQuizAnswerSubmitAnswer200ResponseDataFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('DriverQuizAnswerSubmitAnswer200ResponseData', json, (
  $checkedConvert,
) {
  $checkKeys(
    json,
    requiredKeys: const ['isCorrect', 'pointsEarned', 'explanation'],
  );
  final val = DriverQuizAnswerSubmitAnswer200ResponseData(
    isCorrect: $checkedConvert('isCorrect', (v) => v as bool),
    pointsEarned: $checkedConvert('pointsEarned', (v) => v as num),
    correctOptionId: $checkedConvert('correctOptionId', (v) => v as String?),
    explanation: $checkedConvert('explanation', (v) => v as String?),
  );
  return val;
});

Map<String, dynamic> _$DriverQuizAnswerSubmitAnswer200ResponseDataToJson(
  DriverQuizAnswerSubmitAnswer200ResponseData instance,
) => <String, dynamic>{
  'isCorrect': instance.isCorrect,
  'pointsEarned': instance.pointsEarned,
  'correctOptionId': ?instance.correctOptionId,
  'explanation': instance.explanation,
};
