// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coupon_create_request_rules_time.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const CouponCreateRequestRulesTimeAllowedDaysEnum
_$couponCreateRequestRulesTimeAllowedDaysEnum_sunday =
    const CouponCreateRequestRulesTimeAllowedDaysEnum._('sunday');
const CouponCreateRequestRulesTimeAllowedDaysEnum
_$couponCreateRequestRulesTimeAllowedDaysEnum_monday =
    const CouponCreateRequestRulesTimeAllowedDaysEnum._('monday');
const CouponCreateRequestRulesTimeAllowedDaysEnum
_$couponCreateRequestRulesTimeAllowedDaysEnum_tuesday =
    const CouponCreateRequestRulesTimeAllowedDaysEnum._('tuesday');
const CouponCreateRequestRulesTimeAllowedDaysEnum
_$couponCreateRequestRulesTimeAllowedDaysEnum_wednesday =
    const CouponCreateRequestRulesTimeAllowedDaysEnum._('wednesday');
const CouponCreateRequestRulesTimeAllowedDaysEnum
_$couponCreateRequestRulesTimeAllowedDaysEnum_thursday =
    const CouponCreateRequestRulesTimeAllowedDaysEnum._('thursday');
const CouponCreateRequestRulesTimeAllowedDaysEnum
_$couponCreateRequestRulesTimeAllowedDaysEnum_friday =
    const CouponCreateRequestRulesTimeAllowedDaysEnum._('friday');
const CouponCreateRequestRulesTimeAllowedDaysEnum
_$couponCreateRequestRulesTimeAllowedDaysEnum_saturday =
    const CouponCreateRequestRulesTimeAllowedDaysEnum._('saturday');

