//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:api_client/src/model/location.dart';
import 'package:api_client/src/model/driver_update_request_user.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'driver_update_request.g.dart';

/// DriverUpdateRequest
///
/// Properties:
/// * [studentId] 
/// * [licenseNumber] 
/// * [status] 
/// * [isOnline] 
/// * [currentLocation] 
/// * [user] 
@BuiltValue()
abstract class DriverUpdateRequest implements Built<DriverUpdateRequest, DriverUpdateRequestBuilder> {
  @BuiltValueField(wireName: r'studentId')
  String? get studentId;

  @BuiltValueField(wireName: r'licenseNumber')
  String? get licenseNumber;

  @BuiltValueField(wireName: r'status')
  DriverUpdateRequestStatusEnum? get status;
  // enum statusEnum {  pending,  approved,  rejected,  active,  inactive,  suspended,  };

  @BuiltValueField(wireName: r'isOnline')
  bool? get isOnline;

  @BuiltValueField(wireName: r'currentLocation')
  Location? get currentLocation;

  @BuiltValueField(wireName: r'user')
  DriverUpdateRequestUser? get user;

  DriverUpdateRequest._();

  factory DriverUpdateRequest([void updates(DriverUpdateRequestBuilder b)]) = _$DriverUpdateRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(DriverUpdateRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<DriverUpdateRequest> get serializer => _$DriverUpdateRequestSerializer();
}

class _$DriverUpdateRequestSerializer implements PrimitiveSerializer<DriverUpdateRequest> {
  @override
  final Iterable<Type> types = const [DriverUpdateRequest, _$DriverUpdateRequest];

  @override
  final String wireName = r'DriverUpdateRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    DriverUpdateRequest object, {
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
        specifiedType: const FullType(DriverUpdateRequestStatusEnum),
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
        specifiedType: const FullType(Location),
      );
    }
    if (object.user != null) {
      yield r'user';
      yield serializers.serialize(
        object.user,
        specifiedType: const FullType(DriverUpdateRequestUser),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    DriverUpdateRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required DriverUpdateRequestBuilder result,
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
            specifiedType: const FullType(DriverUpdateRequestStatusEnum),
          ) as DriverUpdateRequestStatusEnum;
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
            specifiedType: const FullType(Location),
          ) as Location;
          result.currentLocation.replace(valueDes);
          break;
        case r'user':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DriverUpdateRequestUser),
          ) as DriverUpdateRequestUser;
          result.user.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  DriverUpdateRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = DriverUpdateRequestBuilder();
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

class DriverUpdateRequestStatusEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'pending')
  static const DriverUpdateRequestStatusEnum pending = _$driverUpdateRequestStatusEnum_pending;
  @BuiltValueEnumConst(wireName: r'approved')
  static const DriverUpdateRequestStatusEnum approved = _$driverUpdateRequestStatusEnum_approved;
  @BuiltValueEnumConst(wireName: r'rejected')
  static const DriverUpdateRequestStatusEnum rejected = _$driverUpdateRequestStatusEnum_rejected;
  @BuiltValueEnumConst(wireName: r'active')
  static const DriverUpdateRequestStatusEnum active = _$driverUpdateRequestStatusEnum_active;
  @BuiltValueEnumConst(wireName: r'inactive')
  static const DriverUpdateRequestStatusEnum inactive = _$driverUpdateRequestStatusEnum_inactive;
  @BuiltValueEnumConst(wireName: r'suspended')
  static const DriverUpdateRequestStatusEnum suspended = _$driverUpdateRequestStatusEnum_suspended;

  static Serializer<DriverUpdateRequestStatusEnum> get serializer => _$driverUpdateRequestStatusEnumSerializer;

  const DriverUpdateRequestStatusEnum._(String name): super(name);

  static BuiltSet<DriverUpdateRequestStatusEnum> get values => _$driverUpdateRequestStatusEnumValues;
  static DriverUpdateRequestStatusEnum valueOf(String name) => _$driverUpdateRequestStatusEnumValueOf(name);
}

