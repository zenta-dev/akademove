// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_up_email_post200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$SignUpEmailPost200Response extends SignUpEmailPost200Response {
  @override
  final String? token;
  @override
  final SignUpEmailPost200ResponseUser user;

  factory _$SignUpEmailPost200Response([
    void Function(SignUpEmailPost200ResponseBuilder)? updates,
  ]) => (SignUpEmailPost200ResponseBuilder()..update(updates))._build();

  _$SignUpEmailPost200Response._({this.token, required this.user}) : super._();
  @override
  SignUpEmailPost200Response rebuild(
    void Function(SignUpEmailPost200ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  SignUpEmailPost200ResponseBuilder toBuilder() =>
      SignUpEmailPost200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SignUpEmailPost200Response &&
        token == other.token &&
        user == other.user;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, token.hashCode);
    _$hash = $jc(_$hash, user.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'SignUpEmailPost200Response')
          ..add('token', token)
          ..add('user', user))
        .toString();
  }
}

class SignUpEmailPost200ResponseBuilder
    implements
        Builder<SignUpEmailPost200Response, SignUpEmailPost200ResponseBuilder> {
  _$SignUpEmailPost200Response? _$v;

  String? _token;
  String? get token => _$this._token;
  set token(String? token) => _$this._token = token;

  SignUpEmailPost200ResponseUserBuilder? _user;
  SignUpEmailPost200ResponseUserBuilder get user =>
      _$this._user ??= SignUpEmailPost200ResponseUserBuilder();
  set user(SignUpEmailPost200ResponseUserBuilder? user) => _$this._user = user;

  SignUpEmailPost200ResponseBuilder() {
    SignUpEmailPost200Response._defaults(this);
  }

  SignUpEmailPost200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _token = $v.token;
      _user = $v.user.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SignUpEmailPost200Response other) {
    _$v = other as _$SignUpEmailPost200Response;
  }

  @override
  void update(void Function(SignUpEmailPost200ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  SignUpEmailPost200Response build() => _build();

  _$SignUpEmailPost200Response _build() {
    _$SignUpEmailPost200Response _$result;
    try {
      _$result =
          _$v ??
          _$SignUpEmailPost200Response._(token: token, user: user.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'user';
        user.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'SignUpEmailPost200Response',
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
