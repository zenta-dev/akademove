// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_has_permission_request.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$AuthHasPermissionRequestCWProxy {
  AuthHasPermissionRequest permissions(Statements permissions);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `AuthHasPermissionRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// AuthHasPermissionRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  AuthHasPermissionRequest call({Statements permissions});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfAuthHasPermissionRequest.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfAuthHasPermissionRequest.copyWith.fieldName(...)`
class _$AuthHasPermissionRequestCWProxyImpl
    implements _$AuthHasPermissionRequestCWProxy {
  const _$AuthHasPermissionRequestCWProxyImpl(this._value);

  final AuthHasPermissionRequest _value;

  @override
  AuthHasPermissionRequest permissions(Statements permissions) =>
      this(permissions: permissions);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `AuthHasPermissionRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// AuthHasPermissionRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  AuthHasPermissionRequest call({
    Object? permissions = const $CopyWithPlaceholder(),
  }) {
    return AuthHasPermissionRequest(
      permissions: permissions == const $CopyWithPlaceholder()
          ? _value.permissions
          // ignore: cast_nullable_to_non_nullable
          : permissions as Statements,
    );
  }
}

extension $AuthHasPermissionRequestCopyWith on AuthHasPermissionRequest {
  /// Returns a callable class that can be used as follows: `instanceOfAuthHasPermissionRequest.copyWith(...)` or like so:`instanceOfAuthHasPermissionRequest.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$AuthHasPermissionRequestCWProxy get copyWith =>
      _$AuthHasPermissionRequestCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthHasPermissionRequest _$AuthHasPermissionRequestFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('AuthHasPermissionRequest', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['permissions']);
  final val = AuthHasPermissionRequest(
    permissions: $checkedConvert(
      'permissions',
      (v) => Statements.fromJson(v as Map<String, dynamic>),
    ),
  );
  return val;
});

Map<String, dynamic> _$AuthHasPermissionRequestToJson(
  AuthHasPermissionRequest instance,
) => <String, dynamic>{'permissions': instance.permissions.toJson()};
