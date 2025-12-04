// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quick_message_list200_response_data.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$QuickMessageList200ResponseDataCWProxy {
  QuickMessageList200ResponseData rows(List<QuickMessageTemplate> rows);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `QuickMessageList200ResponseData(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// QuickMessageList200ResponseData(...).copyWith(id: 12, name: "My name")
  /// ```
  QuickMessageList200ResponseData call({List<QuickMessageTemplate> rows});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfQuickMessageList200ResponseData.copyWith(...)` or call `instanceOfQuickMessageList200ResponseData.copyWith.fieldName(value)` for a single field.
class _$QuickMessageList200ResponseDataCWProxyImpl
    implements _$QuickMessageList200ResponseDataCWProxy {
  const _$QuickMessageList200ResponseDataCWProxyImpl(this._value);

  final QuickMessageList200ResponseData _value;

  @override
  QuickMessageList200ResponseData rows(List<QuickMessageTemplate> rows) =>
      call(rows: rows);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `QuickMessageList200ResponseData(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// QuickMessageList200ResponseData(...).copyWith(id: 12, name: "My name")
  /// ```
  QuickMessageList200ResponseData call({
    Object? rows = const $CopyWithPlaceholder(),
  }) {
    return QuickMessageList200ResponseData(
      rows: rows == const $CopyWithPlaceholder() || rows == null
          ? _value.rows
          // ignore: cast_nullable_to_non_nullable
          : rows as List<QuickMessageTemplate>,
    );
  }
}

extension $QuickMessageList200ResponseDataCopyWith
    on QuickMessageList200ResponseData {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfQuickMessageList200ResponseData.copyWith(...)` or `instanceOfQuickMessageList200ResponseData.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$QuickMessageList200ResponseDataCWProxy get copyWith =>
      _$QuickMessageList200ResponseDataCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuickMessageList200ResponseData _$QuickMessageList200ResponseDataFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('QuickMessageList200ResponseData', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['rows']);
  final val = QuickMessageList200ResponseData(
    rows: $checkedConvert(
      'rows',
      (v) => (v as List<dynamic>)
          .map((e) => QuickMessageTemplate.fromJson(e as Map<String, dynamic>))
          .toList(),
    ),
  );
  return val;
});

Map<String, dynamic> _$QuickMessageList200ResponseDataToJson(
  QuickMessageList200ResponseData instance,
) => <String, dynamic>{'rows': instance.rows.map((e) => e.toJson()).toList()};
