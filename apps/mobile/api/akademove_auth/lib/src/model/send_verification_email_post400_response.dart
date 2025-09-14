//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'send_verification_email_post400_response.g.dart';

/// SendVerificationEmailPost400Response
///
/// Properties:
/// * [message] - Error message
@BuiltValue()
abstract class SendVerificationEmailPost400Response
    implements
        Built<SendVerificationEmailPost400Response,
            SendVerificationEmailPost400ResponseBuilder> {
  /// Error message
  @BuiltValueField(wireName: r'message')
  String? get message;

  SendVerificationEmailPost400Response._();

  factory SendVerificationEmailPost400Response(
          [void updates(SendVerificationEmailPost400ResponseBuilder b)]) =
      _$SendVerificationEmailPost400Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(SendVerificationEmailPost400ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<SendVerificationEmailPost400Response> get serializer =>
      _$SendVerificationEmailPost400ResponseSerializer();
}

class _$SendVerificationEmailPost400ResponseSerializer
    implements PrimitiveSerializer<SendVerificationEmailPost400Response> {
  @override
  final Iterable<Type> types = const [
    SendVerificationEmailPost400Response,
    _$SendVerificationEmailPost400Response
  ];

  @override
  final String wireName = r'SendVerificationEmailPost400Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    SendVerificationEmailPost400Response object, {
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
    SendVerificationEmailPost400Response object, {
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
    required SendVerificationEmailPost400ResponseBuilder result,
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
  SendVerificationEmailPost400Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = SendVerificationEmailPost400ResponseBuilder();
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
