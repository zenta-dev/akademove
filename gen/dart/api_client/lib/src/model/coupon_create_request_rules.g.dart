// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coupon_create_request_rules.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$CouponCreateRequestRules extends CouponCreateRequestRules {
  @override
  final CouponCreateRequestRulesGeneral? general;
  @override
  final CouponCreateRequestRulesUser? user;
  @override
  final CouponCreateRequestRulesTime? time;

  factory _$CouponCreateRequestRules([
    void Function(CouponCreateRequestRulesBuilder)? updates,
  ]) => (CouponCreateRequestRulesBuilder()..update(updates))._build();

  _$CouponCreateRequestRules._({this.general, this.user, this.time})
    : super._();
  @override
  CouponCreateRequestRules rebuild(
    void Function(CouponCreateRequestRulesBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  CouponCreateRequestRulesBuilder toBuilder() =>
      CouponCreateRequestRulesBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CouponCreateRequestRules &&
        general == other.general &&
        user == other.user &&
        time == other.time;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, general.hashCode);
    _$hash = $jc(_$hash, user.hashCode);
    _$hash = $jc(_$hash, time.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'CouponCreateRequestRules')
          ..add('general', general)
          ..add('user', user)
          ..add('time', time))
        .toString();
  }
}

class CouponCreateRequestRulesBuilder
    implements
        Builder<CouponCreateRequestRules, CouponCreateRequestRulesBuilder> {
  _$CouponCreateRequestRules? _$v;

  CouponCreateRequestRulesGeneralBuilder? _general;
  CouponCreateRequestRulesGeneralBuilder get general =>
      _$this._general ??= CouponCreateRequestRulesGeneralBuilder();
  set general(CouponCreateRequestRulesGeneralBuilder? general) =>
      _$this._general = general;

  CouponCreateRequestRulesUserBuilder? _user;
  CouponCreateRequestRulesUserBuilder get user =>
      _$this._user ??= CouponCreateRequestRulesUserBuilder();
  set user(CouponCreateRequestRulesUserBuilder? user) => _$this._user = user;

  CouponCreateRequestRulesTimeBuilder? _time;
  CouponCreateRequestRulesTimeBuilder get time =>
      _$this._time ??= CouponCreateRequestRulesTimeBuilder();
  set time(CouponCreateRequestRulesTimeBuilder? time) => _$this._time = time;

  CouponCreateRequestRulesBuilder() {
    CouponCreateRequestRules._defaults(this);
  }

  CouponCreateRequestRulesBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _general = $v.general?.toBuilder();
      _user = $v.user?.toBuilder();
      _time = $v.time?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CouponCreateRequestRules other) {
    _$v = other as _$CouponCreateRequestRules;
  }

  @override
  void update(void Function(CouponCreateRequestRulesBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CouponCreateRequestRules build() => _build();

  _$CouponCreateRequestRules _build() {
    _$CouponCreateRequestRules _$result;
    try {
      _$result =
          _$v ??
          _$CouponCreateRequestRules._(
            general: _general?.build(),
            user: _user?.build(),
            time: _time?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'general';
        _general?.build();
        _$failedField = 'user';
        _user?.build();
        _$failedField = 'time';
        _time?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'CouponCreateRequestRules',
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
