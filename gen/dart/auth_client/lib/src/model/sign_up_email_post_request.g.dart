// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_up_email_post_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$SignUpEmailPostRequest extends SignUpEmailPostRequest {
  @override
  final String name;
  @override
  final String email;
  @override
  final String password;
  @override
  final String? image;
  @override
  final String? callbackURL;
  @override
  final bool? rememberMe;

  factory _$SignUpEmailPostRequest([
    void Function(SignUpEmailPostRequestBuilder)? updates,
  ]) => (SignUpEmailPostRequestBuilder()..update(updates))._build();

  _$SignUpEmailPostRequest._({
    required this.name,
    required this.email,
    required this.password,
    this.image,
    this.callbackURL,
    this.rememberMe,
  }) : super._();
  @override
  SignUpEmailPostRequest rebuild(
    void Function(SignUpEmailPostRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  SignUpEmailPostRequestBuilder toBuilder() =>
      SignUpEmailPostRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SignUpEmailPostRequest &&
        name == other.name &&
        email == other.email &&
        password == other.password &&
        image == other.image &&
        callbackURL == other.callbackURL &&
        rememberMe == other.rememberMe;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, email.hashCode);
    _$hash = $jc(_$hash, password.hashCode);
    _$hash = $jc(_$hash, image.hashCode);
    _$hash = $jc(_$hash, callbackURL.hashCode);
    _$hash = $jc(_$hash, rememberMe.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'SignUpEmailPostRequest')
          ..add('name', name)
          ..add('email', email)
          ..add('password', password)
          ..add('image', image)
          ..add('callbackURL', callbackURL)
          ..add('rememberMe', rememberMe))
        .toString();
  }
}

class SignUpEmailPostRequestBuilder
    implements Builder<SignUpEmailPostRequest, SignUpEmailPostRequestBuilder> {
  _$SignUpEmailPostRequest? _$v;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _email;
  String? get email => _$this._email;
  set email(String? email) => _$this._email = email;

  String? _password;
  String? get password => _$this._password;
  set password(String? password) => _$this._password = password;

  String? _image;
  String? get image => _$this._image;
  set image(String? image) => _$this._image = image;

  String? _callbackURL;
  String? get callbackURL => _$this._callbackURL;
  set callbackURL(String? callbackURL) => _$this._callbackURL = callbackURL;

  bool? _rememberMe;
  bool? get rememberMe => _$this._rememberMe;
  set rememberMe(bool? rememberMe) => _$this._rememberMe = rememberMe;

  SignUpEmailPostRequestBuilder() {
    SignUpEmailPostRequest._defaults(this);
  }

  SignUpEmailPostRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _name = $v.name;
      _email = $v.email;
      _password = $v.password;
      _image = $v.image;
      _callbackURL = $v.callbackURL;
      _rememberMe = $v.rememberMe;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SignUpEmailPostRequest other) {
    _$v = other as _$SignUpEmailPostRequest;
  }

  @override
  void update(void Function(SignUpEmailPostRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  SignUpEmailPostRequest build() => _build();

  _$SignUpEmailPostRequest _build() {
    final _$result =
        _$v ??
        _$SignUpEmailPostRequest._(
          name: BuiltValueNullFieldError.checkNotNull(
            name,
            r'SignUpEmailPostRequest',
            'name',
          ),
          email: BuiltValueNullFieldError.checkNotNull(
            email,
            r'SignUpEmailPostRequest',
            'email',
          ),
          password: BuiltValueNullFieldError.checkNotNull(
            password,
            r'SignUpEmailPostRequest',
            'password',
          ),
          image: image,
          callbackURL: callbackURL,
          rememberMe: rememberMe,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
