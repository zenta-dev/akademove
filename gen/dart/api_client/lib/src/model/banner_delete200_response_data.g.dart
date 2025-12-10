// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'banner_delete200_response_data.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$BannerDelete200ResponseDataCWProxy {
  BannerDelete200ResponseData ok(bool ok);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `BannerDelete200ResponseData(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// BannerDelete200ResponseData(...).copyWith(id: 12, name: "My name")
  /// ```
  BannerDelete200ResponseData call({bool ok});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfBannerDelete200ResponseData.copyWith(...)` or call `instanceOfBannerDelete200ResponseData.copyWith.fieldName(value)` for a single field.
class _$BannerDelete200ResponseDataCWProxyImpl
    implements _$BannerDelete200ResponseDataCWProxy {
  const _$BannerDelete200ResponseDataCWProxyImpl(this._value);

  final BannerDelete200ResponseData _value;

  @override
  BannerDelete200ResponseData ok(bool ok) => call(ok: ok);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `BannerDelete200ResponseData(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// BannerDelete200ResponseData(...).copyWith(id: 12, name: "My name")
  /// ```
  BannerDelete200ResponseData call({
    Object? ok = const $CopyWithPlaceholder(),
  }) {
    return BannerDelete200ResponseData(
      ok: ok == const $CopyWithPlaceholder() || ok == null
          ? _value.ok
          // ignore: cast_nullable_to_non_nullable
          : ok as bool,
    );
  }
}

extension $BannerDelete200ResponseDataCopyWith on BannerDelete200ResponseData {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfBannerDelete200ResponseData.copyWith(...)` or `instanceOfBannerDelete200ResponseData.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$BannerDelete200ResponseDataCWProxy get copyWith =>
      _$BannerDelete200ResponseDataCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BannerDelete200ResponseData _$BannerDelete200ResponseDataFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('BannerDelete200ResponseData', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['ok']);
  final val = BannerDelete200ResponseData(
    ok: $checkedConvert('ok', (v) => v as bool),
  );
  return val;
});

Map<String, dynamic> _$BannerDelete200ResponseDataToJson(
  BannerDelete200ResponseData instance,
) => <String, dynamic>{'ok': instance.ok};
