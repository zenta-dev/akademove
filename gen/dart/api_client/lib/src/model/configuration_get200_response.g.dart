// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'configuration_get200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ConfigurationGet200Response extends ConfigurationGet200Response {
  @override
  final String message;
  @override
  final Configuration data;

  factory _$ConfigurationGet200Response([
    void Function(ConfigurationGet200ResponseBuilder)? updates,
  ]) => (ConfigurationGet200ResponseBuilder()..update(updates))._build();

  _$ConfigurationGet200Response._({required this.message, required this.data})
    : super._();
  @override
  ConfigurationGet200Response rebuild(
    void Function(ConfigurationGet200ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ConfigurationGet200ResponseBuilder toBuilder() =>
      ConfigurationGet200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ConfigurationGet200Response &&
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
    return (newBuiltValueToStringHelper(r'ConfigurationGet200Response')
          ..add('message', message)
          ..add('data', data))
        .toString();
  }
}

class ConfigurationGet200ResponseBuilder
    implements
        Builder<
          ConfigurationGet200Response,
          ConfigurationGet200ResponseBuilder
        > {
  _$ConfigurationGet200Response? _$v;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  ConfigurationBuilder? _data;
  ConfigurationBuilder get data => _$this._data ??= ConfigurationBuilder();
  set data(ConfigurationBuilder? data) => _$this._data = data;

  ConfigurationGet200ResponseBuilder() {
    ConfigurationGet200Response._defaults(this);
  }

  ConfigurationGet200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _message = $v.message;
      _data = $v.data.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ConfigurationGet200Response other) {
    _$v = other as _$ConfigurationGet200Response;
  }

  @override
  void update(void Function(ConfigurationGet200ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ConfigurationGet200Response build() => _build();

  _$ConfigurationGet200Response _build() {
    _$ConfigurationGet200Response _$result;
    try {
      _$result =
          _$v ??
          _$ConfigurationGet200Response._(
            message: BuiltValueNullFieldError.checkNotNull(
              message,
              r'ConfigurationGet200Response',
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
          r'ConfigurationGet200Response',
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
