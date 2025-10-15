// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ban_user_schema_request.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$BanUserSchemaRequestCWProxy {
  BanUserSchemaRequest banReason(String banReason);

  BanUserSchemaRequest banExpiresIn(num? banExpiresIn);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `BanUserSchemaRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// BanUserSchemaRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  BanUserSchemaRequest call({String banReason, num? banExpiresIn});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfBanUserSchemaRequest.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfBanUserSchemaRequest.copyWith.fieldName(...)`
class _$BanUserSchemaRequestCWProxyImpl
    implements _$BanUserSchemaRequestCWProxy {
  const _$BanUserSchemaRequestCWProxyImpl(this._value);

  final BanUserSchemaRequest _value;

  @override
  BanUserSchemaRequest banReason(String banReason) =>
      this(banReason: banReason);

  @override
  BanUserSchemaRequest banExpiresIn(num? banExpiresIn) =>
      this(banExpiresIn: banExpiresIn);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `BanUserSchemaRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// BanUserSchemaRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  BanUserSchemaRequest call({
    Object? banReason = const $CopyWithPlaceholder(),
    Object? banExpiresIn = const $CopyWithPlaceholder(),
  }) {
    return BanUserSchemaRequest(
      banReason: banReason == const $CopyWithPlaceholder()
          ? _value.banReason
          // ignore: cast_nullable_to_non_nullable
          : banReason as String,
      banExpiresIn: banExpiresIn == const $CopyWithPlaceholder()
          ? _value.banExpiresIn
          // ignore: cast_nullable_to_non_nullable
          : banExpiresIn as num?,
    );
  }
}

extension $BanUserSchemaRequestCopyWith on BanUserSchemaRequest {
  /// Returns a callable class that can be used as follows: `instanceOfBanUserSchemaRequest.copyWith(...)` or like so:`instanceOfBanUserSchemaRequest.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$BanUserSchemaRequestCWProxy get copyWith =>
      _$BanUserSchemaRequestCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BanUserSchemaRequest _$BanUserSchemaRequestFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('BanUserSchemaRequest', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['banReason']);
  final val = BanUserSchemaRequest(
    banReason: $checkedConvert('banReason', (v) => v as String),
    banExpiresIn: $checkedConvert('banExpiresIn', (v) => v as num?),
  );
  return val;
});

Map<String, dynamic> _$BanUserSchemaRequestToJson(
  BanUserSchemaRequest instance,
) => <String, dynamic>{
  'banReason': instance.banReason,
  'banExpiresIn': ?instance.banExpiresIn,
};
