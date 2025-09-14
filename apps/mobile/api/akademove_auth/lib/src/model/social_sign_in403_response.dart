//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'social_sign_in403_response.g.dart';

/// SocialSignIn403Response
///
/// Properties:
/// * [message]
@BuiltValue()
abstract class SocialSignIn403Response
    implements Built<SocialSignIn403Response, SocialSignIn403ResponseBuilder> {
  @BuiltValueField(wireName: r'message')
  String? get message;

  SocialSignIn403Response._();

  factory SocialSignIn403Response(
          [void updates(SocialSignIn403ResponseBuilder b)]) =
      _$SocialSignIn403Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(SocialSignIn403ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<SocialSignIn403Response> get serializer =>
      _$SocialSignIn403ResponseSerializer();
}

class _$SocialSignIn403ResponseSerializer
    implements PrimitiveSerializer<SocialSignIn403Response> {
  @override
  final Iterable<Type> types = const [
    SocialSignIn403Response,
    _$SocialSignIn403Response
  ];

  @override
  final String wireName = r'SocialSignIn403Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    SocialSignIn403Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.message != null) {
      yield r'message';
      yield serializers.serialize(
        object.message,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    SocialSignIn403Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object,
            specifiedType: specifiedType)
        .toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required SocialSignIn403ResponseBuilder result,
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
  SocialSignIn403Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = SocialSignIn403ResponseBuilder();
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
