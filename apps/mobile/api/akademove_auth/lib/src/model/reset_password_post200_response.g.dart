// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reset_password_post200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ResetPasswordPost200Response extends ResetPasswordPost200Response {
  @override
  final bool? status;

  factory _$ResetPasswordPost200Response(
          [void Function(ResetPasswordPost200ResponseBuilder)? updates]) =>
      (ResetPasswordPost200ResponseBuilder()..update(updates))._build();

  _$ResetPasswordPost200Response._({this.status}) : super._();
  @override
  ResetPasswordPost200Response rebuild(
          void Function(ResetPasswordPost200ResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ResetPasswordPost200ResponseBuilder toBuilder() =>
      ResetPasswordPost200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ResetPasswordPost200Response && status == other.status;
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
    return (newBuiltValueToStringHelper(r'ResetPasswordPost200Response')
          ..add('status', status))
        .toString();
  }
}

class ResetPasswordPost200ResponseBuilder
    implements
        Builder<ResetPasswordPost200Response,
            ResetPasswordPost200ResponseBuilder> {
  _$ResetPasswordPost200Response? _$v;

  bool? _status;
  bool? get status => _$this._status;
  set status(bool? status) => _$this._status = status;

  ResetPasswordPost200ResponseBuilder() {
    ResetPasswordPost200Response._defaults(this);
  }

  ResetPasswordPost200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _status = $v.status;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ResetPasswordPost200Response other) {
    _$v = other as _$ResetPasswordPost200Response;
  }

  @override
  void update(void Function(ResetPasswordPost200ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ResetPasswordPost200Response build() => _build();

  _$ResetPasswordPost200Response _build() {
    final _$result = _$v ??
        _$ResetPasswordPost200Response._(
          status: status,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
