// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'driver_list200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$DriverList200Response extends DriverList200Response {
  @override
  final String message;
  @override
  final BuiltList<Driver> data;

  factory _$DriverList200Response([
    void Function(DriverList200ResponseBuilder)? updates,
  ]) => (DriverList200ResponseBuilder()..update(updates))._build();

  _$DriverList200Response._({required this.message, required this.data})
    : super._();
  @override
  DriverList200Response rebuild(
    void Function(DriverList200ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  DriverList200ResponseBuilder toBuilder() =>
      DriverList200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is DriverList200Response &&
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
    return (newBuiltValueToStringHelper(r'DriverList200Response')
          ..add('message', message)
          ..add('data', data))
        .toString();
  }
}

class DriverList200ResponseBuilder
    implements Builder<DriverList200Response, DriverList200ResponseBuilder> {
  _$DriverList200Response? _$v;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  ListBuilder<Driver>? _data;
  ListBuilder<Driver> get data => _$this._data ??= ListBuilder<Driver>();
  set data(ListBuilder<Driver>? data) => _$this._data = data;

  DriverList200ResponseBuilder() {
    DriverList200Response._defaults(this);
  }

  DriverList200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _message = $v.message;
      _data = $v.data.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(DriverList200Response other) {
    _$v = other as _$DriverList200Response;
  }

  @override
  void update(void Function(DriverList200ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  DriverList200Response build() => _build();

  _$DriverList200Response _build() {
    _$DriverList200Response _$result;
    try {
      _$result =
          _$v ??
          _$DriverList200Response._(
            message: BuiltValueNullFieldError.checkNotNull(
              message,
              r'DriverList200Response',
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
          r'DriverList200Response',
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
