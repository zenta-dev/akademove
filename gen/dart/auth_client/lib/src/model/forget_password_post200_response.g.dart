// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'forget_password_post200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ForgetPasswordPost200Response extends ForgetPasswordPost200Response {
  @override
  final bool? status;
  @override
  final String? message;

  factory _$ForgetPasswordPost200Response([
    void Function(ForgetPasswordPost200ResponseBuilder)? updates,
  ]) => (ForgetPasswordPost200ResponseBuilder()..update(updates))._build();

  _$ForgetPasswordPost200Response._({this.status, this.message}) : super._();
  @override
  ForgetPasswordPost200Response rebuild(
    void Function(ForgetPasswordPost200ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ForgetPasswordPost200ResponseBuilder toBuilder() =>
      ForgetPasswordPost200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ForgetPasswordPost200Response &&
        status == other.status &&
        message == other.message;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, message.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ForgetPasswordPost200Response')
          ..add('status', status)
          ..add('message', message))
        .toString();
  }
}

class ForgetPasswordPost200ResponseBuilder
    implements
        Builder<
          ForgetPasswordPost200Response,
          ForgetPasswordPost200ResponseBuilder
        > {
  _$ForgetPasswordPost200Response? _$v;

  bool? _status;
  bool? get status => _$this._status;
  set status(bool? status) => _$this._status = status;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  ForgetPasswordPost200ResponseBuilder() {
    ForgetPasswordPost200Response._defaults(this);
  }

  ForgetPasswordPost200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _status = $v.status;
      _message = $v.message;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ForgetPasswordPost200Response other) {
    _$v = other as _$ForgetPasswordPost200Response;
  }

  @override
  void update(void Function(ForgetPasswordPost200ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ForgetPasswordPost200Response build() => _build();

  _$ForgetPasswordPost200Response _build() {
    final _$result =
        _$v ??
        _$ForgetPasswordPost200Response._(status: status, message: message);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
