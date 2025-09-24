// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coupon_create_request_rules_general.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const CouponCreateRequestRulesGeneralTypeEnum
_$couponCreateRequestRulesGeneralTypeEnum_percentage =
    const CouponCreateRequestRulesGeneralTypeEnum._('percentage');
const CouponCreateRequestRulesGeneralTypeEnum
_$couponCreateRequestRulesGeneralTypeEnum_fixed =
    const CouponCreateRequestRulesGeneralTypeEnum._('fixed');

CouponCreateRequestRulesGeneralTypeEnum
_$couponCreateRequestRulesGeneralTypeEnumValueOf(String name) {
  switch (name) {
    case 'percentage':
      return _$couponCreateRequestRulesGeneralTypeEnum_percentage;
    case 'fixed':
      return _$couponCreateRequestRulesGeneralTypeEnum_fixed;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<CouponCreateRequestRulesGeneralTypeEnum>
_$couponCreateRequestRulesGeneralTypeEnumValues =
    BuiltSet<CouponCreateRequestRulesGeneralTypeEnum>(
      const <CouponCreateRequestRulesGeneralTypeEnum>[
        _$couponCreateRequestRulesGeneralTypeEnum_percentage,
        _$couponCreateRequestRulesGeneralTypeEnum_fixed,
      ],
    );

Serializer<CouponCreateRequestRulesGeneralTypeEnum>
_$couponCreateRequestRulesGeneralTypeEnumSerializer =
    _$CouponCreateRequestRulesGeneralTypeEnumSerializer();

class _$CouponCreateRequestRulesGeneralTypeEnumSerializer
    implements PrimitiveSerializer<CouponCreateRequestRulesGeneralTypeEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'percentage': 'percentage',
    'fixed': 'fixed',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'percentage': 'percentage',
    'fixed': 'fixed',
  };

  @override
  final Iterable<Type> types = const <Type>[
    CouponCreateRequestRulesGeneralTypeEnum,
  ];
  @override
  final String wireName = 'CouponCreateRequestRulesGeneralTypeEnum';

  @override
  Object serialize(
    Serializers serializers,
    CouponCreateRequestRulesGeneralTypeEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  CouponCreateRequestRulesGeneralTypeEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => CouponCreateRequestRulesGeneralTypeEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$CouponCreateRequestRulesGeneral
    extends CouponCreateRequestRulesGeneral {
  @override
  final CouponCreateRequestRulesGeneralTypeEnum? type;
  @override
  final num? minOrderAmount;
  @override
  final num? maxDiscountAmount;

  factory _$CouponCreateRequestRulesGeneral([
    void Function(CouponCreateRequestRulesGeneralBuilder)? updates,
  ]) => (CouponCreateRequestRulesGeneralBuilder()..update(updates))._build();

  _$CouponCreateRequestRulesGeneral._({
    this.type,
    this.minOrderAmount,
    this.maxDiscountAmount,
  }) : super._();
  @override
  CouponCreateRequestRulesGeneral rebuild(
    void Function(CouponCreateRequestRulesGeneralBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  CouponCreateRequestRulesGeneralBuilder toBuilder() =>
      CouponCreateRequestRulesGeneralBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CouponCreateRequestRulesGeneral &&
        type == other.type &&
        minOrderAmount == other.minOrderAmount &&
        maxDiscountAmount == other.maxDiscountAmount;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, type.hashCode);
    _$hash = $jc(_$hash, minOrderAmount.hashCode);
    _$hash = $jc(_$hash, maxDiscountAmount.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'CouponCreateRequestRulesGeneral')
          ..add('type', type)
          ..add('minOrderAmount', minOrderAmount)
          ..add('maxDiscountAmount', maxDiscountAmount))
        .toString();
  }
}

class CouponCreateRequestRulesGeneralBuilder
    implements
        Builder<
          CouponCreateRequestRulesGeneral,
          CouponCreateRequestRulesGeneralBuilder
        > {
  _$CouponCreateRequestRulesGeneral? _$v;

  CouponCreateRequestRulesGeneralTypeEnum? _type;
  CouponCreateRequestRulesGeneralTypeEnum? get type => _$this._type;
  set type(CouponCreateRequestRulesGeneralTypeEnum? type) =>
      _$this._type = type;

  num? _minOrderAmount;
  num? get minOrderAmount => _$this._minOrderAmount;
  set minOrderAmount(num? minOrderAmount) =>
      _$this._minOrderAmount = minOrderAmount;

  num? _maxDiscountAmount;
  num? get maxDiscountAmount => _$this._maxDiscountAmount;
  set maxDiscountAmount(num? maxDiscountAmount) =>
      _$this._maxDiscountAmount = maxDiscountAmount;

  CouponCreateRequestRulesGeneralBuilder() {
    CouponCreateRequestRulesGeneral._defaults(this);
  }

  CouponCreateRequestRulesGeneralBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _type = $v.type;
      _minOrderAmount = $v.minOrderAmount;
      _maxDiscountAmount = $v.maxDiscountAmount;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CouponCreateRequestRulesGeneral other) {
    _$v = other as _$CouponCreateRequestRulesGeneral;
  }

  @override
  void update(void Function(CouponCreateRequestRulesGeneralBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CouponCreateRequestRulesGeneral build() => _build();

  _$CouponCreateRequestRulesGeneral _build() {
    final _$result =
        _$v ??
        _$CouponCreateRequestRulesGeneral._(
          type: type,
          minOrderAmount: minOrderAmount,
          maxDiscountAmount: maxDiscountAmount,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
