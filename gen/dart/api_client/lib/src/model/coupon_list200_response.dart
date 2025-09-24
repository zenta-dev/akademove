//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/coupon.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'coupon_list200_response.g.dart';

/// CouponList200Response
///
/// Properties:
/// * [message] 
/// * [data] 
@BuiltValue()
abstract class CouponList200Response implements Built<CouponList200Response, CouponList200ResponseBuilder> {
  @BuiltValueField(wireName: r'message')
  String get message;

  @BuiltValueField(wireName: r'data')
  BuiltList<Coupon> get data;

  CouponList200Response._();

  factory CouponList200Response([void updates(CouponList200ResponseBuilder b)]) = _$CouponList200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(CouponList200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<CouponList200Response> get serializer => _$CouponList200ResponseSerializer();
}

class _$CouponList200ResponseSerializer implements PrimitiveSerializer<CouponList200Response> {
  @override
  final Iterable<Type> types = const [CouponList200Response, _$CouponList200Response];

  @override
  final String wireName = r'CouponList200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    CouponList200Response object, {
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
      specifiedType: const FullType(BuiltList, [FullType(Coupon)]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    CouponList200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required CouponList200ResponseBuilder result,
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
            specifiedType: const FullType(BuiltList, [FullType(Coupon)]),
          ) as BuiltList<Coupon>;
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
  CouponList200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = CouponList200ResponseBuilder();
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

