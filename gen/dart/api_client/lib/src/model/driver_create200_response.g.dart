// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'driver_create200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$DriverCreate200Response extends DriverCreate200Response {
  @override
  final String message;
  @override
  final Driver data;

  factory _$DriverCreate200Response([
    void Function(DriverCreate200ResponseBuilder)? updates,
  ]) => (DriverCreate200ResponseBuilder()..update(updates))._build();

  _$DriverCreate200Response._({required this.message, required this.data})
    : super._();
  @override
  DriverCreate200Response rebuild(
    void Function(DriverCreate200ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  DriverCreate200ResponseBuilder toBuilder() =>
      DriverCreate200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is DriverCreate200Response &&
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
    return (newBuiltValueToStringHelper(r'DriverCreate200Response')
          ..add('message', message)
          ..add('data', data))
        .toString();
  }
}

class DriverCreate200ResponseBuilder
    implements
        Builder<DriverCreate200Response, DriverCreate200ResponseBuilder> {
  _$DriverCreate200Response? _$v;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  DriverBuilder? _data;
  DriverBuilder get data => _$this._data ??= DriverBuilder();
  set data(DriverBuilder? data) => _$this._data = data;

  DriverCreate200ResponseBuilder() {
    DriverCreate200Response._defaults(this);
  }

  DriverCreate200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _message = $v.message;
      _data = $v.data.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(DriverCreate200Response other) {
    _$v = other as _$DriverCreate200Response;
  }

  @override
  void update(void Function(DriverCreate200ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  DriverCreate200Response build() => _build();

  _$DriverCreate200Response _build() {
    _$DriverCreate200Response _$result;
    try {
      _$result =
          _$v ??
          _$DriverCreate200Response._(
            message: BuiltValueNullFieldError.checkNotNull(
              message,
              r'DriverCreate200Response',
              'message',
            ),
            data: data.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'DriverCreate200Response',
          _$failedField,
          e.toString(),
        );
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
