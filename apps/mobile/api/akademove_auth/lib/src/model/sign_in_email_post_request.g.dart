// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_in_email_post_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$SignInEmailPostRequest extends SignInEmailPostRequest {
  @override
  final String email;
  @override
  final String password;
  @override
  final String? callbackURL;
  @override
  final String? rememberMe;

  factory _$SignInEmailPostRequest(
          [void Function(SignInEmailPostRequestBuilder)? updates]) =>
      (SignInEmailPostRequestBuilder()..update(updates))._build();

  _$SignInEmailPostRequest._(
      {required this.email,
      required this.password,
      this.callbackURL,
      this.rememberMe})
      : super._();
  @override
  SignInEmailPostRequest rebuild(
          void Function(SignInEmailPostRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SignInEmailPostRequestBuilder toBuilder() =>
      SignInEmailPostRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SignInEmailPostRequest &&
        email == other.email &&
        password == other.password &&
        callbackURL == other.callbackURL &&
        rememberMe == other.rememberMe;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, email.hashCode);
    _$hash = $jc(_$hash, password.hashCode);
    _$hash = $jc(_$hash, callbackURL.hashCode);
    _$hash = $jc(_$hash, rememberMe.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'SignInEmailPostRequest')
          ..add('email', email)
          ..add('password', password)
          ..add('callbackURL', callbackURL)
          ..add('rememberMe', rememberMe))
        .toString();
  }
}

class SignInEmailPostRequestBuilder
    implements Builder<SignInEmailPostRequest, SignInEmailPostRequestBuilder> {
  _$SignInEmailPostRequest? _$v;

  String? _email;
  String? get email => _$this._email;
  set email(String? email) => _$this._email = email;

  String? _password;
  String? get password => _$this._password;
  set password(String? password) => _$this._password = password;

  String? _callbackURL;
  String? get callbackURL => _$this._callbackURL;
  set callbackURL(String? callbackURL) => _$this._callbackURL = callbackURL;

  String? _rememberMe;
  String? get rememberMe => _$this._rememberMe;
  set rememberMe(String? rememberMe) => _$this._rememberMe = rememberMe;

  SignInEmailPostRequestBuilder() {
    SignInEmailPostRequest._defaults(this);
  }

  SignInEmailPostRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _email = $v.email;
      _password = $v.password;
      _callbackURL = $v.callbackURL;
      _rememberMe = $v.rememberMe;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SignInEmailPostRequest other) {
    _$v = other as _$SignInEmailPostRequest;
  }

  @override
  void update(void Function(SignInEmailPostRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  SignInEmailPostRequest build() => _build();

  _$SignInEmailPostRequest _build() {
    final _$result = _$v ??
        _$SignInEmailPostRequest._(
          email: BuiltValueNullFieldError.checkNotNull(
              email, r'SignInEmailPostRequest', 'email'),
          password: BuiltValueNullFieldError.checkNotNull(
              password, r'SignInEmailPostRequest', 'password'),
          callbackURL: callbackURL,
          rememberMe: rememberMe,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
