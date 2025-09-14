//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/json_object.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'delete_report_success_response.g.dart';

/// DeleteReportSuccessResponse
///
/// Properties:
/// * [success] 
/// * [message] 
/// * [data] 
@BuiltValue()
abstract class DeleteReportSuccessResponse implements Built<DeleteReportSuccessResponse, DeleteReportSuccessResponseBuilder> {
  @BuiltValueField(wireName: r'success')
  DeleteReportSuccessResponseSuccessEnum get success;
  // enum successEnum {  true,  };

  @BuiltValueField(wireName: r'message')
  String get message;

  @BuiltValueField(wireName: r'data')
  JsonObject? get data;

  DeleteReportSuccessResponse._();

  factory DeleteReportSuccessResponse([void updates(DeleteReportSuccessResponseBuilder b)]) = _$DeleteReportSuccessResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(DeleteReportSuccessResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<DeleteReportSuccessResponse> get serializer => _$DeleteReportSuccessResponseSerializer();
}

class _$DeleteReportSuccessResponseSerializer implements PrimitiveSerializer<DeleteReportSuccessResponse> {
  @override
  final Iterable<Type> types = const [DeleteReportSuccessResponse, _$DeleteReportSuccessResponse];

  @override
  final String wireName = r'DeleteReportSuccessResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    DeleteReportSuccessResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'success';
    yield serializers.serialize(
      object.success,
      specifiedType: const FullType(DeleteReportSuccessResponseSuccessEnum),
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
    DeleteReportSuccessResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required DeleteReportSuccessResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'success':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DeleteReportSuccessResponseSuccessEnum),
          ) as DeleteReportSuccessResponseSuccessEnum;
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
  DeleteReportSuccessResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = DeleteReportSuccessResponseBuilder();
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

class DeleteReportSuccessResponseSuccessEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'true')
  static const DeleteReportSuccessResponseSuccessEnum true_ = _$deleteReportSuccessResponseSuccessEnum_true_;

  static Serializer<DeleteReportSuccessResponseSuccessEnum> get serializer => _$deleteReportSuccessResponseSuccessEnumSerializer;

  const DeleteReportSuccessResponseSuccessEnum._(String name): super(name);

  static BuiltSet<DeleteReportSuccessResponseSuccessEnum> get values => _$deleteReportSuccessResponseSuccessEnumValues;
  static DeleteReportSuccessResponseSuccessEnum valueOf(String name) => _$deleteReportSuccessResponseSuccessEnumValueOf(name);
}

