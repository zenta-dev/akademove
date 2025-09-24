// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'driver_remove200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$DriverRemove200Response extends DriverRemove200Response {
  @override
  final String message;
  @override
  final JsonObject? data;

  factory _$DriverRemove200Response([
    void Function(DriverRemove200ResponseBuilder)? updates,
  ]) => (DriverRemove200ResponseBuilder()..update(updates))._build();

  _$DriverRemove200Response._({required this.message, this.data}) : super._();
  @override
  DriverRemove200Response rebuild(
    void Function(DriverRemove200ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  DriverRemove200ResponseBuilder toBuilder() =>
      DriverRemove200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is DriverRemove200Response &&
        message == other.message &&
        data == other.data;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, message.hashCode);
    _$hash = $jc(_$hash, data.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'DriverRemove200Response')
          ..add('message', message)
          ..add('data', data))
        .toString();
  }
}

class DriverRemove200ResponseBuilder
    implements
        Builder<DriverRemove200Response, DriverRemove200ResponseBuilder> {
  _$DriverRemove200Response? _$v;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  JsonObject? _data;
  JsonObject? get data => _$this._data;
  set data(JsonObject? data) => _$this._data = data;

  DriverRemove200ResponseBuilder() {
    DriverRemove200Response._defaults(this);
  }

  DriverRemove200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _message = $v.message;
      _data = $v.data;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(DriverRemove200Response other) {
    _$v = other as _$DriverRemove200Response;
  }

  @override
  void update(void Function(DriverRemove200ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  DriverRemove200Response build() => _build();

  _$DriverRemove200Response _build() {
    final _$result =
        _$v ??
        _$DriverRemove200Response._(
          message: BuiltValueNullFieldError.checkNotNull(
            message,
            r'DriverRemove200Response',
            'message',
          ),
          data: data,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
