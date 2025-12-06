// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'driver_quiz_answer_list200_response_data.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$DriverQuizAnswerList200ResponseDataCWProxy {
  DriverQuizAnswerList200ResponseData rows(List<DriverQuizAnswer> rows);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `DriverQuizAnswerList200ResponseData(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// DriverQuizAnswerList200ResponseData(...).copyWith(id: 12, name: "My name")
  /// ```
  DriverQuizAnswerList200ResponseData call({List<DriverQuizAnswer> rows});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfDriverQuizAnswerList200ResponseData.copyWith(...)` or call `instanceOfDriverQuizAnswerList200ResponseData.copyWith.fieldName(value)` for a single field.
class _$DriverQuizAnswerList200ResponseDataCWProxyImpl
    implements _$DriverQuizAnswerList200ResponseDataCWProxy {
  const _$DriverQuizAnswerList200ResponseDataCWProxyImpl(this._value);

  final DriverQuizAnswerList200ResponseData _value;

  @override
  DriverQuizAnswerList200ResponseData rows(List<DriverQuizAnswer> rows) =>
      call(rows: rows);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `DriverQuizAnswerList200ResponseData(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// DriverQuizAnswerList200ResponseData(...).copyWith(id: 12, name: "My name")
  /// ```
  DriverQuizAnswerList200ResponseData call({
    Object? rows = const $CopyWithPlaceholder(),
  }) {
    return DriverQuizAnswerList200ResponseData(
      rows: rows == const $CopyWithPlaceholder() || rows == null
          ? _value.rows
          // ignore: cast_nullable_to_non_nullable
          : rows as List<DriverQuizAnswer>,
    );
  }
}

extension $DriverQuizAnswerList200ResponseDataCopyWith
    on DriverQuizAnswerList200ResponseData {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfDriverQuizAnswerList200ResponseData.copyWith(...)` or `instanceOfDriverQuizAnswerList200ResponseData.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$DriverQuizAnswerList200ResponseDataCWProxy get copyWith =>
      _$DriverQuizAnswerList200ResponseDataCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DriverQuizAnswerList200ResponseData
_$DriverQuizAnswerList200ResponseDataFromJson(Map<String, dynamic> json) =>
    $checkedCreate('DriverQuizAnswerList200ResponseData', json, (
      $checkedConvert,
    ) {
      $checkKeys(json, requiredKeys: const ['rows']);
      final val = DriverQuizAnswerList200ResponseData(
        rows: $checkedConvert(
          'rows',
          (v) => (v as List<dynamic>)
              .map((e) => DriverQuizAnswer.fromJson(e as Map<String, dynamic>))
              .toList(),
        ),
      );
      return val;
    });

Map<String, dynamic> _$DriverQuizAnswerList200ResponseDataToJson(
  DriverQuizAnswerList200ResponseData instance,
) => <String, dynamic>{'rows': instance.rows.map((e) => e.toJson()).toList()};
