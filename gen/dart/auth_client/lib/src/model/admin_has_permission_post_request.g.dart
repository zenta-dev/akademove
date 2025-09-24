// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_has_permission_post_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AdminHasPermissionPostRequest extends AdminHasPermissionPostRequest {
  @override
  final JsonObject? permission;
  @override
  final JsonObject permissions;

  factory _$AdminHasPermissionPostRequest([
    void Function(AdminHasPermissionPostRequestBuilder)? updates,
  ]) => (AdminHasPermissionPostRequestBuilder()..update(updates))._build();

  _$AdminHasPermissionPostRequest._({
    this.permission,
    required this.permissions,
  }) : super._();
  @override
  AdminHasPermissionPostRequest rebuild(
    void Function(AdminHasPermissionPostRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  AdminHasPermissionPostRequestBuilder toBuilder() =>
      AdminHasPermissionPostRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AdminHasPermissionPostRequest &&
        permission == other.permission &&
        permissions == other.permissions;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, permission.hashCode);
    _$hash = $jc(_$hash, permissions.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AdminHasPermissionPostRequest')
          ..add('permission', permission)
          ..add('permissions', permissions))
        .toString();
  }
}

class AdminHasPermissionPostRequestBuilder
    implements
        Builder<
          AdminHasPermissionPostRequest,
          AdminHasPermissionPostRequestBuilder
        > {
  _$AdminHasPermissionPostRequest? _$v;

  JsonObject? _permission;
  JsonObject? get permission => _$this._permission;
  set permission(JsonObject? permission) => _$this._permission = permission;

  JsonObject? _permissions;
  JsonObject? get permissions => _$this._permissions;
  set permissions(JsonObject? permissions) => _$this._permissions = permissions;

  AdminHasPermissionPostRequestBuilder() {
    AdminHasPermissionPostRequest._defaults(this);
  }

  AdminHasPermissionPostRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _permission = $v.permission;
      _permissions = $v.permissions;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AdminHasPermissionPostRequest other) {
    _$v = other as _$AdminHasPermissionPostRequest;
  }

  @override
  void update(void Function(AdminHasPermissionPostRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AdminHasPermissionPostRequest build() => _build();

  _$AdminHasPermissionPostRequest _build() {
    final _$result =
        _$v ??
        _$AdminHasPermissionPostRequest._(
          permission: permission,
          permissions: BuiltValueNullFieldError.checkNotNull(
            permissions,
            r'AdminHasPermissionPostRequest',
            'permissions',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
