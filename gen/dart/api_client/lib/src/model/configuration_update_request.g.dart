// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'configuration_update_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ConfigurationUpdateRequest extends ConfigurationUpdateRequest {
  @override
  final String? name;
  @override
  final JsonObject? value;
  @override
  final String? description;

  factory _$ConfigurationUpdateRequest([
    void Function(ConfigurationUpdateRequestBuilder)? updates,
  ]) => (ConfigurationUpdateRequestBuilder()..update(updates))._build();

  _$ConfigurationUpdateRequest._({this.name, this.value, this.description})
    : super._();
  @override
  ConfigurationUpdateRequest rebuild(
    void Function(ConfigurationUpdateRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ConfigurationUpdateRequestBuilder toBuilder() =>
      ConfigurationUpdateRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ConfigurationUpdateRequest &&
        name == other.name &&
        value == other.value &&
        description == other.description;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, value.hashCode);
    _$hash = $jc(_$hash, description.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ConfigurationUpdateRequest')
          ..add('name', name)
          ..add('value', value)
          ..add('description', description))
        .toString();
  }
}

class ConfigurationUpdateRequestBuilder
    implements
        Builder<ConfigurationUpdateRequest, ConfigurationUpdateRequestBuilder> {
  _$ConfigurationUpdateRequest? _$v;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  JsonObject? _value;
  JsonObject? get value => _$this._value;
  set value(JsonObject? value) => _$this._value = value;

  String? _description;
  String? get description => _$this._description;
  set description(String? description) => _$this._description = description;

  ConfigurationUpdateRequestBuilder() {
    ConfigurationUpdateRequest._defaults(this);
  }

  ConfigurationUpdateRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _name = $v.name;
      _value = $v.value;
      _description = $v.description;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ConfigurationUpdateRequest other) {
    _$v = other as _$ConfigurationUpdateRequest;
  }

  @override
  void update(void Function(ConfigurationUpdateRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ConfigurationUpdateRequest build() => _build();

  _$ConfigurationUpdateRequest _build() {
    final _$result =
        _$v ??
        _$ConfigurationUpdateRequest._(
          name: name,
          value: value,
          description: description,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
