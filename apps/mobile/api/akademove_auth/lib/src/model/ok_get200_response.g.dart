// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ok_get200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$OkGet200Response extends OkGet200Response {
  @override
  final bool ok;

  factory _$OkGet200Response(
          [void Function(OkGet200ResponseBuilder)? updates]) =>
      (OkGet200ResponseBuilder()..update(updates))._build();

  _$OkGet200Response._({required this.ok}) : super._();
  @override
  OkGet200Response rebuild(void Function(OkGet200ResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  OkGet200ResponseBuilder toBuilder() =>
      OkGet200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is OkGet200Response && ok == other.ok;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, ok.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'OkGet200Response')..add('ok', ok))
        .toString();
  }
}

class OkGet200ResponseBuilder
    implements Builder<OkGet200Response, OkGet200ResponseBuilder> {
  _$OkGet200Response? _$v;

  bool? _ok;
  bool? get ok => _$this._ok;
  set ok(bool? ok) => _$this._ok = ok;

  OkGet200ResponseBuilder() {
    OkGet200Response._defaults(this);
  }

  OkGet200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _ok = $v.ok;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(OkGet200Response other) {
    _$v = other as _$OkGet200Response;
  }

  @override
  void update(void Function(OkGet200ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  OkGet200Response build() => _build();

  _$OkGet200Response _build() {
    final _$result = _$v ??
        _$OkGet200Response._(
          ok: BuiltValueNullFieldError.checkNotNull(
              ok, r'OkGet200Response', 'ok'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
