// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coupon_update_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$CouponUpdateRequest extends CouponUpdateRequest {
  @override
  final String? name;
  @override
  final String? code;
  @override
  final CouponCreateRequestRules? rules;
  @override
  final num? discountAmount;
  @override
  final num? discountPercentage;
  @override
  final num? usageLimit;
  @override
  final num? periodStart;
  @override
  final num? periodEnd;
  @override
  final bool? isActive;

  factory _$CouponUpdateRequest([
    void Function(CouponUpdateRequestBuilder)? updates,
  ]) => (CouponUpdateRequestBuilder()..update(updates))._build();

  _$CouponUpdateRequest._({
    this.name,
    this.code,
    this.rules,
    this.discountAmount,
    this.discountPercentage,
    this.usageLimit,
    this.periodStart,
    this.periodEnd,
    this.isActive,
  }) : super._();
  @override
  CouponUpdateRequest rebuild(
    void Function(CouponUpdateRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  CouponUpdateRequestBuilder toBuilder() =>
      CouponUpdateRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CouponUpdateRequest &&
        name == other.name &&
        code == other.code &&
        rules == other.rules &&
        discountAmount == other.discountAmount &&
        discountPercentage == other.discountPercentage &&
        usageLimit == other.usageLimit &&
        periodStart == other.periodStart &&
        periodEnd == other.periodEnd &&
        isActive == other.isActive;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, code.hashCode);
    _$hash = $jc(_$hash, rules.hashCode);
    _$hash = $jc(_$hash, discountAmount.hashCode);
    _$hash = $jc(_$hash, discountPercentage.hashCode);
    _$hash = $jc(_$hash, usageLimit.hashCode);
    _$hash = $jc(_$hash, periodStart.hashCode);
    _$hash = $jc(_$hash, periodEnd.hashCode);
    _$hash = $jc(_$hash, isActive.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'CouponUpdateRequest')
          ..add('name', name)
          ..add('code', code)
          ..add('rules', rules)
          ..add('discountAmount', discountAmount)
          ..add('discountPercentage', discountPercentage)
          ..add('usageLimit', usageLimit)
          ..add('periodStart', periodStart)
          ..add('periodEnd', periodEnd)
          ..add('isActive', isActive))
        .toString();
  }
}

class CouponUpdateRequestBuilder
    implements Builder<CouponUpdateRequest, CouponUpdateRequestBuilder> {
  _$CouponUpdateRequest? _$v;

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

  num? _periodStart;
  num? get periodStart => _$this._periodStart;
  set periodStart(num? periodStart) => _$this._periodStart = periodStart;

  num? _periodEnd;
  num? get periodEnd => _$this._periodEnd;
  set periodEnd(num? periodEnd) => _$this._periodEnd = periodEnd;

  bool? _isActive;
  bool? get isActive => _$this._isActive;
  set isActive(bool? isActive) => _$this._isActive = isActive;

  CouponUpdateRequestBuilder() {
    CouponUpdateRequest._defaults(this);
  }

  CouponUpdateRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _name = $v.name;
      _code = $v.code;
      _rules = $v.rules?.toBuilder();
      _discountAmount = $v.discountAmount;
      _discountPercentage = $v.discountPercentage;
      _usageLimit = $v.usageLimit;
      _periodStart = $v.periodStart;
      _periodEnd = $v.periodEnd;
      _isActive = $v.isActive;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CouponUpdateRequest other) {
    _$v = other as _$CouponUpdateRequest;
  }

  @override
  void update(void Function(CouponUpdateRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CouponUpdateRequest build() => _build();

  _$CouponUpdateRequest _build() {
    _$CouponUpdateRequest _$result;
    try {
      _$result =
          _$v ??
          _$CouponUpdateRequest._(
            name: name,
            code: code,
            rules: _rules?.build(),
            discountAmount: discountAmount,
            discountPercentage: discountPercentage,
            usageLimit: usageLimit,
            periodStart: periodStart,
            periodEnd: periodEnd,
            isActive: isActive,
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'rules';
        _rules?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'CouponUpdateRequest',
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
