// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'revoke_sessions_post200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$RevokeSessionsPost200Response extends RevokeSessionsPost200Response {
  @override
  final bool status;

  factory _$RevokeSessionsPost200Response(
          [void Function(RevokeSessionsPost200ResponseBuilder)? updates]) =>
      (RevokeSessionsPost200ResponseBuilder()..update(updates))._build();

  _$RevokeSessionsPost200Response._({required this.status}) : super._();
  @override
  RevokeSessionsPost200Response rebuild(
          void Function(RevokeSessionsPost200ResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  RevokeSessionsPost200ResponseBuilder toBuilder() =>
      RevokeSessionsPost200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is RevokeSessionsPost200Response && status == other.status;
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
    return (newBuiltValueToStringHelper(r'RevokeSessionsPost200Response')
          ..add('status', status))
        .toString();
  }
}

class RevokeSessionsPost200ResponseBuilder
    implements
        Builder<RevokeSessionsPost200Response,
            RevokeSessionsPost200ResponseBuilder> {
  _$RevokeSessionsPost200Response? _$v;

  bool? _status;
  bool? get status => _$this._status;
  set status(bool? status) => _$this._status = status;

  RevokeSessionsPost200ResponseBuilder() {
    RevokeSessionsPost200Response._defaults(this);
  }

  RevokeSessionsPost200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _status = $v.status;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(RevokeSessionsPost200Response other) {
    _$v = other as _$RevokeSessionsPost200Response;
  }

  @override
  void update(void Function(RevokeSessionsPost200ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  RevokeSessionsPost200Response build() => _build();

  _$RevokeSessionsPost200Response _build() {
    final _$result = _$v ??
        _$RevokeSessionsPost200Response._(
          status: BuiltValueNullFieldError.checkNotNull(
              status, r'RevokeSessionsPost200Response', 'status'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
