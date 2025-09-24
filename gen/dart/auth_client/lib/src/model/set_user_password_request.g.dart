// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'set_user_password_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$SetUserPasswordRequest extends SetUserPasswordRequest {
  @override
  final String newPassword;
  @override
  final String userId;

  factory _$SetUserPasswordRequest([
    void Function(SetUserPasswordRequestBuilder)? updates,
  ]) => (SetUserPasswordRequestBuilder()..update(updates))._build();

  _$SetUserPasswordRequest._({required this.newPassword, required this.userId})
    : super._();
  @override
  SetUserPasswordRequest rebuild(
    void Function(SetUserPasswordRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  SetUserPasswordRequestBuilder toBuilder() =>
      SetUserPasswordRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SetUserPasswordRequest &&
        newPassword == other.newPassword &&
        userId == other.userId;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, newPassword.hashCode);
    _$hash = $jc(_$hash, userId.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'SetUserPasswordRequest')
          ..add('newPassword', newPassword)
          ..add('userId', userId))
        .toString();
  }
}

class SetUserPasswordRequestBuilder
    implements Builder<SetUserPasswordRequest, SetUserPasswordRequestBuilder> {
  _$SetUserPasswordRequest? _$v;

  String? _newPassword;
  String? get newPassword => _$this._newPassword;
  set newPassword(String? newPassword) => _$this._newPassword = newPassword;

  String? _userId;
  String? get userId => _$this._userId;
  set userId(String? userId) => _$this._userId = userId;

  SetUserPasswordRequestBuilder() {
    SetUserPasswordRequest._defaults(this);
  }

  SetUserPasswordRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _newPassword = $v.newPassword;
      _userId = $v.userId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SetUserPasswordRequest other) {
    _$v = other as _$SetUserPasswordRequest;
  }

  @override
  void update(void Function(SetUserPasswordRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  SetUserPasswordRequest build() => _build();

  _$SetUserPasswordRequest _build() {
    final _$result =
        _$v ??
        _$SetUserPasswordRequest._(
          newPassword: BuiltValueNullFieldError.checkNotNull(
            newPassword,
            r'SetUserPasswordRequest',
            'newPassword',
          ),
          userId: BuiltValueNullFieldError.checkNotNull(
            userId,
            r'SetUserPasswordRequest',
            'userId',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
