//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'admin_has_permission_post200_response.g.dart';

/// AdminHasPermissionPost200Response
///
/// Properties:
/// * [error] 
/// * [success] 
@BuiltValue()
abstract class AdminHasPermissionPost200Response implements Built<AdminHasPermissionPost200Response, AdminHasPermissionPost200ResponseBuilder> {
  @BuiltValueField(wireName: r'error')
  String? get error;

  @BuiltValueField(wireName: r'success')
  bool get success;

  AdminHasPermissionPost200Response._();

  factory AdminHasPermissionPost200Response([void updates(AdminHasPermissionPost200ResponseBuilder b)]) = _$AdminHasPermissionPost200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AdminHasPermissionPost200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AdminHasPermissionPost200Response> get serializer => _$AdminHasPermissionPost200ResponseSerializer();
}

class _$AdminHasPermissionPost200ResponseSerializer implements PrimitiveSerializer<AdminHasPermissionPost200Response> {
  @override
  final Iterable<Type> types = const [AdminHasPermissionPost200Response, _$AdminHasPermissionPost200Response];

  @override
  final String wireName = r'AdminHasPermissionPost200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AdminHasPermissionPost200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.error != null) {
      yield r'error';
      yield serializers.serialize(
        object.error,
        specifiedType: const FullType(String),
      );
    }
    yield r'success';
    yield serializers.serialize(
      object.success,
      specifiedType: const FullType(bool),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    AdminHasPermissionPost200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required AdminHasPermissionPost200ResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'error':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.error = valueDes;
          break;
        case r'success':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.success = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  AdminHasPermissionPost200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AdminHasPermissionPost200ResponseBuilder();
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

