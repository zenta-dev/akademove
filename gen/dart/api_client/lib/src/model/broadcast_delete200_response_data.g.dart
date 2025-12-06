// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'broadcast_delete200_response_data.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$BroadcastDelete200ResponseDataCWProxy {
  BroadcastDelete200ResponseData ok(bool ok);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `BroadcastDelete200ResponseData(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// BroadcastDelete200ResponseData(...).copyWith(id: 12, name: "My name")
  /// ```
  BroadcastDelete200ResponseData call({bool ok});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfBroadcastDelete200ResponseData.copyWith(...)` or call `instanceOfBroadcastDelete200ResponseData.copyWith.fieldName(value)` for a single field.
class _$BroadcastDelete200ResponseDataCWProxyImpl
    implements _$BroadcastDelete200ResponseDataCWProxy {
  const _$BroadcastDelete200ResponseDataCWProxyImpl(this._value);

  final BroadcastDelete200ResponseData _value;

  @override
  BroadcastDelete200ResponseData ok(bool ok) => call(ok: ok);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `BroadcastDelete200ResponseData(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// BroadcastDelete200ResponseData(...).copyWith(id: 12, name: "My name")
  /// ```
  BroadcastDelete200ResponseData call({
    Object? ok = const $CopyWithPlaceholder(),
  }) {
    return BroadcastDelete200ResponseData(
      ok: ok == const $CopyWithPlaceholder() || ok == null
          ? _value.ok
          // ignore: cast_nullable_to_non_nullable
          : ok as bool,
    );
  }
}

extension $BroadcastDelete200ResponseDataCopyWith
    on BroadcastDelete200ResponseData {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfBroadcastDelete200ResponseData.copyWith(...)` or `instanceOfBroadcastDelete200ResponseData.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$BroadcastDelete200ResponseDataCWProxy get copyWith =>
      _$BroadcastDelete200ResponseDataCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BroadcastDelete200ResponseData _$BroadcastDelete200ResponseDataFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('BroadcastDelete200ResponseData', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['ok']);
  final val = BroadcastDelete200ResponseData(
    ok: $checkedConvert('ok', (v) => v as bool),
  );
  return val;
});

Map<String, dynamic> _$BroadcastDelete200ResponseDataToJson(
  BroadcastDelete200ResponseData instance,
) => <String, dynamic>{'ok': instance.ok};
