// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'support_chat_mark_as_read200_response_data.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$SupportChatMarkAsRead200ResponseDataCWProxy {
  SupportChatMarkAsRead200ResponseData count(num count);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `SupportChatMarkAsRead200ResponseData(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// SupportChatMarkAsRead200ResponseData(...).copyWith(id: 12, name: "My name")
  /// ```
  SupportChatMarkAsRead200ResponseData call({num count});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfSupportChatMarkAsRead200ResponseData.copyWith(...)` or call `instanceOfSupportChatMarkAsRead200ResponseData.copyWith.fieldName(value)` for a single field.
class _$SupportChatMarkAsRead200ResponseDataCWProxyImpl
    implements _$SupportChatMarkAsRead200ResponseDataCWProxy {
  const _$SupportChatMarkAsRead200ResponseDataCWProxyImpl(this._value);

  final SupportChatMarkAsRead200ResponseData _value;

  @override
  SupportChatMarkAsRead200ResponseData count(num count) => call(count: count);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `SupportChatMarkAsRead200ResponseData(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// SupportChatMarkAsRead200ResponseData(...).copyWith(id: 12, name: "My name")
  /// ```
  SupportChatMarkAsRead200ResponseData call({
    Object? count = const $CopyWithPlaceholder(),
  }) {
    return SupportChatMarkAsRead200ResponseData(
      count: count == const $CopyWithPlaceholder() || count == null
          ? _value.count
          // ignore: cast_nullable_to_non_nullable
          : count as num,
    );
  }
}

extension $SupportChatMarkAsRead200ResponseDataCopyWith
    on SupportChatMarkAsRead200ResponseData {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfSupportChatMarkAsRead200ResponseData.copyWith(...)` or `instanceOfSupportChatMarkAsRead200ResponseData.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$SupportChatMarkAsRead200ResponseDataCWProxy get copyWith =>
      _$SupportChatMarkAsRead200ResponseDataCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SupportChatMarkAsRead200ResponseData
_$SupportChatMarkAsRead200ResponseDataFromJson(Map<String, dynamic> json) =>
    $checkedCreate('SupportChatMarkAsRead200ResponseData', json, (
      $checkedConvert,
    ) {
      $checkKeys(json, requiredKeys: const ['count']);
      final val = SupportChatMarkAsRead200ResponseData(
        count: $checkedConvert('count', (v) => v as num),
      );
      return val;
    });

Map<String, dynamic> _$SupportChatMarkAsRead200ResponseDataToJson(
  SupportChatMarkAsRead200ResponseData instance,
) => <String, dynamic>{'count': instance.count};
