//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'forget_password_post200_response.g.dart';

/// ForgetPasswordPost200Response
///
/// Properties:
/// * [status] 
/// * [message] 
@BuiltValue()
abstract class ForgetPasswordPost200Response implements Built<ForgetPasswordPost200Response, ForgetPasswordPost200ResponseBuilder> {
  @BuiltValueField(wireName: r'status')
  bool? get status;

  @BuiltValueField(wireName: r'message')
  String? get message;

  ForgetPasswordPost200Response._();

  factory ForgetPasswordPost200Response([void updates(ForgetPasswordPost200ResponseBuilder b)]) = _$ForgetPasswordPost200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ForgetPasswordPost200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ForgetPasswordPost200Response> get serializer => _$ForgetPasswordPost200ResponseSerializer();
}

class _$ForgetPasswordPost200ResponseSerializer implements PrimitiveSerializer<ForgetPasswordPost200Response> {
  @override
  final Iterable<Type> types = const [ForgetPasswordPost200Response, _$ForgetPasswordPost200Response];

  @override
  final String wireName = r'ForgetPasswordPost200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ForgetPasswordPost200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.status != null) {
      yield r'status';
      yield serializers.serialize(
        object.status,
        specifiedType: const FullType(bool),
      );
    }
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
    ForgetPasswordPost200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ForgetPasswordPost200ResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.status = valueDes;
          break;
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
  ForgetPasswordPost200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ForgetPasswordPost200ResponseBuilder();
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

