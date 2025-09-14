// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_session_get200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$GetSessionGet200Response extends GetSessionGet200Response {
  @override
  final Session session;
  @override
  final User user;

  factory _$GetSessionGet200Response(
          [void Function(GetSessionGet200ResponseBuilder)? updates]) =>
      (GetSessionGet200ResponseBuilder()..update(updates))._build();

  _$GetSessionGet200Response._({required this.session, required this.user})
      : super._();
  @override
  GetSessionGet200Response rebuild(
          void Function(GetSessionGet200ResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GetSessionGet200ResponseBuilder toBuilder() =>
      GetSessionGet200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GetSessionGet200Response &&
        session == other.session &&
        user == other.user;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, session.hashCode);
    _$hash = $jc(_$hash, user.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GetSessionGet200Response')
          ..add('session', session)
          ..add('user', user))
        .toString();
  }
}

class GetSessionGet200ResponseBuilder
    implements
        Builder<GetSessionGet200Response, GetSessionGet200ResponseBuilder> {
  _$GetSessionGet200Response? _$v;

  SessionBuilder? _session;
  SessionBuilder get session => _$this._session ??= SessionBuilder();
  set session(SessionBuilder? session) => _$this._session = session;

  UserBuilder? _user;
  UserBuilder get user => _$this._user ??= UserBuilder();
  set user(UserBuilder? user) => _$this._user = user;

  GetSessionGet200ResponseBuilder() {
    GetSessionGet200Response._defaults(this);
  }

  GetSessionGet200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _session = $v.session.toBuilder();
      _user = $v.user.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GetSessionGet200Response other) {
    _$v = other as _$GetSessionGet200Response;
  }

  @override
  void update(void Function(GetSessionGet200ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GetSessionGet200Response build() => _build();

  _$GetSessionGet200Response _build() {
    _$GetSessionGet200Response _$result;
    try {
      _$result = _$v ??
          _$GetSessionGet200Response._(
            session: session.build(),
            user: user.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'session';
        session.build();
        _$failedField = 'user';
        user.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'GetSessionGet200Response', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
