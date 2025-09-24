// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_user_password_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$UpdateUserPasswordRequest extends UpdateUserPasswordRequest {
  @override
  final String password;
  @override
  final String confirmPassword;

  factory _$UpdateUserPasswordRequest([
    void Function(UpdateUserPasswordRequestBuilder)? updates,
  ]) => (UpdateUserPasswordRequestBuilder()..update(updates))._build();

  _$UpdateUserPasswordRequest._({
    required this.password,
    required this.confirmPassword,
  }) : super._();
  @override
  UpdateUserPasswordRequest rebuild(
    void Function(UpdateUserPasswordRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  UpdateUserPasswordRequestBuilder toBuilder() =>
      UpdateUserPasswordRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UpdateUserPasswordRequest &&
        password == other.password &&
        confirmPassword == other.confirmPassword;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, password.hashCode);
    _$hash = $jc(_$hash, confirmPassword.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'UpdateUserPasswordRequest')
          ..add('password', password)
          ..add('confirmPassword', confirmPassword))
        .toString();
  }
}

class UpdateUserPasswordRequestBuilder
    implements
        Builder<UpdateUserPasswordRequest, UpdateUserPasswordRequestBuilder> {
  _$UpdateUserPasswordRequest? _$v;

  String? _password;
  String? get password => _$this._password;
  set password(String? password) => _$this._password = password;

  String? _confirmPassword;
  String? get confirmPassword => _$this._confirmPassword;
  set confirmPassword(String? confirmPassword) =>
      _$this._confirmPassword = confirmPassword;

  UpdateUserPasswordRequestBuilder() {
    UpdateUserPasswordRequest._defaults(this);
  }

  UpdateUserPasswordRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _password = $v.password;
      _confirmPassword = $v.confirmPassword;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UpdateUserPasswordRequest other) {
    _$v = other as _$UpdateUserPasswordRequest;
  }

  @override
  void update(void Function(UpdateUserPasswordRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  UpdateUserPasswordRequest build() => _build();

  _$UpdateUserPasswordRequest _build() {
    final _$result =
        _$v ??
        _$UpdateUserPasswordRequest._(
          password: BuiltValueNullFieldError.checkNotNull(
            password,
            r'UpdateUserPasswordRequest',
            'password',
          ),
          confirmPassword: BuiltValueNullFieldError.checkNotNull(
            confirmPassword,
            r'UpdateUserPasswordRequest',
            'confirmPassword',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
