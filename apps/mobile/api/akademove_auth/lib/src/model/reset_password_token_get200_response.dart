//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'reset_password_token_get200_response.g.dart';

/// ResetPasswordTokenGet200Response
///
/// Properties:
/// * [token]
@BuiltValue()
abstract class ResetPasswordTokenGet200Response
    implements
        Built<ResetPasswordTokenGet200Response,
            ResetPasswordTokenGet200ResponseBuilder> {
  @BuiltValueField(wireName: r'token')
  String? get token;

  ResetPasswordTokenGet200Response._();

  factory ResetPasswordTokenGet200Response(
          [void updates(ResetPasswordTokenGet200ResponseBuilder b)]) =
      _$ResetPasswordTokenGet200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ResetPasswordTokenGet200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ResetPasswordTokenGet200Response> get serializer =>
      _$ResetPasswordTokenGet200ResponseSerializer();
}

class _$ResetPasswordTokenGet200ResponseSerializer
    implements PrimitiveSerializer<ResetPasswordTokenGet200Response> {
  @override
  final Iterable<Type> types = const [
    ResetPasswordTokenGet200Response,
    _$ResetPasswordTokenGet200Response
  ];

  @override
  final String wireName = r'ResetPasswordTokenGet200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ResetPasswordTokenGet200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.token != null) {
      yield r'token';
      yield serializers.serialize(
        object.token,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    ResetPasswordTokenGet200Response object, {
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
    required ResetPasswordTokenGet200ResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'token':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.token = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ResetPasswordTokenGet200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ResetPasswordTokenGet200ResponseBuilder();
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
