//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/json_object.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'delete_merchant_success_response.g.dart';

/// DeleteMerchantSuccessResponse
///
/// Properties:
/// * [success] 
/// * [message] 
/// * [data] 
@BuiltValue()
abstract class DeleteMerchantSuccessResponse implements Built<DeleteMerchantSuccessResponse, DeleteMerchantSuccessResponseBuilder> {
  @BuiltValueField(wireName: r'success')
  DeleteMerchantSuccessResponseSuccessEnum get success;
  // enum successEnum {  true,  };

  @BuiltValueField(wireName: r'message')
  String get message;

  @BuiltValueField(wireName: r'data')
  JsonObject? get data;

  DeleteMerchantSuccessResponse._();

  factory DeleteMerchantSuccessResponse([void updates(DeleteMerchantSuccessResponseBuilder b)]) = _$DeleteMerchantSuccessResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(DeleteMerchantSuccessResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<DeleteMerchantSuccessResponse> get serializer => _$DeleteMerchantSuccessResponseSerializer();
}

class _$DeleteMerchantSuccessResponseSerializer implements PrimitiveSerializer<DeleteMerchantSuccessResponse> {
  @override
  final Iterable<Type> types = const [DeleteMerchantSuccessResponse, _$DeleteMerchantSuccessResponse];

  @override
  final String wireName = r'DeleteMerchantSuccessResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    DeleteMerchantSuccessResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'success';
    yield serializers.serialize(
      object.success,
      specifiedType: const FullType(DeleteMerchantSuccessResponseSuccessEnum),
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
    DeleteMerchantSuccessResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required DeleteMerchantSuccessResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'success':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DeleteMerchantSuccessResponseSuccessEnum),
          ) as DeleteMerchantSuccessResponseSuccessEnum;
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
  DeleteMerchantSuccessResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = DeleteMerchantSuccessResponseBuilder();
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

class DeleteMerchantSuccessResponseSuccessEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'true')
  static const DeleteMerchantSuccessResponseSuccessEnum true_ = _$deleteMerchantSuccessResponseSuccessEnum_true_;

  static Serializer<DeleteMerchantSuccessResponseSuccessEnum> get serializer => _$deleteMerchantSuccessResponseSuccessEnumSerializer;

  const DeleteMerchantSuccessResponseSuccessEnum._(String name): super(name);

  static BuiltSet<DeleteMerchantSuccessResponseSuccessEnum> get values => _$deleteMerchantSuccessResponseSuccessEnumValues;
  static DeleteMerchantSuccessResponseSuccessEnum valueOf(String name) => _$deleteMerchantSuccessResponseSuccessEnumValueOf(name);
}

