//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/json_object.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'admin_has_permission_post_request.g.dart';

/// AdminHasPermissionPostRequest
///
/// Properties:
/// * [permission] - The permission to check
/// * [permissions] - The permission to check
@BuiltValue()
abstract class AdminHasPermissionPostRequest implements Built<AdminHasPermissionPostRequest, AdminHasPermissionPostRequestBuilder> {
  /// The permission to check
  @Deprecated('permission has been deprecated')
  @BuiltValueField(wireName: r'permission')
  JsonObject? get permission;

  /// The permission to check
  @BuiltValueField(wireName: r'permissions')
  JsonObject get permissions;

  AdminHasPermissionPostRequest._();

  factory AdminHasPermissionPostRequest([void updates(AdminHasPermissionPostRequestBuilder b)]) = _$AdminHasPermissionPostRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AdminHasPermissionPostRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AdminHasPermissionPostRequest> get serializer => _$AdminHasPermissionPostRequestSerializer();
}

class _$AdminHasPermissionPostRequestSerializer implements PrimitiveSerializer<AdminHasPermissionPostRequest> {
  @override
  final Iterable<Type> types = const [AdminHasPermissionPostRequest, _$AdminHasPermissionPostRequest];

  @override
  final String wireName = r'AdminHasPermissionPostRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AdminHasPermissionPostRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.permission != null) {
      yield r'permission';
      yield serializers.serialize(
        object.permission,
        specifiedType: const FullType(JsonObject),
      );
    }
    yield r'permissions';
    yield serializers.serialize(
      object.permissions,
      specifiedType: const FullType(JsonObject),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    AdminHasPermissionPostRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required AdminHasPermissionPostRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'permission':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(JsonObject),
          ) as JsonObject;
          result.permission = valueDes;
          break;
        case r'permissions':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(JsonObject),
          ) as JsonObject;
          result.permissions = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  AdminHasPermissionPostRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AdminHasPermissionPostRequestBuilder();
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

