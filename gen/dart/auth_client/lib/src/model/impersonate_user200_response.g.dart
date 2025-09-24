// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'impersonate_user200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ImpersonateUser200Response extends ImpersonateUser200Response {
  @override
  final Session? session;
  @override
  final User? user;

  factory _$ImpersonateUser200Response([
    void Function(ImpersonateUser200ResponseBuilder)? updates,
  ]) => (ImpersonateUser200ResponseBuilder()..update(updates))._build();

  _$ImpersonateUser200Response._({this.session, this.user}) : super._();
  @override
  ImpersonateUser200Response rebuild(
    void Function(ImpersonateUser200ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ImpersonateUser200ResponseBuilder toBuilder() =>
      ImpersonateUser200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ImpersonateUser200Response &&
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
    return (newBuiltValueToStringHelper(r'ImpersonateUser200Response')
          ..add('session', session)
          ..add('user', user))
        .toString();
  }
}

class ImpersonateUser200ResponseBuilder
    implements
        Builder<ImpersonateUser200Response, ImpersonateUser200ResponseBuilder> {
  _$ImpersonateUser200Response? _$v;

  SessionBuilder? _session;
  SessionBuilder get session => _$this._session ??= SessionBuilder();
  set session(SessionBuilder? session) => _$this._session = session;

  UserBuilder? _user;
  UserBuilder get user => _$this._user ??= UserBuilder();
  set user(UserBuilder? user) => _$this._user = user;

  ImpersonateUser200ResponseBuilder() {
    ImpersonateUser200Response._defaults(this);
  }

  ImpersonateUser200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _session = $v.session?.toBuilder();
      _user = $v.user?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ImpersonateUser200Response other) {
    _$v = other as _$ImpersonateUser200Response;
  }

  @override
  void update(void Function(ImpersonateUser200ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ImpersonateUser200Response build() => _build();

  _$ImpersonateUser200Response _build() {
    _$ImpersonateUser200Response _$result;
    try {
      _$result =
          _$v ??
          _$ImpersonateUser200Response._(
            session: _session?.build(),
            user: _user?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'session';
        _session?.build();
        _$failedField = 'user';
        _user?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'ImpersonateUser200Response',
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
