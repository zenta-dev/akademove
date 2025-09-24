// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coupon_create_request_rules_user.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$CouponCreateRequestRulesUser extends CouponCreateRequestRulesUser {
  @override
  final bool? newUserOnly;

  factory _$CouponCreateRequestRulesUser([
    void Function(CouponCreateRequestRulesUserBuilder)? updates,
  ]) => (CouponCreateRequestRulesUserBuilder()..update(updates))._build();

  _$CouponCreateRequestRulesUser._({this.newUserOnly}) : super._();
  @override
  CouponCreateRequestRulesUser rebuild(
    void Function(CouponCreateRequestRulesUserBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  CouponCreateRequestRulesUserBuilder toBuilder() =>
      CouponCreateRequestRulesUserBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CouponCreateRequestRulesUser &&
        newUserOnly == other.newUserOnly;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, newUserOnly.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
      r'CouponCreateRequestRulesUser',
    )..add('newUserOnly', newUserOnly)).toString();
  }
}

class CouponCreateRequestRulesUserBuilder
    implements
        Builder<
          CouponCreateRequestRulesUser,
          CouponCreateRequestRulesUserBuilder
        > {
  _$CouponCreateRequestRulesUser? _$v;

  bool? _newUserOnly;
  bool? get newUserOnly => _$this._newUserOnly;
  set newUserOnly(bool? newUserOnly) => _$this._newUserOnly = newUserOnly;

  CouponCreateRequestRulesUserBuilder() {
    CouponCreateRequestRulesUser._defaults(this);
  }

  CouponCreateRequestRulesUserBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _newUserOnly = $v.newUserOnly;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CouponCreateRequestRulesUser other) {
    _$v = other as _$CouponCreateRequestRulesUser;
  }

  @override
  void update(void Function(CouponCreateRequestRulesUserBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CouponCreateRequestRulesUser build() => _build();

  _$CouponCreateRequestRulesUser _build() {
    final _$result =
        _$v ?? _$CouponCreateRequestRulesUser._(newUserOnly: newUserOnly);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
