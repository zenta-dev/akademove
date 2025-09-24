// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'set_role200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$SetRole200Response extends SetRole200Response {
  @override
  final User? user;

  factory _$SetRole200Response([
    void Function(SetRole200ResponseBuilder)? updates,
  ]) => (SetRole200ResponseBuilder()..update(updates))._build();

  _$SetRole200Response._({this.user}) : super._();
  @override
  SetRole200Response rebuild(
    void Function(SetRole200ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  SetRole200ResponseBuilder toBuilder() =>
      SetRole200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SetRole200Response && user == other.user;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, user.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
      r'SetRole200Response',
    )..add('user', user)).toString();
  }
}

class SetRole200ResponseBuilder
    implements Builder<SetRole200Response, SetRole200ResponseBuilder> {
  _$SetRole200Response? _$v;

  UserBuilder? _user;
  UserBuilder get user => _$this._user ??= UserBuilder();
  set user(UserBuilder? user) => _$this._user = user;

  SetRole200ResponseBuilder() {
    SetRole200Response._defaults(this);
  }

  SetRole200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _user = $v.user?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SetRole200Response other) {
    _$v = other as _$SetRole200Response;
  }

  @override
  void update(void Function(SetRole200ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  SetRole200Response build() => _build();

  _$SetRole200Response _build() {
    _$SetRole200Response _$result;
    try {
      _$result = _$v ?? _$SetRole200Response._(user: _user?.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'user';
        _user?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'SetRole200Response',
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
