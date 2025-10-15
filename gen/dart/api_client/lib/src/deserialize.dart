import 'package:api_client/src/model/auth_forgot_password_request.dart';
import 'package:api_client/src/model/auth_get_session200_response.dart';
import 'package:api_client/src/model/auth_get_session200_response_data.dart';
import 'package:api_client/src/model/auth_has_permission200_response.dart';
import 'package:api_client/src/model/auth_has_permission_request.dart';
import 'package:api_client/src/model/auth_reset_password_request.dart';
import 'package:api_client/src/model/auth_sign_in200_response.dart';
import 'package:api_client/src/model/auth_sign_in200_response_data.dart';
import 'package:api_client/src/model/auth_sign_in_request.dart';
import 'package:api_client/src/model/auth_sign_out200_response.dart';
import 'package:api_client/src/model/auth_sign_up_user200_response.dart';
import 'package:api_client/src/model/auth_sign_up_user200_response_data.dart';
import 'package:api_client/src/model/ban_user_schema_request.dart';
import 'package:api_client/src/model/configuration.dart';
import 'package:api_client/src/model/configuration_get200_response.dart';
import 'package:api_client/src/model/configuration_list200_response.dart';
import 'package:api_client/src/model/configuration_update_request.dart';
import 'package:api_client/src/model/coupon.dart';
import 'package:api_client/src/model/coupon_create200_response.dart';
import 'package:api_client/src/model/coupon_create_request.dart';
import 'package:api_client/src/model/coupon_create_request_rules.dart';
import 'package:api_client/src/model/coupon_create_request_rules_general.dart';
import 'package:api_client/src/model/coupon_create_request_rules_time.dart';
import 'package:api_client/src/model/coupon_create_request_rules_user.dart';
import 'package:api_client/src/model/coupon_list200_response.dart';
import 'package:api_client/src/model/coupon_update_request.dart';
import 'package:api_client/src/model/driver.dart';
import 'package:api_client/src/model/driver_get200_response.dart';
import 'package:api_client/src/model/driver_list200_response.dart';
import 'package:api_client/src/model/driver_remove200_response.dart';
import 'package:api_client/src/model/location.dart';
import 'package:api_client/src/model/merchant.dart';
import 'package:api_client/src/model/merchant_get_mine200_response.dart';
import 'package:api_client/src/model/merchant_get_mine200_response_body.dart';
import 'package:api_client/src/model/merchant_list200_response.dart';
import 'package:api_client/src/model/merchant_menu.dart';
import 'package:api_client/src/model/merchant_menu_create200_response.dart';
import 'package:api_client/src/model/merchant_menu_list200_response.dart';
import 'package:api_client/src/model/order.dart';
import 'package:api_client/src/model/order_create200_response.dart';
import 'package:api_client/src/model/order_create_request.dart';
import 'package:api_client/src/model/order_create_request_driver.dart';
import 'package:api_client/src/model/order_create_request_merchant.dart';
import 'package:api_client/src/model/order_create_request_note.dart';
import 'package:api_client/src/model/order_create_request_user.dart';
import 'package:api_client/src/model/order_list200_response.dart';
import 'package:api_client/src/model/order_update_request.dart';
import 'package:api_client/src/model/report.dart';
import 'package:api_client/src/model/report_create200_response.dart';
import 'package:api_client/src/model/report_create_request.dart';
import 'package:api_client/src/model/report_list200_response.dart';
import 'package:api_client/src/model/report_update_request.dart';
import 'package:api_client/src/model/review.dart';
import 'package:api_client/src/model/review_create200_response.dart';
import 'package:api_client/src/model/review_create_request.dart';
import 'package:api_client/src/model/review_list200_response.dart';
import 'package:api_client/src/model/review_update_request.dart';
import 'package:api_client/src/model/schedule.dart';
import 'package:api_client/src/model/schedule_create200_response.dart';
import 'package:api_client/src/model/schedule_create_request.dart';
import 'package:api_client/src/model/schedule_list200_response.dart';
import 'package:api_client/src/model/schedule_update_request.dart';
import 'package:api_client/src/model/statements.dart';
import 'package:api_client/src/model/time.dart';
import 'package:api_client/src/model/unban_user_schema_request.dart';
import 'package:api_client/src/model/update_user_password_request.dart';
import 'package:api_client/src/model/update_user_role_request.dart';
import 'package:api_client/src/model/user.dart';
import 'package:api_client/src/model/user_create200_response.dart';
import 'package:api_client/src/model/user_create_request.dart';
import 'package:api_client/src/model/user_list200_response.dart';
import 'package:api_client/src/model/user_update_request.dart';

