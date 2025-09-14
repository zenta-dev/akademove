//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'change_email_post200_response.g.dart';

/// ChangeEmailPost200Response
///
/// Properties:
/// * [status] - Indicates if the request was successful
/// * [message] - Status message of the email change process
@BuiltValue()
abstract class ChangeEmailPost200Response implements Built<ChangeEmailPost200Response, ChangeEmailPost200ResponseBuilder> {
  /// Indicates if the request was successful
  @BuiltValueField(wireName: r'status')
  bool get status;

  /// Status message of the email change process
  @BuiltValueField(wireName: r'message')
  ChangeEmailPost200ResponseMessageEnum? get message;
  // enum messageEnum {  Email updated,  Verification email sent,  };

  ChangeEmailPost200Response._();

  factory ChangeEmailPost200Response([void updates(ChangeEmailPost200ResponseBuilder b)]) = _$ChangeEmailPost200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ChangeEmailPost200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ChangeEmailPost200Response> get serializer => _$ChangeEmailPost200ResponseSerializer();
}

class _$ChangeEmailPost200ResponseSerializer implements PrimitiveSerializer<ChangeEmailPost200Response> {
  @override
  final Iterable<Type> types = const [ChangeEmailPost200Response, _$ChangeEmailPost200Response];

  @override
  final String wireName = r'ChangeEmailPost200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ChangeEmailPost200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'status';
    yield serializers.serialize(
      object.status,
      specifiedType: const FullType(bool),
    );
    if (object.message != null) {
      yield r'message';
      yield serializers.serialize(
        object.message,
        specifiedType: const FullType(ChangeEmailPost200ResponseMessageEnum),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    ChangeEmailPost200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ChangeEmailPost200ResponseBuilder result,
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
            specifiedType: const FullType(ChangeEmailPost200ResponseMessageEnum),
          ) as ChangeEmailPost200ResponseMessageEnum;
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
  ChangeEmailPost200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ChangeEmailPost200ResponseBuilder();
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

class ChangeEmailPost200ResponseMessageEnum extends EnumClass {

  /// Status message of the email change process
  @BuiltValueEnumConst(wireName: r'Email updated')
  static const ChangeEmailPost200ResponseMessageEnum emailUpdated = _$changeEmailPost200ResponseMessageEnum_emailUpdated;
  /// Status message of the email change process
  @BuiltValueEnumConst(wireName: r'Verification email sent')
  static const ChangeEmailPost200ResponseMessageEnum verificationEmailSent = _$changeEmailPost200ResponseMessageEnum_verificationEmailSent;

  static Serializer<ChangeEmailPost200ResponseMessageEnum> get serializer => _$changeEmailPost200ResponseMessageEnumSerializer;

  const ChangeEmailPost200ResponseMessageEnum._(String name): super(name);

  static BuiltSet<ChangeEmailPost200ResponseMessageEnum> get values => _$changeEmailPost200ResponseMessageEnumValues;
  static ChangeEmailPost200ResponseMessageEnum valueOf(String name) => _$changeEmailPost200ResponseMessageEnumValueOf(name);
}

