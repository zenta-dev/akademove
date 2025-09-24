//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:api_client/src/model/location.dart';
import 'package:api_client/src/model/driver_update_request_user.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'driver.g.dart';

/// Driver
///
/// Properties:
/// * [id] 
/// * [userId] 
/// * [studentId] 
/// * [licenseNumber] 
/// * [status] 
/// * [rating] 
/// * [isOnline] 
/// * [currentLocation] 
/// * [lastLocationUpdate] - unix timestamp format
/// * [createdAt] - unix timestamp format
/// * [user] 
@BuiltValue()
abstract class Driver implements Built<Driver, DriverBuilder> {
  @BuiltValueField(wireName: r'id')
  String get id;

  @BuiltValueField(wireName: r'userId')
  String get userId;

  @BuiltValueField(wireName: r'studentId')
  String get studentId;

  @BuiltValueField(wireName: r'licenseNumber')
  String get licenseNumber;

  @BuiltValueField(wireName: r'status')
  DriverStatusEnum get status;
  // enum statusEnum {  pending,  approved,  rejected,  active,  inactive,  suspended,  };

  @BuiltValueField(wireName: r'rating')
  num get rating;

  @BuiltValueField(wireName: r'isOnline')
  bool get isOnline;

  @BuiltValueField(wireName: r'currentLocation')
  Location? get currentLocation;

  /// unix timestamp format
  @BuiltValueField(wireName: r'lastLocationUpdate')
  num? get lastLocationUpdate;

  /// unix timestamp format
  @BuiltValueField(wireName: r'createdAt')
  num get createdAt;

  @BuiltValueField(wireName: r'user')
  DriverUpdateRequestUser? get user;

  Driver._();

  factory Driver([void updates(DriverBuilder b)]) = _$Driver;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(DriverBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<Driver> get serializer => _$DriverSerializer();
}

class _$DriverSerializer implements PrimitiveSerializer<Driver> {
  @override
  final Iterable<Type> types = const [Driver, _$Driver];

  @override
  final String wireName = r'Driver';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    Driver object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'id';
    yield serializers.serialize(
      object.id,
      specifiedType: const FullType(String),
    );
    yield r'userId';
    yield serializers.serialize(
      object.userId,
      specifiedType: const FullType(String),
    );
    yield r'studentId';
    yield serializers.serialize(
      object.studentId,
      specifiedType: const FullType(String),
    );
    yield r'licenseNumber';
    yield serializers.serialize(
      object.licenseNumber,
      specifiedType: const FullType(String),
    );
    yield r'status';
    yield serializers.serialize(
      object.status,
      specifiedType: const FullType(DriverStatusEnum),
    );
    yield r'rating';
    yield serializers.serialize(
      object.rating,
      specifiedType: const FullType(num),
    );
    yield r'isOnline';
    yield serializers.serialize(
      object.isOnline,
      specifiedType: const FullType(bool),
    );
    if (object.currentLocation != null) {
      yield r'currentLocation';
      yield serializers.serialize(
        object.currentLocation,
        specifiedType: const FullType(Location),
      );
    }
    if (object.lastLocationUpdate != null) {
      yield r'lastLocationUpdate';
      yield serializers.serialize(
        object.lastLocationUpdate,
        specifiedType: const FullType(num),
      );
    }
    yield r'createdAt';
    yield serializers.serialize(
      object.createdAt,
      specifiedType: const FullType(num),
    );
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
    Driver object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required DriverBuilder result,
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
        case r'userId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.userId = valueDes;
          break;
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
            specifiedType: const FullType(DriverStatusEnum),
          ) as DriverStatusEnum;
          result.status = valueDes;
          break;
        case r'rating':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.rating = valueDes;
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
        case r'lastLocationUpdate':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.lastLocationUpdate = valueDes;
          break;
        case r'createdAt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.createdAt = valueDes;
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
  Driver deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = DriverBuilder();
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

class DriverStatusEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'pending')
  static const DriverStatusEnum pending = _$driverStatusEnum_pending;
  @BuiltValueEnumConst(wireName: r'approved')
  static const DriverStatusEnum approved = _$driverStatusEnum_approved;
  @BuiltValueEnumConst(wireName: r'rejected')
  static const DriverStatusEnum rejected = _$driverStatusEnum_rejected;
  @BuiltValueEnumConst(wireName: r'active')
  static const DriverStatusEnum active = _$driverStatusEnum_active;
  @BuiltValueEnumConst(wireName: r'inactive')
  static const DriverStatusEnum inactive = _$driverStatusEnum_inactive;
  @BuiltValueEnumConst(wireName: r'suspended')
  static const DriverStatusEnum suspended = _$driverStatusEnum_suspended;

  static Serializer<DriverStatusEnum> get serializer => _$driverStatusEnumSerializer;

  const DriverStatusEnum._(String name): super(name);

  static BuiltSet<DriverStatusEnum> get values => _$driverStatusEnumValues;
  static DriverStatusEnum valueOf(String name) => _$driverStatusEnumValueOf(name);
}

