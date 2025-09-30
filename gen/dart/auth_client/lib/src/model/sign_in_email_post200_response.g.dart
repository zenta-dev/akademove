// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_in_email_post200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$SignInEmailPost200Response extends SignInEmailPost200Response {
  @override
  final String token;
  @override
  final JsonObject? url;
  @override
  final SignInEmailPost200ResponseUser user;

  factory _$SignInEmailPost200Response([
    void Function(SignInEmailPost200ResponseBuilder)? updates,
  ]) => (SignInEmailPost200ResponseBuilder()..update(updates))._build();

  _$SignInEmailPost200Response._({
    required this.token,
    this.url,
    required this.user,
  }) : super._();
  @override
  SignInEmailPost200Response rebuild(
    void Function(SignInEmailPost200ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  SignInEmailPost200ResponseBuilder toBuilder() =>
      SignInEmailPost200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SignInEmailPost200Response &&
        token == other.token &&
        url == other.url &&
        user == other.user;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, token.hashCode);
    _$hash = $jc(_$hash, url.hashCode);
    _$hash = $jc(_$hash, user.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'SignInEmailPost200Response')
          ..add('token', token)
          ..add('url', url)
          ..add('user', user))
        .toString();
  }
}

class SignInEmailPost200ResponseBuilder
    implements
        Builder<SignInEmailPost200Response, SignInEmailPost200ResponseBuilder> {
  _$SignInEmailPost200Response? _$v;

  String? _token;
  String? get token => _$this._token;
  set token(String? token) => _$this._token = token;

  JsonObject? _url;
  JsonObject? get url => _$this._url;
  set url(JsonObject? url) => _$this._url = url;

  SignInEmailPost200ResponseUserBuilder? _user;
  SignInEmailPost200ResponseUserBuilder get user =>
      _$this._user ??= SignInEmailPost200ResponseUserBuilder();
  set user(SignInEmailPost200ResponseUserBuilder? user) => _$this._user = user;

  SignInEmailPost200ResponseBuilder() {
    SignInEmailPost200Response._defaults(this);
  }

  SignInEmailPost200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _token = $v.token;
      _url = $v.url;
      _user = $v.user.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SignInEmailPost200Response other) {
    _$v = other as _$SignInEmailPost200Response;
  }

  @override
  void update(void Function(SignInEmailPost200ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  SignInEmailPost200Response build() => _build();

  _$SignInEmailPost200Response _build() {
    _$SignInEmailPost200Response _$result;
    try {
      _$result =
          _$v ??
          _$SignInEmailPost200Response._(
            token: BuiltValueNullFieldError.checkNotNull(
              token,
              r'SignInEmailPost200Response',
              'token',
            ),
            url: url,
            user: user.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'user';
        user.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'SignInEmailPost200Response',
          _$failedField,
          e.toString(),
        );
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
