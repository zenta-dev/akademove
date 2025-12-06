// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'broadcast_stats200_response_data.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$BroadcastStats200ResponseDataCWProxy {
  BroadcastStats200ResponseData total(int total);

  BroadcastStats200ResponseData pending(int pending);

  BroadcastStats200ResponseData sending(int sending);

  BroadcastStats200ResponseData sent(int sent);

  BroadcastStats200ResponseData failed(int failed);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `BroadcastStats200ResponseData(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// BroadcastStats200ResponseData(...).copyWith(id: 12, name: "My name")
  /// ```
  BroadcastStats200ResponseData call({
    int total,
    int pending,
    int sending,
    int sent,
    int failed,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfBroadcastStats200ResponseData.copyWith(...)` or call `instanceOfBroadcastStats200ResponseData.copyWith.fieldName(value)` for a single field.
class _$BroadcastStats200ResponseDataCWProxyImpl
    implements _$BroadcastStats200ResponseDataCWProxy {
  const _$BroadcastStats200ResponseDataCWProxyImpl(this._value);

  final BroadcastStats200ResponseData _value;

  @override
  BroadcastStats200ResponseData total(int total) => call(total: total);

  @override
  BroadcastStats200ResponseData pending(int pending) => call(pending: pending);

  @override
  BroadcastStats200ResponseData sending(int sending) => call(sending: sending);

  @override
  BroadcastStats200ResponseData sent(int sent) => call(sent: sent);

  @override
  BroadcastStats200ResponseData failed(int failed) => call(failed: failed);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `BroadcastStats200ResponseData(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// BroadcastStats200ResponseData(...).copyWith(id: 12, name: "My name")
  /// ```
  BroadcastStats200ResponseData call({
    Object? total = const $CopyWithPlaceholder(),
    Object? pending = const $CopyWithPlaceholder(),
    Object? sending = const $CopyWithPlaceholder(),
    Object? sent = const $CopyWithPlaceholder(),
    Object? failed = const $CopyWithPlaceholder(),
  }) {
    return BroadcastStats200ResponseData(
      total: total == const $CopyWithPlaceholder() || total == null
          ? _value.total
          // ignore: cast_nullable_to_non_nullable
          : total as int,
      pending: pending == const $CopyWithPlaceholder() || pending == null
          ? _value.pending
          // ignore: cast_nullable_to_non_nullable
          : pending as int,
      sending: sending == const $CopyWithPlaceholder() || sending == null
          ? _value.sending
          // ignore: cast_nullable_to_non_nullable
          : sending as int,
      sent: sent == const $CopyWithPlaceholder() || sent == null
          ? _value.sent
          // ignore: cast_nullable_to_non_nullable
          : sent as int,
      failed: failed == const $CopyWithPlaceholder() || failed == null
          ? _value.failed
          // ignore: cast_nullable_to_non_nullable
          : failed as int,
    );
  }
}

extension $BroadcastStats200ResponseDataCopyWith
    on BroadcastStats200ResponseData {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfBroadcastStats200ResponseData.copyWith(...)` or `instanceOfBroadcastStats200ResponseData.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$BroadcastStats200ResponseDataCWProxy get copyWith =>
      _$BroadcastStats200ResponseDataCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BroadcastStats200ResponseData _$BroadcastStats200ResponseDataFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('BroadcastStats200ResponseData', json, ($checkedConvert) {
  $checkKeys(
    json,
    requiredKeys: const ['total', 'pending', 'sending', 'sent', 'failed'],
  );
  final val = BroadcastStats200ResponseData(
    total: $checkedConvert('total', (v) => (v as num).toInt()),
    pending: $checkedConvert('pending', (v) => (v as num).toInt()),
    sending: $checkedConvert('sending', (v) => (v as num).toInt()),
    sent: $checkedConvert('sent', (v) => (v as num).toInt()),
    failed: $checkedConvert('failed', (v) => (v as num).toInt()),
  );
  return val;
});

Map<String, dynamic> _$BroadcastStats200ResponseDataToJson(
  BroadcastStats200ResponseData instance,
) => <String, dynamic>{
  'total': instance.total,
  'pending': instance.pending,
  'sending': instance.sending,
  'sent': instance.sent,
  'failed': instance.failed,
};
