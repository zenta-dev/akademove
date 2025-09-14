// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_user_post200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$UpdateUserPost200Response extends UpdateUserPost200Response {
  @override
  final bool? status;

  factory _$UpdateUserPost200Response([
    void Function(UpdateUserPost200ResponseBuilder)? updates,
  ]) => (UpdateUserPost200ResponseBuilder()..update(updates))._build();

  _$UpdateUserPost200Response._({this.status}) : super._();
  @override
  UpdateUserPost200Response rebuild(
    void Function(UpdateUserPost200ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  UpdateUserPost200ResponseBuilder toBuilder() =>
      UpdateUserPost200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UpdateUserPost200Response && status == other.status;
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
      r'UpdateUserPost200Response',
    )..add('status', status)).toString();
  }
}

class UpdateUserPost200ResponseBuilder
    implements
        Builder<UpdateUserPost200Response, UpdateUserPost200ResponseBuilder> {
  _$UpdateUserPost200Response? _$v;

  bool? _status;
  bool? get status => _$this._status;
  set status(bool? status) => _$this._status = status;

  UpdateUserPost200ResponseBuilder() {
    UpdateUserPost200Response._defaults(this);
  }

  UpdateUserPost200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _status = $v.status;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UpdateUserPost200Response other) {
    _$v = other as _$UpdateUserPost200Response;
  }

  @override
  void update(void Function(UpdateUserPost200ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  UpdateUserPost200Response build() => _build();

  _$UpdateUserPost200Response _build() {
    final _$result = _$v ?? _$UpdateUserPost200Response._(status: status);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
