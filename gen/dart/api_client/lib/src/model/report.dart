//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'report.g.dart';

/// Report
///
/// Properties:
/// * [id] 
/// * [orderId] 
/// * [reporterId] 
/// * [targetUserId] 
/// * [category] 
/// * [description] 
/// * [evidenceUrl] 
/// * [status] 
/// * [handledById] 
/// * [resolution] 
/// * [reportedAt] - unix timestamp format
/// * [resolvedAt] - unix timestamp format
@BuiltValue()
abstract class Report implements Built<Report, ReportBuilder> {
  @BuiltValueField(wireName: r'id')
  String get id;

  @BuiltValueField(wireName: r'orderId')
  String? get orderId;

  @BuiltValueField(wireName: r'reporterId')
  String get reporterId;

  @BuiltValueField(wireName: r'targetUserId')
  String get targetUserId;

  @BuiltValueField(wireName: r'category')
  ReportCategoryEnum get category;
  // enum categoryEnum {  behavior,  safety,  fraud,  other,  };

  @BuiltValueField(wireName: r'description')
  String get description;

  @BuiltValueField(wireName: r'evidenceUrl')
  String? get evidenceUrl;

  @BuiltValueField(wireName: r'status')
  ReportStatusEnum? get status;
  // enum statusEnum {  pending,  investigating,  resolved,  dismissed,  };

  @BuiltValueField(wireName: r'handledById')
  String? get handledById;

  @BuiltValueField(wireName: r'resolution')
  String? get resolution;

  /// unix timestamp format
  @BuiltValueField(wireName: r'reportedAt')
  num get reportedAt;

  /// unix timestamp format
  @BuiltValueField(wireName: r'resolvedAt')
  num? get resolvedAt;

  Report._();

  factory Report([void updates(ReportBuilder b)]) = _$Report;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ReportBuilder b) => b
      ..status = const ReportStatusEnum._('pending');

  @BuiltValueSerializer(custom: true)
  static Serializer<Report> get serializer => _$ReportSerializer();
}

class _$ReportSerializer implements PrimitiveSerializer<Report> {
  @override
  final Iterable<Type> types = const [Report, _$Report];

  @override
  final String wireName = r'Report';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    Report object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'id';
    yield serializers.serialize(
      object.id,
      specifiedType: const FullType(String),
    );
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
    yield r'category';
    yield serializers.serialize(
      object.category,
      specifiedType: const FullType(ReportCategoryEnum),
    );
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
        specifiedType: const FullType(ReportStatusEnum),
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
    yield r'reportedAt';
    yield serializers.serialize(
      object.reportedAt,
      specifiedType: const FullType(num),
    );
    if (object.resolvedAt != null) {
      yield r'resolvedAt';
      yield serializers.serialize(
        object.resolvedAt,
        specifiedType: const FullType(num),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    Report object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ReportBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.id = valueDes;
          break;
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
            specifiedType: const FullType(ReportCategoryEnum),
          ) as ReportCategoryEnum;
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
            specifiedType: const FullType(ReportStatusEnum),
          ) as ReportStatusEnum;
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
        case r'reportedAt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.reportedAt = valueDes;
          break;
        case r'resolvedAt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.resolvedAt = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  Report deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ReportBuilder();
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

class ReportCategoryEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'behavior')
  static const ReportCategoryEnum behavior = _$reportCategoryEnum_behavior;
  @BuiltValueEnumConst(wireName: r'safety')
  static const ReportCategoryEnum safety = _$reportCategoryEnum_safety;
  @BuiltValueEnumConst(wireName: r'fraud')
  static const ReportCategoryEnum fraud = _$reportCategoryEnum_fraud;
  @BuiltValueEnumConst(wireName: r'other')
  static const ReportCategoryEnum other = _$reportCategoryEnum_other;

  static Serializer<ReportCategoryEnum> get serializer => _$reportCategoryEnumSerializer;

  const ReportCategoryEnum._(String name): super(name);

  static BuiltSet<ReportCategoryEnum> get values => _$reportCategoryEnumValues;
  static ReportCategoryEnum valueOf(String name) => _$reportCategoryEnumValueOf(name);
}

class ReportStatusEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'pending')
  static const ReportStatusEnum pending = _$reportStatusEnum_pending;
  @BuiltValueEnumConst(wireName: r'investigating')
  static const ReportStatusEnum investigating = _$reportStatusEnum_investigating;
  @BuiltValueEnumConst(wireName: r'resolved')
  static const ReportStatusEnum resolved = _$reportStatusEnum_resolved;
  @BuiltValueEnumConst(wireName: r'dismissed')
  static const ReportStatusEnum dismissed = _$reportStatusEnum_dismissed;

  static Serializer<ReportStatusEnum> get serializer => _$reportStatusEnumSerializer;

  const ReportStatusEnum._(String name): super(name);

  static BuiltSet<ReportStatusEnum> get values => _$reportStatusEnumValues;
  static ReportStatusEnum valueOf(String name) => _$reportStatusEnumValueOf(name);
}

