//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'coupon_create_request_rules_time.g.dart';

/// CouponCreateRequestRulesTime
///
/// Properties:
/// * [allowedDays] 
/// * [allowedHours] 
@BuiltValue()
abstract class CouponCreateRequestRulesTime implements Built<CouponCreateRequestRulesTime, CouponCreateRequestRulesTimeBuilder> {
  @BuiltValueField(wireName: r'allowedDays')
  BuiltList<CouponCreateRequestRulesTimeAllowedDaysEnum>? get allowedDays;
  // enum allowedDaysEnum {  sunday,  monday,  tuesday,  wednesday,  thursday,  friday,  saturday,  };

  @BuiltValueField(wireName: r'allowedHours')
  BuiltList<int>? get allowedHours;

  CouponCreateRequestRulesTime._();

  factory CouponCreateRequestRulesTime([void updates(CouponCreateRequestRulesTimeBuilder b)]) = _$CouponCreateRequestRulesTime;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(CouponCreateRequestRulesTimeBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<CouponCreateRequestRulesTime> get serializer => _$CouponCreateRequestRulesTimeSerializer();
}

class _$CouponCreateRequestRulesTimeSerializer implements PrimitiveSerializer<CouponCreateRequestRulesTime> {
  @override
  final Iterable<Type> types = const [CouponCreateRequestRulesTime, _$CouponCreateRequestRulesTime];

  @override
  final String wireName = r'CouponCreateRequestRulesTime';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    CouponCreateRequestRulesTime object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.allowedDays != null) {
      yield r'allowedDays';
      yield serializers.serialize(
        object.allowedDays,
        specifiedType: const FullType(BuiltList, [FullType(CouponCreateRequestRulesTimeAllowedDaysEnum)]),
      );
    }
    if (object.allowedHours != null) {
      yield r'allowedHours';
      yield serializers.serialize(
        object.allowedHours,
        specifiedType: const FullType(BuiltList, [FullType(int)]),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    CouponCreateRequestRulesTime object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required CouponCreateRequestRulesTimeBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'allowedDays':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(CouponCreateRequestRulesTimeAllowedDaysEnum)]),
          ) as BuiltList<CouponCreateRequestRulesTimeAllowedDaysEnum>;
          result.allowedDays.replace(valueDes);
          break;
        case r'allowedHours':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(int)]),
          ) as BuiltList<int>;
          result.allowedHours.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  CouponCreateRequestRulesTime deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = CouponCreateRequestRulesTimeBuilder();
    final serializedList = (serialized as Iterable<Object?>).toList();
    final unhandled = <Object?>[];
    _deserializeProperties(
      serializers,
      serialized,
      specifiedType: specifiedType,
      serializedList: serializedList,
      unhandled: unhandled,
      result: result,
    );
    return result.build();
  }
}

class CouponCreateRequestRulesTimeAllowedDaysEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'sunday')
  static const CouponCreateRequestRulesTimeAllowedDaysEnum sunday = _$couponCreateRequestRulesTimeAllowedDaysEnum_sunday;
  @BuiltValueEnumConst(wireName: r'monday')
  static const CouponCreateRequestRulesTimeAllowedDaysEnum monday = _$couponCreateRequestRulesTimeAllowedDaysEnum_monday;
  @BuiltValueEnumConst(wireName: r'tuesday')
  static const CouponCreateRequestRulesTimeAllowedDaysEnum tuesday = _$couponCreateRequestRulesTimeAllowedDaysEnum_tuesday;
  @BuiltValueEnumConst(wireName: r'wednesday')
  static const CouponCreateRequestRulesTimeAllowedDaysEnum wednesday = _$couponCreateRequestRulesTimeAllowedDaysEnum_wednesday;
  @BuiltValueEnumConst(wireName: r'thursday')
  static const CouponCreateRequestRulesTimeAllowedDaysEnum thursday = _$couponCreateRequestRulesTimeAllowedDaysEnum_thursday;
  @BuiltValueEnumConst(wireName: r'friday')
  static const CouponCreateRequestRulesTimeAllowedDaysEnum friday = _$couponCreateRequestRulesTimeAllowedDaysEnum_friday;
  @BuiltValueEnumConst(wireName: r'saturday')
  static const CouponCreateRequestRulesTimeAllowedDaysEnum saturday = _$couponCreateRequestRulesTimeAllowedDaysEnum_saturday;

  static Serializer<CouponCreateRequestRulesTimeAllowedDaysEnum> get serializer => _$couponCreateRequestRulesTimeAllowedDaysEnumSerializer;

  const CouponCreateRequestRulesTimeAllowedDaysEnum._(String name): super(name);

  static BuiltSet<CouponCreateRequestRulesTimeAllowedDaysEnum> get values => _$couponCreateRequestRulesTimeAllowedDaysEnumValues;
  static CouponCreateRequestRulesTimeAllowedDaysEnum valueOf(String name) => _$couponCreateRequestRulesTimeAllowedDaysEnumValueOf(name);
}

