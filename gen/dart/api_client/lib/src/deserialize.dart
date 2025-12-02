import 'package:api_client/src/model/admin_update_user.dart';
import 'package:api_client/src/model/auth_exchange_token200_response.dart';
import 'package:api_client/src/model/auth_forgot_password_request.dart';
import 'package:api_client/src/model/auth_get_session200_response.dart';
import 'package:api_client/src/model/auth_has_permission200_response.dart';
import 'package:api_client/src/model/auth_has_permission_request.dart';
import 'package:api_client/src/model/auth_sign_in200_response.dart';
import 'package:api_client/src/model/auth_sign_out200_response.dart';
import 'package:api_client/src/model/auth_sign_up_user201_response.dart';
import 'package:api_client/src/model/badge.dart';
import 'package:api_client/src/model/badge_benefits.dart';
import 'package:api_client/src/model/badge_create200_response.dart';
import 'package:api_client/src/model/badge_criteria.dart';
import 'package:api_client/src/model/badge_list200_response.dart';
import 'package:api_client/src/model/badge_remove200_response.dart';
import 'package:api_client/src/model/badge_user_create200_response.dart';
import 'package:api_client/src/model/badge_user_create_request.dart';
import 'package:api_client/src/model/badge_user_list200_response.dart';
import 'package:api_client/src/model/badge_user_update_request.dart';
import 'package:api_client/src/model/ban_user.dart';
import 'package:api_client/src/model/bank.dart';
import 'package:api_client/src/model/banner_configuration.dart';
import 'package:api_client/src/model/chat_list200_response.dart';
import 'package:api_client/src/model/chat_list200_response_data.dart';
import 'package:api_client/src/model/chat_send200_response.dart';
import 'package:api_client/src/model/commission_configuration.dart';
import 'package:api_client/src/model/configuration.dart';
import 'package:api_client/src/model/configuration_get200_response.dart';
import 'package:api_client/src/model/configuration_list200_response.dart';
import 'package:api_client/src/model/contact.dart';
import 'package:api_client/src/model/contact_list200_response.dart';
import 'package:api_client/src/model/contact_list200_response_data.dart';
import 'package:api_client/src/model/contact_list200_response_data_pagination.dart';
import 'package:api_client/src/model/contact_submit201_response.dart';
import 'package:api_client/src/model/coordinate.dart';
import 'package:api_client/src/model/coupon.dart';
import 'package:api_client/src/model/coupon_create200_response.dart';
import 'package:api_client/src/model/coupon_get_eligible_coupons200_response.dart';
import 'package:api_client/src/model/coupon_get_eligible_coupons200_response_data.dart';
import 'package:api_client/src/model/coupon_get_eligible_coupons_request.dart';
import 'package:api_client/src/model/coupon_list200_response.dart';
import 'package:api_client/src/model/coupon_rules.dart';
import 'package:api_client/src/model/coupon_validate200_response.dart';
import 'package:api_client/src/model/coupon_validate200_response_data.dart';
import 'package:api_client/src/model/coupon_validate_request.dart';
import 'package:api_client/src/model/dashboard_stats.dart';
import 'package:api_client/src/model/delivery_pricing_configuration.dart';
import 'package:api_client/src/model/driver.dart';
import 'package:api_client/src/model/driver_get_mine200_response.dart';
import 'package:api_client/src/model/driver_get_mine200_response_body.dart';
import 'package:api_client/src/model/driver_list200_response.dart';
import 'package:api_client/src/model/driver_schedule.dart';
import 'package:api_client/src/model/driver_schedule_create200_response.dart';
import 'package:api_client/src/model/driver_schedule_create_request.dart';
import 'package:api_client/src/model/driver_schedule_list200_response.dart';
import 'package:api_client/src/model/driver_schedule_update_request.dart';
import 'package:api_client/src/model/driver_update_request_bank.dart';
import 'package:api_client/src/model/driver_update_request_current_location.dart';
import 'package:api_client/src/model/driver_user.dart';
import 'package:api_client/src/model/emergency.dart';
import 'package:api_client/src/model/emergency_contact_configuration.dart';
import 'package:api_client/src/model/emergency_list_by_order200_response.dart';
import 'package:api_client/src/model/emergency_location.dart';
import 'package:api_client/src/model/emergency_trigger200_response.dart';
import 'package:api_client/src/model/emergency_update_status_request.dart';
import 'package:api_client/src/model/estimate_order.dart';
import 'package:api_client/src/model/fcm_notification_log.dart';
import 'package:api_client/src/model/food_pricing_configuration.dart';
import 'package:api_client/src/model/general_rules.dart';
import 'package:api_client/src/model/get_session_response.dart';
import 'package:api_client/src/model/insert_configuration.dart';
import 'package:api_client/src/model/insert_contact.dart';
import 'package:api_client/src/model/insert_coupon.dart';
import 'package:api_client/src/model/insert_emergency.dart';
import 'package:api_client/src/model/insert_leaderboard.dart';
import 'package:api_client/src/model/insert_order_chat_message.dart';
import 'package:api_client/src/model/insert_payment.dart';
import 'package:api_client/src/model/insert_report.dart';
import 'package:api_client/src/model/insert_review.dart';
import 'package:api_client/src/model/insert_transaction.dart';
import 'package:api_client/src/model/insert_user.dart';
import 'package:api_client/src/model/leaderboard.dart';
import 'package:api_client/src/model/leaderboard_get200_response.dart';
import 'package:api_client/src/model/leaderboard_list200_response.dart';
import 'package:api_client/src/model/location.dart';
import 'package:api_client/src/model/merchant.dart';
import 'package:api_client/src/model/merchant_analytics200_response.dart';
import 'package:api_client/src/model/merchant_analytics200_response_data.dart';
import 'package:api_client/src/model/merchant_analytics200_response_data_revenue_by_day_inner.dart';
import 'package:api_client/src/model/merchant_analytics200_response_data_top_selling_items_inner.dart';
import 'package:api_client/src/model/merchant_best_sellers200_response.dart';
import 'package:api_client/src/model/merchant_best_sellers200_response_data_inner.dart';
import 'package:api_client/src/model/merchant_best_sellers200_response_data_inner_menu.dart';
import 'package:api_client/src/model/merchant_best_sellers200_response_data_inner_merchant.dart';
import 'package:api_client/src/model/merchant_get_mine200_response.dart';
import 'package:api_client/src/model/merchant_get_mine200_response_body.dart';
import 'package:api_client/src/model/merchant_menu.dart';
import 'package:api_client/src/model/merchant_menu_create200_response.dart';
import 'package:api_client/src/model/merchant_menu_list200_response.dart';
import 'package:api_client/src/model/merchant_order_accept200_response.dart';
import 'package:api_client/src/model/merchant_populars200_response.dart';
import 'package:api_client/src/model/notification_list200_response.dart';
import 'package:api_client/src/model/notification_save_token200_response.dart';
import 'package:api_client/src/model/notification_save_token200_response_data.dart';
import 'package:api_client/src/model/notification_save_token_request.dart';
import 'package:api_client/src/model/notification_subscribe_to_topic200_response.dart';
import 'package:api_client/src/model/notification_subscribe_to_topic200_response_data.dart';
import 'package:api_client/src/model/notification_subscribe_to_topic_request.dart';
import 'package:api_client/src/model/order.dart';
import 'package:api_client/src/model/order_cancel_request.dart';
import 'package:api_client/src/model/order_chat_message.dart';
import 'package:api_client/src/model/order_chat_message_list_query.dart';
import 'package:api_client/src/model/order_chat_message_sender.dart';
import 'package:api_client/src/model/order_driver.dart';
import 'package:api_client/src/model/order_envelope.dart';
import 'package:api_client/src/model/order_envelope_payload.dart';
import 'package:api_client/src/model/order_envelope_payload_detail.dart';
import 'package:api_client/src/model/order_envelope_payload_done.dart';
import 'package:api_client/src/model/order_envelope_payload_driver_update_location.dart';
import 'package:api_client/src/model/order_envelope_payload_message.dart';
import 'package:api_client/src/model/order_estimate200_response.dart';
import 'package:api_client/src/model/order_item.dart';
import 'package:api_client/src/model/order_item_item.dart';
import 'package:api_client/src/model/order_list200_response.dart';
import 'package:api_client/src/model/order_merchant.dart';
import 'package:api_client/src/model/order_note.dart';
import 'package:api_client/src/model/order_place_order200_response.dart';
import 'package:api_client/src/model/order_send_message_request.dart';
import 'package:api_client/src/model/order_summary.dart';
import 'package:api_client/src/model/order_summary_breakdown.dart';
import 'package:api_client/src/model/pagination_result.dart';
import 'package:api_client/src/model/pay_request.dart';
import 'package:api_client/src/model/payment.dart';
import 'package:api_client/src/model/payment_envelope.dart';
import 'package:api_client/src/model/payment_envelope_payload.dart';
import 'package:api_client/src/model/phone.dart';
import 'package:api_client/src/model/place_order.dart';
import 'package:api_client/src/model/place_order_payment.dart';
import 'package:api_client/src/model/place_order_response.dart';
import 'package:api_client/src/model/pricing_configuration.dart';
import 'package:api_client/src/model/report.dart';
import 'package:api_client/src/model/report_create200_response.dart';
import 'package:api_client/src/model/report_list200_response.dart';
import 'package:api_client/src/model/reset_password.dart';
import 'package:api_client/src/model/review.dart';
import 'package:api_client/src/model/review_create200_response.dart';
import 'package:api_client/src/model/review_list200_response.dart';
import 'package:api_client/src/model/ride_pricing_configuration.dart';
import 'package:api_client/src/model/session.dart';
import 'package:api_client/src/model/sign_in_request.dart';
import 'package:api_client/src/model/sign_in_response.dart';
import 'package:api_client/src/model/sign_up_response.dart';
import 'package:api_client/src/model/statements.dart';
import 'package:api_client/src/model/time.dart';
import 'package:api_client/src/model/time_rules.dart';
import 'package:api_client/src/model/top_up_request.dart';
import 'package:api_client/src/model/transaction.dart';
import 'package:api_client/src/model/transaction_get200_response.dart';
import 'package:api_client/src/model/transaction_list200_response.dart';
import 'package:api_client/src/model/transfer_request.dart';
import 'package:api_client/src/model/unban_user.dart';
import 'package:api_client/src/model/update_configuration.dart';
import 'package:api_client/src/model/update_contact.dart';
import 'package:api_client/src/model/update_coupon.dart';
import 'package:api_client/src/model/update_emergency.dart';
import 'package:api_client/src/model/update_leaderboard.dart';
import 'package:api_client/src/model/update_order.dart';
import 'package:api_client/src/model/update_payment.dart';
import 'package:api_client/src/model/update_report.dart';
import 'package:api_client/src/model/update_review.dart';
import 'package:api_client/src/model/update_transaction.dart';
import 'package:api_client/src/model/update_user_password.dart';
import 'package:api_client/src/model/update_user_role.dart';
import 'package:api_client/src/model/update_wallet.dart';
import 'package:api_client/src/model/user.dart';
import 'package:api_client/src/model/user_admin_create200_response.dart';
import 'package:api_client/src/model/user_admin_dashboard_stats200_response.dart';
import 'package:api_client/src/model/user_admin_list200_response.dart';
import 'package:api_client/src/model/user_badge.dart';
import 'package:api_client/src/model/user_badge_metadata.dart';
import 'package:api_client/src/model/user_notification.dart';
import 'package:api_client/src/model/user_rules.dart';
import 'package:api_client/src/model/va_number.dart';
import 'package:api_client/src/model/wallet.dart';
import 'package:api_client/src/model/wallet_get200_response.dart';
import 'package:api_client/src/model/wallet_get_monthly_summary200_response.dart';
import 'package:api_client/src/model/wallet_monthly_summary_query.dart';
import 'package:api_client/src/model/wallet_monthly_summary_response.dart';
import 'package:api_client/src/model/wallet_top_up200_response.dart';
import 'package:api_client/src/model/withdraw_request.dart';

