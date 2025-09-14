//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'send_verification_email_post200_response.g.dart';

/// SendVerificationEmailPost200Response
///
/// Properties:
/// * [status] - Indicates if the email was sent successfully
@BuiltValue()
abstract class SendVerificationEmailPost200Response implements Built<SendVerificationEmailPost200Response, SendVerificationEmailPost200ResponseBuilder> {
  /// Indicates if the email was sent successfully
  @BuiltValueField(wireName: r'status')
  bool? get status;

  SendVerificationEmailPost200Response._();

  factory SendVerificationEmailPost200Response([void updates(SendVerificationEmailPost200ResponseBuilder b)]) = _$SendVerificationEmailPost200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(SendVerificationEmailPost200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<SendVerificationEmailPost200Response> get serializer => _$SendVerificationEmailPost200ResponseSerializer();
}

class _$SendVerificationEmailPost200ResponseSerializer implements PrimitiveSerializer<SendVerificationEmailPost200Response> {
  @override
  final Iterable<Type> types = const [SendVerificationEmailPost200Response, _$SendVerificationEmailPost200Response];

  @override
  final String wireName = r'SendVerificationEmailPost200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    SendVerificationEmailPost200Response object, {
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
    SendVerificationEmailPost200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required SendVerificationEmailPost200ResponseBuilder result,
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
  SendVerificationEmailPost200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = SendVerificationEmailPost200ResponseBuilder();
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

