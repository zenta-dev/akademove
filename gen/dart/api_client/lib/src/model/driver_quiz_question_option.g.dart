// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'driver_quiz_question_option.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$DriverQuizQuestionOptionCWProxy {
  DriverQuizQuestionOption id(String id);

  DriverQuizQuestionOption text(String text);

  DriverQuizQuestionOption isCorrect(bool isCorrect);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `DriverQuizQuestionOption(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// DriverQuizQuestionOption(...).copyWith(id: 12, name: "My name")
  /// ```
  DriverQuizQuestionOption call({String id, String text, bool isCorrect});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfDriverQuizQuestionOption.copyWith(...)` or call `instanceOfDriverQuizQuestionOption.copyWith.fieldName(value)` for a single field.
class _$DriverQuizQuestionOptionCWProxyImpl
    implements _$DriverQuizQuestionOptionCWProxy {
  const _$DriverQuizQuestionOptionCWProxyImpl(this._value);

  final DriverQuizQuestionOption _value;

  @override
  DriverQuizQuestionOption id(String id) => call(id: id);

  @override
  DriverQuizQuestionOption text(String text) => call(text: text);

  @override
  DriverQuizQuestionOption isCorrect(bool isCorrect) =>
      call(isCorrect: isCorrect);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `DriverQuizQuestionOption(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// DriverQuizQuestionOption(...).copyWith(id: 12, name: "My name")
  /// ```
  DriverQuizQuestionOption call({
    Object? id = const $CopyWithPlaceholder(),
    Object? text = const $CopyWithPlaceholder(),
    Object? isCorrect = const $CopyWithPlaceholder(),
  }) {
    return DriverQuizQuestionOption(
      id: id == const $CopyWithPlaceholder() || id == null
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
      text: text == const $CopyWithPlaceholder() || text == null
          ? _value.text
          // ignore: cast_nullable_to_non_nullable
          : text as String,
      isCorrect: isCorrect == const $CopyWithPlaceholder() || isCorrect == null
          ? _value.isCorrect
          // ignore: cast_nullable_to_non_nullable
          : isCorrect as bool,
    );
  }
}

extension $DriverQuizQuestionOptionCopyWith on DriverQuizQuestionOption {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfDriverQuizQuestionOption.copyWith(...)` or `instanceOfDriverQuizQuestionOption.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$DriverQuizQuestionOptionCWProxy get copyWith =>
      _$DriverQuizQuestionOptionCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DriverQuizQuestionOption _$DriverQuizQuestionOptionFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('DriverQuizQuestionOption', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['id', 'text', 'isCorrect']);
  final val = DriverQuizQuestionOption(
    id: $checkedConvert('id', (v) => v as String),
    text: $checkedConvert('text', (v) => v as String),
    isCorrect: $checkedConvert('isCorrect', (v) => v as bool),
  );
  return val;
});

Map<String, dynamic> _$DriverQuizQuestionOptionToJson(
  DriverQuizQuestionOption instance,
) => <String, dynamic>{
  'id': instance.id,
  'text': instance.text,
  'isCorrect': instance.isCorrect,
};
