// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_admin_list_filters_parameter.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$UserAdminListFiltersParameterCWProxy {
  UserAdminListFiltersParameter roles(
    List<UserAdminListFiltersParameterRolesEnum>? roles,
  );

  UserAdminListFiltersParameter genders(
    List<UserAdminListFiltersParameterGendersEnum>? genders,
  );

  UserAdminListFiltersParameter emailVerified(bool? emailVerified);

  UserAdminListFiltersParameter banned(bool? banned);

  UserAdminListFiltersParameter startDate(DateTime? startDate);

  UserAdminListFiltersParameter endDate(DateTime? endDate);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `UserAdminListFiltersParameter(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// UserAdminListFiltersParameter(...).copyWith(id: 12, name: "My name")
  /// ```
  UserAdminListFiltersParameter call({
    List<UserAdminListFiltersParameterRolesEnum>? roles,
    List<UserAdminListFiltersParameterGendersEnum>? genders,
    bool? emailVerified,
    bool? banned,
    DateTime? startDate,
    DateTime? endDate,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfUserAdminListFiltersParameter.copyWith(...)` or call `instanceOfUserAdminListFiltersParameter.copyWith.fieldName(value)` for a single field.
class _$UserAdminListFiltersParameterCWProxyImpl
    implements _$UserAdminListFiltersParameterCWProxy {
  const _$UserAdminListFiltersParameterCWProxyImpl(this._value);

  final UserAdminListFiltersParameter _value;

  @override
  UserAdminListFiltersParameter roles(
    List<UserAdminListFiltersParameterRolesEnum>? roles,
  ) => call(roles: roles);

  @override
  UserAdminListFiltersParameter genders(
    List<UserAdminListFiltersParameterGendersEnum>? genders,
  ) => call(genders: genders);

  @override
  UserAdminListFiltersParameter emailVerified(bool? emailVerified) =>
      call(emailVerified: emailVerified);

  @override
  UserAdminListFiltersParameter banned(bool? banned) => call(banned: banned);

  @override
  UserAdminListFiltersParameter startDate(DateTime? startDate) =>
      call(startDate: startDate);

  @override
  UserAdminListFiltersParameter endDate(DateTime? endDate) =>
      call(endDate: endDate);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `UserAdminListFiltersParameter(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// UserAdminListFiltersParameter(...).copyWith(id: 12, name: "My name")
  /// ```
  UserAdminListFiltersParameter call({
    Object? roles = const $CopyWithPlaceholder(),
    Object? genders = const $CopyWithPlaceholder(),
    Object? emailVerified = const $CopyWithPlaceholder(),
    Object? banned = const $CopyWithPlaceholder(),
    Object? startDate = const $CopyWithPlaceholder(),
    Object? endDate = const $CopyWithPlaceholder(),
  }) {
    return UserAdminListFiltersParameter(
      roles: roles == const $CopyWithPlaceholder()
          ? _value.roles
          // ignore: cast_nullable_to_non_nullable
          : roles as List<UserAdminListFiltersParameterRolesEnum>?,
      genders: genders == const $CopyWithPlaceholder()
          ? _value.genders
          // ignore: cast_nullable_to_non_nullable
          : genders as List<UserAdminListFiltersParameterGendersEnum>?,
      emailVerified: emailVerified == const $CopyWithPlaceholder()
          ? _value.emailVerified
          // ignore: cast_nullable_to_non_nullable
          : emailVerified as bool?,
      banned: banned == const $CopyWithPlaceholder()
          ? _value.banned
          // ignore: cast_nullable_to_non_nullable
          : banned as bool?,
      startDate: startDate == const $CopyWithPlaceholder()
          ? _value.startDate
          // ignore: cast_nullable_to_non_nullable
          : startDate as DateTime?,
      endDate: endDate == const $CopyWithPlaceholder()
          ? _value.endDate
          // ignore: cast_nullable_to_non_nullable
          : endDate as DateTime?,
    );
  }
}

extension $UserAdminListFiltersParameterCopyWith
    on UserAdminListFiltersParameter {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfUserAdminListFiltersParameter.copyWith(...)` or `instanceOfUserAdminListFiltersParameter.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$UserAdminListFiltersParameterCWProxy get copyWith =>
      _$UserAdminListFiltersParameterCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserAdminListFiltersParameter _$UserAdminListFiltersParameterFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('UserAdminListFiltersParameter', json, ($checkedConvert) {
  final val = UserAdminListFiltersParameter(
    roles: $checkedConvert(
      'roles',
      (v) => (v as List<dynamic>?)
          ?.map(
            (e) =>
                $enumDecode(_$UserAdminListFiltersParameterRolesEnumEnumMap, e),
          )
          .toList(),
    ),
    genders: $checkedConvert(
      'genders',
      (v) => (v as List<dynamic>?)
          ?.map(
            (e) => $enumDecode(
              _$UserAdminListFiltersParameterGendersEnumEnumMap,
              e,
            ),
          )
          .toList(),
    ),
    emailVerified: $checkedConvert('emailVerified', (v) => v as bool?),
    banned: $checkedConvert('banned', (v) => v as bool?),
    startDate: $checkedConvert(
      'startDate',
      (v) => v == null ? null : DateTime.parse(v as String),
    ),
    endDate: $checkedConvert(
      'endDate',
      (v) => v == null ? null : DateTime.parse(v as String),
    ),
  );
  return val;
});

Map<String, dynamic> _$UserAdminListFiltersParameterToJson(
  UserAdminListFiltersParameter instance,
) => <String, dynamic>{
  'roles': ?instance.roles
      ?.map((e) => _$UserAdminListFiltersParameterRolesEnumEnumMap[e]!)
      .toList(),
  'genders': ?instance.genders
      ?.map((e) => _$UserAdminListFiltersParameterGendersEnumEnumMap[e]!)
      .toList(),
  'emailVerified': ?instance.emailVerified,
  'banned': ?instance.banned,
  'startDate': ?instance.startDate?.toIso8601String(),
  'endDate': ?instance.endDate?.toIso8601String(),
};

const _$UserAdminListFiltersParameterRolesEnumEnumMap = {
  UserAdminListFiltersParameterRolesEnum.ADMIN: 'ADMIN',
  UserAdminListFiltersParameterRolesEnum.OPERATOR: 'OPERATOR',
  UserAdminListFiltersParameterRolesEnum.MERCHANT: 'MERCHANT',
  UserAdminListFiltersParameterRolesEnum.DRIVER: 'DRIVER',
  UserAdminListFiltersParameterRolesEnum.USER: 'USER',
};

const _$UserAdminListFiltersParameterGendersEnumEnumMap = {
  UserAdminListFiltersParameterGendersEnum.MALE: 'MALE',
  UserAdminListFiltersParameterGendersEnum.FEMALE: 'FEMALE',
};
