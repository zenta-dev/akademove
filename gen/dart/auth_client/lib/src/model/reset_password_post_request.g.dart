// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reset_password_post_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ResetPasswordPostRequest extends ResetPasswordPostRequest {
  @override
  final String newPassword;
  @override
  final String? token;

  factory _$ResetPasswordPostRequest([
    void Function(ResetPasswordPostRequestBuilder)? updates,
  ]) => (ResetPasswordPostRequestBuilder()..update(updates))._build();

  _$ResetPasswordPostRequest._({required this.newPassword, this.token})
    : super._();
  @override
  ResetPasswordPostRequest rebuild(
    void Function(ResetPasswordPostRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ResetPasswordPostRequestBuilder toBuilder() =>
      ResetPasswordPostRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ResetPasswordPostRequest &&
        newPassword == other.newPassword &&
        token == other.token;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, newPassword.hashCode);
    _$hash = $jc(_$hash, token.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ResetPasswordPostRequest')
          ..add('newPassword', newPassword)
          ..add('token', token))
        .toString();
  }
}

class ResetPasswordPostRequestBuilder
    implements
        Builder<ResetPasswordPostRequest, ResetPasswordPostRequestBuilder> {
  _$ResetPasswordPostRequest? _$v;

  String? _newPassword;
  String? get newPassword => _$this._newPassword;
  set newPassword(String? newPassword) => _$this._newPassword = newPassword;

  String? _token;
  String? get token => _$this._token;
  set token(String? token) => _$this._token = token;

  ResetPasswordPostRequestBuilder() {
    ResetPasswordPostRequest._defaults(this);
  }

  ResetPasswordPostRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _newPassword = $v.newPassword;
      _token = $v.token;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ResetPasswordPostRequest other) {
    _$v = other as _$ResetPasswordPostRequest;
  }

  @override
  void update(void Function(ResetPasswordPostRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ResetPasswordPostRequest build() => _build();

  _$ResetPasswordPostRequest _build() {
    final _$result =
        _$v ??
        _$ResetPasswordPostRequest._(
          newPassword: BuiltValueNullFieldError.checkNotNull(
            newPassword,
            r'ResetPasswordPostRequest',
            'newPassword',
          ),
          token: token,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
