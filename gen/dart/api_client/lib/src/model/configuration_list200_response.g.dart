// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'configuration_list200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ConfigurationList200Response extends ConfigurationList200Response {
  @override
  final String message;
  @override
  final BuiltList<Configuration> data;

  factory _$ConfigurationList200Response([
    void Function(ConfigurationList200ResponseBuilder)? updates,
  ]) => (ConfigurationList200ResponseBuilder()..update(updates))._build();

  _$ConfigurationList200Response._({required this.message, required this.data})
    : super._();
  @override
  ConfigurationList200Response rebuild(
    void Function(ConfigurationList200ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ConfigurationList200ResponseBuilder toBuilder() =>
      ConfigurationList200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ConfigurationList200Response &&
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
    return (newBuiltValueToStringHelper(r'ConfigurationList200Response')
          ..add('message', message)
          ..add('data', data))
        .toString();
  }
}

class ConfigurationList200ResponseBuilder
    implements
        Builder<
          ConfigurationList200Response,
          ConfigurationList200ResponseBuilder
        > {
  _$ConfigurationList200Response? _$v;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  ListBuilder<Configuration>? _data;
  ListBuilder<Configuration> get data =>
      _$this._data ??= ListBuilder<Configuration>();
  set data(ListBuilder<Configuration>? data) => _$this._data = data;

  ConfigurationList200ResponseBuilder() {
    ConfigurationList200Response._defaults(this);
  }

  ConfigurationList200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _message = $v.message;
      _data = $v.data.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ConfigurationList200Response other) {
    _$v = other as _$ConfigurationList200Response;
  }

  @override
  void update(void Function(ConfigurationList200ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ConfigurationList200Response build() => _build();

  _$ConfigurationList200Response _build() {
    _$ConfigurationList200Response _$result;
    try {
      _$result =
          _$v ??
          _$ConfigurationList200Response._(
            message: BuiltValueNullFieldError.checkNotNull(
              message,
              r'ConfigurationList200Response',
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
          r'ConfigurationList200Response',
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
