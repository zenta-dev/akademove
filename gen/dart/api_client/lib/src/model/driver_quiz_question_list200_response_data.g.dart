// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'driver_quiz_question_list200_response_data.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$DriverQuizQuestionList200ResponseDataCWProxy {
  DriverQuizQuestionList200ResponseData rows(List<DriverQuizQuestion> rows);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `DriverQuizQuestionList200ResponseData(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// DriverQuizQuestionList200ResponseData(...).copyWith(id: 12, name: "My name")
  /// ```
  DriverQuizQuestionList200ResponseData call({List<DriverQuizQuestion> rows});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfDriverQuizQuestionList200ResponseData.copyWith(...)` or call `instanceOfDriverQuizQuestionList200ResponseData.copyWith.fieldName(value)` for a single field.
class _$DriverQuizQuestionList200ResponseDataCWProxyImpl
    implements _$DriverQuizQuestionList200ResponseDataCWProxy {
  const _$DriverQuizQuestionList200ResponseDataCWProxyImpl(this._value);

  final DriverQuizQuestionList200ResponseData _value;

  @override
  DriverQuizQuestionList200ResponseData rows(List<DriverQuizQuestion> rows) =>
      call(rows: rows);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `DriverQuizQuestionList200ResponseData(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// DriverQuizQuestionList200ResponseData(...).copyWith(id: 12, name: "My name")
  /// ```
  DriverQuizQuestionList200ResponseData call({
    Object? rows = const $CopyWithPlaceholder(),
  }) {
    return DriverQuizQuestionList200ResponseData(
      rows: rows == const $CopyWithPlaceholder() || rows == null
          ? _value.rows
          // ignore: cast_nullable_to_non_nullable
          : rows as List<DriverQuizQuestion>,
    );
  }
}

extension $DriverQuizQuestionList200ResponseDataCopyWith
    on DriverQuizQuestionList200ResponseData {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfDriverQuizQuestionList200ResponseData.copyWith(...)` or `instanceOfDriverQuizQuestionList200ResponseData.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$DriverQuizQuestionList200ResponseDataCWProxy get copyWith =>
      _$DriverQuizQuestionList200ResponseDataCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DriverQuizQuestionList200ResponseData
_$DriverQuizQuestionList200ResponseDataFromJson(Map<String, dynamic> json) =>
    $checkedCreate('DriverQuizQuestionList200ResponseData', json, (
      $checkedConvert,
    ) {
      $checkKeys(json, requiredKeys: const ['rows']);
      final val = DriverQuizQuestionList200ResponseData(
        rows: $checkedConvert(
          'rows',
          (v) => (v as List<dynamic>)
              .map(
                (e) => DriverQuizQuestion.fromJson(e as Map<String, dynamic>),
              )
              .toList(),
        ),
      );
      return val;
    });

Map<String, dynamic> _$DriverQuizQuestionList200ResponseDataToJson(
  DriverQuizQuestionList200ResponseData instance,
) => <String, dynamic>{'rows': instance.rows.map((e) => e.toJson()).toList()};
