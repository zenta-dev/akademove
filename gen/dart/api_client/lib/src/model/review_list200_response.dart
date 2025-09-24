//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/review.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'review_list200_response.g.dart';

/// ReviewList200Response
///
/// Properties:
/// * [message] 
/// * [data] 
@BuiltValue()
abstract class ReviewList200Response implements Built<ReviewList200Response, ReviewList200ResponseBuilder> {
  @BuiltValueField(wireName: r'message')
  String get message;

  @BuiltValueField(wireName: r'data')
  BuiltList<Review> get data;

  ReviewList200Response._();

  factory ReviewList200Response([void updates(ReviewList200ResponseBuilder b)]) = _$ReviewList200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ReviewList200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ReviewList200Response> get serializer => _$ReviewList200ResponseSerializer();
}

class _$ReviewList200ResponseSerializer implements PrimitiveSerializer<ReviewList200Response> {
  @override
  final Iterable<Type> types = const [ReviewList200Response, _$ReviewList200Response];

  @override
  final String wireName = r'ReviewList200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ReviewList200Response object, {
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
      specifiedType: const FullType(BuiltList, [FullType(Review)]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    ReviewList200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ReviewList200ResponseBuilder result,
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
            specifiedType: const FullType(BuiltList, [FullType(Review)]),
          ) as BuiltList<Review>;
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
  ReviewList200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ReviewList200ResponseBuilder();
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

