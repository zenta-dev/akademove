//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'report_update_request.g.dart';

/// ReportUpdateRequest
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
abstract class ReportUpdateRequest implements Built<ReportUpdateRequest, ReportUpdateRequestBuilder> {
  @BuiltValueField(wireName: r'orderId')
  String? get orderId;

  @BuiltValueField(wireName: r'reporterId')
  String? get reporterId;

  @BuiltValueField(wireName: r'targetUserId')
  String? get targetUserId;

  @BuiltValueField(wireName: r'category')
  ReportUpdateRequestCategoryEnum? get category;
  // enum categoryEnum {  behavior,  safety,  fraud,  other,  };

  @BuiltValueField(wireName: r'description')
  String? get description;

  @BuiltValueField(wireName: r'evidenceUrl')
  String? get evidenceUrl;

  @BuiltValueField(wireName: r'status')
  ReportUpdateRequestStatusEnum? get status;
  // enum statusEnum {  pending,  investigating,  resolved,  dismissed,  };

  @BuiltValueField(wireName: r'handledById')
  String? get handledById;

  @BuiltValueField(wireName: r'resolution')
  String? get resolution;

  ReportUpdateRequest._();

  factory ReportUpdateRequest([void updates(ReportUpdateRequestBuilder b)]) = _$ReportUpdateRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ReportUpdateRequestBuilder b) => b
      ..category = const ReportUpdateRequestCategoryEnum._('other')
      ..status = const ReportUpdateRequestStatusEnum._('pending');

  @BuiltValueSerializer(custom: true)
  static Serializer<ReportUpdateRequest> get serializer => _$ReportUpdateRequestSerializer();
}

class _$ReportUpdateRequestSerializer implements PrimitiveSerializer<ReportUpdateRequest> {
  @override
  final Iterable<Type> types = const [ReportUpdateRequest, _$ReportUpdateRequest];

  @override
  final String wireName = r'ReportUpdateRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ReportUpdateRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.orderId != null) {
      yield r'orderId';
      yield serializers.serialize(
        object.orderId,
        specifiedType: const FullType(String),
      );
    }
    if (object.reporterId != null) {
      yield r'reporterId';
      yield serializers.serialize(
        object.reporterId,
        specifiedType: const FullType(String),
      );
    }
    if (object.targetUserId != null) {
      yield r'targetUserId';
      yield serializers.serialize(
        object.targetUserId,
        specifiedType: const FullType(String),
      );
    }
    if (object.category != null) {
      yield r'category';
      yield serializers.serialize(
        object.category,
        specifiedType: const FullType(ReportUpdateRequestCategoryEnum),
      );
    }
    if (object.description != null) {
      yield r'description';
      yield serializers.serialize(
        object.description,
        specifiedType: const FullType(String),
      );
    }
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
        specifiedType: const FullType(ReportUpdateRequestStatusEnum),
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
    ReportUpdateRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ReportUpdateRequestBuilder result,
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
            specifiedType: const FullType(ReportUpdateRequestCategoryEnum),
          ) as ReportUpdateRequestCategoryEnum;
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
            specifiedType: const FullType(ReportUpdateRequestStatusEnum),
          ) as ReportUpdateRequestStatusEnum;
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
  ReportUpdateRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ReportUpdateRequestBuilder();
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

class ReportUpdateRequestCategoryEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'behavior')
  static const ReportUpdateRequestCategoryEnum behavior = _$reportUpdateRequestCategoryEnum_behavior;
  @BuiltValueEnumConst(wireName: r'safety')
  static const ReportUpdateRequestCategoryEnum safety = _$reportUpdateRequestCategoryEnum_safety;
  @BuiltValueEnumConst(wireName: r'fraud')
  static const ReportUpdateRequestCategoryEnum fraud = _$reportUpdateRequestCategoryEnum_fraud;
  @BuiltValueEnumConst(wireName: r'other')
  static const ReportUpdateRequestCategoryEnum other = _$reportUpdateRequestCategoryEnum_other;

  static Serializer<ReportUpdateRequestCategoryEnum> get serializer => _$reportUpdateRequestCategoryEnumSerializer;

  const ReportUpdateRequestCategoryEnum._(String name): super(name);

  static BuiltSet<ReportUpdateRequestCategoryEnum> get values => _$reportUpdateRequestCategoryEnumValues;
  static ReportUpdateRequestCategoryEnum valueOf(String name) => _$reportUpdateRequestCategoryEnumValueOf(name);
}

class ReportUpdateRequestStatusEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'pending')
  static const ReportUpdateRequestStatusEnum pending = _$reportUpdateRequestStatusEnum_pending;
  @BuiltValueEnumConst(wireName: r'investigating')
  static const ReportUpdateRequestStatusEnum investigating = _$reportUpdateRequestStatusEnum_investigating;
  @BuiltValueEnumConst(wireName: r'resolved')
  static const ReportUpdateRequestStatusEnum resolved = _$reportUpdateRequestStatusEnum_resolved;
  @BuiltValueEnumConst(wireName: r'dismissed')
  static const ReportUpdateRequestStatusEnum dismissed = _$reportUpdateRequestStatusEnum_dismissed;

  static Serializer<ReportUpdateRequestStatusEnum> get serializer => _$reportUpdateRequestStatusEnumSerializer;

  const ReportUpdateRequestStatusEnum._(String name): super(name);

  static BuiltSet<ReportUpdateRequestStatusEnum> get values => _$reportUpdateRequestStatusEnumValues;
  static ReportUpdateRequestStatusEnum valueOf(String name) => _$reportUpdateRequestStatusEnumValueOf(name);
}

