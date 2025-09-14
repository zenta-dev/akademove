// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'refresh_token_post200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$RefreshTokenPost200Response extends RefreshTokenPost200Response {
  @override
  final String? tokenType;
  @override
  final String? idToken;
  @override
  final String? accessToken;
  @override
  final String? refreshToken;
  @override
  final DateTime? accessTokenExpiresAt;
  @override
  final DateTime? refreshTokenExpiresAt;

  factory _$RefreshTokenPost200Response(
          [void Function(RefreshTokenPost200ResponseBuilder)? updates]) =>
      (RefreshTokenPost200ResponseBuilder()..update(updates))._build();

  _$RefreshTokenPost200Response._(
      {this.tokenType,
      this.idToken,
      this.accessToken,
      this.refreshToken,
      this.accessTokenExpiresAt,
      this.refreshTokenExpiresAt})
      : super._();
  @override
  RefreshTokenPost200Response rebuild(
          void Function(RefreshTokenPost200ResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  RefreshTokenPost200ResponseBuilder toBuilder() =>
      RefreshTokenPost200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is RefreshTokenPost200Response &&
        tokenType == other.tokenType &&
        idToken == other.idToken &&
        accessToken == other.accessToken &&
        refreshToken == other.refreshToken &&
        accessTokenExpiresAt == other.accessTokenExpiresAt &&
        refreshTokenExpiresAt == other.refreshTokenExpiresAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, tokenType.hashCode);
    _$hash = $jc(_$hash, idToken.hashCode);
    _$hash = $jc(_$hash, accessToken.hashCode);
    _$hash = $jc(_$hash, refreshToken.hashCode);
    _$hash = $jc(_$hash, accessTokenExpiresAt.hashCode);
    _$hash = $jc(_$hash, refreshTokenExpiresAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'RefreshTokenPost200Response')
          ..add('tokenType', tokenType)
          ..add('idToken', idToken)
          ..add('accessToken', accessToken)
          ..add('refreshToken', refreshToken)
          ..add('accessTokenExpiresAt', accessTokenExpiresAt)
          ..add('refreshTokenExpiresAt', refreshTokenExpiresAt))
        .toString();
  }
}

class RefreshTokenPost200ResponseBuilder
    implements
        Builder<RefreshTokenPost200Response,
            RefreshTokenPost200ResponseBuilder> {
  _$RefreshTokenPost200Response? _$v;

  String? _tokenType;
  String? get tokenType => _$this._tokenType;
  set tokenType(String? tokenType) => _$this._tokenType = tokenType;

  String? _idToken;
  String? get idToken => _$this._idToken;
  set idToken(String? idToken) => _$this._idToken = idToken;

  String? _accessToken;
  String? get accessToken => _$this._accessToken;
  set accessToken(String? accessToken) => _$this._accessToken = accessToken;

  String? _refreshToken;
  String? get refreshToken => _$this._refreshToken;
  set refreshToken(String? refreshToken) => _$this._refreshToken = refreshToken;

  DateTime? _accessTokenExpiresAt;
  DateTime? get accessTokenExpiresAt => _$this._accessTokenExpiresAt;
  set accessTokenExpiresAt(DateTime? accessTokenExpiresAt) =>
      _$this._accessTokenExpiresAt = accessTokenExpiresAt;

  DateTime? _refreshTokenExpiresAt;
  DateTime? get refreshTokenExpiresAt => _$this._refreshTokenExpiresAt;
  set refreshTokenExpiresAt(DateTime? refreshTokenExpiresAt) =>
      _$this._refreshTokenExpiresAt = refreshTokenExpiresAt;

  RefreshTokenPost200ResponseBuilder() {
    RefreshTokenPost200Response._defaults(this);
  }

  RefreshTokenPost200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _tokenType = $v.tokenType;
      _idToken = $v.idToken;
      _accessToken = $v.accessToken;
      _refreshToken = $v.refreshToken;
      _accessTokenExpiresAt = $v.accessTokenExpiresAt;
      _refreshTokenExpiresAt = $v.refreshTokenExpiresAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(RefreshTokenPost200Response other) {
    _$v = other as _$RefreshTokenPost200Response;
  }

  @override
  void update(void Function(RefreshTokenPost200ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  RefreshTokenPost200Response build() => _build();

  _$RefreshTokenPost200Response _build() {
    final _$result = _$v ??
        _$RefreshTokenPost200Response._(
          tokenType: tokenType,
          idToken: idToken,
          accessToken: accessToken,
          refreshToken: refreshToken,
          accessTokenExpiresAt: accessTokenExpiresAt,
          refreshTokenExpiresAt: refreshTokenExpiresAt,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
