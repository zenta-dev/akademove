// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$Account extends Account {
  @override
  final String accountId;
  @override
  final String providerId;
  @override
  final String userId;
  @override
  final String createdAt;
  @override
  final String updatedAt;
  @override
  final String? id;
  @override
  final String? accessToken;
  @override
  final String? refreshToken;
  @override
  final String? idToken;
  @override
  final String? accessTokenExpiresAt;
  @override
  final String? refreshTokenExpiresAt;
  @override
  final String? scope;
  @override
  final String? password;

  factory _$Account([void Function(AccountBuilder)? updates]) =>
      (AccountBuilder()..update(updates))._build();

  _$Account._(
      {required this.accountId,
      required this.providerId,
      required this.userId,
      required this.createdAt,
      required this.updatedAt,
      this.id,
      this.accessToken,
      this.refreshToken,
      this.idToken,
      this.accessTokenExpiresAt,
      this.refreshTokenExpiresAt,
      this.scope,
      this.password})
      : super._();
  @override
  Account rebuild(void Function(AccountBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AccountBuilder toBuilder() => AccountBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Account &&
        accountId == other.accountId &&
        providerId == other.providerId &&
        userId == other.userId &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt &&
        id == other.id &&
        accessToken == other.accessToken &&
        refreshToken == other.refreshToken &&
        idToken == other.idToken &&
        accessTokenExpiresAt == other.accessTokenExpiresAt &&
        refreshTokenExpiresAt == other.refreshTokenExpiresAt &&
        scope == other.scope &&
        password == other.password;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, accountId.hashCode);
    _$hash = $jc(_$hash, providerId.hashCode);
    _$hash = $jc(_$hash, userId.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, updatedAt.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, accessToken.hashCode);
    _$hash = $jc(_$hash, refreshToken.hashCode);
    _$hash = $jc(_$hash, idToken.hashCode);
    _$hash = $jc(_$hash, accessTokenExpiresAt.hashCode);
    _$hash = $jc(_$hash, refreshTokenExpiresAt.hashCode);
    _$hash = $jc(_$hash, scope.hashCode);
    _$hash = $jc(_$hash, password.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Account')
          ..add('accountId', accountId)
          ..add('providerId', providerId)
          ..add('userId', userId)
          ..add('createdAt', createdAt)
          ..add('updatedAt', updatedAt)
          ..add('id', id)
          ..add('accessToken', accessToken)
          ..add('refreshToken', refreshToken)
          ..add('idToken', idToken)
          ..add('accessTokenExpiresAt', accessTokenExpiresAt)
          ..add('refreshTokenExpiresAt', refreshTokenExpiresAt)
          ..add('scope', scope)
          ..add('password', password))
        .toString();
  }
}

class AccountBuilder implements Builder<Account, AccountBuilder> {
  _$Account? _$v;

  String? _accountId;
  String? get accountId => _$this._accountId;
  set accountId(String? accountId) => _$this._accountId = accountId;

  String? _providerId;
  String? get providerId => _$this._providerId;
  set providerId(String? providerId) => _$this._providerId = providerId;

  String? _userId;
  String? get userId => _$this._userId;
  set userId(String? userId) => _$this._userId = userId;

  String? _createdAt;
  String? get createdAt => _$this._createdAt;
  set createdAt(String? createdAt) => _$this._createdAt = createdAt;

  String? _updatedAt;
  String? get updatedAt => _$this._updatedAt;
  set updatedAt(String? updatedAt) => _$this._updatedAt = updatedAt;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _accessToken;
  String? get accessToken => _$this._accessToken;
  set accessToken(String? accessToken) => _$this._accessToken = accessToken;

  String? _refreshToken;
  String? get refreshToken => _$this._refreshToken;
  set refreshToken(String? refreshToken) => _$this._refreshToken = refreshToken;

  String? _idToken;
  String? get idToken => _$this._idToken;
  set idToken(String? idToken) => _$this._idToken = idToken;

  String? _accessTokenExpiresAt;
  String? get accessTokenExpiresAt => _$this._accessTokenExpiresAt;
  set accessTokenExpiresAt(String? accessTokenExpiresAt) =>
      _$this._accessTokenExpiresAt = accessTokenExpiresAt;

  String? _refreshTokenExpiresAt;
  String? get refreshTokenExpiresAt => _$this._refreshTokenExpiresAt;
  set refreshTokenExpiresAt(String? refreshTokenExpiresAt) =>
      _$this._refreshTokenExpiresAt = refreshTokenExpiresAt;

  String? _scope;
  String? get scope => _$this._scope;
  set scope(String? scope) => _$this._scope = scope;

  String? _password;
  String? get password => _$this._password;
  set password(String? password) => _$this._password = password;

  AccountBuilder() {
    Account._defaults(this);
  }

  AccountBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _accountId = $v.accountId;
      _providerId = $v.providerId;
      _userId = $v.userId;
      _createdAt = $v.createdAt;
      _updatedAt = $v.updatedAt;
      _id = $v.id;
      _accessToken = $v.accessToken;
      _refreshToken = $v.refreshToken;
      _idToken = $v.idToken;
      _accessTokenExpiresAt = $v.accessTokenExpiresAt;
      _refreshTokenExpiresAt = $v.refreshTokenExpiresAt;
      _scope = $v.scope;
      _password = $v.password;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Account other) {
    _$v = other as _$Account;
  }

  @override
  void update(void Function(AccountBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Account build() => _build();

  _$Account _build() {
    final _$result = _$v ??
        _$Account._(
          accountId: BuiltValueNullFieldError.checkNotNull(
              accountId, r'Account', 'accountId'),
          providerId: BuiltValueNullFieldError.checkNotNull(
              providerId, r'Account', 'providerId'),
          userId: BuiltValueNullFieldError.checkNotNull(
              userId, r'Account', 'userId'),
          createdAt: BuiltValueNullFieldError.checkNotNull(
              createdAt, r'Account', 'createdAt'),
          updatedAt: BuiltValueNullFieldError.checkNotNull(
              updatedAt, r'Account', 'updatedAt'),
          id: id,
          accessToken: accessToken,
          refreshToken: refreshToken,
          idToken: idToken,
          accessTokenExpiresAt: accessTokenExpiresAt,
          refreshTokenExpiresAt: refreshTokenExpiresAt,
          scope: scope,
          password: password,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
