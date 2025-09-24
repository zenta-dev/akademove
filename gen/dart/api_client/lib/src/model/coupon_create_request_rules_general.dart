//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'coupon_create_request_rules_general.g.dart';

/// CouponCreateRequestRulesGeneral
///
/// Properties:
/// * [type] 
/// * [minOrderAmount] 
/// * [maxDiscountAmount] 
@BuiltValue()
abstract class CouponCreateRequestRulesGeneral implements Built<CouponCreateRequestRulesGeneral, CouponCreateRequestRulesGeneralBuilder> {
  @BuiltValueField(wireName: r'type')
  CouponCreateRequestRulesGeneralTypeEnum? get type;
  // enum typeEnum {  percentage,  fixed,  };

  @BuiltValueField(wireName: r'minOrderAmount')
  num? get minOrderAmount;

  @BuiltValueField(wireName: r'maxDiscountAmount')
  num? get maxDiscountAmount;

  CouponCreateRequestRulesGeneral._();

  factory CouponCreateRequestRulesGeneral([void updates(CouponCreateRequestRulesGeneralBuilder b)]) = _$CouponCreateRequestRulesGeneral;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(CouponCreateRequestRulesGeneralBuilder b) => b
      ..type = const CouponCreateRequestRulesGeneralTypeEnum._('percentage');

  @BuiltValueSerializer(custom: true)
  static Serializer<CouponCreateRequestRulesGeneral> get serializer => _$CouponCreateRequestRulesGeneralSerializer();
}

class _$CouponCreateRequestRulesGeneralSerializer implements PrimitiveSerializer<CouponCreateRequestRulesGeneral> {
  @override
  final Iterable<Type> types = const [CouponCreateRequestRulesGeneral, _$CouponCreateRequestRulesGeneral];

  @override
  final String wireName = r'CouponCreateRequestRulesGeneral';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    CouponCreateRequestRulesGeneral object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.type != null) {
      yield r'type';
      yield serializers.serialize(
        object.type,
        specifiedType: const FullType(CouponCreateRequestRulesGeneralTypeEnum),
      );
    }
    if (object.minOrderAmount != null) {
      yield r'minOrderAmount';
      yield serializers.serialize(
        object.minOrderAmount,
        specifiedType: const FullType(num),
      );
    }
    if (object.maxDiscountAmount != null) {
      yield r'maxDiscountAmount';
      yield serializers.serialize(
        object.maxDiscountAmount,
        specifiedType: const FullType(num),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    CouponCreateRequestRulesGeneral object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required CouponCreateRequestRulesGeneralBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'type':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(CouponCreateRequestRulesGeneralTypeEnum),
          ) as CouponCreateRequestRulesGeneralTypeEnum;
          result.type = valueDes;
          break;
        case r'minOrderAmount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.minOrderAmount = valueDes;
          break;
        case r'maxDiscountAmount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.maxDiscountAmount = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  CouponCreateRequestRulesGeneral deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = CouponCreateRequestRulesGeneralBuilder();
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

class CouponCreateRequestRulesGeneralTypeEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'percentage')
  static const CouponCreateRequestRulesGeneralTypeEnum percentage = _$couponCreateRequestRulesGeneralTypeEnum_percentage;
  @BuiltValueEnumConst(wireName: r'fixed')
  static const CouponCreateRequestRulesGeneralTypeEnum fixed = _$couponCreateRequestRulesGeneralTypeEnum_fixed;

  static Serializer<CouponCreateRequestRulesGeneralTypeEnum> get serializer => _$couponCreateRequestRulesGeneralTypeEnumSerializer;

  const CouponCreateRequestRulesGeneralTypeEnum._(String name): super(name);

  static BuiltSet<CouponCreateRequestRulesGeneralTypeEnum> get values => _$couponCreateRequestRulesGeneralTypeEnumValues;
  static CouponCreateRequestRulesGeneralTypeEnum valueOf(String name) => _$couponCreateRequestRulesGeneralTypeEnumValueOf(name);
}

