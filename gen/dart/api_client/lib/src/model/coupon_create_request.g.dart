// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coupon_create_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$CouponCreateRequest extends CouponCreateRequest {
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
  final num periodStart;
  @override
  final num periodEnd;
  @override
  final bool isActive;

  factory _$CouponCreateRequest([
    void Function(CouponCreateRequestBuilder)? updates,
  ]) => (CouponCreateRequestBuilder()..update(updates))._build();

  _$CouponCreateRequest._({
    required this.name,
    required this.code,
    required this.rules,
    this.discountAmount,
    this.discountPercentage,
    required this.usageLimit,
    required this.periodStart,
    required this.periodEnd,
    required this.isActive,
  }) : super._();
  @override
  CouponCreateRequest rebuild(
    void Function(CouponCreateRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  CouponCreateRequestBuilder toBuilder() =>
      CouponCreateRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CouponCreateRequest &&
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
    return (newBuiltValueToStringHelper(r'CouponCreateRequest')
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

class CouponCreateRequestBuilder
    implements Builder<CouponCreateRequest, CouponCreateRequestBuilder> {
  _$CouponCreateRequest? _$v;

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

  CouponCreateRequestBuilder() {
    CouponCreateRequest._defaults(this);
  }

  CouponCreateRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _name = $v.name;
      _code = $v.code;
      _rules = $v.rules.toBuilder();
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
  void replace(CouponCreateRequest other) {
    _$v = other as _$CouponCreateRequest;
  }

  @override
  void update(void Function(CouponCreateRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CouponCreateRequest build() => _build();

  _$CouponCreateRequest _build() {
    _$CouponCreateRequest _$result;
    try {
      _$result =
          _$v ??
          _$CouponCreateRequest._(
            name: BuiltValueNullFieldError.checkNotNull(
              name,
              r'CouponCreateRequest',
              'name',
            ),
            code: BuiltValueNullFieldError.checkNotNull(
              code,
              r'CouponCreateRequest',
              'code',
            ),
            rules: rules.build(),
            discountAmount: discountAmount,
            discountPercentage: discountPercentage,
            usageLimit: BuiltValueNullFieldError.checkNotNull(
              usageLimit,
              r'CouponCreateRequest',
              'usageLimit',
            ),
            periodStart: BuiltValueNullFieldError.checkNotNull(
              periodStart,
              r'CouponCreateRequest',
              'periodStart',
            ),
            periodEnd: BuiltValueNullFieldError.checkNotNull(
              periodEnd,
              r'CouponCreateRequest',
              'periodEnd',
            ),
            isActive: BuiltValueNullFieldError.checkNotNull(
              isActive,
              r'CouponCreateRequest',
              'isActive',
            ),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'rules';
        rules.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'CouponCreateRequest',
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
