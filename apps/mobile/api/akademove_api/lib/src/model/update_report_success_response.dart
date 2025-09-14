//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:akademove_api/src/model/report.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'update_report_success_response.g.dart';

/// UpdateReportSuccessResponse
///
/// Properties:
/// * [success]
/// * [message]
/// * [data]
@BuiltValue()
abstract class UpdateReportSuccessResponse
    implements
        Built<UpdateReportSuccessResponse, UpdateReportSuccessResponseBuilder> {
  @BuiltValueField(wireName: r'success')
  UpdateReportSuccessResponseSuccessEnum get success;
  // enum successEnum {  true,  };

  @BuiltValueField(wireName: r'message')
  String get message;

  @BuiltValueField(wireName: r'data')
  Report get data;

  UpdateReportSuccessResponse._();

  factory UpdateReportSuccessResponse(
          [void updates(UpdateReportSuccessResponseBuilder b)]) =
      _$UpdateReportSuccessResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(UpdateReportSuccessResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<UpdateReportSuccessResponse> get serializer =>
      _$UpdateReportSuccessResponseSerializer();
}

class _$UpdateReportSuccessResponseSerializer
    implements PrimitiveSerializer<UpdateReportSuccessResponse> {
  @override
  final Iterable<Type> types = const [
    UpdateReportSuccessResponse,
    _$UpdateReportSuccessResponse
  ];

  @override
  final String wireName = r'UpdateReportSuccessResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    UpdateReportSuccessResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'success';
    yield serializers.serialize(
      object.success,
      specifiedType: const FullType(UpdateReportSuccessResponseSuccessEnum),
    );
    yield r'message';
    yield serializers.serialize(
      object.message,
      specifiedType: const FullType(String),
    );
    yield r'data';
    yield serializers.serialize(
      object.data,
      specifiedType: const FullType(Report),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    UpdateReportSuccessResponse object, {
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
    required UpdateReportSuccessResponseBuilder result,
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
                const FullType(UpdateReportSuccessResponseSuccessEnum),
          ) as UpdateReportSuccessResponseSuccessEnum;
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
            specifiedType: const FullType(Report),
          ) as Report;
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
  UpdateReportSuccessResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = UpdateReportSuccessResponseBuilder();
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

class UpdateReportSuccessResponseSuccessEnum extends EnumClass {
  @BuiltValueEnumConst(wireName: r'true')
  static const UpdateReportSuccessResponseSuccessEnum true_ =
      _$updateReportSuccessResponseSuccessEnum_true_;

  static Serializer<UpdateReportSuccessResponseSuccessEnum> get serializer =>
      _$updateReportSuccessResponseSuccessEnumSerializer;

  const UpdateReportSuccessResponseSuccessEnum._(String name) : super(name);

  static BuiltSet<UpdateReportSuccessResponseSuccessEnum> get values =>
      _$updateReportSuccessResponseSuccessEnumValues;
  static UpdateReportSuccessResponseSuccessEnum valueOf(String name) =>
      _$updateReportSuccessResponseSuccessEnumValueOf(name);
}
