//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:api_client/src/model/location.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'update_driver_request.g.dart';

/// UpdateDriverRequest
///
/// Properties:
/// * [studentId] 
/// * [licenseNumber] 
/// * [status] 
/// * [isOnline] 
/// * [currentLocation] 
@BuiltValue()
abstract class UpdateDriverRequest implements Built<UpdateDriverRequest, UpdateDriverRequestBuilder> {
  @BuiltValueField(wireName: r'studentId')
  String? get studentId;

  @BuiltValueField(wireName: r'licenseNumber')
  String? get licenseNumber;

  @BuiltValueField(wireName: r'status')
  UpdateDriverRequestStatusEnum? get status;
  // enum statusEnum {  pending,  approved,  rejected,  active,  inactive,  suspended,  };

  @BuiltValueField(wireName: r'isOnline')
  bool? get isOnline;

  @BuiltValueField(wireName: r'currentLocation')
  Location? get currentLocation;

  UpdateDriverRequest._();

  factory UpdateDriverRequest([void updates(UpdateDriverRequestBuilder b)]) = _$UpdateDriverRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(UpdateDriverRequestBuilder b) => b
      ..isOnline = false;

  @BuiltValueSerializer(custom: true)
  static Serializer<UpdateDriverRequest> get serializer => _$UpdateDriverRequestSerializer();
}

class _$UpdateDriverRequestSerializer implements PrimitiveSerializer<UpdateDriverRequest> {
  @override
  final Iterable<Type> types = const [UpdateDriverRequest, _$UpdateDriverRequest];

  @override
  final String wireName = r'UpdateDriverRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    UpdateDriverRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.studentId != null) {
      yield r'studentId';
      yield serializers.serialize(
        object.studentId,
        specifiedType: const FullType(String),
      );
    }
    if (object.licenseNumber != null) {
      yield r'licenseNumber';
      yield serializers.serialize(
        object.licenseNumber,
        specifiedType: const FullType(String),
      );
    }
    if (object.status != null) {
      yield r'status';
      yield serializers.serialize(
        object.status,
        specifiedType: const FullType(UpdateDriverRequestStatusEnum),
      );
    }
    if (object.isOnline != null) {
      yield r'isOnline';
      yield serializers.serialize(
        object.isOnline,
        specifiedType: const FullType(bool),
      );
    }
    if (object.currentLocation != null) {
      yield r'currentLocation';
      yield serializers.serialize(
        object.currentLocation,
        specifiedType: const FullType.nullable(Location),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    UpdateDriverRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required UpdateDriverRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'studentId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.studentId = valueDes;
          break;
        case r'licenseNumber':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.licenseNumber = valueDes;
          break;
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(UpdateDriverRequestStatusEnum),
          ) as UpdateDriverRequestStatusEnum;
          result.status = valueDes;
          break;
        case r'isOnline':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.isOnline = valueDes;
          break;
        case r'currentLocation':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(Location),
          ) as Location?;
          if (valueDes == null) continue;
          result.currentLocation.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  UpdateDriverRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = UpdateDriverRequestBuilder();
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

class UpdateDriverRequestStatusEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'pending')
  static const UpdateDriverRequestStatusEnum pending = _$updateDriverRequestStatusEnum_pending;
  @BuiltValueEnumConst(wireName: r'approved')
  static const UpdateDriverRequestStatusEnum approved = _$updateDriverRequestStatusEnum_approved;
  @BuiltValueEnumConst(wireName: r'rejected')
  static const UpdateDriverRequestStatusEnum rejected = _$updateDriverRequestStatusEnum_rejected;
  @BuiltValueEnumConst(wireName: r'active')
  static const UpdateDriverRequestStatusEnum active = _$updateDriverRequestStatusEnum_active;
  @BuiltValueEnumConst(wireName: r'inactive')
  static const UpdateDriverRequestStatusEnum inactive = _$updateDriverRequestStatusEnum_inactive;
  @BuiltValueEnumConst(wireName: r'suspended')
  static const UpdateDriverRequestStatusEnum suspended = _$updateDriverRequestStatusEnum_suspended;

  static Serializer<UpdateDriverRequestStatusEnum> get serializer => _$updateDriverRequestStatusEnumSerializer;

  const UpdateDriverRequestStatusEnum._(String name): super(name);

  static BuiltSet<UpdateDriverRequestStatusEnum> get values => _$updateDriverRequestStatusEnumValues;
  static UpdateDriverRequestStatusEnum valueOf(String name) => _$updateDriverRequestStatusEnumValueOf(name);
}

