// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'complete_driver_quiz.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$CompleteDriverQuizCWProxy {
  CompleteDriverQuiz attemptId(String attemptId);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `CompleteDriverQuiz(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// CompleteDriverQuiz(...).copyWith(id: 12, name: "My name")
  /// ```
  CompleteDriverQuiz call({String attemptId});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfCompleteDriverQuiz.copyWith(...)` or call `instanceOfCompleteDriverQuiz.copyWith.fieldName(value)` for a single field.
class _$CompleteDriverQuizCWProxyImpl implements _$CompleteDriverQuizCWProxy {
  const _$CompleteDriverQuizCWProxyImpl(this._value);

  final CompleteDriverQuiz _value;

  @override
  CompleteDriverQuiz attemptId(String attemptId) => call(attemptId: attemptId);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `CompleteDriverQuiz(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// CompleteDriverQuiz(...).copyWith(id: 12, name: "My name")
  /// ```
  CompleteDriverQuiz call({Object? attemptId = const $CopyWithPlaceholder()}) {
    return CompleteDriverQuiz(
      attemptId: attemptId == const $CopyWithPlaceholder() || attemptId == null
          ? _value.attemptId
          // ignore: cast_nullable_to_non_nullable
          : attemptId as String,
    );
  }
}

extension $CompleteDriverQuizCopyWith on CompleteDriverQuiz {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfCompleteDriverQuiz.copyWith(...)` or `instanceOfCompleteDriverQuiz.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$CompleteDriverQuizCWProxy get copyWith =>
      _$CompleteDriverQuizCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CompleteDriverQuiz _$CompleteDriverQuizFromJson(Map<String, dynamic> json) =>
    $checkedCreate('CompleteDriverQuiz', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['attemptId']);
      final val = CompleteDriverQuiz(
        attemptId: $checkedConvert('attemptId', (v) => v as String),
      );
      return val;
    });

Map<String, dynamic> _$CompleteDriverQuizToJson(CompleteDriverQuiz instance) =>
    <String, dynamic>{'attemptId': instance.attemptId};
