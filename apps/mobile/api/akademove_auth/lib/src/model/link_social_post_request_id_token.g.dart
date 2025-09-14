// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'link_social_post_request_id_token.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$LinkSocialPostRequestIdToken extends LinkSocialPostRequestIdToken {
  @override
  final String token;
  @override
  final String? nonce;
  @override
  final String? accessToken;
  @override
  final String? refreshToken;
  @override
  final BuiltList<JsonObject?>? scopes;

  factory _$LinkSocialPostRequestIdToken(
          [void Function(LinkSocialPostRequestIdTokenBuilder)? updates]) =>
      (LinkSocialPostRequestIdTokenBuilder()..update(updates))._build();

  _$LinkSocialPostRequestIdToken._(
      {required this.token,
      this.nonce,
      this.accessToken,
      this.refreshToken,
      this.scopes})
      : super._();
  @override
  LinkSocialPostRequestIdToken rebuild(
          void Function(LinkSocialPostRequestIdTokenBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  LinkSocialPostRequestIdTokenBuilder toBuilder() =>
      LinkSocialPostRequestIdTokenBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is LinkSocialPostRequestIdToken &&
        token == other.token &&
        nonce == other.nonce &&
        accessToken == other.accessToken &&
        refreshToken == other.refreshToken &&
        scopes == other.scopes;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, token.hashCode);
    _$hash = $jc(_$hash, nonce.hashCode);
    _$hash = $jc(_$hash, accessToken.hashCode);
    _$hash = $jc(_$hash, refreshToken.hashCode);
    _$hash = $jc(_$hash, scopes.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'LinkSocialPostRequestIdToken')
          ..add('token', token)
          ..add('nonce', nonce)
          ..add('accessToken', accessToken)
          ..add('refreshToken', refreshToken)
          ..add('scopes', scopes))
        .toString();
  }
}

class LinkSocialPostRequestIdTokenBuilder
    implements
        Builder<LinkSocialPostRequestIdToken,
            LinkSocialPostRequestIdTokenBuilder> {
  _$LinkSocialPostRequestIdToken? _$v;

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

  ListBuilder<JsonObject?>? _scopes;
  ListBuilder<JsonObject?> get scopes =>
      _$this._scopes ??= ListBuilder<JsonObject?>();
  set scopes(ListBuilder<JsonObject?>? scopes) => _$this._scopes = scopes;

  LinkSocialPostRequestIdTokenBuilder() {
    LinkSocialPostRequestIdToken._defaults(this);
  }

  LinkSocialPostRequestIdTokenBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _token = $v.token;
      _nonce = $v.nonce;
      _accessToken = $v.accessToken;
      _refreshToken = $v.refreshToken;
      _scopes = $v.scopes?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(LinkSocialPostRequestIdToken other) {
    _$v = other as _$LinkSocialPostRequestIdToken;
  }

  @override
  void update(void Function(LinkSocialPostRequestIdTokenBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  LinkSocialPostRequestIdToken build() => _build();

  _$LinkSocialPostRequestIdToken _build() {
    _$LinkSocialPostRequestIdToken _$result;
    try {
      _$result = _$v ??
          _$LinkSocialPostRequestIdToken._(
            token: BuiltValueNullFieldError.checkNotNull(
                token, r'LinkSocialPostRequestIdToken', 'token'),
            nonce: nonce,
            accessToken: accessToken,
            refreshToken: refreshToken,
            scopes: _scopes?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'scopes';
        _scopes?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'LinkSocialPostRequestIdToken', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