CouponCreateRequestRulesTimeAllowedDaysEnum
_$couponCreateRequestRulesTimeAllowedDaysEnumValueOf(String name) {
  switch (name) {
    case 'sunday':
      return _$couponCreateRequestRulesTimeAllowedDaysEnum_sunday;
    case 'monday':
      return _$couponCreateRequestRulesTimeAllowedDaysEnum_monday;
    case 'tuesday':
      return _$couponCreateRequestRulesTimeAllowedDaysEnum_tuesday;
    case 'wednesday':
      return _$couponCreateRequestRulesTimeAllowedDaysEnum_wednesday;
    case 'thursday':
      return _$couponCreateRequestRulesTimeAllowedDaysEnum_thursday;
    case 'friday':
      return _$couponCreateRequestRulesTimeAllowedDaysEnum_friday;
    case 'saturday':
      return _$couponCreateRequestRulesTimeAllowedDaysEnum_saturday;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<CouponCreateRequestRulesTimeAllowedDaysEnum>
_$couponCreateRequestRulesTimeAllowedDaysEnumValues =
    BuiltSet<CouponCreateRequestRulesTimeAllowedDaysEnum>(
      const <CouponCreateRequestRulesTimeAllowedDaysEnum>[
        _$couponCreateRequestRulesTimeAllowedDaysEnum_sunday,
        _$couponCreateRequestRulesTimeAllowedDaysEnum_monday,
        _$couponCreateRequestRulesTimeAllowedDaysEnum_tuesday,
        _$couponCreateRequestRulesTimeAllowedDaysEnum_wednesday,
        _$couponCreateRequestRulesTimeAllowedDaysEnum_thursday,
        _$couponCreateRequestRulesTimeAllowedDaysEnum_friday,
        _$couponCreateRequestRulesTimeAllowedDaysEnum_saturday,
      ],
    );

Serializer<CouponCreateRequestRulesTimeAllowedDaysEnum>
_$couponCreateRequestRulesTimeAllowedDaysEnumSerializer =
    _$CouponCreateRequestRulesTimeAllowedDaysEnumSerializer();

class _$CouponCreateRequestRulesTimeAllowedDaysEnumSerializer
    implements
        PrimitiveSerializer<CouponCreateRequestRulesTimeAllowedDaysEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'sunday': 'sunday',
    'monday': 'monday',
    'tuesday': 'tuesday',
    'wednesday': 'wednesday',
    'thursday': 'thursday',
    'friday': 'friday',
    'saturday': 'saturday',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'sunday': 'sunday',
    'monday': 'monday',
    'tuesday': 'tuesday',
    'wednesday': 'wednesday',
    'thursday': 'thursday',
    'friday': 'friday',
    'saturday': 'saturday',
  };

  @override
  final Iterable<Type> types = const <Type>[
    CouponCreateRequestRulesTimeAllowedDaysEnum,
  ];
  @override
  final String wireName = 'CouponCreateRequestRulesTimeAllowedDaysEnum';

  @override
  Object serialize(
    Serializers serializers,
    CouponCreateRequestRulesTimeAllowedDaysEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  CouponCreateRequestRulesTimeAllowedDaysEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => CouponCreateRequestRulesTimeAllowedDaysEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$CouponCreateRequestRulesTime extends CouponCreateRequestRulesTime {
  @override
  final BuiltList<CouponCreateRequestRulesTimeAllowedDaysEnum>? allowedDays;
  @override
  final BuiltList<int>? allowedHours;

  factory _$CouponCreateRequestRulesTime([
    void Function(CouponCreateRequestRulesTimeBuilder)? updates,
  ]) => (CouponCreateRequestRulesTimeBuilder()..update(updates))._build();

  _$CouponCreateRequestRulesTime._({this.allowedDays, this.allowedHours})
    : super._();
  @override
  CouponCreateRequestRulesTime rebuild(
    void Function(CouponCreateRequestRulesTimeBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  CouponCreateRequestRulesTimeBuilder toBuilder() =>
      CouponCreateRequestRulesTimeBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CouponCreateRequestRulesTime &&
        allowedDays == other.allowedDays &&
        allowedHours == other.allowedHours;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, allowedDays.hashCode);
    _$hash = $jc(_$hash, allowedHours.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'CouponCreateRequestRulesTime')
          ..add('allowedDays', allowedDays)
          ..add('allowedHours', allowedHours))
        .toString();
  }
}

class CouponCreateRequestRulesTimeBuilder
    implements
        Builder<
          CouponCreateRequestRulesTime,
          CouponCreateRequestRulesTimeBuilder
        > {
  _$CouponCreateRequestRulesTime? _$v;

  ListBuilder<CouponCreateRequestRulesTimeAllowedDaysEnum>? _allowedDays;
  ListBuilder<CouponCreateRequestRulesTimeAllowedDaysEnum> get allowedDays =>
      _$this._allowedDays ??=
          ListBuilder<CouponCreateRequestRulesTimeAllowedDaysEnum>();
  set allowedDays(
    ListBuilder<CouponCreateRequestRulesTimeAllowedDaysEnum>? allowedDays,
  ) => _$this._allowedDays = allowedDays;

  ListBuilder<int>? _allowedHours;
  ListBuilder<int> get allowedHours =>
      _$this._allowedHours ??= ListBuilder<int>();
  set allowedHours(ListBuilder<int>? allowedHours) =>
      _$this._allowedHours = allowedHours;

  CouponCreateRequestRulesTimeBuilder() {
    CouponCreateRequestRulesTime._defaults(this);
  }

  CouponCreateRequestRulesTimeBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _allowedDays = $v.allowedDays?.toBuilder();
      _allowedHours = $v.allowedHours?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CouponCreateRequestRulesTime other) {
    _$v = other as _$CouponCreateRequestRulesTime;
  }

  @override
  void update(void Function(CouponCreateRequestRulesTimeBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CouponCreateRequestRulesTime build() => _build();

  _$CouponCreateRequestRulesTime _build() {
    _$CouponCreateRequestRulesTime _$result;
    try {
      _$result =
          _$v ??
          _$CouponCreateRequestRulesTime._(
            allowedDays: _allowedDays?.build(),
            allowedHours: _allowedHours?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'allowedDays';
        _allowedDays?.build();
        _$failedField = 'allowedHours';
        _allowedHours?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'CouponCreateRequestRulesTime',
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
