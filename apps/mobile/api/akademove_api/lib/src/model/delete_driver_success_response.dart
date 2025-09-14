//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/json_object.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'delete_driver_success_response.g.dart';

/// DeleteDriverSuccessResponse
///
/// Properties:
/// * [success]
/// * [message]
/// * [data]
@BuiltValue()
abstract class DeleteDriverSuccessResponse
    implements
        Built<DeleteDriverSuccessResponse, DeleteDriverSuccessResponseBuilder> {
  @BuiltValueField(wireName: r'success')
  DeleteDriverSuccessResponseSuccessEnum get success;
  // enum successEnum {  true,  };

  @BuiltValueField(wireName: r'message')
  String get message;

  @BuiltValueField(wireName: r'data')
  JsonObject? get data;

  DeleteDriverSuccessResponse._();

  factory DeleteDriverSuccessResponse(
          [void updates(DeleteDriverSuccessResponseBuilder b)]) =
      _$DeleteDriverSuccessResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(DeleteDriverSuccessResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<DeleteDriverSuccessResponse> get serializer =>
      _$DeleteDriverSuccessResponseSerializer();
}

class _$DeleteDriverSuccessResponseSerializer
    implements PrimitiveSerializer<DeleteDriverSuccessResponse> {
  @override
  final Iterable<Type> types = const [
    DeleteDriverSuccessResponse,
    _$DeleteDriverSuccessResponse
  ];

  @override
  final String wireName = r'DeleteDriverSuccessResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    DeleteDriverSuccessResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'success';
    yield serializers.serialize(
      object.success,
      specifiedType: const FullType(DeleteDriverSuccessResponseSuccessEnum),
    );
    yield r'message';
    yield serializers.serialize(
      object.message,
      specifiedType: const FullType(String),
    );
    yield r'data';
    yield object.data == null
        ? null
        : serializers.serialize(
            object.data,
            specifiedType: const FullType.nullable(JsonObject),
          );
  }

  @override
  Object serialize(
    Serializers serializers,
    DeleteDriverSuccessResponse object, {
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
    required DeleteDriverSuccessResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'success':
          final valueDes = serializers.deserialize(
            value,
            specifiedType:
                const FullType(DeleteDriverSuccessResponseSuccessEnum),
          ) as DeleteDriverSuccessResponseSuccessEnum;
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
  DeleteDriverSuccessResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = DeleteDriverSuccessResponseBuilder();
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

class DeleteDriverSuccessResponseSuccessEnum extends EnumClass {
  @BuiltValueEnumConst(wireName: r'true')
  static const DeleteDriverSuccessResponseSuccessEnum true_ =
      _$deleteDriverSuccessResponseSuccessEnum_true_;

  static Serializer<DeleteDriverSuccessResponseSuccessEnum> get serializer =>
      _$deleteDriverSuccessResponseSuccessEnumSerializer;

  const DeleteDriverSuccessResponseSuccessEnum._(String name) : super(name);

  static BuiltSet<DeleteDriverSuccessResponseSuccessEnum> get values =>
      _$deleteDriverSuccessResponseSuccessEnumValues;
  static DeleteDriverSuccessResponseSuccessEnum valueOf(String name) =>
      _$deleteDriverSuccessResponseSuccessEnumValueOf(name);
}