final _regList = RegExp(r'^List<(.*)>$');
final _regSet = RegExp(r'^Set<(.*)>$');
final _regMap = RegExp(r'^Map<String,(.*)>$');

ReturnType deserialize<ReturnType, BaseType>(
  dynamic value,
  String targetType, {
  bool growable = true,
}) {
  switch (targetType) {
    case 'String':
      return '$value' as ReturnType;
    case 'int':
      return (value is int ? value : int.parse('$value')) as ReturnType;
    case 'bool':
      if (value is bool) {
        return value as ReturnType;
      }
      final valueString = '$value'.toLowerCase();
      return (valueString == 'true' || valueString == '1') as ReturnType;
    case 'double':
      return (value is double ? value : double.parse('$value')) as ReturnType;
    case 'AuthForgotPasswordRequest':
      return AuthForgotPasswordRequest.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'AuthGetSession200Response':
      return AuthGetSession200Response.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'AuthGetSession200ResponseData':
      return AuthGetSession200ResponseData.fromJson(
            value as Map<String, dynamic>,
          )
          as ReturnType;
    case 'AuthHasPermission200Response':
      return AuthHasPermission200Response.fromJson(
            value as Map<String, dynamic>,
          )
          as ReturnType;
    case 'AuthHasPermissionRequest':
      return AuthHasPermissionRequest.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'AuthResetPasswordRequest':
      return AuthResetPasswordRequest.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'AuthSignIn200Response':
      return AuthSignIn200Response.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'AuthSignIn200ResponseData':
      return AuthSignIn200ResponseData.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'AuthSignInRequest':
      return AuthSignInRequest.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'AuthSignOut200Response':
      return AuthSignOut200Response.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'AuthSignUpUser200Response':
      return AuthSignUpUser200Response.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'AuthSignUpUser200ResponseData':
      return AuthSignUpUser200ResponseData.fromJson(
            value as Map<String, dynamic>,
          )
          as ReturnType;
    case 'BanUserSchemaRequest':
      return BanUserSchemaRequest.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'Configuration':
      return Configuration.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'ConfigurationGet200Response':
      return ConfigurationGet200Response.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'ConfigurationList200Response':
      return ConfigurationList200Response.fromJson(
            value as Map<String, dynamic>,
          )
          as ReturnType;
    case 'ConfigurationUpdateRequest':
      return ConfigurationUpdateRequest.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'Coupon':
      return Coupon.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'CouponCreate200Response':
      return CouponCreate200Response.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'CouponCreateRequest':
      return CouponCreateRequest.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'CouponCreateRequestRules':
      return CouponCreateRequestRules.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'CouponCreateRequestRulesGeneral':
      return CouponCreateRequestRulesGeneral.fromJson(
            value as Map<String, dynamic>,
          )
          as ReturnType;
    case 'CouponCreateRequestRulesTime':
      return CouponCreateRequestRulesTime.fromJson(
            value as Map<String, dynamic>,
          )
          as ReturnType;
    case 'CouponCreateRequestRulesUser':
      return CouponCreateRequestRulesUser.fromJson(
            value as Map<String, dynamic>,
          )
          as ReturnType;
    case 'CouponList200Response':
      return CouponList200Response.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'CouponUpdateRequest':
      return CouponUpdateRequest.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'Driver':
      return Driver.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'DriverGet200Response':
      return DriverGet200Response.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'DriverList200Response':
      return DriverList200Response.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'DriverRemove200Response':
      return DriverRemove200Response.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'Location':
      return Location.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'Merchant':
      return Merchant.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'MerchantGetMine200Response':
      return MerchantGetMine200Response.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'MerchantGetMine200ResponseBody':
      return MerchantGetMine200ResponseBody.fromJson(
            value as Map<String, dynamic>,
          )
          as ReturnType;
    case 'MerchantList200Response':
      return MerchantList200Response.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'MerchantMenu':
      return MerchantMenu.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'MerchantMenuCreate200Response':
      return MerchantMenuCreate200Response.fromJson(
            value as Map<String, dynamic>,
          )
          as ReturnType;
    case 'MerchantMenuList200Response':
      return MerchantMenuList200Response.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'Order':
      return Order.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'OrderCreate200Response':
      return OrderCreate200Response.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'OrderCreateRequest':
      return OrderCreateRequest.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'OrderCreateRequestDriver':
      return OrderCreateRequestDriver.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'OrderCreateRequestMerchant':
      return OrderCreateRequestMerchant.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'OrderCreateRequestNote':
      return OrderCreateRequestNote.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'OrderCreateRequestUser':
      return OrderCreateRequestUser.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'OrderList200Response':
      return OrderList200Response.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'OrderUpdateRequest':
      return OrderUpdateRequest.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'Report':
      return Report.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'ReportCreate200Response':
      return ReportCreate200Response.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'ReportCreateRequest':
      return ReportCreateRequest.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'ReportList200Response':
      return ReportList200Response.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'ReportUpdateRequest':
      return ReportUpdateRequest.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'Review':
      return Review.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'ReviewCreate200Response':
      return ReviewCreate200Response.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'ReviewCreateRequest':
      return ReviewCreateRequest.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'ReviewList200Response':
      return ReviewList200Response.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'ReviewUpdateRequest':
      return ReviewUpdateRequest.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'Schedule':
      return Schedule.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'ScheduleCreate200Response':
      return ScheduleCreate200Response.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'ScheduleCreateRequest':
      return ScheduleCreateRequest.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'ScheduleList200Response':
      return ScheduleList200Response.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'ScheduleUpdateRequest':
      return ScheduleUpdateRequest.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'Statements':
      return Statements.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'Time':
      return Time.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'UnbanUserSchemaRequest':
      return UnbanUserSchemaRequest.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'UpdateUserPasswordRequest':
      return UpdateUserPasswordRequest.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'UpdateUserRoleRequest':
      return UpdateUserRoleRequest.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'User':
      return User.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'UserCreate200Response':
      return UserCreate200Response.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'UserCreateRequest':
      return UserCreateRequest.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'UserList200Response':
      return UserList200Response.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'UserUpdateRequest':
      return UserUpdateRequest.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    default:
      RegExpMatch? match;

      if (value is List && (match = _regList.firstMatch(targetType)) != null) {
        targetType = match![1]!; // ignore: parameter_assignments
        return value
                .map<BaseType>(
                  (dynamic v) => deserialize<BaseType, BaseType>(
                    v,
                    targetType,
                    growable: growable,
                  ),
                )
                .toList(growable: growable)
            as ReturnType;
      }
      if (value is Set && (match = _regSet.firstMatch(targetType)) != null) {
        targetType = match![1]!; // ignore: parameter_assignments
        return value
                .map<BaseType>(
                  (dynamic v) => deserialize<BaseType, BaseType>(
                    v,
                    targetType,
                    growable: growable,
                  ),
                )
                .toSet()
            as ReturnType;
      }
      if (value is Map && (match = _regMap.firstMatch(targetType)) != null) {
        targetType = match![1]!.trim(); // ignore: parameter_assignments
        return Map<String, BaseType>.fromIterables(
              value.keys as Iterable<String>,
              value.values.map(
                (dynamic v) => deserialize<BaseType, BaseType>(
                  v,
                  targetType,
                  growable: growable,
                ),
              ),
            )
            as ReturnType;
      }
      break;
  }
  throw Exception('Cannot deserialize');
}
