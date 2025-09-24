// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'set_role_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$SetRoleRequest extends SetRoleRequest {
  @override
  final String userId;
  @override
  final String role;

  factory _$SetRoleRequest([void Function(SetRoleRequestBuilder)? updates]) =>
      (SetRoleRequestBuilder()..update(updates))._build();

  _$SetRoleRequest._({required this.userId, required this.role}) : super._();
  @override
  SetRoleRequest rebuild(void Function(SetRoleRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SetRoleRequestBuilder toBuilder() => SetRoleRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SetRoleRequest &&
        userId == other.userId &&
        role == other.role;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, userId.hashCode);
    _$hash = $jc(_$hash, role.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'SetRoleRequest')
          ..add('userId', userId)
          ..add('role', role))
        .toString();
  }
}

class SetRoleRequestBuilder
    implements Builder<SetRoleRequest, SetRoleRequestBuilder> {
  _$SetRoleRequest? _$v;

  String? _userId;
  String? get userId => _$this._userId;
  set userId(String? userId) => _$this._userId = userId;

  String? _role;
  String? get role => _$this._role;
  set role(String? role) => _$this._role = role;

  SetRoleRequestBuilder() {
    SetRoleRequest._defaults(this);
  }

  SetRoleRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _userId = $v.userId;
      _role = $v.role;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SetRoleRequest other) {
    _$v = other as _$SetRoleRequest;
  }

  @override
  void update(void Function(SetRoleRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  SetRoleRequest build() => _build();

  _$SetRoleRequest _build() {
    final _$result =
        _$v ??
        _$SetRoleRequest._(
          userId: BuiltValueNullFieldError.checkNotNull(
            userId,
            r'SetRoleRequest',
            'userId',
          ),
          role: BuiltValueNullFieldError.checkNotNull(
            role,
            r'SetRoleRequest',
            'role',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
