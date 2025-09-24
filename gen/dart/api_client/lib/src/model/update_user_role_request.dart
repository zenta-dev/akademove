//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'update_user_role_request.g.dart';

/// UpdateUserRoleRequest
///
/// Properties:
/// * [role] 
@BuiltValue()
abstract class UpdateUserRoleRequest implements Built<UpdateUserRoleRequest, UpdateUserRoleRequestBuilder> {
  @BuiltValueField(wireName: r'role')
  UpdateUserRoleRequestRoleEnum get role;
  // enum roleEnum {  admin,  operator,  merchant,  driver,  user,  };

  UpdateUserRoleRequest._();

  factory UpdateUserRoleRequest([void updates(UpdateUserRoleRequestBuilder b)]) = _$UpdateUserRoleRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(UpdateUserRoleRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<UpdateUserRoleRequest> get serializer => _$UpdateUserRoleRequestSerializer();
}

class _$UpdateUserRoleRequestSerializer implements PrimitiveSerializer<UpdateUserRoleRequest> {
  @override
  final Iterable<Type> types = const [UpdateUserRoleRequest, _$UpdateUserRoleRequest];

  @override
  final String wireName = r'UpdateUserRoleRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    UpdateUserRoleRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'role';
    yield serializers.serialize(
      object.role,
      specifiedType: const FullType(UpdateUserRoleRequestRoleEnum),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    UpdateUserRoleRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required UpdateUserRoleRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'role':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(UpdateUserRoleRequestRoleEnum),
          ) as UpdateUserRoleRequestRoleEnum;
          result.role = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  UpdateUserRoleRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = UpdateUserRoleRequestBuilder();
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

class UpdateUserRoleRequestRoleEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'admin')
  static const UpdateUserRoleRequestRoleEnum admin = _$updateUserRoleRequestRoleEnum_admin;
  @BuiltValueEnumConst(wireName: r'operator')
  static const UpdateUserRoleRequestRoleEnum operator_ = _$updateUserRoleRequestRoleEnum_operator_;
  @BuiltValueEnumConst(wireName: r'merchant')
  static const UpdateUserRoleRequestRoleEnum merchant = _$updateUserRoleRequestRoleEnum_merchant;
  @BuiltValueEnumConst(wireName: r'driver')
  static const UpdateUserRoleRequestRoleEnum driver = _$updateUserRoleRequestRoleEnum_driver;
  @BuiltValueEnumConst(wireName: r'user')
  static const UpdateUserRoleRequestRoleEnum user = _$updateUserRoleRequestRoleEnum_user;

  static Serializer<UpdateUserRoleRequestRoleEnum> get serializer => _$updateUserRoleRequestRoleEnumSerializer;

  const UpdateUserRoleRequestRoleEnum._(String name): super(name);

  static BuiltSet<UpdateUserRoleRequestRoleEnum> get values => _$updateUserRoleRequestRoleEnumValues;
  static UpdateUserRoleRequestRoleEnum valueOf(String name) => _$updateUserRoleRequestRoleEnumValueOf(name);
}

