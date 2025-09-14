// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'revoke_other_sessions_post200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$RevokeOtherSessionsPost200Response
    extends RevokeOtherSessionsPost200Response {
  @override
  final bool status;

  factory _$RevokeOtherSessionsPost200Response(
          [void Function(RevokeOtherSessionsPost200ResponseBuilder)?
              updates]) =>
      (RevokeOtherSessionsPost200ResponseBuilder()..update(updates))._build();

  _$RevokeOtherSessionsPost200Response._({required this.status}) : super._();
  @override
  RevokeOtherSessionsPost200Response rebuild(
          void Function(RevokeOtherSessionsPost200ResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  RevokeOtherSessionsPost200ResponseBuilder toBuilder() =>
      RevokeOtherSessionsPost200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is RevokeOtherSessionsPost200Response &&
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
    return (newBuiltValueToStringHelper(r'RevokeOtherSessionsPost200Response')
          ..add('status', status))
        .toString();
  }
}

class RevokeOtherSessionsPost200ResponseBuilder
    implements
        Builder<RevokeOtherSessionsPost200Response,
            RevokeOtherSessionsPost200ResponseBuilder> {
  _$RevokeOtherSessionsPost200Response? _$v;

  bool? _status;
  bool? get status => _$this._status;
  set status(bool? status) => _$this._status = status;

  RevokeOtherSessionsPost200ResponseBuilder() {
    RevokeOtherSessionsPost200Response._defaults(this);
  }

  RevokeOtherSessionsPost200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _status = $v.status;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(RevokeOtherSessionsPost200Response other) {
    _$v = other as _$RevokeOtherSessionsPost200Response;
  }

  @override
  void update(
      void Function(RevokeOtherSessionsPost200ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  RevokeOtherSessionsPost200Response build() => _build();

  _$RevokeOtherSessionsPost200Response _build() {
    final _$result = _$v ??
        _$RevokeOtherSessionsPost200Response._(
          status: BuiltValueNullFieldError.checkNotNull(
              status, r'RevokeOtherSessionsPost200Response', 'status'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
