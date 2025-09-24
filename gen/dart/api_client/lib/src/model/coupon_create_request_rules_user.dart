//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'coupon_create_request_rules_user.g.dart';

/// CouponCreateRequestRulesUser
///
/// Properties:
/// * [newUserOnly] 
@BuiltValue()
abstract class CouponCreateRequestRulesUser implements Built<CouponCreateRequestRulesUser, CouponCreateRequestRulesUserBuilder> {
  @BuiltValueField(wireName: r'newUserOnly')
  bool? get newUserOnly;

  CouponCreateRequestRulesUser._();

  factory CouponCreateRequestRulesUser([void updates(CouponCreateRequestRulesUserBuilder b)]) = _$CouponCreateRequestRulesUser;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(CouponCreateRequestRulesUserBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<CouponCreateRequestRulesUser> get serializer => _$CouponCreateRequestRulesUserSerializer();
}

class _$CouponCreateRequestRulesUserSerializer implements PrimitiveSerializer<CouponCreateRequestRulesUser> {
  @override
  final Iterable<Type> types = const [CouponCreateRequestRulesUser, _$CouponCreateRequestRulesUser];

  @override
  final String wireName = r'CouponCreateRequestRulesUser';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    CouponCreateRequestRulesUser object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.newUserOnly != null) {
      yield r'newUserOnly';
      yield serializers.serialize(
        object.newUserOnly,
        specifiedType: const FullType(bool),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    CouponCreateRequestRulesUser object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required CouponCreateRequestRulesUserBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'newUserOnly':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.newUserOnly = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  CouponCreateRequestRulesUser deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = CouponCreateRequestRulesUserBuilder();
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

