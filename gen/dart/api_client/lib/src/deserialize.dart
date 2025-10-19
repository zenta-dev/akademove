import 'package:api_client/src/model/auth_get_session200_response.dart';
import 'package:api_client/src/model/auth_get_session200_response_data.dart';
import 'package:api_client/src/model/auth_has_permission200_response.dart';
import 'package:api_client/src/model/auth_has_permission_request.dart';
import 'package:api_client/src/model/auth_sign_in200_response.dart';
import 'package:api_client/src/model/auth_sign_out200_response.dart';
import 'package:api_client/src/model/auth_sign_up_user201_response.dart';
import 'package:api_client/src/model/ban_user_schema_request.dart';
import 'package:api_client/src/model/bank.dart';
import 'package:api_client/src/model/configuration.dart';
import 'package:api_client/src/model/configuration_get200_response.dart';
import 'package:api_client/src/model/configuration_list200_response.dart';
import 'package:api_client/src/model/coupon.dart';
import 'package:api_client/src/model/coupon_create200_response.dart';
import 'package:api_client/src/model/coupon_general_rules.dart';
import 'package:api_client/src/model/coupon_list200_response.dart';
import 'package:api_client/src/model/coupon_rules.dart';
import 'package:api_client/src/model/coupon_time_rules.dart';
import 'package:api_client/src/model/coupon_user_rules.dart';
import 'package:api_client/src/model/driver.dart';
import 'package:api_client/src/model/driver_get_mine200_response.dart';
import 'package:api_client/src/model/driver_get_mine200_response_body.dart';
import 'package:api_client/src/model/driver_list200_response.dart';
import 'package:api_client/src/model/driver_remove200_response.dart';
import 'package:api_client/src/model/driver_update_request_bank.dart';
import 'package:api_client/src/model/forgot_password_request.dart';
import 'package:api_client/src/model/insert_coupon_request.dart';
import 'package:api_client/src/model/insert_order_request.dart';
import 'package:api_client/src/model/insert_order_request_driver.dart';
import 'package:api_client/src/model/insert_order_request_merchant.dart';
import 'package:api_client/src/model/insert_order_request_user.dart';
import 'package:api_client/src/model/insert_report_request.dart';
import 'package:api_client/src/model/insert_review_request.dart';
import 'package:api_client/src/model/insert_schedule_request.dart';
import 'package:api_client/src/model/insert_user_request.dart';
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
import 'package:api_client/src/model/order_item.dart';
import 'package:api_client/src/model/order_item_item.dart';
import 'package:api_client/src/model/order_list200_response.dart';
import 'package:api_client/src/model/order_note.dart';
import 'package:api_client/src/model/phone.dart';
import 'package:api_client/src/model/report.dart';
import 'package:api_client/src/model/report_create200_response.dart';
import 'package:api_client/src/model/report_list200_response.dart';
import 'package:api_client/src/model/reset_password_request.dart';
import 'package:api_client/src/model/review.dart';
import 'package:api_client/src/model/review_create200_response.dart';
import 'package:api_client/src/model/review_list200_response.dart';
import 'package:api_client/src/model/schedule.dart';
import 'package:api_client/src/model/schedule_create200_response.dart';
import 'package:api_client/src/model/schedule_list200_response.dart';
import 'package:api_client/src/model/sign_in_request.dart';
import 'package:api_client/src/model/sign_in_res_body.dart';
import 'package:api_client/src/model/sign_up_res_body.dart';
import 'package:api_client/src/model/statements.dart';
import 'package:api_client/src/model/time.dart';
import 'package:api_client/src/model/unban_user_schema_request.dart';
import 'package:api_client/src/model/update_configuration_request.dart';
import 'package:api_client/src/model/update_coupon_request.dart';
import 'package:api_client/src/model/update_order_request.dart';
import 'package:api_client/src/model/update_report_request.dart';
import 'package:api_client/src/model/update_review_request.dart';
import 'package:api_client/src/model/update_schedule_request.dart';
import 'package:api_client/src/model/update_user_password_request.dart';
import 'package:api_client/src/model/update_user_role_request.dart';
import 'package:api_client/src/model/user.dart';
import 'package:api_client/src/model/user_create200_response.dart';
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
    case 'AuthSignIn200Response':
      return AuthSignIn200Response.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'AuthSignOut200Response':
      return AuthSignOut200Response.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'AuthSignUpUser201Response':
      return AuthSignUpUser201Response.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'BanUserSchemaRequest':
      return BanUserSchemaRequest.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'Bank':
      return Bank.fromJson(value as Map<String, dynamic>) as ReturnType;
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
    case 'Coupon':
      return Coupon.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'CouponCreate200Response':
      return CouponCreate200Response.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'CouponGeneralRules':
      return CouponGeneralRules.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'CouponList200Response':
      return CouponList200Response.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'CouponRules':
      return CouponRules.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'CouponTimeRules':
      return CouponTimeRules.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'CouponUserRules':
      return CouponUserRules.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'Driver':
      return Driver.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'DriverGetMine200Response':
      return DriverGetMine200Response.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'DriverGetMine200ResponseBody':
      return DriverGetMine200ResponseBody.fromJson(
            value as Map<String, dynamic>,
          )
          as ReturnType;
    case 'DriverList200Response':
      return DriverList200Response.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'DriverRemove200Response':
      return DriverRemove200Response.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'DriverUpdateRequestBank':
      return DriverUpdateRequestBank.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'ForgotPasswordRequest':
      return ForgotPasswordRequest.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'InsertCouponRequest':
      return InsertCouponRequest.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'InsertOrderRequest':
      return InsertOrderRequest.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'InsertOrderRequestDriver':
      return InsertOrderRequestDriver.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'InsertOrderRequestMerchant':
      return InsertOrderRequestMerchant.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'InsertOrderRequestUser':
      return InsertOrderRequestUser.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'InsertReportRequest':
      return InsertReportRequest.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'InsertReviewRequest':
      return InsertReviewRequest.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'InsertScheduleRequest':
      return InsertScheduleRequest.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'InsertUserRequest':
      return InsertUserRequest.fromJson(value as Map<String, dynamic>)
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
    case 'OrderItem':
      return OrderItem.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'OrderItemItem':
      return OrderItemItem.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'OrderList200Response':
      return OrderList200Response.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'OrderNote':
      return OrderNote.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'Phone':
      return Phone.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'Report':
      return Report.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'ReportCreate200Response':
      return ReportCreate200Response.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'ReportList200Response':
      return ReportList200Response.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'ResetPasswordRequest':
      return ResetPasswordRequest.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'Review':
      return Review.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'ReviewCreate200Response':
      return ReviewCreate200Response.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'ReviewList200Response':
      return ReviewList200Response.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'Schedule':
      return Schedule.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'ScheduleCreate200Response':
      return ScheduleCreate200Response.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'ScheduleList200Response':
      return ScheduleList200Response.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'SignInRequest':
      return SignInRequest.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'SignInResBody':
      return SignInResBody.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'SignUpResBody':
      return SignUpResBody.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'Statements':
      return Statements.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'Time':
      return Time.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'UnbanUserSchemaRequest':
      return UnbanUserSchemaRequest.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'UpdateConfigurationRequest':
      return UpdateConfigurationRequest.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'UpdateCouponRequest':
      return UpdateCouponRequest.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'UpdateOrderRequest':
      return UpdateOrderRequest.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'UpdateReportRequest':
      return UpdateReportRequest.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'UpdateReviewRequest':
      return UpdateReviewRequest.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'UpdateScheduleRequest':
      return UpdateScheduleRequest.fromJson(value as Map<String, dynamic>)
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
