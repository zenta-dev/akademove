// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$Session extends Session {
  @override
  final String expiresAt;
  @override
  final String token;
  @override
  final String createdAt;
  @override
  final String updatedAt;
  @override
  final String userId;
  @override
  final String? id;
  @override
  final String? ipAddress;
  @override
  final String? userAgent;

  factory _$Session([void Function(SessionBuilder)? updates]) =>
      (SessionBuilder()..update(updates))._build();

  _$Session._(
      {required this.expiresAt,
      required this.token,
      required this.createdAt,
      required this.updatedAt,
      required this.userId,
      this.id,
      this.ipAddress,
      this.userAgent})
      : super._();
  @override
  Session rebuild(void Function(SessionBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SessionBuilder toBuilder() => SessionBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Session &&
        expiresAt == other.expiresAt &&
        token == other.token &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt &&
        userId == other.userId &&
        id == other.id &&
        ipAddress == other.ipAddress &&
        userAgent == other.userAgent;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, expiresAt.hashCode);
    _$hash = $jc(_$hash, token.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, updatedAt.hashCode);
    _$hash = $jc(_$hash, userId.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, ipAddress.hashCode);
    _$hash = $jc(_$hash, userAgent.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Session')
          ..add('expiresAt', expiresAt)
          ..add('token', token)
          ..add('createdAt', createdAt)
          ..add('updatedAt', updatedAt)
          ..add('userId', userId)
          ..add('id', id)
          ..add('ipAddress', ipAddress)
          ..add('userAgent', userAgent))
        .toString();
  }
}

class SessionBuilder implements Builder<Session, SessionBuilder> {
  _$Session? _$v;

  String? _expiresAt;
  String? get expiresAt => _$this._expiresAt;
  set expiresAt(String? expiresAt) => _$this._expiresAt = expiresAt;

  String? _token;
  String? get token => _$this._token;
  set token(String? token) => _$this._token = token;

  String? _createdAt;
  String? get createdAt => _$this._createdAt;
  set createdAt(String? createdAt) => _$this._createdAt = createdAt;

  String? _updatedAt;
  String? get updatedAt => _$this._updatedAt;
  set updatedAt(String? updatedAt) => _$this._updatedAt = updatedAt;

  String? _userId;
  String? get userId => _$this._userId;
  set userId(String? userId) => _$this._userId = userId;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _ipAddress;
  String? get ipAddress => _$this._ipAddress;
  set ipAddress(String? ipAddress) => _$this._ipAddress = ipAddress;

  String? _userAgent;
  String? get userAgent => _$this._userAgent;
  set userAgent(String? userAgent) => _$this._userAgent = userAgent;

  SessionBuilder() {
    Session._defaults(this);
  }

  SessionBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _expiresAt = $v.expiresAt;
      _token = $v.token;
      _createdAt = $v.createdAt;
      _updatedAt = $v.updatedAt;
      _userId = $v.userId;
      _id = $v.id;
      _ipAddress = $v.ipAddress;
      _userAgent = $v.userAgent;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Session other) {
    _$v = other as _$Session;
  }

  @override
  void update(void Function(SessionBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Session build() => _build();

  _$Session _build() {
    final _$result = _$v ??
        _$Session._(
          expiresAt: BuiltValueNullFieldError.checkNotNull(
              expiresAt, r'Session', 'expiresAt'),
          token:
              BuiltValueNullFieldError.checkNotNull(token, r'Session', 'token'),
          createdAt: BuiltValueNullFieldError.checkNotNull(
              createdAt, r'Session', 'createdAt'),
          updatedAt: BuiltValueNullFieldError.checkNotNull(
              updatedAt, r'Session', 'updatedAt'),
          userId: BuiltValueNullFieldError.checkNotNull(
              userId, r'Session', 'userId'),
          id: id,
          ipAddress: ipAddress,
          userAgent: userAgent,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
