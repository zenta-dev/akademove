//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/report.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'report_create200_response.g.dart';

/// ReportCreate200Response
///
/// Properties:
/// * [message] 
/// * [data] 
@BuiltValue()
abstract class ReportCreate200Response implements Built<ReportCreate200Response, ReportCreate200ResponseBuilder> {
  @BuiltValueField(wireName: r'message')
  String get message;

  @BuiltValueField(wireName: r'data')
  Report get data;

  ReportCreate200Response._();

  factory ReportCreate200Response([void updates(ReportCreate200ResponseBuilder b)]) = _$ReportCreate200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ReportCreate200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ReportCreate200Response> get serializer => _$ReportCreate200ResponseSerializer();
}

class _$ReportCreate200ResponseSerializer implements PrimitiveSerializer<ReportCreate200Response> {
  @override
  final Iterable<Type> types = const [ReportCreate200Response, _$ReportCreate200Response];

  @override
  final String wireName = r'ReportCreate200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ReportCreate200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
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
    ReportCreate200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ReportCreate200ResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
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
  ReportCreate200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ReportCreate200ResponseBuilder();
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

