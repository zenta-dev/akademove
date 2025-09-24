//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/coupon.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'coupon_create200_response.g.dart';

/// CouponCreate200Response
///
/// Properties:
/// * [message] 
/// * [data] 
@BuiltValue()
abstract class CouponCreate200Response implements Built<CouponCreate200Response, CouponCreate200ResponseBuilder> {
  @BuiltValueField(wireName: r'message')
  String get message;

  @BuiltValueField(wireName: r'data')
  Coupon get data;

  CouponCreate200Response._();

  factory CouponCreate200Response([void updates(CouponCreate200ResponseBuilder b)]) = _$CouponCreate200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(CouponCreate200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<CouponCreate200Response> get serializer => _$CouponCreate200ResponseSerializer();
}

class _$CouponCreate200ResponseSerializer implements PrimitiveSerializer<CouponCreate200Response> {
  @override
  final Iterable<Type> types = const [CouponCreate200Response, _$CouponCreate200Response];

  @override
  final String wireName = r'CouponCreate200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    CouponCreate200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'message';
    yield serializers.serialize(
      object.message,
      specifiedType: const FullType(String),
    );
    yield r'data';
    yield serializers.serialize(
      object.data,
      specifiedType: const FullType(Coupon),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    CouponCreate200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required CouponCreate200ResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'message':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.message = valueDes;
          break;
        case r'data':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(Coupon),
          ) as Coupon;
          result.data.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  CouponCreate200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = CouponCreate200ResponseBuilder();
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

