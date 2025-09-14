//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/json_object.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'delete_schedule_success_response.g.dart';

/// DeleteScheduleSuccessResponse
///
/// Properties:
/// * [success] 
/// * [message] 
/// * [data] 
@BuiltValue()
abstract class DeleteScheduleSuccessResponse implements Built<DeleteScheduleSuccessResponse, DeleteScheduleSuccessResponseBuilder> {
  @BuiltValueField(wireName: r'success')
  DeleteScheduleSuccessResponseSuccessEnum get success;
  // enum successEnum {  true,  };

  @BuiltValueField(wireName: r'message')
  String get message;

  @BuiltValueField(wireName: r'data')
  JsonObject? get data;

  DeleteScheduleSuccessResponse._();

  factory DeleteScheduleSuccessResponse([void updates(DeleteScheduleSuccessResponseBuilder b)]) = _$DeleteScheduleSuccessResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(DeleteScheduleSuccessResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<DeleteScheduleSuccessResponse> get serializer => _$DeleteScheduleSuccessResponseSerializer();
}

class _$DeleteScheduleSuccessResponseSerializer implements PrimitiveSerializer<DeleteScheduleSuccessResponse> {
  @override
  final Iterable<Type> types = const [DeleteScheduleSuccessResponse, _$DeleteScheduleSuccessResponse];

  @override
  final String wireName = r'DeleteScheduleSuccessResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    DeleteScheduleSuccessResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'success';
    yield serializers.serialize(
      object.success,
      specifiedType: const FullType(DeleteScheduleSuccessResponseSuccessEnum),
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
    DeleteScheduleSuccessResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required DeleteScheduleSuccessResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'success':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DeleteScheduleSuccessResponseSuccessEnum),
          ) as DeleteScheduleSuccessResponseSuccessEnum;
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
  DeleteScheduleSuccessResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = DeleteScheduleSuccessResponseBuilder();
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

class DeleteScheduleSuccessResponseSuccessEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'true')
  static const DeleteScheduleSuccessResponseSuccessEnum true_ = _$deleteScheduleSuccessResponseSuccessEnum_true_;

  static Serializer<DeleteScheduleSuccessResponseSuccessEnum> get serializer => _$deleteScheduleSuccessResponseSuccessEnumSerializer;

  const DeleteScheduleSuccessResponseSuccessEnum._(String name): super(name);

  static BuiltSet<DeleteScheduleSuccessResponseSuccessEnum> get values => _$deleteScheduleSuccessResponseSuccessEnumValues;
  static DeleteScheduleSuccessResponseSuccessEnum valueOf(String name) => _$deleteScheduleSuccessResponseSuccessEnumValueOf(name);
}

