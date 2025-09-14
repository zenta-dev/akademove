// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'change_password_post200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ChangePasswordPost200Response extends ChangePasswordPost200Response {
  @override
  final String? token;
  @override
  final SignUpEmailPost200ResponseUser user;

  factory _$ChangePasswordPost200Response([
    void Function(ChangePasswordPost200ResponseBuilder)? updates,
  ]) => (ChangePasswordPost200ResponseBuilder()..update(updates))._build();

  _$ChangePasswordPost200Response._({this.token, required this.user})
    : super._();
  @override
  ChangePasswordPost200Response rebuild(
    void Function(ChangePasswordPost200ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ChangePasswordPost200ResponseBuilder toBuilder() =>
      ChangePasswordPost200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ChangePasswordPost200Response &&
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
    return (newBuiltValueToStringHelper(r'ChangePasswordPost200Response')
          ..add('token', token)
          ..add('user', user))
        .toString();
  }
}

class ChangePasswordPost200ResponseBuilder
    implements
        Builder<
          ChangePasswordPost200Response,
          ChangePasswordPost200ResponseBuilder
        > {
  _$ChangePasswordPost200Response? _$v;

  String? _token;
  String? get token => _$this._token;
  set token(String? token) => _$this._token = token;

  SignUpEmailPost200ResponseUserBuilder? _user;
  SignUpEmailPost200ResponseUserBuilder get user =>
      _$this._user ??= SignUpEmailPost200ResponseUserBuilder();
  set user(SignUpEmailPost200ResponseUserBuilder? user) => _$this._user = user;

  ChangePasswordPost200ResponseBuilder() {
    ChangePasswordPost200Response._defaults(this);
  }

  ChangePasswordPost200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _token = $v.token;
      _user = $v.user.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ChangePasswordPost200Response other) {
    _$v = other as _$ChangePasswordPost200Response;
  }

  @override
  void update(void Function(ChangePasswordPost200ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ChangePasswordPost200Response build() => _build();

  _$ChangePasswordPost200Response _build() {
    _$ChangePasswordPost200Response _$result;
    try {
      _$result =
          _$v ??
          _$ChangePasswordPost200Response._(token: token, user: user.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'user';
        user.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'ChangePasswordPost200Response',
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
