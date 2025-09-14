//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:auth_client/src/model/verify_email_get200_response_user.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'verify_email_get200_response.g.dart';

/// VerifyEmailGet200Response
///
/// Properties:
/// * [user] 
/// * [status] - Indicates if the email was verified successfully
@BuiltValue()
abstract class VerifyEmailGet200Response implements Built<VerifyEmailGet200Response, VerifyEmailGet200ResponseBuilder> {
  @BuiltValueField(wireName: r'user')
  VerifyEmailGet200ResponseUser get user;

  /// Indicates if the email was verified successfully
  @BuiltValueField(wireName: r'status')
  bool get status;

  VerifyEmailGet200Response._();

  factory VerifyEmailGet200Response([void updates(VerifyEmailGet200ResponseBuilder b)]) = _$VerifyEmailGet200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(VerifyEmailGet200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<VerifyEmailGet200Response> get serializer => _$VerifyEmailGet200ResponseSerializer();
}

class _$VerifyEmailGet200ResponseSerializer implements PrimitiveSerializer<VerifyEmailGet200Response> {
  @override
  final Iterable<Type> types = const [VerifyEmailGet200Response, _$VerifyEmailGet200Response];

  @override
  final String wireName = r'VerifyEmailGet200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    VerifyEmailGet200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'user';
    yield serializers.serialize(
      object.user,
      specifiedType: const FullType(VerifyEmailGet200ResponseUser),
    );
    yield r'status';
    yield serializers.serialize(
      object.status,
      specifiedType: const FullType(bool),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    VerifyEmailGet200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required VerifyEmailGet200ResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'user':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(VerifyEmailGet200ResponseUser),
          ) as VerifyEmailGet200ResponseUser;
          result.user.replace(valueDes);
          break;
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
  VerifyEmailGet200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = VerifyEmailGet200ResponseBuilder();
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

