//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'delete_user_callback_get200_response.g.dart';

/// DeleteUserCallbackGet200Response
///
/// Properties:
/// * [success] - Indicates if the deletion was successful
/// * [message] - Confirmation message
@BuiltValue()
abstract class DeleteUserCallbackGet200Response
    implements
        Built<DeleteUserCallbackGet200Response,
            DeleteUserCallbackGet200ResponseBuilder> {
  /// Indicates if the deletion was successful
  @BuiltValueField(wireName: r'success')
  bool get success;

  /// Confirmation message
  @BuiltValueField(wireName: r'message')
  DeleteUserCallbackGet200ResponseMessageEnum get message;
  // enum messageEnum {  User deleted,  };

  DeleteUserCallbackGet200Response._();

  factory DeleteUserCallbackGet200Response(
          [void updates(DeleteUserCallbackGet200ResponseBuilder b)]) =
      _$DeleteUserCallbackGet200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(DeleteUserCallbackGet200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<DeleteUserCallbackGet200Response> get serializer =>
      _$DeleteUserCallbackGet200ResponseSerializer();
}

class _$DeleteUserCallbackGet200ResponseSerializer
    implements PrimitiveSerializer<DeleteUserCallbackGet200Response> {
  @override
  final Iterable<Type> types = const [
    DeleteUserCallbackGet200Response,
    _$DeleteUserCallbackGet200Response
  ];

  @override
  final String wireName = r'DeleteUserCallbackGet200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    DeleteUserCallbackGet200Response object, {
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
      specifiedType:
          const FullType(DeleteUserCallbackGet200ResponseMessageEnum),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    DeleteUserCallbackGet200Response object, {
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
    required DeleteUserCallbackGet200ResponseBuilder result,
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
            specifiedType:
                const FullType(DeleteUserCallbackGet200ResponseMessageEnum),
          ) as DeleteUserCallbackGet200ResponseMessageEnum;
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
  DeleteUserCallbackGet200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = DeleteUserCallbackGet200ResponseBuilder();
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

class DeleteUserCallbackGet200ResponseMessageEnum extends EnumClass {
  /// Confirmation message
  @BuiltValueEnumConst(wireName: r'User deleted')
  static const DeleteUserCallbackGet200ResponseMessageEnum userDeleted =
      _$deleteUserCallbackGet200ResponseMessageEnum_userDeleted;

  static Serializer<DeleteUserCallbackGet200ResponseMessageEnum>
      get serializer => _$deleteUserCallbackGet200ResponseMessageEnumSerializer;

  const DeleteUserCallbackGet200ResponseMessageEnum._(String name)
      : super(name);

  static BuiltSet<DeleteUserCallbackGet200ResponseMessageEnum> get values =>
      _$deleteUserCallbackGet200ResponseMessageEnumValues;
  static DeleteUserCallbackGet200ResponseMessageEnum valueOf(String name) =>
      _$deleteUserCallbackGet200ResponseMessageEnumValueOf(name);
}
