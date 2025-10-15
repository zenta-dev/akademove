// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'unban_user_schema_request.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$UnbanUserSchemaRequestCWProxy {
  UnbanUserSchemaRequest id(String id);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `UnbanUserSchemaRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// UnbanUserSchemaRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  UnbanUserSchemaRequest call({String id});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfUnbanUserSchemaRequest.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfUnbanUserSchemaRequest.copyWith.fieldName(...)`
class _$UnbanUserSchemaRequestCWProxyImpl
    implements _$UnbanUserSchemaRequestCWProxy {
  const _$UnbanUserSchemaRequestCWProxyImpl(this._value);

  final UnbanUserSchemaRequest _value;

  @override
  UnbanUserSchemaRequest id(String id) => this(id: id);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `UnbanUserSchemaRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// UnbanUserSchemaRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  UnbanUserSchemaRequest call({Object? id = const $CopyWithPlaceholder()}) {
    return UnbanUserSchemaRequest(
      id: id == const $CopyWithPlaceholder()
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
    );
  }
}

extension $UnbanUserSchemaRequestCopyWith on UnbanUserSchemaRequest {
  /// Returns a callable class that can be used as follows: `instanceOfUnbanUserSchemaRequest.copyWith(...)` or like so:`instanceOfUnbanUserSchemaRequest.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$UnbanUserSchemaRequestCWProxy get copyWith =>
      _$UnbanUserSchemaRequestCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UnbanUserSchemaRequest _$UnbanUserSchemaRequestFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('UnbanUserSchemaRequest', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['id']);
  final val = UnbanUserSchemaRequest(
    id: $checkedConvert('id', (v) => v as String),
  );
  return val;
});

Map<String, dynamic> _$UnbanUserSchemaRequestToJson(
  UnbanUserSchemaRequest instance,
) => <String, dynamic>{'id': instance.id};
