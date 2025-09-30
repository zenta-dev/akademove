//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'driver_update_request_user.g.dart';

/// DriverUpdateRequestUser
///
/// Properties:
/// * [id] 
/// * [name] 
/// * [email] 
/// * [emailVerified] 
/// * [image] 
/// * [role] 
/// * [banned] 
/// * [banReason] 
/// * [banExpires] - unix timestamp format
/// * [createdAt] - unix timestamp format
/// * [updatedAt] - unix timestamp format
@BuiltValue()
abstract class DriverUpdateRequestUser implements Built<DriverUpdateRequestUser, DriverUpdateRequestUserBuilder> {
  @BuiltValueField(wireName: r'id')
  String? get id;

  @BuiltValueField(wireName: r'name')
  String? get name;

  @BuiltValueField(wireName: r'email')
  String? get email;

  @BuiltValueField(wireName: r'emailVerified')
  bool? get emailVerified;

  @BuiltValueField(wireName: r'image')
  String? get image;

  @BuiltValueField(wireName: r'role')
  DriverUpdateRequestUserRoleEnum? get role;
  // enum roleEnum {  admin,  operator,  merchant,  driver,  user,  };

  @BuiltValueField(wireName: r'banned')
  bool? get banned;

  @BuiltValueField(wireName: r'banReason')
  String? get banReason;

  /// unix timestamp format
  @BuiltValueField(wireName: r'banExpires')
  num? get banExpires;

  /// unix timestamp format
  @BuiltValueField(wireName: r'createdAt')
  num? get createdAt;

  /// unix timestamp format
  @BuiltValueField(wireName: r'updatedAt')
  num? get updatedAt;

  DriverUpdateRequestUser._();

  factory DriverUpdateRequestUser([void updates(DriverUpdateRequestUserBuilder b)]) = _$DriverUpdateRequestUser;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(DriverUpdateRequestUserBuilder b) => b
      ..role = const DriverUpdateRequestUserRoleEnum._('user');

  @BuiltValueSerializer(custom: true)
  static Serializer<DriverUpdateRequestUser> get serializer => _$DriverUpdateRequestUserSerializer();
}

class _$DriverUpdateRequestUserSerializer implements PrimitiveSerializer<DriverUpdateRequestUser> {
  @override
  final Iterable<Type> types = const [DriverUpdateRequestUser, _$DriverUpdateRequestUser];

  @override
  final String wireName = r'DriverUpdateRequestUser';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    DriverUpdateRequestUser object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.id != null) {
      yield r'id';
      yield serializers.serialize(
        object.id,
        specifiedType: const FullType(String),
      );
    }
    if (object.name != null) {
      yield r'name';
      yield serializers.serialize(
        object.name,
        specifiedType: const FullType(String),
      );
    }
    if (object.email != null) {
      yield r'email';
      yield serializers.serialize(
        object.email,
        specifiedType: const FullType(String),
      );
    }
    if (object.emailVerified != null) {
      yield r'emailVerified';
      yield serializers.serialize(
        object.emailVerified,
        specifiedType: const FullType(bool),
      );
    }
    if (object.image != null) {
      yield r'image';
      yield serializers.serialize(
        object.image,
        specifiedType: const FullType(String),
      );
    }
    if (object.role != null) {
      yield r'role';
      yield serializers.serialize(
        object.role,
        specifiedType: const FullType(DriverUpdateRequestUserRoleEnum),
      );
    }
    if (object.banned != null) {
      yield r'banned';
      yield serializers.serialize(
        object.banned,
        specifiedType: const FullType(bool),
      );
    }
    if (object.banReason != null) {
      yield r'banReason';
      yield serializers.serialize(
        object.banReason,
        specifiedType: const FullType(String),
      );
    }
    if (object.banExpires != null) {
      yield r'banExpires';
      yield serializers.serialize(
        object.banExpires,
        specifiedType: const FullType(num),
      );
    }
    if (object.createdAt != null) {
      yield r'createdAt';
      yield serializers.serialize(
        object.createdAt,
        specifiedType: const FullType(num),
      );
    }
    if (object.updatedAt != null) {
      yield r'updatedAt';
      yield serializers.serialize(
        object.updatedAt,
        specifiedType: const FullType(num),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    DriverUpdateRequestUser object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required DriverUpdateRequestUserBuilder result,
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
        case r'name':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.name = valueDes;
          break;
        case r'email':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.email = valueDes;
          break;
        case r'emailVerified':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.emailVerified = valueDes;
          break;
        case r'image':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.image = valueDes;
          break;
        case r'role':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DriverUpdateRequestUserRoleEnum),
          ) as DriverUpdateRequestUserRoleEnum;
          result.role = valueDes;
          break;
        case r'banned':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.banned = valueDes;
          break;
        case r'banReason':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.banReason = valueDes;
          break;
        case r'banExpires':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.banExpires = valueDes;
          break;
        case r'createdAt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.createdAt = valueDes;
          break;
        case r'updatedAt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.updatedAt = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  DriverUpdateRequestUser deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = DriverUpdateRequestUserBuilder();
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

class DriverUpdateRequestUserRoleEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'admin')
  static const DriverUpdateRequestUserRoleEnum admin = _$driverUpdateRequestUserRoleEnum_admin;
  @BuiltValueEnumConst(wireName: r'operator')
  static const DriverUpdateRequestUserRoleEnum operator_ = _$driverUpdateRequestUserRoleEnum_operator_;
  @BuiltValueEnumConst(wireName: r'merchant')
  static const DriverUpdateRequestUserRoleEnum merchant = _$driverUpdateRequestUserRoleEnum_merchant;
  @BuiltValueEnumConst(wireName: r'driver')
  static const DriverUpdateRequestUserRoleEnum driver = _$driverUpdateRequestUserRoleEnum_driver;
  @BuiltValueEnumConst(wireName: r'user')
  static const DriverUpdateRequestUserRoleEnum user = _$driverUpdateRequestUserRoleEnum_user;

  static Serializer<DriverUpdateRequestUserRoleEnum> get serializer => _$driverUpdateRequestUserRoleEnumSerializer;

  const DriverUpdateRequestUserRoleEnum._(String name): super(name);

  static BuiltSet<DriverUpdateRequestUserRoleEnum> get values => _$driverUpdateRequestUserRoleEnumValues;
  static DriverUpdateRequestUserRoleEnum valueOf(String name) => _$driverUpdateRequestUserRoleEnumValueOf(name);
}

