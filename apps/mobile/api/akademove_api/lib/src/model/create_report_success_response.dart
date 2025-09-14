//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:akademove_api/src/model/report.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'create_report_success_response.g.dart';

/// CreateReportSuccessResponse
///
/// Properties:
/// * [success]
/// * [message]
/// * [data]
@BuiltValue()
abstract class CreateReportSuccessResponse
    implements
        Built<CreateReportSuccessResponse, CreateReportSuccessResponseBuilder> {
  @BuiltValueField(wireName: r'success')
  CreateReportSuccessResponseSuccessEnum get success;
  // enum successEnum {  true,  };

  @BuiltValueField(wireName: r'message')
  String get message;

  @BuiltValueField(wireName: r'data')
  Report get data;

  CreateReportSuccessResponse._();

  factory CreateReportSuccessResponse(
          [void updates(CreateReportSuccessResponseBuilder b)]) =
      _$CreateReportSuccessResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(CreateReportSuccessResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<CreateReportSuccessResponse> get serializer =>
      _$CreateReportSuccessResponseSerializer();
}

class _$CreateReportSuccessResponseSerializer
    implements PrimitiveSerializer<CreateReportSuccessResponse> {
  @override
  final Iterable<Type> types = const [
    CreateReportSuccessResponse,
    _$CreateReportSuccessResponse
  ];

  @override
  final String wireName = r'CreateReportSuccessResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    CreateReportSuccessResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'success';
    yield serializers.serialize(
      object.success,
      specifiedType: const FullType(CreateReportSuccessResponseSuccessEnum),
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
    CreateReportSuccessResponse object, {
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
    required CreateReportSuccessResponseBuilder result,
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
                const FullType(CreateReportSuccessResponseSuccessEnum),
          ) as CreateReportSuccessResponseSuccessEnum;
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
  CreateReportSuccessResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = CreateReportSuccessResponseBuilder();
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

class CreateReportSuccessResponseSuccessEnum extends EnumClass {
  @BuiltValueEnumConst(wireName: r'true')
  static const CreateReportSuccessResponseSuccessEnum true_ =
      _$createReportSuccessResponseSuccessEnum_true_;

  static Serializer<CreateReportSuccessResponseSuccessEnum> get serializer =>
      _$createReportSuccessResponseSuccessEnumSerializer;

  const CreateReportSuccessResponseSuccessEnum._(String name) : super(name);

  static BuiltSet<CreateReportSuccessResponseSuccessEnum> get values =>
      _$createReportSuccessResponseSuccessEnumValues;
  static CreateReportSuccessResponseSuccessEnum valueOf(String name) =>
      _$createReportSuccessResponseSuccessEnumValueOf(name);
}
