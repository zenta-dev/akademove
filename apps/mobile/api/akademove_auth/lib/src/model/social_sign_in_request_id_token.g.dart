// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'social_sign_in_request_id_token.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$SocialSignInRequestIdToken extends SocialSignInRequestIdToken {
  @override
  final String token;
  @override
  final String? nonce;
  @override
  final String? accessToken;
  @override
  final String? refreshToken;
  @override
  final num? expiresAt;

  factory _$SocialSignInRequestIdToken(
          [void Function(SocialSignInRequestIdTokenBuilder)? updates]) =>
      (SocialSignInRequestIdTokenBuilder()..update(updates))._build();

  _$SocialSignInRequestIdToken._(
      {required this.token,
      this.nonce,
      this.accessToken,
      this.refreshToken,
      this.expiresAt})
      : super._();
  @override
  SocialSignInRequestIdToken rebuild(
          void Function(SocialSignInRequestIdTokenBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SocialSignInRequestIdTokenBuilder toBuilder() =>
      SocialSignInRequestIdTokenBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SocialSignInRequestIdToken &&
        token == other.token &&
        nonce == other.nonce &&
        accessToken == other.accessToken &&
        refreshToken == other.refreshToken &&
        expiresAt == other.expiresAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, token.hashCode);
    _$hash = $jc(_$hash, nonce.hashCode);
    _$hash = $jc(_$hash, accessToken.hashCode);
    _$hash = $jc(_$hash, refreshToken.hashCode);
    _$hash = $jc(_$hash, expiresAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'SocialSignInRequestIdToken')
          ..add('token', token)
          ..add('nonce', nonce)
          ..add('accessToken', accessToken)
          ..add('refreshToken', refreshToken)
          ..add('expiresAt', expiresAt))
        .toString();
  }
}

class SocialSignInRequestIdTokenBuilder
    implements
        Builder<SocialSignInRequestIdToken, SocialSignInRequestIdTokenBuilder> {
  _$SocialSignInRequestIdToken? _$v;

  String? _token;
  String? get token => _$this._token;
  set token(String? token) => _$this._token = token;

  String? _nonce;
  String? get nonce => _$this._nonce;
  set nonce(String? nonce) => _$this._nonce = nonce;

  String? _accessToken;
  String? get accessToken => _$this._accessToken;
  set accessToken(String? accessToken) => _$this._accessToken = accessToken;

  String? _refreshToken;
  String? get refreshToken => _$this._refreshToken;
  set refreshToken(String? refreshToken) => _$this._refreshToken = refreshToken;

  num? _expiresAt;
  num? get expiresAt => _$this._expiresAt;
  set expiresAt(num? expiresAt) => _$this._expiresAt = expiresAt;

  SocialSignInRequestIdTokenBuilder() {
    SocialSignInRequestIdToken._defaults(this);
  }

  SocialSignInRequestIdTokenBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _token = $v.token;
      _nonce = $v.nonce;
      _accessToken = $v.accessToken;
      _refreshToken = $v.refreshToken;
      _expiresAt = $v.expiresAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SocialSignInRequestIdToken other) {
    _$v = other as _$SocialSignInRequestIdToken;
  }

  @override
  void update(void Function(SocialSignInRequestIdTokenBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  SocialSignInRequestIdToken build() => _build();

  _$SocialSignInRequestIdToken _build() {
    final _$result = _$v ??
        _$SocialSignInRequestIdToken._(
          token: BuiltValueNullFieldError.checkNotNull(
              token, r'SocialSignInRequestIdToken', 'token'),
          nonce: nonce,
          accessToken: accessToken,
          refreshToken: refreshToken,
          expiresAt: expiresAt,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
