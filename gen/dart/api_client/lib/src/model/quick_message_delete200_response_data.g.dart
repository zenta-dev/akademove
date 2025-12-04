// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quick_message_delete200_response_data.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$QuickMessageDelete200ResponseDataCWProxy {
  QuickMessageDelete200ResponseData success(bool success);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `QuickMessageDelete200ResponseData(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// QuickMessageDelete200ResponseData(...).copyWith(id: 12, name: "My name")
  /// ```
  QuickMessageDelete200ResponseData call({bool success});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfQuickMessageDelete200ResponseData.copyWith(...)` or call `instanceOfQuickMessageDelete200ResponseData.copyWith.fieldName(value)` for a single field.
class _$QuickMessageDelete200ResponseDataCWProxyImpl
    implements _$QuickMessageDelete200ResponseDataCWProxy {
  const _$QuickMessageDelete200ResponseDataCWProxyImpl(this._value);

  final QuickMessageDelete200ResponseData _value;

  @override
  QuickMessageDelete200ResponseData success(bool success) =>
      call(success: success);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `QuickMessageDelete200ResponseData(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// QuickMessageDelete200ResponseData(...).copyWith(id: 12, name: "My name")
  /// ```
  QuickMessageDelete200ResponseData call({
    Object? success = const $CopyWithPlaceholder(),
  }) {
    return QuickMessageDelete200ResponseData(
      success: success == const $CopyWithPlaceholder() || success == null
          ? _value.success
          // ignore: cast_nullable_to_non_nullable
          : success as bool,
    );
  }
}

extension $QuickMessageDelete200ResponseDataCopyWith
    on QuickMessageDelete200ResponseData {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfQuickMessageDelete200ResponseData.copyWith(...)` or `instanceOfQuickMessageDelete200ResponseData.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$QuickMessageDelete200ResponseDataCWProxy get copyWith =>
      _$QuickMessageDelete200ResponseDataCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuickMessageDelete200ResponseData _$QuickMessageDelete200ResponseDataFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('QuickMessageDelete200ResponseData', json, (
  $checkedConvert,
) {
  $checkKeys(json, requiredKeys: const ['success']);
  final val = QuickMessageDelete200ResponseData(
    success: $checkedConvert('success', (v) => v as bool),
  );
  return val;
});

Map<String, dynamic> _$QuickMessageDelete200ResponseDataToJson(
  QuickMessageDelete200ResponseData instance,
) => <String, dynamic>{'success': instance.success};
