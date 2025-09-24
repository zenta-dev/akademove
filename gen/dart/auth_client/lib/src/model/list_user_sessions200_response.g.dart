// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_user_sessions200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ListUserSessions200Response extends ListUserSessions200Response {
  @override
  final BuiltList<Session>? sessions;

  factory _$ListUserSessions200Response([
    void Function(ListUserSessions200ResponseBuilder)? updates,
  ]) => (ListUserSessions200ResponseBuilder()..update(updates))._build();

  _$ListUserSessions200Response._({this.sessions}) : super._();
  @override
  ListUserSessions200Response rebuild(
    void Function(ListUserSessions200ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ListUserSessions200ResponseBuilder toBuilder() =>
      ListUserSessions200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ListUserSessions200Response && sessions == other.sessions;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, sessions.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
      r'ListUserSessions200Response',
    )..add('sessions', sessions)).toString();
  }
}

class ListUserSessions200ResponseBuilder
    implements
        Builder<
          ListUserSessions200Response,
          ListUserSessions200ResponseBuilder
        > {
  _$ListUserSessions200Response? _$v;

  ListBuilder<Session>? _sessions;
  ListBuilder<Session> get sessions =>
      _$this._sessions ??= ListBuilder<Session>();
  set sessions(ListBuilder<Session>? sessions) => _$this._sessions = sessions;

  ListUserSessions200ResponseBuilder() {
    ListUserSessions200Response._defaults(this);
  }

  ListUserSessions200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _sessions = $v.sessions?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ListUserSessions200Response other) {
    _$v = other as _$ListUserSessions200Response;
  }

  @override
  void update(void Function(ListUserSessions200ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ListUserSessions200Response build() => _build();

  _$ListUserSessions200Response _build() {
    _$ListUserSessions200Response _$result;
    try {
      _$result =
          _$v ?? _$ListUserSessions200Response._(sessions: _sessions?.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'sessions';
        _sessions?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'ListUserSessions200Response',
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
