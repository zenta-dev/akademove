// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verification.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$Verification extends Verification {
  @override
  final String identifier;
  @override
  final String value;
  @override
  final String expiresAt;
  @override
  final String createdAt;
  @override
  final String updatedAt;
  @override
  final String? id;

  factory _$Verification([void Function(VerificationBuilder)? updates]) =>
      (VerificationBuilder()..update(updates))._build();

  _$Verification._(
      {required this.identifier,
      required this.value,
      required this.expiresAt,
      required this.createdAt,
      required this.updatedAt,
      this.id})
      : super._();
  @override
  Verification rebuild(void Function(VerificationBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  VerificationBuilder toBuilder() => VerificationBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Verification &&
        identifier == other.identifier &&
        value == other.value &&
        expiresAt == other.expiresAt &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt &&
        id == other.id;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, identifier.hashCode);
    _$hash = $jc(_$hash, value.hashCode);
    _$hash = $jc(_$hash, expiresAt.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, updatedAt.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Verification')
          ..add('identifier', identifier)
          ..add('value', value)
          ..add('expiresAt', expiresAt)
          ..add('createdAt', createdAt)
          ..add('updatedAt', updatedAt)
          ..add('id', id))
        .toString();
  }
}

class VerificationBuilder
    implements Builder<Verification, VerificationBuilder> {
  _$Verification? _$v;

  String? _identifier;
  String? get identifier => _$this._identifier;
  set identifier(String? identifier) => _$this._identifier = identifier;

  String? _value;
  String? get value => _$this._value;
  set value(String? value) => _$this._value = value;

  String? _expiresAt;
  String? get expiresAt => _$this._expiresAt;
  set expiresAt(String? expiresAt) => _$this._expiresAt = expiresAt;

  String? _createdAt;
  String? get createdAt => _$this._createdAt;
  set createdAt(String? createdAt) => _$this._createdAt = createdAt;

  String? _updatedAt;
  String? get updatedAt => _$this._updatedAt;
  set updatedAt(String? updatedAt) => _$this._updatedAt = updatedAt;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  VerificationBuilder() {
    Verification._defaults(this);
  }

  VerificationBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _identifier = $v.identifier;
      _value = $v.value;
      _expiresAt = $v.expiresAt;
      _createdAt = $v.createdAt;
      _updatedAt = $v.updatedAt;
      _id = $v.id;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Verification other) {
    _$v = other as _$Verification;
  }

  @override
  void update(void Function(VerificationBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Verification build() => _build();

  _$Verification _build() {
    final _$result = _$v ??
        _$Verification._(
          identifier: BuiltValueNullFieldError.checkNotNull(
              identifier, r'Verification', 'identifier'),
          value: BuiltValueNullFieldError.checkNotNull(
              value, r'Verification', 'value'),
          expiresAt: BuiltValueNullFieldError.checkNotNull(
              expiresAt, r'Verification', 'expiresAt'),
          createdAt: BuiltValueNullFieldError.checkNotNull(
              createdAt, r'Verification', 'createdAt'),
          updatedAt: BuiltValueNullFieldError.checkNotNull(
              updatedAt, r'Verification', 'updatedAt'),
          id: id,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