final _regList = RegExp(r'^List<(.*)>$');
final _regSet = RegExp(r'^Set<(.*)>$');
final _regMap = RegExp(r'^Map<String,(.*)>$');

ReturnType deserialize<ReturnType, BaseType>(dynamic value, String targetType, {bool growable = true}) {
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
    case 'AdminUpdateUser':
      return AdminUpdateUser.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'AuthExchangeToken200Response':
      return AuthExchangeToken200Response.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'AuthForgotPasswordRequest':
      return AuthForgotPasswordRequest.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'AuthGetSession200Response':
      return AuthGetSession200Response.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'AuthHasPermission200Response':
      return AuthHasPermission200Response.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'AuthHasPermissionRequest':
      return AuthHasPermissionRequest.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'AuthSignIn200Response':
      return AuthSignIn200Response.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'AuthSignOut200Response':
      return AuthSignOut200Response.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'AuthSignUpUser201Response':
      return AuthSignUpUser201Response.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'Badge':
      return Badge.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'BadgeBenefits':
      return BadgeBenefits.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'BadgeCreate200Response':
      return BadgeCreate200Response.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'BadgeCriteria':
      return BadgeCriteria.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'BadgeLevel':
    case 'BadgeList200Response':
      return BadgeList200Response.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'BadgeRemove200Response':
      return BadgeRemove200Response.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'BadgeTargetRole':
    case 'BadgeType':
    case 'BadgeUserCreate200Response':
      return BadgeUserCreate200Response.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'BadgeUserCreateRequest':
      return BadgeUserCreateRequest.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'BadgeUserList200Response':
      return BadgeUserList200Response.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'BadgeUserUpdateRequest':
      return BadgeUserUpdateRequest.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'BanUser':
      return BanUser.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'Bank':
      return Bank.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'BankProvider':
    case 'BannerConfiguration':
      return BannerConfiguration.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'ChatList200Response':
      return ChatList200Response.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'ChatList200ResponseData':
      return ChatList200ResponseData.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'ChatSend200Response':
      return ChatSend200Response.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'CommissionConfiguration':
      return CommissionConfiguration.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'Configuration':
      return Configuration.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'ConfigurationGet200Response':
      return ConfigurationGet200Response.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'ConfigurationKey':
    case 'ConfigurationList200Response':
      return ConfigurationList200Response.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'Contact':
      return Contact.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'ContactKey':
    case 'ContactList200Response':
      return ContactList200Response.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'ContactList200ResponseData':
      return ContactList200ResponseData.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'ContactList200ResponseDataPagination':
      return ContactList200ResponseDataPagination.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'ContactStatus':
    case 'ContactSubmit201Response':
      return ContactSubmit201Response.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'Coordinate':
      return Coordinate.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'CountryCode':
    case 'Coupon':
      return Coupon.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'CouponCreate200Response':
      return CouponCreate200Response.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'CouponGetEligibleCoupons200Response':
      return CouponGetEligibleCoupons200Response.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'CouponGetEligibleCoupons200ResponseData':
      return CouponGetEligibleCoupons200ResponseData.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'CouponGetEligibleCouponsRequest':
      return CouponGetEligibleCouponsRequest.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'CouponKey':
    case 'CouponList200Response':
      return CouponList200Response.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'CouponRules':
      return CouponRules.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'CouponValidate200Response':
      return CouponValidate200Response.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'CouponValidate200ResponseData':
      return CouponValidate200ResponseData.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'CouponValidateRequest':
      return CouponValidateRequest.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'Currency':
    case 'DashboardStats':
      return DashboardStats.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'DayOfWeek':
    case 'DeliveryPricingConfiguration':
      return DeliveryPricingConfiguration.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'Driver':
      return Driver.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'DriverGetMine200Response':
      return DriverGetMine200Response.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'DriverGetMine200ResponseBody':
      return DriverGetMine200ResponseBody.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'DriverKey':
    case 'DriverList200Response':
      return DriverList200Response.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'DriverSchedule':
      return DriverSchedule.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'DriverScheduleCreate200Response':
      return DriverScheduleCreate200Response.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'DriverScheduleCreateRequest':
      return DriverScheduleCreateRequest.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'DriverScheduleKey':
    case 'DriverScheduleList200Response':
      return DriverScheduleList200Response.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'DriverScheduleUpdateRequest':
      return DriverScheduleUpdateRequest.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'DriverStatus':
    case 'DriverUpdateRequestBank':
      return DriverUpdateRequestBank.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'DriverUpdateRequestCurrentLocation':
      return DriverUpdateRequestCurrentLocation.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'DriverUser':
      return DriverUser.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'Emergency':
      return Emergency.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'EmergencyContactConfiguration':
      return EmergencyContactConfiguration.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'EmergencyKey':
    case 'EmergencyListByOrder200Response':
      return EmergencyListByOrder200Response.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'EmergencyLocation':
      return EmergencyLocation.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'EmergencyStatus':
    case 'EmergencyTrigger200Response':
      return EmergencyTrigger200Response.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'EmergencyType':
    case 'EmergencyUpdateStatusRequest':
      return EmergencyUpdateStatusRequest.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'EnvelopeSender':
    case 'EnvelopeTarget':
    case 'EstimateOrder':
      return EstimateOrder.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'FCMNotificationLog':
      return FCMNotificationLog.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'FoodPricingConfiguration':
      return FoodPricingConfiguration.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'GeneralRuleType':
    case 'GeneralRules':
      return GeneralRules.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'GetSessionResponse':
      return GetSessionResponse.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'InsertConfiguration':
      return InsertConfiguration.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'InsertContact':
      return InsertContact.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'InsertCoupon':
      return InsertCoupon.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'InsertEmergency':
      return InsertEmergency.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'InsertLeaderboard':
      return InsertLeaderboard.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'InsertOrderChatMessage':
      return InsertOrderChatMessage.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'InsertPayment':
      return InsertPayment.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'InsertReport':
      return InsertReport.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'InsertReview':
      return InsertReview.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'InsertTransaction':
      return InsertTransaction.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'InsertUser':
      return InsertUser.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'Leaderboard':
      return Leaderboard.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'LeaderboardGet200Response':
      return LeaderboardGet200Response.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'LeaderboardList200Response':
      return LeaderboardList200Response.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'Location':
      return Location.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'Merchant':
      return Merchant.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'MerchantAnalytics200Response':
      return MerchantAnalytics200Response.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'MerchantAnalytics200ResponseData':
      return MerchantAnalytics200ResponseData.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'MerchantAnalytics200ResponseDataRevenueByDayInner':
      return MerchantAnalytics200ResponseDataRevenueByDayInner.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'MerchantAnalytics200ResponseDataTopSellingItemsInner':
      return MerchantAnalytics200ResponseDataTopSellingItemsInner.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'MerchantBestSellers200Response':
      return MerchantBestSellers200Response.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'MerchantBestSellers200ResponseDataInner':
      return MerchantBestSellers200ResponseDataInner.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'MerchantBestSellers200ResponseDataInnerMenu':
      return MerchantBestSellers200ResponseDataInnerMenu.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'MerchantBestSellers200ResponseDataInnerMerchant':
      return MerchantBestSellers200ResponseDataInnerMerchant.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'MerchantCategory':
    case 'MerchantGetMine200Response':
      return MerchantGetMine200Response.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'MerchantGetMine200ResponseBody':
      return MerchantGetMine200ResponseBody.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'MerchantKey':
    case 'MerchantMenu':
      return MerchantMenu.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'MerchantMenuCreate200Response':
      return MerchantMenuCreate200Response.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'MerchantMenuKey':
    case 'MerchantMenuList200Response':
      return MerchantMenuList200Response.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'MerchantOrderAccept200Response':
      return MerchantOrderAccept200Response.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'MerchantPopulars200Response':
      return MerchantPopulars200Response.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'NotificationList200Response':
      return NotificationList200Response.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'NotificationSaveToken200Response':
      return NotificationSaveToken200Response.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'NotificationSaveToken200ResponseData':
      return NotificationSaveToken200ResponseData.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'NotificationSaveTokenRequest':
      return NotificationSaveTokenRequest.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'NotificationSubscribeToTopic200Response':
      return NotificationSubscribeToTopic200Response.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'NotificationSubscribeToTopic200ResponseData':
      return NotificationSubscribeToTopic200ResponseData.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'NotificationSubscribeToTopicRequest':
      return NotificationSubscribeToTopicRequest.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'Order':
      return Order.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'OrderCancelRequest':
      return OrderCancelRequest.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'OrderChatMessage':
      return OrderChatMessage.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'OrderChatMessageListQuery':
      return OrderChatMessageListQuery.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'OrderChatMessageSender':
      return OrderChatMessageSender.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'OrderDriver':
      return OrderDriver.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'OrderEnvelope':
      return OrderEnvelope.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'OrderEnvelopeAction':
    case 'OrderEnvelopeEvent':
    case 'OrderEnvelopePayload':
      return OrderEnvelopePayload.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'OrderEnvelopePayloadDetail':
      return OrderEnvelopePayloadDetail.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'OrderEnvelopePayloadDone':
      return OrderEnvelopePayloadDone.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'OrderEnvelopePayloadDriverUpdateLocation':
      return OrderEnvelopePayloadDriverUpdateLocation.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'OrderEnvelopePayloadMessage':
      return OrderEnvelopePayloadMessage.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'OrderEstimate200Response':
      return OrderEstimate200Response.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'OrderItem':
      return OrderItem.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'OrderItemItem':
      return OrderItemItem.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'OrderKey':
    case 'OrderList200Response':
      return OrderList200Response.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'OrderMerchant':
      return OrderMerchant.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'OrderNote':
      return OrderNote.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'OrderPlaceOrder200Response':
      return OrderPlaceOrder200Response.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'OrderSendMessageRequest':
      return OrderSendMessageRequest.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'OrderStatus':
    case 'OrderSummary':
      return OrderSummary.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'OrderSummaryBreakdown':
      return OrderSummaryBreakdown.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'OrderType':
    case 'PaginationMode':
    case 'PaginationOrder':
    case 'PaginationResult':
      return PaginationResult.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'PayRequest':
      return PayRequest.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'Payment':
      return Payment.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'PaymentEnvelope':
      return PaymentEnvelope.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'PaymentEnvelopeEvent':
    case 'PaymentEnvelopePayload':
      return PaymentEnvelopePayload.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'PaymentKey':
    case 'PaymentMethod':
    case 'PaymentProvider':
    case 'Phone':
      return Phone.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'PlaceOrder':
      return PlaceOrder.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'PlaceOrderPayment':
      return PlaceOrderPayment.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'PlaceOrderResponse':
      return PlaceOrderResponse.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'PricingConfiguration':
      return PricingConfiguration.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'Report':
      return Report.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'ReportCategory':
    case 'ReportCreate200Response':
      return ReportCreate200Response.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'ReportKey':
    case 'ReportList200Response':
      return ReportList200Response.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'ReportStatus':
    case 'ResetPassword':
      return ResetPassword.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'Review':
      return Review.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'ReviewCategory':
    case 'ReviewCreate200Response':
      return ReviewCreate200Response.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'ReviewKeySchema':
    case 'ReviewList200Response':
      return ReviewList200Response.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'RidePricingConfiguration':
      return RidePricingConfiguration.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'Session':
      return Session.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'SignInRequest':
      return SignInRequest.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'SignInResponse':
      return SignInResponse.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'SignUpResponse':
      return SignUpResponse.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'Statements':
      return Statements.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'Time':
      return Time.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'TimeRules':
      return TimeRules.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'TopUpRequest':
      return TopUpRequest.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'Transaction':
      return Transaction.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'TransactionGet200Response':
      return TransactionGet200Response.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'TransactionKey':
    case 'TransactionList200Response':
      return TransactionList200Response.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'TransactionStatus':
    case 'TransactionType':
    case 'TransferRequest':
      return TransferRequest.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'UnbanUser':
      return UnbanUser.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'UpdateConfiguration':
      return UpdateConfiguration.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'UpdateContact':
      return UpdateContact.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'UpdateCoupon':
      return UpdateCoupon.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'UpdateEmergency':
      return UpdateEmergency.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'UpdateLeaderboard':
      return UpdateLeaderboard.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'UpdateOrder':
      return UpdateOrder.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'UpdatePayment':
      return UpdatePayment.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'UpdateReport':
      return UpdateReport.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'UpdateReview':
      return UpdateReview.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'UpdateTransaction':
      return UpdateTransaction.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'UpdateUserPassword':
      return UpdateUserPassword.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'UpdateUserRole':
      return UpdateUserRole.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'UpdateWallet':
      return UpdateWallet.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'User':
      return User.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'UserAdminCreate200Response':
      return UserAdminCreate200Response.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'UserAdminDashboardStats200Response':
      return UserAdminDashboardStats200Response.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'UserAdminList200Response':
      return UserAdminList200Response.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'UserBadge':
      return UserBadge.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'UserBadgeMetadata':
      return UserBadgeMetadata.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'UserGender':
    case 'UserKey':
    case 'UserNotification':
      return UserNotification.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'UserRole':
    case 'UserRules':
      return UserRules.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'VANumber':
      return VANumber.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'Wallet':
      return Wallet.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'WalletGet200Response':
      return WalletGet200Response.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'WalletGetMonthlySummary200Response':
      return WalletGetMonthlySummary200Response.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'WalletKey':
    case 'WalletMonthlySummaryQuery':
      return WalletMonthlySummaryQuery.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'WalletMonthlySummaryResponse':
      return WalletMonthlySummaryResponse.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'WalletTopUp200Response':
      return WalletTopUp200Response.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'WithdrawRequest':
      return WithdrawRequest.fromJson(value as Map<String, dynamic>) as ReturnType;
    default:
      RegExpMatch? match;

      if (value is List && (match = _regList.firstMatch(targetType)) != null) {
        targetType = match![1]!; // ignore: parameter_assignments
        return value
                .map<BaseType>((dynamic v) => deserialize<BaseType, BaseType>(v, targetType, growable: growable))
                .toList(growable: growable)
            as ReturnType;
      }
      if (value is Set && (match = _regSet.firstMatch(targetType)) != null) {
        targetType = match![1]!; // ignore: parameter_assignments
        return value
                .map<BaseType>((dynamic v) => deserialize<BaseType, BaseType>(v, targetType, growable: growable))
                .toSet()
            as ReturnType;
      }
      if (value is Map && (match = _regMap.firstMatch(targetType)) != null) {
        targetType = match![1]!.trim(); // ignore: parameter_assignments
        return Map<String, BaseType>.fromIterables(
              value.keys as Iterable<String>,
              value.values.map((dynamic v) => deserialize<BaseType, BaseType>(v, targetType, growable: growable)),
            )
            as ReturnType;
      }
      break;
  }
  throw Exception('Cannot deserialize');
}
