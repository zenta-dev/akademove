//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'sign_out_post200_response.g.dart';

/// SignOutPost200Response
///
/// Properties:
/// * [success]
@BuiltValue()
abstract class SignOutPost200Response
    implements Built<SignOutPost200Response, SignOutPost200ResponseBuilder> {
  @BuiltValueField(wireName: r'success')
  bool? get success;

  SignOutPost200Response._();

  factory SignOutPost200Response(
          [void updates(SignOutPost200ResponseBuilder b)]) =
      _$SignOutPost200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(SignOutPost200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<SignOutPost200Response> get serializer =>
      _$SignOutPost200ResponseSerializer();
}

class _$SignOutPost200ResponseSerializer
    implements PrimitiveSerializer<SignOutPost200Response> {
  @override
  final Iterable<Type> types = const [
    SignOutPost200Response,
    _$SignOutPost200Response
  ];

  @override
  final String wireName = r'SignOutPost200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    SignOutPost200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.success != null) {
      yield r'success';
      yield serializers.serialize(
        object.success,
        specifiedType: const FullType(bool),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    SignOutPost200Response object, {
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
    required SignOutPost200ResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'success':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.success = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  SignOutPost200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = SignOutPost200ResponseBuilder();
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
