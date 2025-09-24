//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/coupon_create_request_rules_user.dart';
import 'package:api_client/src/model/coupon_create_request_rules_time.dart';
import 'package:api_client/src/model/coupon_create_request_rules_general.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'coupon_create_request_rules.g.dart';

/// CouponCreateRequestRules
///
/// Properties:
/// * [general] 
/// * [user] 
/// * [time] 
@BuiltValue()
abstract class CouponCreateRequestRules implements Built<CouponCreateRequestRules, CouponCreateRequestRulesBuilder> {
  @BuiltValueField(wireName: r'general')
  CouponCreateRequestRulesGeneral? get general;

  @BuiltValueField(wireName: r'user')
  CouponCreateRequestRulesUser? get user;

  @BuiltValueField(wireName: r'time')
  CouponCreateRequestRulesTime? get time;

  CouponCreateRequestRules._();

  factory CouponCreateRequestRules([void updates(CouponCreateRequestRulesBuilder b)]) = _$CouponCreateRequestRules;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(CouponCreateRequestRulesBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<CouponCreateRequestRules> get serializer => _$CouponCreateRequestRulesSerializer();
}

class _$CouponCreateRequestRulesSerializer implements PrimitiveSerializer<CouponCreateRequestRules> {
  @override
  final Iterable<Type> types = const [CouponCreateRequestRules, _$CouponCreateRequestRules];

  @override
  final String wireName = r'CouponCreateRequestRules';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    CouponCreateRequestRules object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.general != null) {
      yield r'general';
      yield serializers.serialize(
        object.general,
        specifiedType: const FullType(CouponCreateRequestRulesGeneral),
      );
    }
    if (object.user != null) {
      yield r'user';
      yield serializers.serialize(
        object.user,
        specifiedType: const FullType(CouponCreateRequestRulesUser),
      );
    }
    if (object.time != null) {
      yield r'time';
      yield serializers.serialize(
        object.time,
        specifiedType: const FullType(CouponCreateRequestRulesTime),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    CouponCreateRequestRules object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required CouponCreateRequestRulesBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'general':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(CouponCreateRequestRulesGeneral),
          ) as CouponCreateRequestRulesGeneral;
          result.general.replace(valueDes);
          break;
        case r'user':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(CouponCreateRequestRulesUser),
          ) as CouponCreateRequestRulesUser;
          result.user.replace(valueDes);
          break;
        case r'time':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(CouponCreateRequestRulesTime),
          ) as CouponCreateRequestRulesTime;
          result.time.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  CouponCreateRequestRules deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = CouponCreateRequestRulesBuilder();
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

