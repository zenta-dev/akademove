// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'send_verification_email_post200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$SendVerificationEmailPost200Response
    extends SendVerificationEmailPost200Response {
  @override
  final bool? status;

  factory _$SendVerificationEmailPost200Response([
    void Function(SendVerificationEmailPost200ResponseBuilder)? updates,
  ]) =>
      (SendVerificationEmailPost200ResponseBuilder()..update(updates))._build();

  _$SendVerificationEmailPost200Response._({this.status}) : super._();
  @override
  SendVerificationEmailPost200Response rebuild(
    void Function(SendVerificationEmailPost200ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  SendVerificationEmailPost200ResponseBuilder toBuilder() =>
      SendVerificationEmailPost200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SendVerificationEmailPost200Response &&
        status == other.status;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
      r'SendVerificationEmailPost200Response',
    )..add('status', status)).toString();
  }
}

class SendVerificationEmailPost200ResponseBuilder
    implements
        Builder<
          SendVerificationEmailPost200Response,
          SendVerificationEmailPost200ResponseBuilder
        > {
  _$SendVerificationEmailPost200Response? _$v;

  bool? _status;
  bool? get status => _$this._status;
  set status(bool? status) => _$this._status = status;

  SendVerificationEmailPost200ResponseBuilder() {
    SendVerificationEmailPost200Response._defaults(this);
  }

  SendVerificationEmailPost200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _status = $v.status;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SendVerificationEmailPost200Response other) {
    _$v = other as _$SendVerificationEmailPost200Response;
  }

  @override
  void update(
    void Function(SendVerificationEmailPost200ResponseBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  SendVerificationEmailPost200Response build() => _build();

  _$SendVerificationEmailPost200Response _build() {
    final _$result =
        _$v ?? _$SendVerificationEmailPost200Response._(status: status);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
