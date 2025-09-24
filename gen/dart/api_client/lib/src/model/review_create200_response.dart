//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/review.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'review_create200_response.g.dart';

/// ReviewCreate200Response
///
/// Properties:
/// * [message] 
/// * [data] 
@BuiltValue()
abstract class ReviewCreate200Response implements Built<ReviewCreate200Response, ReviewCreate200ResponseBuilder> {
  @BuiltValueField(wireName: r'message')
  String get message;

  @BuiltValueField(wireName: r'data')
  Review get data;

  ReviewCreate200Response._();

  factory ReviewCreate200Response([void updates(ReviewCreate200ResponseBuilder b)]) = _$ReviewCreate200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ReviewCreate200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ReviewCreate200Response> get serializer => _$ReviewCreate200ResponseSerializer();
}

class _$ReviewCreate200ResponseSerializer implements PrimitiveSerializer<ReviewCreate200Response> {
  @override
  final Iterable<Type> types = const [ReviewCreate200Response, _$ReviewCreate200Response];

  @override
  final String wireName = r'ReviewCreate200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ReviewCreate200Response object, {
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
      specifiedType: const FullType(Review),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    ReviewCreate200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ReviewCreate200ResponseBuilder result,
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
            specifiedType: const FullType(Review),
          ) as Review;
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
  ReviewCreate200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ReviewCreate200ResponseBuilder();
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

