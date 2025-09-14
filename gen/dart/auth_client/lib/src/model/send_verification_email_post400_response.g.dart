// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'send_verification_email_post400_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$SendVerificationEmailPost400Response
    extends SendVerificationEmailPost400Response {
  @override
  final String? message;

  factory _$SendVerificationEmailPost400Response([
    void Function(SendVerificationEmailPost400ResponseBuilder)? updates,
  ]) =>
      (SendVerificationEmailPost400ResponseBuilder()..update(updates))._build();

  _$SendVerificationEmailPost400Response._({this.message}) : super._();
  @override
  SendVerificationEmailPost400Response rebuild(
    void Function(SendVerificationEmailPost400ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  SendVerificationEmailPost400ResponseBuilder toBuilder() =>
      SendVerificationEmailPost400ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SendVerificationEmailPost400Response &&
        message == other.message;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, message.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
      r'SendVerificationEmailPost400Response',
    )..add('message', message)).toString();
  }
}

class SendVerificationEmailPost400ResponseBuilder
    implements
        Builder<
          SendVerificationEmailPost400Response,
          SendVerificationEmailPost400ResponseBuilder
        > {
  _$SendVerificationEmailPost400Response? _$v;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  SendVerificationEmailPost400ResponseBuilder() {
    SendVerificationEmailPost400Response._defaults(this);
  }

  SendVerificationEmailPost400ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _message = $v.message;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SendVerificationEmailPost400Response other) {
    _$v = other as _$SendVerificationEmailPost400Response;
  }

  @override
  void update(
    void Function(SendVerificationEmailPost400ResponseBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  SendVerificationEmailPost400Response build() => _build();

  _$SendVerificationEmailPost400Response _build() {
    final _$result =
        _$v ?? _$SendVerificationEmailPost400Response._(message: message);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
