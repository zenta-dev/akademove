// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_has_permission_request.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$AuthHasPermissionRequestCWProxy {
  AuthHasPermissionRequest permissions(Statements permissions);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `AuthHasPermissionRequest(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// AuthHasPermissionRequest(...).copyWith(id: 12, name: "My name")
  /// ```
  AuthHasPermissionRequest call({Statements permissions});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfAuthHasPermissionRequest.copyWith(...)` or call `instanceOfAuthHasPermissionRequest.copyWith.fieldName(value)` for a single field.
class _$AuthHasPermissionRequestCWProxyImpl implements _$AuthHasPermissionRequestCWProxy {
  const _$AuthHasPermissionRequestCWProxyImpl(this._value);

  final AuthHasPermissionRequest _value;

  @override
  AuthHasPermissionRequest permissions(Statements permissions) => call(permissions: permissions);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `AuthHasPermissionRequest(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// AuthHasPermissionRequest(...).copyWith(id: 12, name: "My name")
  /// ```
  AuthHasPermissionRequest call({Object? permissions = const $CopyWithPlaceholder()}) {
    return AuthHasPermissionRequest(
      permissions: permissions == const $CopyWithPlaceholder() || permissions == null
          ? _value.permissions
          // ignore: cast_nullable_to_non_nullable
          : permissions as Statements,
    );
  }
}

extension $AuthHasPermissionRequestCopyWith on AuthHasPermissionRequest {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfAuthHasPermissionRequest.copyWith(...)` or `instanceOfAuthHasPermissionRequest.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$AuthHasPermissionRequestCWProxy get copyWith => _$AuthHasPermissionRequestCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthHasPermissionRequest _$AuthHasPermissionRequestFromJson(Map<String, dynamic> json) =>
    $checkedCreate('AuthHasPermissionRequest', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['permissions']);
      final val = AuthHasPermissionRequest(
        permissions: $checkedConvert('permissions', (v) => Statements.fromJson(v as Map<String, dynamic>)),
      );
      return val;
    });

Map<String, dynamic> _$AuthHasPermissionRequestToJson(AuthHasPermissionRequest instance) => <String, dynamic>{
  'permissions': instance.permissions.toJson(),
};
