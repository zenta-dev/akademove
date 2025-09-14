//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'create_report_request.g.dart';

/// CreateReportRequest
///
/// Properties:
/// * [orderId] 
/// * [reporterId] 
/// * [targetUserId] 
/// * [category] 
/// * [description] 
/// * [evidenceUrl] 
/// * [status] 
/// * [handledById] 
/// * [resolution] 
@BuiltValue()
abstract class CreateReportRequest implements Built<CreateReportRequest, CreateReportRequestBuilder> {
  @BuiltValueField(wireName: r'orderId')
  String? get orderId;

  @BuiltValueField(wireName: r'reporterId')
  String get reporterId;

  @BuiltValueField(wireName: r'targetUserId')
  String get targetUserId;

  @BuiltValueField(wireName: r'category')
  CreateReportRequestCategoryEnum get category;
  // enum categoryEnum {  behavior,  safety,  fraud,  other,  };

  @BuiltValueField(wireName: r'description')
  String get description;

  @BuiltValueField(wireName: r'evidenceUrl')
  String? get evidenceUrl;

  @BuiltValueField(wireName: r'status')
  CreateReportRequestStatusEnum? get status;
  // enum statusEnum {  pending,  investigating,  resolved,  dismissed,  };

  @BuiltValueField(wireName: r'handledById')
  String? get handledById;

  @BuiltValueField(wireName: r'resolution')
  String? get resolution;

  CreateReportRequest._();

  factory CreateReportRequest([void updates(CreateReportRequestBuilder b)]) = _$CreateReportRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(CreateReportRequestBuilder b) => b
      ..status = const CreateReportRequestStatusEnum._('pending');

  @BuiltValueSerializer(custom: true)
  static Serializer<CreateReportRequest> get serializer => _$CreateReportRequestSerializer();
}

class _$CreateReportRequestSerializer implements PrimitiveSerializer<CreateReportRequest> {
  @override
  final Iterable<Type> types = const [CreateReportRequest, _$CreateReportRequest];

  @override
  final String wireName = r'CreateReportRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    CreateReportRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'orderId';
    yield object.orderId == null ? null : serializers.serialize(
      object.orderId,
      specifiedType: const FullType.nullable(String),
    );
    yield r'reporterId';
    yield serializers.serialize(
      object.reporterId,
      specifiedType: const FullType(String),
    );
    yield r'targetUserId';
    yield serializers.serialize(
      object.targetUserId,
      specifiedType: const FullType(String),
    );
    yield r'category';
    yield serializers.serialize(
      object.category,
      specifiedType: const FullType(CreateReportRequestCategoryEnum),
    );
    yield r'description';
    yield serializers.serialize(
      object.description,
      specifiedType: const FullType(String),
    );
    yield r'evidenceUrl';
    yield object.evidenceUrl == null ? null : serializers.serialize(
      object.evidenceUrl,
      specifiedType: const FullType.nullable(String),
    );
    if (object.status != null) {
      yield r'status';
      yield serializers.serialize(
        object.status,
        specifiedType: const FullType(CreateReportRequestStatusEnum),
      );
    }
    yield r'handledById';
    yield object.handledById == null ? null : serializers.serialize(
      object.handledById,
      specifiedType: const FullType.nullable(String),
    );
    yield r'resolution';
    yield object.resolution == null ? null : serializers.serialize(
      object.resolution,
      specifiedType: const FullType.nullable(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    CreateReportRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required CreateReportRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'orderId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.orderId = valueDes;
          break;
        case r'reporterId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.reporterId = valueDes;
          break;
        case r'targetUserId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.targetUserId = valueDes;
          break;
        case r'category':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(CreateReportRequestCategoryEnum),
          ) as CreateReportRequestCategoryEnum;
          result.category = valueDes;
          break;
        case r'description':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.description = valueDes;
          break;
        case r'evidenceUrl':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.evidenceUrl = valueDes;
          break;
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(CreateReportRequestStatusEnum),
          ) as CreateReportRequestStatusEnum;
          result.status = valueDes;
          break;
        case r'handledById':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.handledById = valueDes;
          break;
        case r'resolution':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.resolution = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  CreateReportRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = CreateReportRequestBuilder();
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

class CreateReportRequestCategoryEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'behavior')
  static const CreateReportRequestCategoryEnum behavior = _$createReportRequestCategoryEnum_behavior;
  @BuiltValueEnumConst(wireName: r'safety')
  static const CreateReportRequestCategoryEnum safety = _$createReportRequestCategoryEnum_safety;
  @BuiltValueEnumConst(wireName: r'fraud')
  static const CreateReportRequestCategoryEnum fraud = _$createReportRequestCategoryEnum_fraud;
  @BuiltValueEnumConst(wireName: r'other')
  static const CreateReportRequestCategoryEnum other = _$createReportRequestCategoryEnum_other;

  static Serializer<CreateReportRequestCategoryEnum> get serializer => _$createReportRequestCategoryEnumSerializer;

  const CreateReportRequestCategoryEnum._(String name): super(name);

  static BuiltSet<CreateReportRequestCategoryEnum> get values => _$createReportRequestCategoryEnumValues;
  static CreateReportRequestCategoryEnum valueOf(String name) => _$createReportRequestCategoryEnumValueOf(name);
}

class CreateReportRequestStatusEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'pending')
  static const CreateReportRequestStatusEnum pending = _$createReportRequestStatusEnum_pending;
  @BuiltValueEnumConst(wireName: r'investigating')
  static const CreateReportRequestStatusEnum investigating = _$createReportRequestStatusEnum_investigating;
  @BuiltValueEnumConst(wireName: r'resolved')
  static const CreateReportRequestStatusEnum resolved = _$createReportRequestStatusEnum_resolved;
  @BuiltValueEnumConst(wireName: r'dismissed')
  static const CreateReportRequestStatusEnum dismissed = _$createReportRequestStatusEnum_dismissed;

  static Serializer<CreateReportRequestStatusEnum> get serializer => _$createReportRequestStatusEnumSerializer;

  const CreateReportRequestStatusEnum._(String name): super(name);

  static BuiltSet<CreateReportRequestStatusEnum> get values => _$createReportRequestStatusEnumValues;
  static CreateReportRequestStatusEnum valueOf(String name) => _$createReportRequestStatusEnumValueOf(name);
}

