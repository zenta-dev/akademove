// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_promo_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$CreatePromoRequest extends CreatePromoRequest {
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
  final num periodStart;
  @override
  final num periodEnd;
  @override
  final bool isActive;
  @override
  final String createdById;

  factory _$CreatePromoRequest(
          [void Function(CreatePromoRequestBuilder)? updates]) =>
      (CreatePromoRequestBuilder()..update(updates))._build();

  _$CreatePromoRequest._(
      {required this.name,
      required this.code,
      this.rules,
      required this.discountAmount,
      required this.discountPercentage,
      required this.minOrderAmount,
      required this.maxOrderAmount,
      required this.usageLimit,
      required this.periodStart,
      required this.periodEnd,
      required this.isActive,
      required this.createdById})
      : super._();
  @override
  CreatePromoRequest rebuild(
          void Function(CreatePromoRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CreatePromoRequestBuilder toBuilder() =>
      CreatePromoRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CreatePromoRequest &&
        name == other.name &&
        code == other.code &&
        rules == other.rules &&
        discountAmount == other.discountAmount &&
        discountPercentage == other.discountPercentage &&
        minOrderAmount == other.minOrderAmount &&
        maxOrderAmount == other.maxOrderAmount &&
        usageLimit == other.usageLimit &&
        periodStart == other.periodStart &&
        periodEnd == other.periodEnd &&
        isActive == other.isActive &&
        createdById == other.createdById;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, code.hashCode);
    _$hash = $jc(_$hash, rules.hashCode);
    _$hash = $jc(_$hash, discountAmount.hashCode);
    _$hash = $jc(_$hash, discountPercentage.hashCode);
    _$hash = $jc(_$hash, minOrderAmount.hashCode);
    _$hash = $jc(_$hash, maxOrderAmount.hashCode);
    _$hash = $jc(_$hash, usageLimit.hashCode);
    _$hash = $jc(_$hash, periodStart.hashCode);
    _$hash = $jc(_$hash, periodEnd.hashCode);
    _$hash = $jc(_$hash, isActive.hashCode);
    _$hash = $jc(_$hash, createdById.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'CreatePromoRequest')
          ..add('name', name)
          ..add('code', code)
          ..add('rules', rules)
          ..add('discountAmount', discountAmount)
          ..add('discountPercentage', discountPercentage)
          ..add('minOrderAmount', minOrderAmount)
          ..add('maxOrderAmount', maxOrderAmount)
          ..add('usageLimit', usageLimit)
          ..add('periodStart', periodStart)
          ..add('periodEnd', periodEnd)
          ..add('isActive', isActive)
          ..add('createdById', createdById))
        .toString();
  }
}

class CreatePromoRequestBuilder
    implements Builder<CreatePromoRequest, CreatePromoRequestBuilder> {
  _$CreatePromoRequest? _$v;

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

  CreatePromoRequestBuilder() {
    CreatePromoRequest._defaults(this);
  }

  CreatePromoRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _name = $v.name;
      _code = $v.code;
      _rules = $v.rules;
      _discountAmount = $v.discountAmount;
      _discountPercentage = $v.discountPercentage;
      _minOrderAmount = $v.minOrderAmount;
      _maxOrderAmount = $v.maxOrderAmount;
      _usageLimit = $v.usageLimit;
      _periodStart = $v.periodStart;
      _periodEnd = $v.periodEnd;
      _isActive = $v.isActive;
      _createdById = $v.createdById;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CreatePromoRequest other) {
    _$v = other as _$CreatePromoRequest;
  }

  @override
  void update(void Function(CreatePromoRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CreatePromoRequest build() => _build();

  _$CreatePromoRequest _build() {
    final _$result = _$v ??
        _$CreatePromoRequest._(
          name: BuiltValueNullFieldError.checkNotNull(
              name, r'CreatePromoRequest', 'name'),
          code: BuiltValueNullFieldError.checkNotNull(
              code, r'CreatePromoRequest', 'code'),
          rules: rules,
          discountAmount: BuiltValueNullFieldError.checkNotNull(
              discountAmount, r'CreatePromoRequest', 'discountAmount'),
          discountPercentage: BuiltValueNullFieldError.checkNotNull(
              discountPercentage, r'CreatePromoRequest', 'discountPercentage'),
          minOrderAmount: BuiltValueNullFieldError.checkNotNull(
              minOrderAmount, r'CreatePromoRequest', 'minOrderAmount'),
          maxOrderAmount: BuiltValueNullFieldError.checkNotNull(
              maxOrderAmount, r'CreatePromoRequest', 'maxOrderAmount'),
          usageLimit: BuiltValueNullFieldError.checkNotNull(
              usageLimit, r'CreatePromoRequest', 'usageLimit'),
          periodStart: BuiltValueNullFieldError.checkNotNull(
              periodStart, r'CreatePromoRequest', 'periodStart'),
          periodEnd: BuiltValueNullFieldError.checkNotNull(
              periodEnd, r'CreatePromoRequest', 'periodEnd'),
          isActive: BuiltValueNullFieldError.checkNotNull(
              isActive, r'CreatePromoRequest', 'isActive'),
          createdById: BuiltValueNullFieldError.checkNotNull(
              createdById, r'CreatePromoRequest', 'createdById'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
