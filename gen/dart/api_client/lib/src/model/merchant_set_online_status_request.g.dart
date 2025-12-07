// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'merchant_set_online_status_request.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$MerchantSetOnlineStatusRequestCWProxy {
  MerchantSetOnlineStatusRequest isOnline(bool isOnline);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `MerchantSetOnlineStatusRequest(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// MerchantSetOnlineStatusRequest(...).copyWith(id: 12, name: "My name")
  /// ```
  MerchantSetOnlineStatusRequest call({bool isOnline});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfMerchantSetOnlineStatusRequest.copyWith(...)` or call `instanceOfMerchantSetOnlineStatusRequest.copyWith.fieldName(value)` for a single field.
class _$MerchantSetOnlineStatusRequestCWProxyImpl
    implements _$MerchantSetOnlineStatusRequestCWProxy {
  const _$MerchantSetOnlineStatusRequestCWProxyImpl(this._value);

  final MerchantSetOnlineStatusRequest _value;

  @override
  MerchantSetOnlineStatusRequest isOnline(bool isOnline) =>
      call(isOnline: isOnline);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `MerchantSetOnlineStatusRequest(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// MerchantSetOnlineStatusRequest(...).copyWith(id: 12, name: "My name")
  /// ```
  MerchantSetOnlineStatusRequest call({
    Object? isOnline = const $CopyWithPlaceholder(),
  }) {
    return MerchantSetOnlineStatusRequest(
      isOnline: isOnline == const $CopyWithPlaceholder() || isOnline == null
          ? _value.isOnline
          // ignore: cast_nullable_to_non_nullable
          : isOnline as bool,
    );
  }
}

extension $MerchantSetOnlineStatusRequestCopyWith
    on MerchantSetOnlineStatusRequest {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfMerchantSetOnlineStatusRequest.copyWith(...)` or `instanceOfMerchantSetOnlineStatusRequest.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$MerchantSetOnlineStatusRequestCWProxy get copyWith =>
      _$MerchantSetOnlineStatusRequestCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MerchantSetOnlineStatusRequest _$MerchantSetOnlineStatusRequestFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('MerchantSetOnlineStatusRequest', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['isOnline']);
  final val = MerchantSetOnlineStatusRequest(
    isOnline: $checkedConvert('isOnline', (v) => v as bool),
  );
  return val;
});

Map<String, dynamic> _$MerchantSetOnlineStatusRequestToJson(
  MerchantSetOnlineStatusRequest instance,
) => <String, dynamic>{'isOnline': instance.isOnline};
