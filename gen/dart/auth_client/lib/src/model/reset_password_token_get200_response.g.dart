// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reset_password_token_get200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ResetPasswordTokenGet200Response
    extends ResetPasswordTokenGet200Response {
  @override
  final String? token;

  factory _$ResetPasswordTokenGet200Response([
    void Function(ResetPasswordTokenGet200ResponseBuilder)? updates,
  ]) => (ResetPasswordTokenGet200ResponseBuilder()..update(updates))._build();

  _$ResetPasswordTokenGet200Response._({this.token}) : super._();
  @override
  ResetPasswordTokenGet200Response rebuild(
    void Function(ResetPasswordTokenGet200ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ResetPasswordTokenGet200ResponseBuilder toBuilder() =>
      ResetPasswordTokenGet200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ResetPasswordTokenGet200Response && token == other.token;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, token.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
      r'ResetPasswordTokenGet200Response',
    )..add('token', token)).toString();
  }
}

class ResetPasswordTokenGet200ResponseBuilder
    implements
        Builder<
          ResetPasswordTokenGet200Response,
          ResetPasswordTokenGet200ResponseBuilder
        > {
  _$ResetPasswordTokenGet200Response? _$v;

  String? _token;
  String? get token => _$this._token;
  set token(String? token) => _$this._token = token;

  ResetPasswordTokenGet200ResponseBuilder() {
    ResetPasswordTokenGet200Response._defaults(this);
  }

  ResetPasswordTokenGet200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _token = $v.token;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ResetPasswordTokenGet200Response other) {
    _$v = other as _$ResetPasswordTokenGet200Response;
  }

  @override
  void update(void Function(ResetPasswordTokenGet200ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ResetPasswordTokenGet200Response build() => _build();

  _$ResetPasswordTokenGet200Response _build() {
    final _$result = _$v ?? _$ResetPasswordTokenGet200Response._(token: token);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
