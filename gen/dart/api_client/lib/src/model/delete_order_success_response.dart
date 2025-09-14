//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/json_object.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'delete_order_success_response.g.dart';

/// DeleteOrderSuccessResponse
///
/// Properties:
/// * [success] 
/// * [message] 
/// * [data] 
@BuiltValue()
abstract class DeleteOrderSuccessResponse implements Built<DeleteOrderSuccessResponse, DeleteOrderSuccessResponseBuilder> {
  @BuiltValueField(wireName: r'success')
  DeleteOrderSuccessResponseSuccessEnum get success;
  // enum successEnum {  true,  };

  @BuiltValueField(wireName: r'message')
  String get message;

  @BuiltValueField(wireName: r'data')
  JsonObject? get data;

  DeleteOrderSuccessResponse._();

  factory DeleteOrderSuccessResponse([void updates(DeleteOrderSuccessResponseBuilder b)]) = _$DeleteOrderSuccessResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(DeleteOrderSuccessResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<DeleteOrderSuccessResponse> get serializer => _$DeleteOrderSuccessResponseSerializer();
}

class _$DeleteOrderSuccessResponseSerializer implements PrimitiveSerializer<DeleteOrderSuccessResponse> {
  @override
  final Iterable<Type> types = const [DeleteOrderSuccessResponse, _$DeleteOrderSuccessResponse];

  @override
  final String wireName = r'DeleteOrderSuccessResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    DeleteOrderSuccessResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'success';
    yield serializers.serialize(
      object.success,
      specifiedType: const FullType(DeleteOrderSuccessResponseSuccessEnum),
    );
    yield r'message';
    yield serializers.serialize(
      object.message,
      specifiedType: const FullType(String),
    );
    yield r'data';
    yield object.data == null ? null : serializers.serialize(
      object.data,
      specifiedType: const FullType.nullable(JsonObject),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    DeleteOrderSuccessResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required DeleteOrderSuccessResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'success':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DeleteOrderSuccessResponseSuccessEnum),
          ) as DeleteOrderSuccessResponseSuccessEnum;
          result.success = valueDes;
          break;
        case r'message':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.message = valueDes;
          break;
        case r'data':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(JsonObject),
          ) as JsonObject?;
          if (valueDes == null) continue;
          result.data = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  DeleteOrderSuccessResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = DeleteOrderSuccessResponseBuilder();
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

class DeleteOrderSuccessResponseSuccessEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'true')
  static const DeleteOrderSuccessResponseSuccessEnum true_ = _$deleteOrderSuccessResponseSuccessEnum_true_;

  static Serializer<DeleteOrderSuccessResponseSuccessEnum> get serializer => _$deleteOrderSuccessResponseSuccessEnumSerializer;

  const DeleteOrderSuccessResponseSuccessEnum._(String name): super(name);

  static BuiltSet<DeleteOrderSuccessResponseSuccessEnum> get values => _$deleteOrderSuccessResponseSuccessEnumValues;
  static DeleteOrderSuccessResponseSuccessEnum valueOf(String name) => _$deleteOrderSuccessResponseSuccessEnumValueOf(name);
}

