// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'promo.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$Promo extends Promo {
  @override
  final String id;
  @override
  final String name;
  @override
  final String code;
  @override
  final JsonObject? rules;
  @override
  final num discountAmount;
  @override
  final num discountPercentage;
  @override
  final num minOrderAmount;
  @override
  final num maxOrderAmount;
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

  factory _$Promo([void Function(PromoBuilder)? updates]) =>
      (PromoBuilder()..update(updates))._build();

  _$Promo._(
      {required this.id,
      required this.name,
      required this.code,
      this.rules,
      required this.discountAmount,
      required this.discountPercentage,
      required this.minOrderAmount,
      required this.maxOrderAmount,
      required this.usageLimit,
      required this.usedCount,
      required this.periodStart,
      required this.periodEnd,
      required this.isActive,
      required this.createdById,
      required this.createdAt})
      : super._();
  @override
  Promo rebuild(void Function(PromoBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  PromoBuilder toBuilder() => PromoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Promo &&
        id == other.id &&
        name == other.name &&
        code == other.code &&
        rules == other.rules &&
        discountAmount == other.discountAmount &&
        discountPercentage == other.discountPercentage &&
        minOrderAmount == other.minOrderAmount &&
        maxOrderAmount == other.maxOrderAmount &&
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
    _$hash = $jc(_$hash, minOrderAmount.hashCode);
    _$hash = $jc(_$hash, maxOrderAmount.hashCode);
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
    return (newBuiltValueToStringHelper(r'Promo')
          ..add('id', id)
          ..add('name', name)
          ..add('code', code)
          ..add('rules', rules)
          ..add('discountAmount', discountAmount)
          ..add('discountPercentage', discountPercentage)
          ..add('minOrderAmount', minOrderAmount)
          ..add('maxOrderAmount', maxOrderAmount)
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

class PromoBuilder implements Builder<Promo, PromoBuilder> {
  _$Promo? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _code;
  String? get code => _$this._code;
  set code(String? code) => _$this._code = code;

  JsonObject? _rules;
  JsonObject? get rules => _$this._rules;
  set rules(JsonObject? rules) => _$this._rules = rules;

  num? _discountAmount;
  num? get discountAmount => _$this._discountAmount;
  set discountAmount(num? discountAmount) =>
      _$this._discountAmount = discountAmount;

  num? _discountPercentage;
  num? get discountPercentage => _$this._discountPercentage;
  set discountPercentage(num? discountPercentage) =>
      _$this._discountPercentage = discountPercentage;

  num? _minOrderAmount;
  num? get minOrderAmount => _$this._minOrderAmount;
  set minOrderAmount(num? minOrderAmount) =>
      _$this._minOrderAmount = minOrderAmount;

  num? _maxOrderAmount;
  num? get maxOrderAmount => _$this._maxOrderAmount;
  set maxOrderAmount(num? maxOrderAmount) =>
      _$this._maxOrderAmount = maxOrderAmount;

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

  PromoBuilder() {
    Promo._defaults(this);
  }

  PromoBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _name = $v.name;
      _code = $v.code;
      _rules = $v.rules;
      _discountAmount = $v.discountAmount;
      _discountPercentage = $v.discountPercentage;
      _minOrderAmount = $v.minOrderAmount;
      _maxOrderAmount = $v.maxOrderAmount;
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
  void replace(Promo other) {
    _$v = other as _$Promo;
  }

  @override
  void update(void Function(PromoBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Promo build() => _build();

  _$Promo _build() {
    final _$result = _$v ??
        _$Promo._(
          id: BuiltValueNullFieldError.checkNotNull(id, r'Promo', 'id'),
          name: BuiltValueNullFieldError.checkNotNull(name, r'Promo', 'name'),
          code: BuiltValueNullFieldError.checkNotNull(code, r'Promo', 'code'),
          rules: rules,
          discountAmount: BuiltValueNullFieldError.checkNotNull(
              discountAmount, r'Promo', 'discountAmount'),
          discountPercentage: BuiltValueNullFieldError.checkNotNull(
              discountPercentage, r'Promo', 'discountPercentage'),
          minOrderAmount: BuiltValueNullFieldError.checkNotNull(
              minOrderAmount, r'Promo', 'minOrderAmount'),
          maxOrderAmount: BuiltValueNullFieldError.checkNotNull(
              maxOrderAmount, r'Promo', 'maxOrderAmount'),
          usageLimit: BuiltValueNullFieldError.checkNotNull(
              usageLimit, r'Promo', 'usageLimit'),
          usedCount: BuiltValueNullFieldError.checkNotNull(
              usedCount, r'Promo', 'usedCount'),
          periodStart: BuiltValueNullFieldError.checkNotNull(
              periodStart, r'Promo', 'periodStart'),
          periodEnd: BuiltValueNullFieldError.checkNotNull(
              periodEnd, r'Promo', 'periodEnd'),
          isActive: BuiltValueNullFieldError.checkNotNull(
              isActive, r'Promo', 'isActive'),
          createdById: BuiltValueNullFieldError.checkNotNull(
              createdById, r'Promo', 'createdById'),
          createdAt: BuiltValueNullFieldError.checkNotNull(
              createdAt, r'Promo', 'createdAt'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
