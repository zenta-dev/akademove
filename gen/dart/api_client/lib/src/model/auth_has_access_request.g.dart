// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_has_access_request.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$AuthHasAccessRequestCWProxy {
  AuthHasAccessRequest roles(List<RoleAccess> roles);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `AuthHasAccessRequest(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// AuthHasAccessRequest(...).copyWith(id: 12, name: "My name")
  /// ```
  AuthHasAccessRequest call({List<RoleAccess> roles});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfAuthHasAccessRequest.copyWith(...)` or call `instanceOfAuthHasAccessRequest.copyWith.fieldName(value)` for a single field.
class _$AuthHasAccessRequestCWProxyImpl
    implements _$AuthHasAccessRequestCWProxy {
  const _$AuthHasAccessRequestCWProxyImpl(this._value);

  final AuthHasAccessRequest _value;

  @override
  AuthHasAccessRequest roles(List<RoleAccess> roles) => call(roles: roles);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `AuthHasAccessRequest(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// AuthHasAccessRequest(...).copyWith(id: 12, name: "My name")
  /// ```
  AuthHasAccessRequest call({Object? roles = const $CopyWithPlaceholder()}) {
    return AuthHasAccessRequest(
      roles: roles == const $CopyWithPlaceholder() || roles == null
          ? _value.roles
          // ignore: cast_nullable_to_non_nullable
          : roles as List<RoleAccess>,
    );
  }
}

extension $AuthHasAccessRequestCopyWith on AuthHasAccessRequest {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfAuthHasAccessRequest.copyWith(...)` or `instanceOfAuthHasAccessRequest.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$AuthHasAccessRequestCWProxy get copyWith =>
      _$AuthHasAccessRequestCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthHasAccessRequest _$AuthHasAccessRequestFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('AuthHasAccessRequest', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['roles']);
  final val = AuthHasAccessRequest(
    roles: $checkedConvert(
      'roles',
      (v) => (v as List<dynamic>)
          .map((e) => $enumDecode(_$RoleAccessEnumMap, e))
          .toList(),
    ),
  );
  return val;
});

Map<String, dynamic> _$AuthHasAccessRequestToJson(
  AuthHasAccessRequest instance,
) => <String, dynamic>{
  'roles': instance.roles.map((e) => _$RoleAccessEnumMap[e]!).toList(),
};

const _$RoleAccessEnumMap = {
  RoleAccess.ADMIN: 'ADMIN',
  RoleAccess.OPERATOR: 'OPERATOR',
  RoleAccess.MERCHANT: 'MERCHANT',
  RoleAccess.DRIVER: 'DRIVER',
  RoleAccess.USER: 'USER',
  RoleAccess.ALL: 'ALL',
  RoleAccess.SYSTEM: 'SYSTEM',
};
