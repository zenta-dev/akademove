//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'social_sign_in400_response.g.dart';

/// SocialSignIn400Response
///
/// Properties:
/// * [message] 
@BuiltValue()
abstract class SocialSignIn400Response implements Built<SocialSignIn400Response, SocialSignIn400ResponseBuilder> {
  @BuiltValueField(wireName: r'message')
  String get message;

  SocialSignIn400Response._();

  factory SocialSignIn400Response([void updates(SocialSignIn400ResponseBuilder b)]) = _$SocialSignIn400Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(SocialSignIn400ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<SocialSignIn400Response> get serializer => _$SocialSignIn400ResponseSerializer();
}

class _$SocialSignIn400ResponseSerializer implements PrimitiveSerializer<SocialSignIn400Response> {
  @override
  final Iterable<Type> types = const [SocialSignIn400Response, _$SocialSignIn400Response];

  @override
  final String wireName = r'SocialSignIn400Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    SocialSignIn400Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'message';
    yield serializers.serialize(
      object.message,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    SocialSignIn400Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required SocialSignIn400ResponseBuilder result,
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
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  SocialSignIn400Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = SocialSignIn400ResponseBuilder();
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

