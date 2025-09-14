//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'reset_password_post200_response.g.dart';

/// ResetPasswordPost200Response
///
/// Properties:
/// * [status] 
@BuiltValue()
abstract class ResetPasswordPost200Response implements Built<ResetPasswordPost200Response, ResetPasswordPost200ResponseBuilder> {
  @BuiltValueField(wireName: r'status')
  bool? get status;

  ResetPasswordPost200Response._();

  factory ResetPasswordPost200Response([void updates(ResetPasswordPost200ResponseBuilder b)]) = _$ResetPasswordPost200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ResetPasswordPost200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ResetPasswordPost200Response> get serializer => _$ResetPasswordPost200ResponseSerializer();
}

class _$ResetPasswordPost200ResponseSerializer implements PrimitiveSerializer<ResetPasswordPost200Response> {
  @override
  final Iterable<Type> types = const [ResetPasswordPost200Response, _$ResetPasswordPost200Response];

  @override
  final String wireName = r'ResetPasswordPost200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ResetPasswordPost200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.status != null) {
      yield r'status';
      yield serializers.serialize(
        object.status,
        specifiedType: const FullType(bool),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    ResetPasswordPost200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ResetPasswordPost200ResponseBuilder result,
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
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ResetPasswordPost200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ResetPasswordPost200ResponseBuilder();
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

