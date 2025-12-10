// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'driver_quiz_question_get_quiz_questions200_response_data_inner_options_inner.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$DriverQuizQuestionGetQuizQuestions200ResponseDataInnerOptionsInnerCWProxy {
  DriverQuizQuestionGetQuizQuestions200ResponseDataInnerOptionsInner id(
    String id,
  );

  DriverQuizQuestionGetQuizQuestions200ResponseDataInnerOptionsInner text(
    String text,
  );

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `DriverQuizQuestionGetQuizQuestions200ResponseDataInnerOptionsInner(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// DriverQuizQuestionGetQuizQuestions200ResponseDataInnerOptionsInner(...).copyWith(id: 12, name: "My name")
  /// ```
  DriverQuizQuestionGetQuizQuestions200ResponseDataInnerOptionsInner call({
    String id,
    String text,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfDriverQuizQuestionGetQuizQuestions200ResponseDataInnerOptionsInner.copyWith(...)` or call `instanceOfDriverQuizQuestionGetQuizQuestions200ResponseDataInnerOptionsInner.copyWith.fieldName(value)` for a single field.
class _$DriverQuizQuestionGetQuizQuestions200ResponseDataInnerOptionsInnerCWProxyImpl
    implements
        _$DriverQuizQuestionGetQuizQuestions200ResponseDataInnerOptionsInnerCWProxy {
  const _$DriverQuizQuestionGetQuizQuestions200ResponseDataInnerOptionsInnerCWProxyImpl(
    this._value,
  );

  final DriverQuizQuestionGetQuizQuestions200ResponseDataInnerOptionsInner
  _value;

  @override
  DriverQuizQuestionGetQuizQuestions200ResponseDataInnerOptionsInner id(
    String id,
  ) => call(id: id);

  @override
  DriverQuizQuestionGetQuizQuestions200ResponseDataInnerOptionsInner text(
    String text,
  ) => call(text: text);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `DriverQuizQuestionGetQuizQuestions200ResponseDataInnerOptionsInner(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// DriverQuizQuestionGetQuizQuestions200ResponseDataInnerOptionsInner(...).copyWith(id: 12, name: "My name")
  /// ```
  DriverQuizQuestionGetQuizQuestions200ResponseDataInnerOptionsInner call({
    Object? id = const $CopyWithPlaceholder(),
    Object? text = const $CopyWithPlaceholder(),
  }) {
    return DriverQuizQuestionGetQuizQuestions200ResponseDataInnerOptionsInner(
      id: id == const $CopyWithPlaceholder() || id == null
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
      text: text == const $CopyWithPlaceholder() || text == null
          ? _value.text
          // ignore: cast_nullable_to_non_nullable
          : text as String,
    );
  }
}

extension $DriverQuizQuestionGetQuizQuestions200ResponseDataInnerOptionsInnerCopyWith
    on DriverQuizQuestionGetQuizQuestions200ResponseDataInnerOptionsInner {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfDriverQuizQuestionGetQuizQuestions200ResponseDataInnerOptionsInner.copyWith(...)` or `instanceOfDriverQuizQuestionGetQuizQuestions200ResponseDataInnerOptionsInner.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$DriverQuizQuestionGetQuizQuestions200ResponseDataInnerOptionsInnerCWProxy
  get copyWith =>
      _$DriverQuizQuestionGetQuizQuestions200ResponseDataInnerOptionsInnerCWProxyImpl(
        this,
      );
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DriverQuizQuestionGetQuizQuestions200ResponseDataInnerOptionsInner
_$DriverQuizQuestionGetQuizQuestions200ResponseDataInnerOptionsInnerFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  'DriverQuizQuestionGetQuizQuestions200ResponseDataInnerOptionsInner',
  json,
  ($checkedConvert) {
    $checkKeys(json, requiredKeys: const ['id', 'text']);
    final val =
        DriverQuizQuestionGetQuizQuestions200ResponseDataInnerOptionsInner(
          id: $checkedConvert('id', (v) => v as String),
          text: $checkedConvert('text', (v) => v as String),
        );
    return val;
  },
);

Map<String, dynamic>
_$DriverQuizQuestionGetQuizQuestions200ResponseDataInnerOptionsInnerToJson(
  DriverQuizQuestionGetQuizQuestions200ResponseDataInnerOptionsInner instance,
) => <String, dynamic>{'id': instance.id, 'text': instance.text};
