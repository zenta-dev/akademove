// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coupon.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$Coupon extends Coupon {
  @override
  final String id;
  @override
  final String name;
  @override
  final String code;
  @override
  final CouponCreateRequestRules rules;
  @override
  final num? discountAmount;
  @override
  final num? discountPercentage;
  @override
  final num usageLimit;
  @override
  final num usedCount;
  @override
  final num periodStart;
  @override
  final num periodEnd;
  @override
  final bool isActive;
  @override
  final String createdById;
  @override
  final num createdAt;

  factory _$Coupon([void Function(CouponBuilder)? updates]) =>
      (CouponBuilder()..update(updates))._build();

  _$Coupon._({
    required this.id,
    required this.name,
    required this.code,
    required this.rules,
    this.discountAmount,
    this.discountPercentage,
    required this.usageLimit,
    required this.usedCount,
    required this.periodStart,
    required this.periodEnd,
    required this.isActive,
    required this.createdById,
    required this.createdAt,
  }) : super._();
  @override
  Coupon rebuild(void Function(CouponBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CouponBuilder toBuilder() => CouponBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Coupon &&
        id == other.id &&
        name == other.name &&
        code == other.code &&
        rules == other.rules &&
        discountAmount == other.discountAmount &&
        discountPercentage == other.discountPercentage &&
        usageLimit == other.usageLimit &&
        usedCount == other.usedCount &&
        periodStart == other.periodStart &&
        periodEnd == other.periodEnd &&
        isActive == other.isActive &&
        createdById == other.createdById &&
        createdAt == other.createdAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, code.hashCode);
    _$hash = $jc(_$hash, rules.hashCode);
    _$hash = $jc(_$hash, discountAmount.hashCode);
    _$hash = $jc(_$hash, discountPercentage.hashCode);
    _$hash = $jc(_$hash, usageLimit.hashCode);
    _$hash = $jc(_$hash, usedCount.hashCode);
    _$hash = $jc(_$hash, periodStart.hashCode);
    _$hash = $jc(_$hash, periodEnd.hashCode);
    _$hash = $jc(_$hash, isActive.hashCode);
    _$hash = $jc(_$hash, createdById.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Coupon')
          ..add('id', id)
          ..add('name', name)
          ..add('code', code)
          ..add('rules', rules)
          ..add('discountAmount', discountAmount)
          ..add('discountPercentage', discountPercentage)
          ..add('usageLimit', usageLimit)
          ..add('usedCount', usedCount)
          ..add('periodStart', periodStart)
          ..add('periodEnd', periodEnd)
          ..add('isActive', isActive)
          ..add('createdById', createdById)
          ..add('createdAt', createdAt))
        .toString();
  }
}

class CouponBuilder implements Builder<Coupon, CouponBuilder> {
  _$Coupon? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _code;
  String? get code => _$this._code;
  set code(String? code) => _$this._code = code;

  CouponCreateRequestRulesBuilder? _rules;
  CouponCreateRequestRulesBuilder get rules =>
      _$this._rules ??= CouponCreateRequestRulesBuilder();
  set rules(CouponCreateRequestRulesBuilder? rules) => _$this._rules = rules;

  num? _discountAmount;
  num? get discountAmount => _$this._discountAmount;
  set discountAmount(num? discountAmount) =>
      _$this._discountAmount = discountAmount;

  num? _discountPercentage;
  num? get discountPercentage => _$this._discountPercentage;
  set discountPercentage(num? discountPercentage) =>
      _$this._discountPercentage = discountPercentage;

  num? _usageLimit;
  num? get usageLimit => _$this._usageLimit;
  set usageLimit(num? usageLimit) => _$this._usageLimit = usageLimit;

  num? _usedCount;
  num? get usedCount => _$this._usedCount;
  set usedCount(num? usedCount) => _$this._usedCount = usedCount;

  num? _periodStart;
  num? get periodStart => _$this._periodStart;
  set periodStart(num? periodStart) => _$this._periodStart = periodStart;

  num? _periodEnd;
  num? get periodEnd => _$this._periodEnd;
  set periodEnd(num? periodEnd) => _$this._periodEnd = periodEnd;

  bool? _isActive;
  bool? get isActive => _$this._isActive;
  set isActive(bool? isActive) => _$this._isActive = isActive;

  String? _createdById;
  String? get createdById => _$this._createdById;
  set createdById(String? createdById) => _$this._createdById = createdById;

  num? _createdAt;
  num? get createdAt => _$this._createdAt;
  set createdAt(num? createdAt) => _$this._createdAt = createdAt;

  CouponBuilder() {
    Coupon._defaults(this);
  }

  CouponBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _name = $v.name;
      _code = $v.code;
      _rules = $v.rules.toBuilder();
      _discountAmount = $v.discountAmount;
      _discountPercentage = $v.discountPercentage;
      _usageLimit = $v.usageLimit;
      _usedCount = $v.usedCount;
      _periodStart = $v.periodStart;
      _periodEnd = $v.periodEnd;
      _isActive = $v.isActive;
      _createdById = $v.createdById;
      _createdAt = $v.createdAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Coupon other) {
    _$v = other as _$Coupon;
  }

  @override
  void update(void Function(CouponBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Coupon build() => _build();

  _$Coupon _build() {
    _$Coupon _$result;
    try {
      _$result =
          _$v ??
          _$Coupon._(
            id: BuiltValueNullFieldError.checkNotNull(id, r'Coupon', 'id'),
            name: BuiltValueNullFieldError.checkNotNull(
              name,
              r'Coupon',
              'name',
            ),
            code: BuiltValueNullFieldError.checkNotNull(
              code,
              r'Coupon',
              'code',
            ),
            rules: rules.build(),
            discountAmount: discountAmount,
            discountPercentage: discountPercentage,
            usageLimit: BuiltValueNullFieldError.checkNotNull(
              usageLimit,
              r'Coupon',
              'usageLimit',
            ),
            usedCount: BuiltValueNullFieldError.checkNotNull(
              usedCount,
              r'Coupon',
              'usedCount',
            ),
            periodStart: BuiltValueNullFieldError.checkNotNull(
              periodStart,
              r'Coupon',
              'periodStart',
            ),
            periodEnd: BuiltValueNullFieldError.checkNotNull(
              periodEnd,
              r'Coupon',
              'periodEnd',
            ),
            isActive: BuiltValueNullFieldError.checkNotNull(
              isActive,
              r'Coupon',
              'isActive',
            ),
            createdById: BuiltValueNullFieldError.checkNotNull(
              createdById,
              r'Coupon',
              'createdById',
            ),
            createdAt: BuiltValueNullFieldError.checkNotNull(
              createdAt,
              r'Coupon',
              'createdAt',
            ),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'rules';
        rules.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'Coupon',
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
