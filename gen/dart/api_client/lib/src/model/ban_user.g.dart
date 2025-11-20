// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ban_user.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$BanUserCWProxy {
  BanUser banReason(String banReason);

  BanUser banExpiresIn(num? banExpiresIn);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `BanUser(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// BanUser(...).copyWith(id: 12, name: "My name")
  /// ```
  BanUser call({String banReason, num? banExpiresIn});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfBanUser.copyWith(...)` or call `instanceOfBanUser.copyWith.fieldName(value)` for a single field.
class _$BanUserCWProxyImpl implements _$BanUserCWProxy {
  const _$BanUserCWProxyImpl(this._value);

  final BanUser _value;

  @override
  BanUser banReason(String banReason) => call(banReason: banReason);

  @override
  BanUser banExpiresIn(num? banExpiresIn) => call(banExpiresIn: banExpiresIn);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `BanUser(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// BanUser(...).copyWith(id: 12, name: "My name")
  /// ```
  BanUser call({
    Object? banReason = const $CopyWithPlaceholder(),
    Object? banExpiresIn = const $CopyWithPlaceholder(),
  }) {
    return BanUser(
      banReason: banReason == const $CopyWithPlaceholder() || banReason == null
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
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfBanUser.copyWith(...)` or `instanceOfBanUser.copyWith.fieldName(...)`.
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
