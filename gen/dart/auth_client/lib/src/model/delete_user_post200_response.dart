//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'delete_user_post200_response.g.dart';

/// DeleteUserPost200Response
///
/// Properties:
/// * [success] - Indicates if the operation was successful
/// * [message] - Status message of the deletion process
@BuiltValue()
abstract class DeleteUserPost200Response implements Built<DeleteUserPost200Response, DeleteUserPost200ResponseBuilder> {
  /// Indicates if the operation was successful
  @BuiltValueField(wireName: r'success')
  bool get success;

  /// Status message of the deletion process
  @BuiltValueField(wireName: r'message')
  DeleteUserPost200ResponseMessageEnum get message;
  // enum messageEnum {  User deleted,  Verification email sent,  };

  DeleteUserPost200Response._();

  factory DeleteUserPost200Response([void updates(DeleteUserPost200ResponseBuilder b)]) = _$DeleteUserPost200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(DeleteUserPost200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<DeleteUserPost200Response> get serializer => _$DeleteUserPost200ResponseSerializer();
}

class _$DeleteUserPost200ResponseSerializer implements PrimitiveSerializer<DeleteUserPost200Response> {
  @override
  final Iterable<Type> types = const [DeleteUserPost200Response, _$DeleteUserPost200Response];

  @override
  final String wireName = r'DeleteUserPost200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    DeleteUserPost200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'success';
    yield serializers.serialize(
      object.success,
      specifiedType: const FullType(bool),
    );
    yield r'message';
    yield serializers.serialize(
      object.message,
      specifiedType: const FullType(DeleteUserPost200ResponseMessageEnum),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    DeleteUserPost200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required DeleteUserPost200ResponseBuilder result,
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
        case r'message':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DeleteUserPost200ResponseMessageEnum),
          ) as DeleteUserPost200ResponseMessageEnum;
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
  DeleteUserPost200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = DeleteUserPost200ResponseBuilder();
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

class DeleteUserPost200ResponseMessageEnum extends EnumClass {

  /// Status message of the deletion process
  @BuiltValueEnumConst(wireName: r'User deleted')
  static const DeleteUserPost200ResponseMessageEnum userDeleted = _$deleteUserPost200ResponseMessageEnum_userDeleted;
  /// Status message of the deletion process
  @BuiltValueEnumConst(wireName: r'Verification email sent')
  static const DeleteUserPost200ResponseMessageEnum verificationEmailSent = _$deleteUserPost200ResponseMessageEnum_verificationEmailSent;

  static Serializer<DeleteUserPost200ResponseMessageEnum> get serializer => _$deleteUserPost200ResponseMessageEnumSerializer;

  const DeleteUserPost200ResponseMessageEnum._(String name): super(name);

  static BuiltSet<DeleteUserPost200ResponseMessageEnum> get values => _$deleteUserPost200ResponseMessageEnumValues;
  static DeleteUserPost200ResponseMessageEnum valueOf(String name) => _$deleteUserPost200ResponseMessageEnumValueOf(name);
}

