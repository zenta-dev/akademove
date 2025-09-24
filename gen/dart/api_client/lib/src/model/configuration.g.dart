// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'configuration.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$Configuration extends Configuration {
  @override
  final String key;
  @override
  final String name;
  @override
  final JsonObject? value;
  @override
  final String? description;
  @override
  final String updatedById;
  @override
  final num updatedAt;

  factory _$Configuration([void Function(ConfigurationBuilder)? updates]) =>
      (ConfigurationBuilder()..update(updates))._build();

  _$Configuration._({
    required this.key,
    required this.name,
    this.value,
    this.description,
    required this.updatedById,
    required this.updatedAt,
  }) : super._();
  @override
  Configuration rebuild(void Function(ConfigurationBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ConfigurationBuilder toBuilder() => ConfigurationBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Configuration &&
        key == other.key &&
        name == other.name &&
        value == other.value &&
        description == other.description &&
        updatedById == other.updatedById &&
        updatedAt == other.updatedAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, key.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, value.hashCode);
    _$hash = $jc(_$hash, description.hashCode);
    _$hash = $jc(_$hash, updatedById.hashCode);
    _$hash = $jc(_$hash, updatedAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Configuration')
          ..add('key', key)
          ..add('name', name)
          ..add('value', value)
          ..add('description', description)
          ..add('updatedById', updatedById)
          ..add('updatedAt', updatedAt))
        .toString();
  }
}

class ConfigurationBuilder
    implements Builder<Configuration, ConfigurationBuilder> {
  _$Configuration? _$v;

  String? _key;
  String? get key => _$this._key;
  set key(String? key) => _$this._key = key;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  JsonObject? _value;
  JsonObject? get value => _$this._value;
  set value(JsonObject? value) => _$this._value = value;

  String? _description;
  String? get description => _$this._description;
  set description(String? description) => _$this._description = description;

  String? _updatedById;
  String? get updatedById => _$this._updatedById;
  set updatedById(String? updatedById) => _$this._updatedById = updatedById;

  num? _updatedAt;
  num? get updatedAt => _$this._updatedAt;
  set updatedAt(num? updatedAt) => _$this._updatedAt = updatedAt;

  ConfigurationBuilder() {
    Configuration._defaults(this);
  }

  ConfigurationBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _key = $v.key;
      _name = $v.name;
      _value = $v.value;
      _description = $v.description;
      _updatedById = $v.updatedById;
      _updatedAt = $v.updatedAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Configuration other) {
    _$v = other as _$Configuration;
  }

  @override
  void update(void Function(ConfigurationBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Configuration build() => _build();

  _$Configuration _build() {
    final _$result =
        _$v ??
        _$Configuration._(
          key: BuiltValueNullFieldError.checkNotNull(
            key,
            r'Configuration',
            'key',
          ),
          name: BuiltValueNullFieldError.checkNotNull(
            name,
            r'Configuration',
            'name',
          ),
          value: value,
          description: description,
          updatedById: BuiltValueNullFieldError.checkNotNull(
            updatedById,
            r'Configuration',
            'updatedById',
          ),
          updatedAt: BuiltValueNullFieldError.checkNotNull(
            updatedAt,
            r'Configuration',
            'updatedAt',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
