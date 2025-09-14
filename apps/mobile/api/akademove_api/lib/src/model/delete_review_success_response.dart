//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/json_object.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'delete_review_success_response.g.dart';

/// DeleteReviewSuccessResponse
///
/// Properties:
/// * [success]
/// * [message]
/// * [data]
@BuiltValue()
abstract class DeleteReviewSuccessResponse
    implements
        Built<DeleteReviewSuccessResponse, DeleteReviewSuccessResponseBuilder> {
  @BuiltValueField(wireName: r'success')
  DeleteReviewSuccessResponseSuccessEnum get success;
  // enum successEnum {  true,  };

  @BuiltValueField(wireName: r'message')
  String get message;

  @BuiltValueField(wireName: r'data')
  JsonObject? get data;

  DeleteReviewSuccessResponse._();

  factory DeleteReviewSuccessResponse(
          [void updates(DeleteReviewSuccessResponseBuilder b)]) =
      _$DeleteReviewSuccessResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(DeleteReviewSuccessResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<DeleteReviewSuccessResponse> get serializer =>
      _$DeleteReviewSuccessResponseSerializer();
}

class _$DeleteReviewSuccessResponseSerializer
    implements PrimitiveSerializer<DeleteReviewSuccessResponse> {
  @override
  final Iterable<Type> types = const [
    DeleteReviewSuccessResponse,
    _$DeleteReviewSuccessResponse
  ];

  @override
  final String wireName = r'DeleteReviewSuccessResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    DeleteReviewSuccessResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'success';
    yield serializers.serialize(
      object.success,
      specifiedType: const FullType(DeleteReviewSuccessResponseSuccessEnum),
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
    DeleteReviewSuccessResponse object, {
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
    required DeleteReviewSuccessResponseBuilder result,
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
                const FullType(DeleteReviewSuccessResponseSuccessEnum),
          ) as DeleteReviewSuccessResponseSuccessEnum;
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
  DeleteReviewSuccessResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = DeleteReviewSuccessResponseBuilder();
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

class DeleteReviewSuccessResponseSuccessEnum extends EnumClass {
  @BuiltValueEnumConst(wireName: r'true')
  static const DeleteReviewSuccessResponseSuccessEnum true_ =
      _$deleteReviewSuccessResponseSuccessEnum_true_;

  static Serializer<DeleteReviewSuccessResponseSuccessEnum> get serializer =>
      _$deleteReviewSuccessResponseSuccessEnumSerializer;

  const DeleteReviewSuccessResponseSuccessEnum._(String name) : super(name);

  static BuiltSet<DeleteReviewSuccessResponseSuccessEnum> get values =>
      _$deleteReviewSuccessResponseSuccessEnumValues;
  static DeleteReviewSuccessResponseSuccessEnum valueOf(String name) =>
      _$deleteReviewSuccessResponseSuccessEnumValueOf(name);
}
