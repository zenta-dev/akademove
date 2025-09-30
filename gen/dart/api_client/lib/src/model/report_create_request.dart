//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'report_create_request.g.dart';

/// ReportCreateRequest
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
abstract class ReportCreateRequest implements Built<ReportCreateRequest, ReportCreateRequestBuilder> {
  @BuiltValueField(wireName: r'orderId')
  String? get orderId;

  @BuiltValueField(wireName: r'reporterId')
  String get reporterId;

  @BuiltValueField(wireName: r'targetUserId')
  String get targetUserId;

  @BuiltValueField(wireName: r'category')
  ReportCreateRequestCategoryEnum? get category;
  // enum categoryEnum {  behavior,  safety,  fraud,  other,  };

  @BuiltValueField(wireName: r'description')
  String get description;

  @BuiltValueField(wireName: r'evidenceUrl')
  String? get evidenceUrl;

  @BuiltValueField(wireName: r'status')
  ReportCreateRequestStatusEnum? get status;
  // enum statusEnum {  pending,  investigating,  resolved,  dismissed,  };

  @BuiltValueField(wireName: r'handledById')
  String? get handledById;

  @BuiltValueField(wireName: r'resolution')
  String? get resolution;

  ReportCreateRequest._();

  factory ReportCreateRequest([void updates(ReportCreateRequestBuilder b)]) = _$ReportCreateRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ReportCreateRequestBuilder b) => b
      ..category = const ReportCreateRequestCategoryEnum._('other')
      ..status = const ReportCreateRequestStatusEnum._('pending');

  @BuiltValueSerializer(custom: true)
  static Serializer<ReportCreateRequest> get serializer => _$ReportCreateRequestSerializer();
}

class _$ReportCreateRequestSerializer implements PrimitiveSerializer<ReportCreateRequest> {
  @override
  final Iterable<Type> types = const [ReportCreateRequest, _$ReportCreateRequest];

  @override
  final String wireName = r'ReportCreateRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ReportCreateRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.orderId != null) {
      yield r'orderId';
      yield serializers.serialize(
        object.orderId,
        specifiedType: const FullType(String),
      );
    }
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
    if (object.category != null) {
      yield r'category';
      yield serializers.serialize(
        object.category,
        specifiedType: const FullType(ReportCreateRequestCategoryEnum),
      );
    }
    yield r'description';
    yield serializers.serialize(
      object.description,
      specifiedType: const FullType(String),
    );
    if (object.evidenceUrl != null) {
      yield r'evidenceUrl';
      yield serializers.serialize(
        object.evidenceUrl,
        specifiedType: const FullType(String),
      );
    }
    if (object.status != null) {
      yield r'status';
      yield serializers.serialize(
        object.status,
        specifiedType: const FullType(ReportCreateRequestStatusEnum),
      );
    }
    if (object.handledById != null) {
      yield r'handledById';
      yield serializers.serialize(
        object.handledById,
        specifiedType: const FullType(String),
      );
    }
    if (object.resolution != null) {
      yield r'resolution';
      yield serializers.serialize(
        object.resolution,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    ReportCreateRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ReportCreateRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'orderId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
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
            specifiedType: const FullType(ReportCreateRequestCategoryEnum),
          ) as ReportCreateRequestCategoryEnum;
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
            specifiedType: const FullType(String),
          ) as String;
          result.evidenceUrl = valueDes;
          break;
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(ReportCreateRequestStatusEnum),
          ) as ReportCreateRequestStatusEnum;
          result.status = valueDes;
          break;
        case r'handledById':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.handledById = valueDes;
          break;
        case r'resolution':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
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
  ReportCreateRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ReportCreateRequestBuilder();
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

class ReportCreateRequestCategoryEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'behavior')
  static const ReportCreateRequestCategoryEnum behavior = _$reportCreateRequestCategoryEnum_behavior;
  @BuiltValueEnumConst(wireName: r'safety')
  static const ReportCreateRequestCategoryEnum safety = _$reportCreateRequestCategoryEnum_safety;
  @BuiltValueEnumConst(wireName: r'fraud')
  static const ReportCreateRequestCategoryEnum fraud = _$reportCreateRequestCategoryEnum_fraud;
  @BuiltValueEnumConst(wireName: r'other')
  static const ReportCreateRequestCategoryEnum other = _$reportCreateRequestCategoryEnum_other;

  static Serializer<ReportCreateRequestCategoryEnum> get serializer => _$reportCreateRequestCategoryEnumSerializer;

  const ReportCreateRequestCategoryEnum._(String name): super(name);

  static BuiltSet<ReportCreateRequestCategoryEnum> get values => _$reportCreateRequestCategoryEnumValues;
  static ReportCreateRequestCategoryEnum valueOf(String name) => _$reportCreateRequestCategoryEnumValueOf(name);
}

class ReportCreateRequestStatusEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'pending')
  static const ReportCreateRequestStatusEnum pending = _$reportCreateRequestStatusEnum_pending;
  @BuiltValueEnumConst(wireName: r'investigating')
  static const ReportCreateRequestStatusEnum investigating = _$reportCreateRequestStatusEnum_investigating;
  @BuiltValueEnumConst(wireName: r'resolved')
  static const ReportCreateRequestStatusEnum resolved = _$reportCreateRequestStatusEnum_resolved;
  @BuiltValueEnumConst(wireName: r'dismissed')
  static const ReportCreateRequestStatusEnum dismissed = _$reportCreateRequestStatusEnum_dismissed;

  static Serializer<ReportCreateRequestStatusEnum> get serializer => _$reportCreateRequestStatusEnumSerializer;

  const ReportCreateRequestStatusEnum._(String name): super(name);

  static BuiltSet<ReportCreateRequestStatusEnum> get values => _$reportCreateRequestStatusEnumValues;
  static ReportCreateRequestStatusEnum valueOf(String name) => _$reportCreateRequestStatusEnumValueOf(name);
}

