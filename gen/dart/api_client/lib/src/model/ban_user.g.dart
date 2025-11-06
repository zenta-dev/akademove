// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ban_user.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$BanUserCWProxy {
  BanUser banReason(String banReason);

  BanUser banExpiresIn(num? banExpiresIn);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `BanUser(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// BanUser(...).copyWith(id: 12, name: "My name")
  /// ````
  BanUser call({String banReason, num? banExpiresIn});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfBanUser.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfBanUser.copyWith.fieldName(...)`
class _$BanUserCWProxyImpl implements _$BanUserCWProxy {
  const _$BanUserCWProxyImpl(this._value);

  final BanUser _value;

  @override
  BanUser banReason(String banReason) => this(banReason: banReason);

  @override
  BanUser banExpiresIn(num? banExpiresIn) => this(banExpiresIn: banExpiresIn);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `BanUser(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// BanUser(...).copyWith(id: 12, name: "My name")
  /// ````
  BanUser call({
    Object? banReason = const $CopyWithPlaceholder(),
    Object? banExpiresIn = const $CopyWithPlaceholder(),
  }) {
    return BanUser(
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

extension $BanUserCopyWith on BanUser {
  /// Returns a callable class that can be used as follows: `instanceOfBanUser.copyWith(...)` or like so:`instanceOfBanUser.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$BanUserCWProxy get copyWith => _$BanUserCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BanUser _$BanUserFromJson(Map<String, dynamic> json) =>
    $checkedCreate('BanUser', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['banReason']);
      final val = BanUser(
        banReason: $checkedConvert('banReason', (v) => v as String),
        banExpiresIn: $checkedConvert('banExpiresIn', (v) => v as num?),
      );
      return val;
    });

Map<String, dynamic> _$BanUserToJson(BanUser instance) => <String, dynamic>{
  'banReason': instance.banReason,
  'banExpiresIn': ?instance.banExpiresIn,
};
