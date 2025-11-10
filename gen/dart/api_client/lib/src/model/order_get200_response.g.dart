// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_get200_response.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$OrderGet200ResponseCWProxy {
  OrderGet200Response message(String message);

  OrderGet200Response data(Order data);

  OrderGet200Response totalPages(int? totalPages);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `OrderGet200Response(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// OrderGet200Response(...).copyWith(id: 12, name: "My name")
  /// ````
  OrderGet200Response call({String message, Order data, int? totalPages});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfOrderGet200Response.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfOrderGet200Response.copyWith.fieldName(...)`
class _$OrderGet200ResponseCWProxyImpl implements _$OrderGet200ResponseCWProxy {
  const _$OrderGet200ResponseCWProxyImpl(this._value);

  final OrderGet200Response _value;

  @override
  OrderGet200Response message(String message) => this(message: message);

  @override
  OrderGet200Response data(Order data) => this(data: data);

  @override
  OrderGet200Response totalPages(int? totalPages) =>
      this(totalPages: totalPages);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `OrderGet200Response(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// OrderGet200Response(...).copyWith(id: 12, name: "My name")
  /// ````
  OrderGet200Response call({
    Object? message = const $CopyWithPlaceholder(),
    Object? data = const $CopyWithPlaceholder(),
    Object? totalPages = const $CopyWithPlaceholder(),
  }) {
    return OrderGet200Response(
      message: message == const $CopyWithPlaceholder()
          ? _value.message
          // ignore: cast_nullable_to_non_nullable
          : message as String,
      data: data == const $CopyWithPlaceholder()
          ? _value.data
          // ignore: cast_nullable_to_non_nullable
          : data as Order,
      totalPages: totalPages == const $CopyWithPlaceholder()
          ? _value.totalPages
          // ignore: cast_nullable_to_non_nullable
          : totalPages as int?,
    );
  }
}

extension $OrderGet200ResponseCopyWith on OrderGet200Response {
  /// Returns a callable class that can be used as follows: `instanceOfOrderGet200Response.copyWith(...)` or like so:`instanceOfOrderGet200Response.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$OrderGet200ResponseCWProxy get copyWith =>
      _$OrderGet200ResponseCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderGet200Response _$OrderGet200ResponseFromJson(Map<String, dynamic> json) =>
    $checkedCreate('OrderGet200Response', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['message', 'data']);
      final val = OrderGet200Response(
        message: $checkedConvert('message', (v) => v as String),
        data: $checkedConvert(
          'data',
          (v) => Order.fromJson(v as Map<String, dynamic>),
        ),
        totalPages: $checkedConvert('totalPages', (v) => (v as num?)?.toInt()),
      );
      return val;
    });

Map<String, dynamic> _$OrderGet200ResponseToJson(
  OrderGet200Response instance,
) => <String, dynamic>{
  'message': instance.message,
  'data': instance.data.toJson(),
  'totalPages': ?instance.totalPages,
};
