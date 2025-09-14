// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'revoke_session_post200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$RevokeSessionPost200Response extends RevokeSessionPost200Response {
  @override
  final bool status;

  factory _$RevokeSessionPost200Response([
    void Function(RevokeSessionPost200ResponseBuilder)? updates,
  ]) => (RevokeSessionPost200ResponseBuilder()..update(updates))._build();

  _$RevokeSessionPost200Response._({required this.status}) : super._();
  @override
  RevokeSessionPost200Response rebuild(
    void Function(RevokeSessionPost200ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  RevokeSessionPost200ResponseBuilder toBuilder() =>
      RevokeSessionPost200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is RevokeSessionPost200Response && status == other.status;
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
      r'RevokeSessionPost200Response',
    )..add('status', status)).toString();
  }
}

class RevokeSessionPost200ResponseBuilder
    implements
        Builder<
          RevokeSessionPost200Response,
          RevokeSessionPost200ResponseBuilder
        > {
  _$RevokeSessionPost200Response? _$v;

  bool? _status;
  bool? get status => _$this._status;
  set status(bool? status) => _$this._status = status;

  RevokeSessionPost200ResponseBuilder() {
    RevokeSessionPost200Response._defaults(this);
  }

  RevokeSessionPost200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _status = $v.status;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(RevokeSessionPost200Response other) {
    _$v = other as _$RevokeSessionPost200Response;
  }

  @override
  void update(void Function(RevokeSessionPost200ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  RevokeSessionPost200Response build() => _build();

  _$RevokeSessionPost200Response _build() {
    final _$result =
        _$v ??
        _$RevokeSessionPost200Response._(
          status: BuiltValueNullFieldError.checkNotNull(
            status,
            r'RevokeSessionPost200Response',
            'status',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
