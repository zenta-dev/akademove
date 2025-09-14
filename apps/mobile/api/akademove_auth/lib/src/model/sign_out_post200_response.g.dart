// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_out_post200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$SignOutPost200Response extends SignOutPost200Response {
  @override
  final bool? success;

  factory _$SignOutPost200Response(
          [void Function(SignOutPost200ResponseBuilder)? updates]) =>
      (SignOutPost200ResponseBuilder()..update(updates))._build();

  _$SignOutPost200Response._({this.success}) : super._();
  @override
  SignOutPost200Response rebuild(
          void Function(SignOutPost200ResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SignOutPost200ResponseBuilder toBuilder() =>
      SignOutPost200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SignOutPost200Response && success == other.success;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, success.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'SignOutPost200Response')
          ..add('success', success))
        .toString();
  }
}

class SignOutPost200ResponseBuilder
    implements Builder<SignOutPost200Response, SignOutPost200ResponseBuilder> {
  _$SignOutPost200Response? _$v;

  bool? _success;
  bool? get success => _$this._success;
  set success(bool? success) => _$this._success = success;

  SignOutPost200ResponseBuilder() {
    SignOutPost200Response._defaults(this);
  }

  SignOutPost200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _success = $v.success;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SignOutPost200Response other) {
    _$v = other as _$SignOutPost200Response;
  }

  @override
  void update(void Function(SignOutPost200ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  SignOutPost200Response build() => _build();

  _$SignOutPost200Response _build() {
    final _$result = _$v ??
        _$SignOutPost200Response._(
          success: success,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
