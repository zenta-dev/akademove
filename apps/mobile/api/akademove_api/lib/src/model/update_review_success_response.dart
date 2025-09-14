//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:akademove_api/src/model/review.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'update_review_success_response.g.dart';

/// UpdateReviewSuccessResponse
///
/// Properties:
/// * [success]
/// * [message]
/// * [data]
@BuiltValue()
abstract class UpdateReviewSuccessResponse
    implements
        Built<UpdateReviewSuccessResponse, UpdateReviewSuccessResponseBuilder> {
  @BuiltValueField(wireName: r'success')
  UpdateReviewSuccessResponseSuccessEnum get success;
  // enum successEnum {  true,  };

  @BuiltValueField(wireName: r'message')
  String get message;

  @BuiltValueField(wireName: r'data')
  Review get data;

  UpdateReviewSuccessResponse._();

  factory UpdateReviewSuccessResponse(
          [void updates(UpdateReviewSuccessResponseBuilder b)]) =
      _$UpdateReviewSuccessResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(UpdateReviewSuccessResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<UpdateReviewSuccessResponse> get serializer =>
      _$UpdateReviewSuccessResponseSerializer();
}

class _$UpdateReviewSuccessResponseSerializer
    implements PrimitiveSerializer<UpdateReviewSuccessResponse> {
  @override
  final Iterable<Type> types = const [
    UpdateReviewSuccessResponse,
    _$UpdateReviewSuccessResponse
  ];

  @override
  final String wireName = r'UpdateReviewSuccessResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    UpdateReviewSuccessResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'success';
    yield serializers.serialize(
      object.success,
      specifiedType: const FullType(UpdateReviewSuccessResponseSuccessEnum),
    );
    yield r'message';
    yield serializers.serialize(
      object.message,
      specifiedType: const FullType(String),
    );
    yield r'data';
    yield serializers.serialize(
      object.data,
      specifiedType: const FullType(Review),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    UpdateReviewSuccessResponse object, {
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
    required UpdateReviewSuccessResponseBuilder result,
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
                const FullType(UpdateReviewSuccessResponseSuccessEnum),
          ) as UpdateReviewSuccessResponseSuccessEnum;
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
            specifiedType: const FullType(Review),
          ) as Review;
          result.data.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  UpdateReviewSuccessResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = UpdateReviewSuccessResponseBuilder();
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

class UpdateReviewSuccessResponseSuccessEnum extends EnumClass {
  @BuiltValueEnumConst(wireName: r'true')
  static const UpdateReviewSuccessResponseSuccessEnum true_ =
      _$updateReviewSuccessResponseSuccessEnum_true_;

  static Serializer<UpdateReviewSuccessResponseSuccessEnum> get serializer =>
      _$updateReviewSuccessResponseSuccessEnumSerializer;

  const UpdateReviewSuccessResponseSuccessEnum._(String name) : super(name);

  static BuiltSet<UpdateReviewSuccessResponseSuccessEnum> get values =>
      _$updateReviewSuccessResponseSuccessEnumValues;
  static UpdateReviewSuccessResponseSuccessEnum valueOf(String name) =>
      _$updateReviewSuccessResponseSuccessEnumValueOf(name);
}
