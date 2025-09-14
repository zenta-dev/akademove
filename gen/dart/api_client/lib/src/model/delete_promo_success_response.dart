//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/json_object.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'delete_promo_success_response.g.dart';

/// DeletePromoSuccessResponse
///
/// Properties:
/// * [success] 
/// * [message] 
/// * [data] 
@BuiltValue()
abstract class DeletePromoSuccessResponse implements Built<DeletePromoSuccessResponse, DeletePromoSuccessResponseBuilder> {
  @BuiltValueField(wireName: r'success')
  DeletePromoSuccessResponseSuccessEnum get success;
  // enum successEnum {  true,  };

  @BuiltValueField(wireName: r'message')
  String get message;

  @BuiltValueField(wireName: r'data')
  JsonObject? get data;

  DeletePromoSuccessResponse._();

  factory DeletePromoSuccessResponse([void updates(DeletePromoSuccessResponseBuilder b)]) = _$DeletePromoSuccessResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(DeletePromoSuccessResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<DeletePromoSuccessResponse> get serializer => _$DeletePromoSuccessResponseSerializer();
}

class _$DeletePromoSuccessResponseSerializer implements PrimitiveSerializer<DeletePromoSuccessResponse> {
  @override
  final Iterable<Type> types = const [DeletePromoSuccessResponse, _$DeletePromoSuccessResponse];

  @override
  final String wireName = r'DeletePromoSuccessResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    DeletePromoSuccessResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'success';
    yield serializers.serialize(
      object.success,
      specifiedType: const FullType(DeletePromoSuccessResponseSuccessEnum),
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
    DeletePromoSuccessResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required DeletePromoSuccessResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'success':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DeletePromoSuccessResponseSuccessEnum),
          ) as DeletePromoSuccessResponseSuccessEnum;
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
  DeletePromoSuccessResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = DeletePromoSuccessResponseBuilder();
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

class DeletePromoSuccessResponseSuccessEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'true')
  static const DeletePromoSuccessResponseSuccessEnum true_ = _$deletePromoSuccessResponseSuccessEnum_true_;

  static Serializer<DeletePromoSuccessResponseSuccessEnum> get serializer => _$deletePromoSuccessResponseSuccessEnumSerializer;

  const DeletePromoSuccessResponseSuccessEnum._(String name): super(name);

  static BuiltSet<DeletePromoSuccessResponseSuccessEnum> get values => _$deletePromoSuccessResponseSuccessEnumValues;
  static DeletePromoSuccessResponseSuccessEnum valueOf(String name) => _$deletePromoSuccessResponseSuccessEnumValueOf(name);
}

