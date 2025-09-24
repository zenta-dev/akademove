//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'set_role_request.g.dart';

/// SetRoleRequest
///
/// Properties:
/// * [userId] - The user id
/// * [role] - The role to set, this can be a string or an array of strings. Eg: `admin` or `[admin, user]`
@BuiltValue()
abstract class SetRoleRequest implements Built<SetRoleRequest, SetRoleRequestBuilder> {
  /// The user id
  @BuiltValueField(wireName: r'userId')
  String get userId;

  /// The role to set, this can be a string or an array of strings. Eg: `admin` or `[admin, user]`
  @BuiltValueField(wireName: r'role')
  String get role;

  SetRoleRequest._();

  factory SetRoleRequest([void updates(SetRoleRequestBuilder b)]) = _$SetRoleRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(SetRoleRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<SetRoleRequest> get serializer => _$SetRoleRequestSerializer();
}

class _$SetRoleRequestSerializer implements PrimitiveSerializer<SetRoleRequest> {
  @override
  final Iterable<Type> types = const [SetRoleRequest, _$SetRoleRequest];

  @override
  final String wireName = r'SetRoleRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    SetRoleRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'userId';
    yield serializers.serialize(
      object.userId,
      specifiedType: const FullType(String),
    );
    yield r'role';
    yield serializers.serialize(
      object.role,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    SetRoleRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required SetRoleRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'userId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.userId = valueDes;
          break;
        case r'role':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
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
  SetRoleRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = SetRoleRequestBuilder();
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

