// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'driver_min_quiz_question_options_inner.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$DriverMinQuizQuestionOptionsInnerCWProxy {
  DriverMinQuizQuestionOptionsInner id(String id);

  DriverMinQuizQuestionOptionsInner text(String text);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `DriverMinQuizQuestionOptionsInner(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// DriverMinQuizQuestionOptionsInner(...).copyWith(id: 12, name: "My name")
  /// ```
  DriverMinQuizQuestionOptionsInner call({String id, String text});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfDriverMinQuizQuestionOptionsInner.copyWith(...)` or call `instanceOfDriverMinQuizQuestionOptionsInner.copyWith.fieldName(value)` for a single field.
class _$DriverMinQuizQuestionOptionsInnerCWProxyImpl
    implements _$DriverMinQuizQuestionOptionsInnerCWProxy {
  const _$DriverMinQuizQuestionOptionsInnerCWProxyImpl(this._value);

  final DriverMinQuizQuestionOptionsInner _value;

  @override
  DriverMinQuizQuestionOptionsInner id(String id) => call(id: id);

  @override
  DriverMinQuizQuestionOptionsInner text(String text) => call(text: text);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `DriverMinQuizQuestionOptionsInner(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// DriverMinQuizQuestionOptionsInner(...).copyWith(id: 12, name: "My name")
  /// ```
  DriverMinQuizQuestionOptionsInner call({
    Object? id = const $CopyWithPlaceholder(),
    Object? text = const $CopyWithPlaceholder(),
  }) {
    return DriverMinQuizQuestionOptionsInner(
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

extension $DriverMinQuizQuestionOptionsInnerCopyWith
    on DriverMinQuizQuestionOptionsInner {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfDriverMinQuizQuestionOptionsInner.copyWith(...)` or `instanceOfDriverMinQuizQuestionOptionsInner.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$DriverMinQuizQuestionOptionsInnerCWProxy get copyWith =>
      _$DriverMinQuizQuestionOptionsInnerCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DriverMinQuizQuestionOptionsInner _$DriverMinQuizQuestionOptionsInnerFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('DriverMinQuizQuestionOptionsInner', json, (
  $checkedConvert,
) {
  $checkKeys(json, requiredKeys: const ['id', 'text']);
  final val = DriverMinQuizQuestionOptionsInner(
    id: $checkedConvert('id', (v) => v as String),
    text: $checkedConvert('text', (v) => v as String),
  );
  return val;
});

Map<String, dynamic> _$DriverMinQuizQuestionOptionsInnerToJson(
  DriverMinQuizQuestionOptionsInner instance,
) => <String, dynamic>{'id': instance.id, 'text': instance.text};
