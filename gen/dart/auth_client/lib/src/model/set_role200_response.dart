//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:auth_client/src/model/user.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'set_role200_response.g.dart';

/// SetRole200Response
///
/// Properties:
/// * [user] 
@BuiltValue()
abstract class SetRole200Response implements Built<SetRole200Response, SetRole200ResponseBuilder> {
  @BuiltValueField(wireName: r'user')
  User? get user;

  SetRole200Response._();

  factory SetRole200Response([void updates(SetRole200ResponseBuilder b)]) = _$SetRole200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(SetRole200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<SetRole200Response> get serializer => _$SetRole200ResponseSerializer();
}

class _$SetRole200ResponseSerializer implements PrimitiveSerializer<SetRole200Response> {
  @override
  final Iterable<Type> types = const [SetRole200Response, _$SetRole200Response];

  @override
  final String wireName = r'SetRole200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    SetRole200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.user != null) {
      yield r'user';
      yield serializers.serialize(
        object.user,
        specifiedType: const FullType(User),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    SetRole200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required SetRole200ResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'user':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(User),
          ) as User;
          result.user.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  SetRole200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = SetRole200ResponseBuilder();
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

