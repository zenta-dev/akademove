import 'package:api_client/src/model/account_deletion.dart';
import 'package:api_client/src/model/account_deletion_delete200_response.dart';
import 'package:api_client/src/model/account_deletion_delete200_response_data.dart';
import 'package:api_client/src/model/account_deletion_list200_response.dart';
import 'package:api_client/src/model/account_deletion_list200_response_data.dart';
import 'package:api_client/src/model/account_deletion_list200_response_data_pagination.dart';
import 'package:api_client/src/model/account_deletion_review_request.dart';
import 'package:api_client/src/model/account_deletion_submit201_response.dart';
import 'package:api_client/src/model/activate_driver.dart';
import 'package:api_client/src/model/add_to_cart.dart';
import 'package:api_client/src/model/admin_update_user.dart';
import 'package:api_client/src/model/approve_driver.dart';
import 'package:api_client/src/model/audit_list200_response.dart';
import 'package:api_client/src/model/audit_list200_response_data_inner.dart';
import 'package:api_client/src/model/auth_exchange_token200_response.dart';
import 'package:api_client/src/model/auth_forgot_password_request.dart';
import 'package:api_client/src/model/auth_get_session200_response.dart';
import 'package:api_client/src/model/auth_has_access_request.dart';
import 'package:api_client/src/model/auth_sign_in200_response.dart';
import 'package:api_client/src/model/auth_sign_out200_response.dart';
import 'package:api_client/src/model/auth_sign_up_user201_response.dart';
import 'package:api_client/src/model/auth_verify_email200_response.dart';
import 'package:api_client/src/model/auth_verify_email200_response_data.dart';
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
import 'package:api_client/src/model/bank_validate_account200_response.dart';
import 'package:api_client/src/model/bank_validation_request.dart';
import 'package:api_client/src/model/bank_validation_response.dart';
import 'package:api_client/src/model/banner_configuration.dart';
import 'package:api_client/src/model/banner_create201_response.dart';
import 'package:api_client/src/model/banner_create201_response_data.dart';
import 'package:api_client/src/model/banner_create_request.dart';
import 'package:api_client/src/model/banner_delete200_response.dart';
import 'package:api_client/src/model/banner_delete200_response_data.dart';
import 'package:api_client/src/model/banner_list200_response.dart';
import 'package:api_client/src/model/banner_list200_response_data_inner.dart';
import 'package:api_client/src/model/banner_list_public200_response.dart';
import 'package:api_client/src/model/banner_list_public200_response_data_inner.dart';
import 'package:api_client/src/model/banner_update_request.dart';
import 'package:api_client/src/model/broadcast.dart';
import 'package:api_client/src/model/broadcast_create201_response.dart';
import 'package:api_client/src/model/broadcast_create201_response_data.dart';
import 'package:api_client/src/model/broadcast_create_request.dart';
import 'package:api_client/src/model/broadcast_list200_response.dart';
import 'package:api_client/src/model/broadcast_list200_response_data_inner.dart';
import 'package:api_client/src/model/broadcast_stats200_response.dart';
import 'package:api_client/src/model/broadcast_stats200_response_data.dart';
import 'package:api_client/src/model/broadcast_update_request.dart';
import 'package:api_client/src/model/business_configuration.dart';
import 'package:api_client/src/model/cart.dart';
import 'package:api_client/src/model/cart_item.dart';
import 'package:api_client/src/model/chart_data_point.dart';
import 'package:api_client/src/model/chat_get_unread_count200_response.dart';
import 'package:api_client/src/model/chat_list200_response.dart';
import 'package:api_client/src/model/chat_list200_response_data.dart';
import 'package:api_client/src/model/chat_mark_as_read200_response.dart';
import 'package:api_client/src/model/chat_send200_response.dart';
import 'package:api_client/src/model/chat_unread_count.dart';
import 'package:api_client/src/model/commission_report_query.dart';
import 'package:api_client/src/model/commission_report_response.dart';
import 'package:api_client/src/model/commission_transaction.dart';
import 'package:api_client/src/model/complete_driver_quiz.dart';
import 'package:api_client/src/model/configuration.dart';
import 'package:api_client/src/model/configuration_get200_response.dart';
import 'package:api_client/src/model/configuration_get_business_config200_response.dart';
import 'package:api_client/src/model/configuration_list200_response.dart';
import 'package:api_client/src/model/contact.dart';
import 'package:api_client/src/model/contact_delete200_response.dart';
import 'package:api_client/src/model/contact_list200_response.dart';
import 'package:api_client/src/model/contact_list200_response_data.dart';
import 'package:api_client/src/model/contact_respond_request.dart';
import 'package:api_client/src/model/contact_submit201_response.dart';
import 'package:api_client/src/model/coordinate.dart';
import 'package:api_client/src/model/coordinate_with_meta.dart';
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
import 'package:api_client/src/model/dashboard_stats_high_cancellation_drivers_inner.dart';
import 'package:api_client/src/model/dashboard_stats_orders_by_day_inner.dart';
import 'package:api_client/src/model/dashboard_stats_orders_by_type_inner.dart';
import 'package:api_client/src/model/dashboard_stats_query.dart';
import 'package:api_client/src/model/dashboard_stats_top_drivers_inner.dart';
import 'package:api_client/src/model/dashboard_stats_top_merchants_inner.dart';
import 'package:api_client/src/model/delivery_pricing_configuration.dart';
import 'package:api_client/src/model/dismiss_report.dart';
import 'package:api_client/src/model/driver.dart';
import 'package:api_client/src/model/driver_get_analytics200_response.dart';
import 'package:api_client/src/model/driver_get_analytics200_response_data.dart';
import 'package:api_client/src/model/driver_get_analytics200_response_data_earnings_by_day_inner.dart';
import 'package:api_client/src/model/driver_get_analytics200_response_data_earnings_by_type_inner.dart';
import 'package:api_client/src/model/driver_get_analytics200_response_data_top_earning_days_inner.dart';
import 'package:api_client/src/model/driver_get_mine200_response.dart';
import 'package:api_client/src/model/driver_get_mine200_response_body.dart';
import 'package:api_client/src/model/driver_get_review200_response.dart';
import 'package:api_client/src/model/driver_get_review200_response_data.dart';
import 'package:api_client/src/model/driver_list200_response.dart';
import 'package:api_client/src/model/driver_min_quiz_question.dart';
import 'package:api_client/src/model/driver_quiz_answer.dart';
import 'package:api_client/src/model/driver_quiz_answer_complete_quiz200_response.dart';
import 'package:api_client/src/model/driver_quiz_answer_get_attempt200_response.dart';
import 'package:api_client/src/model/driver_quiz_answer_list200_response.dart';
import 'package:api_client/src/model/driver_quiz_answer_list200_response_data.dart';
import 'package:api_client/src/model/driver_quiz_answer_start_quiz201_response.dart';
import 'package:api_client/src/model/driver_quiz_answer_submit_answer200_response.dart';
import 'package:api_client/src/model/driver_quiz_attempt.dart';
import 'package:api_client/src/model/driver_quiz_question.dart';
import 'package:api_client/src/model/driver_quiz_question_answer.dart';
import 'package:api_client/src/model/driver_quiz_question_create201_response.dart';
import 'package:api_client/src/model/driver_quiz_question_get_quiz_questions200_response.dart';
import 'package:api_client/src/model/driver_quiz_question_get_quiz_questions200_response_data_inner.dart';
import 'package:api_client/src/model/driver_quiz_question_get_quiz_questions200_response_data_inner_options_inner.dart';
import 'package:api_client/src/model/driver_quiz_question_list200_response.dart';
import 'package:api_client/src/model/driver_quiz_question_list200_response_data.dart';
import 'package:api_client/src/model/driver_quiz_question_option.dart';
import 'package:api_client/src/model/driver_quiz_result.dart';
import 'package:api_client/src/model/driver_reject_request.dart';
import 'package:api_client/src/model/driver_schedule.dart';
import 'package:api_client/src/model/driver_schedule_create200_response.dart';
import 'package:api_client/src/model/driver_schedule_create_request.dart';
import 'package:api_client/src/model/driver_schedule_list200_response.dart';
import 'package:api_client/src/model/driver_schedule_update_request.dart';
import 'package:api_client/src/model/driver_submit_approval_request.dart';
import 'package:api_client/src/model/driver_submit_rejection_request.dart';
import 'package:api_client/src/model/driver_suspend_request.dart';
import 'package:api_client/src/model/driver_update_document_status_request.dart';
import 'package:api_client/src/model/driver_update_online_status_request.dart';
import 'package:api_client/src/model/driver_update_taking_order_status_request.dart';
import 'package:api_client/src/model/driver_user.dart';
import 'package:api_client/src/model/driver_verify_quiz_request.dart';
import 'package:api_client/src/model/driver_wallet_get_monthly_summary200_response.dart';
import 'package:api_client/src/model/driver_wallet_get_saved_bank_account200_response.dart';
import 'package:api_client/src/model/driver_wallet_get_transactions200_response.dart';
import 'package:api_client/src/model/driver_wallet_get_wallet200_response.dart';
import 'package:api_client/src/model/driver_wallet_top_up200_response.dart';
import 'package:api_client/src/model/driver_wallet_transfer200_response.dart';
import 'package:api_client/src/model/emergency.dart';
import 'package:api_client/src/model/emergency_contact_configuration.dart';
import 'package:api_client/src/model/emergency_list_by_order200_response.dart';
import 'package:api_client/src/model/emergency_location.dart';
import 'package:api_client/src/model/emergency_trigger200_response.dart';
import 'package:api_client/src/model/emergency_update_status_request.dart';
import 'package:api_client/src/model/estimate_order.dart';
import 'package:api_client/src/model/food_pricing_configuration.dart';
import 'package:api_client/src/model/fraud_config.dart';
import 'package:api_client/src/model/fraud_event.dart';
import 'package:api_client/src/model/fraud_event_driver.dart';
import 'package:api_client/src/model/fraud_event_handled_by.dart';
import 'package:api_client/src/model/fraud_event_list_query.dart';
import 'package:api_client/src/model/fraud_event_user.dart';
import 'package:api_client/src/model/fraud_get_event200_response.dart';
import 'package:api_client/src/model/fraud_get_stats200_response.dart';
import 'package:api_client/src/model/fraud_get_user_profile200_response.dart';
import 'package:api_client/src/model/fraud_list_events200_response.dart';
import 'package:api_client/src/model/fraud_list_high_risk_users200_response.dart';
import 'package:api_client/src/model/fraud_signal.dart';
import 'package:api_client/src/model/fraud_stats.dart';
import 'package:api_client/src/model/fraud_stats_events_by_severity.dart';
import 'package:api_client/src/model/fraud_stats_query.dart';
import 'package:api_client/src/model/fraud_stats_recent_trend_inner.dart';
import 'package:api_client/src/model/general_rules.dart';
import 'package:api_client/src/model/get_session_response.dart';
import 'package:api_client/src/model/insert_account_deletion.dart';
import 'package:api_client/src/model/insert_broadcast.dart';
import 'package:api_client/src/model/insert_configuration.dart';
import 'package:api_client/src/model/insert_contact.dart';
import 'package:api_client/src/model/insert_coupon.dart';
import 'package:api_client/src/model/insert_driver_quiz_question.dart';
import 'package:api_client/src/model/insert_emergency.dart';
import 'package:api_client/src/model/insert_fraud_event.dart';
import 'package:api_client/src/model/insert_leaderboard.dart';
import 'package:api_client/src/model/insert_newsletter.dart';
import 'package:api_client/src/model/insert_order_chat_message.dart';
import 'package:api_client/src/model/insert_payment.dart';
import 'package:api_client/src/model/insert_quick_message_template.dart';
import 'package:api_client/src/model/insert_report.dart';
import 'package:api_client/src/model/insert_review.dart';
import 'package:api_client/src/model/insert_support_chat_message.dart';
import 'package:api_client/src/model/insert_support_ticket.dart';
import 'package:api_client/src/model/insert_transaction.dart';
import 'package:api_client/src/model/insert_user.dart';
import 'package:api_client/src/model/leaderboard.dart';
import 'package:api_client/src/model/leaderboard_get200_response.dart';
import 'package:api_client/src/model/leaderboard_list200_response.dart';
import 'package:api_client/src/model/list_driver_quiz_answer_query.dart';
import 'package:api_client/src/model/list_driver_quiz_question_query.dart';
import 'package:api_client/src/model/list_quick_message_query.dart';
import 'package:api_client/src/model/location.dart';
import 'package:api_client/src/model/mark_chat_as_read.dart';
import 'package:api_client/src/model/merchant.dart';
import 'package:api_client/src/model/merchant_analytics200_response.dart';
import 'package:api_client/src/model/merchant_analytics200_response_data.dart';
import 'package:api_client/src/model/merchant_analytics200_response_data_revenue_by_day_inner.dart';
import 'package:api_client/src/model/merchant_analytics200_response_data_top_selling_items_inner.dart';
import 'package:api_client/src/model/merchant_best_sellers200_response.dart';
import 'package:api_client/src/model/merchant_best_sellers200_response_data_inner.dart';
import 'package:api_client/src/model/merchant_best_sellers200_response_data_inner_menu.dart';
import 'package:api_client/src/model/merchant_best_sellers200_response_data_inner_merchant.dart';
import 'package:api_client/src/model/merchant_deactivate_request.dart';
import 'package:api_client/src/model/merchant_envelope.dart';
import 'package:api_client/src/model/merchant_envelope_payload.dart';
import 'package:api_client/src/model/merchant_envelope_payload_sync_request.dart';
import 'package:api_client/src/model/merchant_get_availability_status200_response.dart';
import 'package:api_client/src/model/merchant_get_availability_status200_response_data.dart';
import 'package:api_client/src/model/merchant_get_mine200_response.dart';
import 'package:api_client/src/model/merchant_get_mine200_response_body.dart';
import 'package:api_client/src/model/merchant_get_review200_response.dart';
import 'package:api_client/src/model/merchant_get_review200_response_data.dart';
import 'package:api_client/src/model/merchant_menu.dart';
import 'package:api_client/src/model/merchant_menu_create200_response.dart';
import 'package:api_client/src/model/merchant_menu_list200_response.dart';
import 'package:api_client/src/model/merchant_operating_hours.dart';
import 'package:api_client/src/model/merchant_operating_hours_bulk_upsert_request.dart';
import 'package:api_client/src/model/merchant_operating_hours_create200_response.dart';
import 'package:api_client/src/model/merchant_operating_hours_create_request.dart';
import 'package:api_client/src/model/merchant_operating_hours_list200_response.dart';
import 'package:api_client/src/model/merchant_operating_hours_update_request.dart';
import 'package:api_client/src/model/merchant_order_accept200_response.dart';
import 'package:api_client/src/model/merchant_populars200_response.dart';
import 'package:api_client/src/model/merchant_set_operating_status_request.dart';
import 'package:api_client/src/model/merchant_update_document_status_request.dart';
import 'package:api_client/src/model/newsletter.dart';
import 'package:api_client/src/model/notification_get_unread_count200_response.dart';
import 'package:api_client/src/model/notification_get_unread_count200_response_data.dart';
import 'package:api_client/src/model/notification_list200_response.dart';
import 'package:api_client/src/model/notification_list200_response_data_inner.dart';
import 'package:api_client/src/model/notification_mark_as_read200_response.dart';
import 'package:api_client/src/model/notification_mark_as_read200_response_data.dart';
import 'package:api_client/src/model/notification_save_token_request.dart';
import 'package:api_client/src/model/notification_subscribe_to_topic200_response.dart';
import 'package:api_client/src/model/notification_subscribe_to_topic200_response_data.dart';
import 'package:api_client/src/model/notification_subscribe_to_topic_request.dart';
import 'package:api_client/src/model/order.dart';
import 'package:api_client/src/model/order_cancel_request.dart';
import 'package:api_client/src/model/order_chat_message.dart';
import 'package:api_client/src/model/order_chat_message_list_query.dart';
import 'package:api_client/src/model/order_chat_message_sender.dart';
import 'package:api_client/src/model/order_chat_read_status.dart';
import 'package:api_client/src/model/order_driver.dart';
import 'package:api_client/src/model/order_envelope.dart';
import 'package:api_client/src/model/order_envelope_payload.dart';
import 'package:api_client/src/model/order_envelope_payload_chat_unread_count.dart';
import 'package:api_client/src/model/order_envelope_payload_detail.dart';
import 'package:api_client/src/model/order_envelope_payload_done.dart';
import 'package:api_client/src/model/order_envelope_payload_driver_update_location.dart';
import 'package:api_client/src/model/order_envelope_payload_merchant_action.dart';
import 'package:api_client/src/model/order_envelope_payload_message.dart';
import 'package:api_client/src/model/order_envelope_payload_no_show.dart';
import 'package:api_client/src/model/order_envelope_payload_retry_info.dart';
import 'package:api_client/src/model/order_envelope_payload_sync_request.dart';
import 'package:api_client/src/model/order_estimate200_response.dart';
import 'package:api_client/src/model/order_get_active200_response.dart';
import 'package:api_client/src/model/order_get_active200_response_data.dart';
import 'package:api_client/src/model/order_get_status_history200_response.dart';
import 'package:api_client/src/model/order_item.dart';
import 'package:api_client/src/model/order_item_item.dart';
import 'package:api_client/src/model/order_list200_response.dart';
import 'package:api_client/src/model/order_merchant.dart';
import 'package:api_client/src/model/order_note.dart';
import 'package:api_client/src/model/order_place_order200_response.dart';
import 'package:api_client/src/model/order_place_scheduled_order200_response.dart';
import 'package:api_client/src/model/order_send_message_request.dart';
import 'package:api_client/src/model/order_status_history.dart';
import 'package:api_client/src/model/order_summary.dart';
import 'package:api_client/src/model/order_summary_breakdown.dart';
import 'package:api_client/src/model/order_upload_delivery_proof200_response.dart';
import 'package:api_client/src/model/order_upload_delivery_proof200_response_data.dart';
import 'package:api_client/src/model/order_upload_delivery_proof_request.dart';
import 'package:api_client/src/model/order_verify_delivery_otp200_response.dart';
import 'package:api_client/src/model/order_verify_delivery_otp200_response_data.dart';
import 'package:api_client/src/model/order_verify_delivery_otp_request.dart';
import 'package:api_client/src/model/pagination_result.dart';
import 'package:api_client/src/model/pay_request.dart';
import 'package:api_client/src/model/payment.dart';
import 'package:api_client/src/model/payment_envelope.dart';
import 'package:api_client/src/model/payment_envelope_payload.dart';
import 'package:api_client/src/model/payment_envelope_payload_sync_request.dart';
import 'package:api_client/src/model/phone.dart';
import 'package:api_client/src/model/place_order.dart';
import 'package:api_client/src/model/place_order_payment.dart';
import 'package:api_client/src/model/place_order_response.dart';
import 'package:api_client/src/model/place_order_response_auto_applied_coupon.dart';
import 'package:api_client/src/model/place_scheduled_order.dart';
import 'package:api_client/src/model/place_scheduled_order_response.dart';
import 'package:api_client/src/model/pricing_configuration.dart';
import 'package:api_client/src/model/quick_message_create200_response.dart';
import 'package:api_client/src/model/quick_message_list200_response.dart';
import 'package:api_client/src/model/quick_message_list200_response_data.dart';
import 'package:api_client/src/model/quick_message_template.dart';
import 'package:api_client/src/model/reject_driver.dart';
import 'package:api_client/src/model/report.dart';
import 'package:api_client/src/model/report_create200_response.dart';
import 'package:api_client/src/model/report_list200_response.dart';
import 'package:api_client/src/model/reset_password.dart';
import 'package:api_client/src/model/resolve_report.dart';
import 'package:api_client/src/model/review.dart';
import 'package:api_client/src/model/review_check_can_review200_response.dart';
import 'package:api_client/src/model/review_check_can_review200_response_data.dart';
import 'package:api_client/src/model/review_create200_response.dart';
import 'package:api_client/src/model/review_fraud_event.dart';
import 'package:api_client/src/model/review_list200_response.dart';
import 'package:api_client/src/model/ride_pricing_configuration.dart';
import 'package:api_client/src/model/saved_bank_account.dart';
import 'package:api_client/src/model/send_email_verification.dart';
import 'package:api_client/src/model/session.dart';
import 'package:api_client/src/model/sign_in_request.dart';
import 'package:api_client/src/model/sign_in_response.dart';
import 'package:api_client/src/model/sign_up_response.dart';
import 'package:api_client/src/model/start_driver_quiz.dart';
import 'package:api_client/src/model/start_investigation.dart';
import 'package:api_client/src/model/submit_driver_quiz_answer.dart';
import 'package:api_client/src/model/submit_driver_quiz_answer_response.dart';
import 'package:api_client/src/model/support_chat_envelope.dart';
import 'package:api_client/src/model/support_chat_envelope_payload.dart';
import 'package:api_client/src/model/support_chat_message.dart';
import 'package:api_client/src/model/support_chat_message_list_query.dart';
import 'package:api_client/src/model/support_ticket.dart';
import 'package:api_client/src/model/support_ticket_assigned_to.dart';
import 'package:api_client/src/model/support_ticket_list_query.dart';
import 'package:api_client/src/model/support_ticket_user.dart';
import 'package:api_client/src/model/suspend_driver.dart';
import 'package:api_client/src/model/time.dart';
import 'package:api_client/src/model/time_rules.dart';
import 'package:api_client/src/model/top_up_request.dart';
import 'package:api_client/src/model/transaction.dart';
import 'package:api_client/src/model/transaction_get200_response.dart';
import 'package:api_client/src/model/transfer_request.dart';
import 'package:api_client/src/model/transfer_response.dart';
import 'package:api_client/src/model/unban_user.dart';
import 'package:api_client/src/model/update_account_deletion.dart';
import 'package:api_client/src/model/update_broadcast.dart';
import 'package:api_client/src/model/update_configuration.dart';
import 'package:api_client/src/model/update_contact.dart';
import 'package:api_client/src/model/update_coupon.dart';
import 'package:api_client/src/model/update_driver_quiz_question.dart';
import 'package:api_client/src/model/update_emergency.dart';
import 'package:api_client/src/model/update_fraud_event.dart';
import 'package:api_client/src/model/update_leaderboard.dart';
import 'package:api_client/src/model/update_newsletter.dart';
import 'package:api_client/src/model/update_order.dart';
import 'package:api_client/src/model/update_payment.dart';
import 'package:api_client/src/model/update_quick_message_template.dart';
import 'package:api_client/src/model/update_report.dart';
import 'package:api_client/src/model/update_review.dart';
import 'package:api_client/src/model/update_scheduled_order.dart';
import 'package:api_client/src/model/update_support_ticket.dart';
import 'package:api_client/src/model/update_transaction.dart';
import 'package:api_client/src/model/update_user_password.dart';
import 'package:api_client/src/model/update_user_role.dart';
import 'package:api_client/src/model/update_wallet.dart';
import 'package:api_client/src/model/user.dart';
import 'package:api_client/src/model/user_admin_create200_response.dart';
import 'package:api_client/src/model/user_admin_dashboard_stats200_response.dart';
import 'package:api_client/src/model/user_admin_list200_response.dart';
import 'package:api_client/src/model/user_admin_list_filters_parameter.dart';
import 'package:api_client/src/model/user_badge.dart';
import 'package:api_client/src/model/user_badge_metadata.dart';
import 'package:api_client/src/model/user_fraud_profile.dart';
import 'package:api_client/src/model/user_fraud_profile_user.dart';
import 'package:api_client/src/model/user_lookup_by_phone200_response.dart';
import 'package:api_client/src/model/user_lookup_query.dart';
import 'package:api_client/src/model/user_lookup_result.dart';
import 'package:api_client/src/model/user_lookup_result_phone.dart';
import 'package:api_client/src/model/user_me_change_password_request.dart';
import 'package:api_client/src/model/user_rules.dart';
import 'package:api_client/src/model/va_number.dart';
import 'package:api_client/src/model/verify_email.dart';
import 'package:api_client/src/model/wallet.dart';
import 'package:api_client/src/model/wallet_get_commission_report200_response.dart';
import 'package:api_client/src/model/wallet_monthly_summary_query.dart';
import 'package:api_client/src/model/wallet_monthly_summary_response.dart';
import 'package:api_client/src/model/withdraw_request.dart';
import 'package:api_client/src/model/withdraw_response.dart';

final _regList = RegExp(r'^List<(.*)>$');
final _regSet = RegExp(r'^Set<(.*)>$');
final _regMap = RegExp(r'^Map<String,(.*)>$');

  ReturnType deserialize<ReturnType, BaseType>(dynamic value, String targetType, {bool growable= true}) {
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
        case 'AccountDeletion':
          return AccountDeletion.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'AccountDeletionDelete200Response':
          return AccountDeletionDelete200Response.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'AccountDeletionDelete200ResponseData':
          return AccountDeletionDelete200ResponseData.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'AccountDeletionKey':
          
          
        case 'AccountDeletionList200Response':
          return AccountDeletionList200Response.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'AccountDeletionList200ResponseData':
          return AccountDeletionList200ResponseData.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'AccountDeletionList200ResponseDataPagination':
          return AccountDeletionList200ResponseDataPagination.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'AccountDeletionReason':
          
          
        case 'AccountDeletionReviewRequest':
          return AccountDeletionReviewRequest.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'AccountDeletionStatus':
          
          
        case 'AccountDeletionSubmit201Response':
          return AccountDeletionSubmit201Response.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'AccountType':
          
          
        case 'ActivateDriver':
          return ActivateDriver.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'AddToCart':
          return AddToCart.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'AdminUpdateUser':
          return AdminUpdateUser.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'ApproveDriver':
          return ApproveDriver.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'AuditList200Response':
          return AuditList200Response.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'AuditList200ResponseDataInner':
          return AuditList200ResponseDataInner.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'AuthExchangeToken200Response':
          return AuthExchangeToken200Response.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'AuthForgotPasswordRequest':
          return AuthForgotPasswordRequest.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'AuthGetSession200Response':
          return AuthGetSession200Response.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'AuthHasAccessRequest':
          return AuthHasAccessRequest.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'AuthSignIn200Response':
          return AuthSignIn200Response.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'AuthSignOut200Response':
          return AuthSignOut200Response.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'AuthSignUpUser201Response':
          return AuthSignUpUser201Response.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'AuthVerifyEmail200Response':
          return AuthVerifyEmail200Response.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'AuthVerifyEmail200ResponseData':
          return AuthVerifyEmail200ResponseData.fromJson(value as Map<String, dynamic>) as ReturnType;
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
          
          
        case 'BankValidateAccount200Response':
          return BankValidateAccount200Response.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'BankValidationRequest':
          return BankValidationRequest.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'BankValidationResponse':
          return BankValidationResponse.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'BannerConfiguration':
          return BannerConfiguration.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'BannerCreate201Response':
          return BannerCreate201Response.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'BannerCreate201ResponseData':
          return BannerCreate201ResponseData.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'BannerCreateRequest':
          return BannerCreateRequest.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'BannerDelete200Response':
          return BannerDelete200Response.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'BannerDelete200ResponseData':
          return BannerDelete200ResponseData.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'BannerList200Response':
          return BannerList200Response.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'BannerList200ResponseDataInner':
          return BannerList200ResponseDataInner.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'BannerListPublic200Response':
          return BannerListPublic200Response.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'BannerListPublic200ResponseDataInner':
          return BannerListPublic200ResponseDataInner.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'BannerUpdateRequest':
          return BannerUpdateRequest.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'Broadcast':
          return Broadcast.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'BroadcastCreate201Response':
          return BroadcastCreate201Response.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'BroadcastCreate201ResponseData':
          return BroadcastCreate201ResponseData.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'BroadcastCreateRequest':
          return BroadcastCreateRequest.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'BroadcastKey':
          
          
        case 'BroadcastList200Response':
          return BroadcastList200Response.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'BroadcastList200ResponseDataInner':
          return BroadcastList200ResponseDataInner.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'BroadcastStats200Response':
          return BroadcastStats200Response.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'BroadcastStats200ResponseData':
          return BroadcastStats200ResponseData.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'BroadcastStatus':
          
          
        case 'BroadcastType':
          
          
        case 'BroadcastUpdateRequest':
          return BroadcastUpdateRequest.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'BusinessConfiguration':
          return BusinessConfiguration.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'Cart':
          return Cart.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'CartItem':
          return CartItem.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'ChartDataPoint':
          return ChartDataPoint.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'ChatGetUnreadCount200Response':
          return ChatGetUnreadCount200Response.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'ChatList200Response':
          return ChatList200Response.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'ChatList200ResponseData':
          return ChatList200ResponseData.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'ChatMarkAsRead200Response':
          return ChatMarkAsRead200Response.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'ChatSend200Response':
          return ChatSend200Response.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'ChatSenderRole':
          
          
        case 'ChatUnreadCount':
          return ChatUnreadCount.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'CommissionReportPeriod':
          
          
        case 'CommissionReportQuery':
          return CommissionReportQuery.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'CommissionReportResponse':
          return CommissionReportResponse.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'CommissionTransaction':
          return CommissionTransaction.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'CompleteDriverQuiz':
          return CompleteDriverQuiz.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'Configuration':
          return Configuration.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'ConfigurationGet200Response':
          return ConfigurationGet200Response.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'ConfigurationGetBusinessConfig200Response':
          return ConfigurationGetBusinessConfig200Response.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'ConfigurationKey':
          
          
        case 'ConfigurationList200Response':
          return ConfigurationList200Response.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'Contact':
          return Contact.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'ContactDelete200Response':
          return ContactDelete200Response.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'ContactKey':
          
          
        case 'ContactList200Response':
          return ContactList200Response.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'ContactList200ResponseData':
          return ContactList200ResponseData.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'ContactRespondRequest':
          return ContactRespondRequest.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'ContactStatus':
          
          
        case 'ContactSubmit201Response':
          return ContactSubmit201Response.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'Coordinate':
          return Coordinate.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'CoordinateWithMeta':
          return CoordinateWithMeta.fromJson(value as Map<String, dynamic>) as ReturnType;
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
        case 'CouponType':
          
          
        case 'CouponValidate200Response':
          return CouponValidate200Response.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'CouponValidate200ResponseData':
          return CouponValidate200ResponseData.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'CouponValidateRequest':
          return CouponValidateRequest.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'Currency':
          
          
        case 'DashboardStats':
          return DashboardStats.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'DashboardStatsHighCancellationDriversInner':
          return DashboardStatsHighCancellationDriversInner.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'DashboardStatsOrdersByDayInner':
          return DashboardStatsOrdersByDayInner.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'DashboardStatsOrdersByTypeInner':
          return DashboardStatsOrdersByTypeInner.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'DashboardStatsQuery':
          return DashboardStatsQuery.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'DashboardStatsTopDriversInner':
          return DashboardStatsTopDriversInner.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'DashboardStatsTopMerchantsInner':
          return DashboardStatsTopMerchantsInner.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'DayOfWeek':
          
          
        case 'DeliveryItemType':
          
          
        case 'DeliveryPricingConfiguration':
          return DeliveryPricingConfiguration.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'DismissReport':
          return DismissReport.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'Driver':
          return Driver.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'DriverGetAnalytics200Response':
          return DriverGetAnalytics200Response.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'DriverGetAnalytics200ResponseData':
          return DriverGetAnalytics200ResponseData.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'DriverGetAnalytics200ResponseDataEarningsByDayInner':
          return DriverGetAnalytics200ResponseDataEarningsByDayInner.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'DriverGetAnalytics200ResponseDataEarningsByTypeInner':
          return DriverGetAnalytics200ResponseDataEarningsByTypeInner.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'DriverGetAnalytics200ResponseDataTopEarningDaysInner':
          return DriverGetAnalytics200ResponseDataTopEarningDaysInner.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'DriverGetMine200Response':
          return DriverGetMine200Response.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'DriverGetMine200ResponseBody':
          return DriverGetMine200ResponseBody.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'DriverGetReview200Response':
          return DriverGetReview200Response.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'DriverGetReview200ResponseData':
          return DriverGetReview200ResponseData.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'DriverKey':
          
          
        case 'DriverList200Response':
          return DriverList200Response.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'DriverMinQuizQuestion':
          return DriverMinQuizQuestion.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'DriverQuizAnswer':
          return DriverQuizAnswer.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'DriverQuizAnswerCompleteQuiz200Response':
          return DriverQuizAnswerCompleteQuiz200Response.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'DriverQuizAnswerGetAttempt200Response':
          return DriverQuizAnswerGetAttempt200Response.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'DriverQuizAnswerList200Response':
          return DriverQuizAnswerList200Response.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'DriverQuizAnswerList200ResponseData':
          return DriverQuizAnswerList200ResponseData.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'DriverQuizAnswerStartQuiz201Response':
          return DriverQuizAnswerStartQuiz201Response.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'DriverQuizAnswerStatus':
          
          
        case 'DriverQuizAnswerSubmitAnswer200Response':
          return DriverQuizAnswerSubmitAnswer200Response.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'DriverQuizAttempt':
          return DriverQuizAttempt.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'DriverQuizQuestion':
          return DriverQuizQuestion.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'DriverQuizQuestionAnswer':
          return DriverQuizQuestionAnswer.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'DriverQuizQuestionCategory':
          
          
        case 'DriverQuizQuestionCreate201Response':
          return DriverQuizQuestionCreate201Response.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'DriverQuizQuestionGetQuizQuestions200Response':
          return DriverQuizQuestionGetQuizQuestions200Response.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'DriverQuizQuestionGetQuizQuestions200ResponseDataInner':
          return DriverQuizQuestionGetQuizQuestions200ResponseDataInner.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'DriverQuizQuestionGetQuizQuestions200ResponseDataInnerOptionsInner':
          return DriverQuizQuestionGetQuizQuestions200ResponseDataInnerOptionsInner.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'DriverQuizQuestionList200Response':
          return DriverQuizQuestionList200Response.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'DriverQuizQuestionList200ResponseData':
          return DriverQuizQuestionList200ResponseData.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'DriverQuizQuestionOption':
          return DriverQuizQuestionOption.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'DriverQuizQuestionType':
          
          
        case 'DriverQuizResult':
          return DriverQuizResult.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'DriverQuizStatus':
          
          
        case 'DriverRejectRequest':
          return DriverRejectRequest.fromJson(value as Map<String, dynamic>) as ReturnType;
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
          
          
        case 'DriverSubmitApprovalRequest':
          return DriverSubmitApprovalRequest.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'DriverSubmitRejectionRequest':
          return DriverSubmitRejectionRequest.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'DriverSuspendRequest':
          return DriverSuspendRequest.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'DriverUpdateDocumentStatusRequest':
          return DriverUpdateDocumentStatusRequest.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'DriverUpdateOnlineStatusRequest':
          return DriverUpdateOnlineStatusRequest.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'DriverUpdateTakingOrderStatusRequest':
          return DriverUpdateTakingOrderStatusRequest.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'DriverUser':
          return DriverUser.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'DriverVerifyQuizRequest':
          return DriverVerifyQuizRequest.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'DriverWalletGetMonthlySummary200Response':
          return DriverWalletGetMonthlySummary200Response.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'DriverWalletGetSavedBankAccount200Response':
          return DriverWalletGetSavedBankAccount200Response.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'DriverWalletGetTransactions200Response':
          return DriverWalletGetTransactions200Response.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'DriverWalletGetWallet200Response':
          return DriverWalletGetWallet200Response.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'DriverWalletTopUp200Response':
          return DriverWalletTopUp200Response.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'DriverWalletTransfer200Response':
          return DriverWalletTransfer200Response.fromJson(value as Map<String, dynamic>) as ReturnType;
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
        case 'FoodPricingConfiguration':
          return FoodPricingConfiguration.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'FraudConfig':
          return FraudConfig.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'FraudEvent':
          return FraudEvent.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'FraudEventDriver':
          return FraudEventDriver.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'FraudEventHandledBy':
          return FraudEventHandledBy.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'FraudEventListQuery':
          return FraudEventListQuery.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'FraudEventType':
          
          
        case 'FraudEventUser':
          return FraudEventUser.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'FraudGetEvent200Response':
          return FraudGetEvent200Response.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'FraudGetStats200Response':
          return FraudGetStats200Response.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'FraudGetUserProfile200Response':
          return FraudGetUserProfile200Response.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'FraudListEvents200Response':
          return FraudListEvents200Response.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'FraudListHighRiskUsers200Response':
          return FraudListHighRiskUsers200Response.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'FraudSeverity':
          
          
        case 'FraudSignal':
          return FraudSignal.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'FraudStats':
          return FraudStats.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'FraudStatsEventsBySeverity':
          return FraudStatsEventsBySeverity.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'FraudStatsQuery':
          return FraudStatsQuery.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'FraudStatsRecentTrendInner':
          return FraudStatsRecentTrendInner.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'FraudStatus':
          
          
        case 'GeneralRuleType':
          
          
        case 'GeneralRules':
          return GeneralRules.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'GetSessionResponse':
          return GetSessionResponse.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'InsertAccountDeletion':
          return InsertAccountDeletion.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'InsertBroadcast':
          return InsertBroadcast.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'InsertConfiguration':
          return InsertConfiguration.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'InsertContact':
          return InsertContact.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'InsertCoupon':
          return InsertCoupon.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'InsertDriverQuizQuestion':
          return InsertDriverQuizQuestion.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'InsertEmergency':
          return InsertEmergency.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'InsertFraudEvent':
          return InsertFraudEvent.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'InsertLeaderboard':
          return InsertLeaderboard.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'InsertNewsletter':
          return InsertNewsletter.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'InsertOrderChatMessage':
          return InsertOrderChatMessage.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'InsertPayment':
          return InsertPayment.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'InsertQuickMessageTemplate':
          return InsertQuickMessageTemplate.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'InsertReport':
          return InsertReport.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'InsertReview':
          return InsertReview.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'InsertSupportChatMessage':
          return InsertSupportChatMessage.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'InsertSupportTicket':
          return InsertSupportTicket.fromJson(value as Map<String, dynamic>) as ReturnType;
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
        case 'ListDriverQuizAnswerQuery':
          return ListDriverQuizAnswerQuery.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'ListDriverQuizQuestionQuery':
          return ListDriverQuizQuestionQuery.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'ListQuickMessageQuery':
          return ListQuickMessageQuery.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'Location':
          return Location.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'MarkChatAsRead':
          return MarkChatAsRead.fromJson(value as Map<String, dynamic>) as ReturnType;
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
          
          
        case 'MerchantDeactivateRequest':
          return MerchantDeactivateRequest.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'MerchantEnvelope':
          return MerchantEnvelope.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'MerchantEnvelopeAction':
          
          
        case 'MerchantEnvelopeEvent':
          
          
        case 'MerchantEnvelopePayload':
          return MerchantEnvelopePayload.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'MerchantEnvelopePayloadSyncRequest':
          return MerchantEnvelopePayloadSyncRequest.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'MerchantGetAvailabilityStatus200Response':
          return MerchantGetAvailabilityStatus200Response.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'MerchantGetAvailabilityStatus200ResponseData':
          return MerchantGetAvailabilityStatus200ResponseData.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'MerchantGetMine200Response':
          return MerchantGetMine200Response.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'MerchantGetMine200ResponseBody':
          return MerchantGetMine200ResponseBody.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'MerchantGetReview200Response':
          return MerchantGetReview200Response.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'MerchantGetReview200ResponseData':
          return MerchantGetReview200ResponseData.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'MerchantKey':
          
          
        case 'MerchantMenu':
          return MerchantMenu.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'MerchantMenuCreate200Response':
          return MerchantMenuCreate200Response.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'MerchantMenuKey':
          
          
        case 'MerchantMenuList200Response':
          return MerchantMenuList200Response.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'MerchantOperatingHours':
          return MerchantOperatingHours.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'MerchantOperatingHoursBulkUpsertRequest':
          return MerchantOperatingHoursBulkUpsertRequest.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'MerchantOperatingHoursCreate200Response':
          return MerchantOperatingHoursCreate200Response.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'MerchantOperatingHoursCreateRequest':
          return MerchantOperatingHoursCreateRequest.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'MerchantOperatingHoursKey':
          
          
        case 'MerchantOperatingHoursList200Response':
          return MerchantOperatingHoursList200Response.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'MerchantOperatingHoursUpdateRequest':
          return MerchantOperatingHoursUpdateRequest.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'MerchantOrderAccept200Response':
          return MerchantOrderAccept200Response.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'MerchantPopulars200Response':
          return MerchantPopulars200Response.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'MerchantSetOperatingStatusRequest':
          return MerchantSetOperatingStatusRequest.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'MerchantStatus':
          
          
        case 'MerchantUpdateDocumentStatusRequest':
          return MerchantUpdateDocumentStatusRequest.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'Newsletter':
          return Newsletter.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'NewsletterKey':
          
          
        case 'NewsletterStatus':
          
          
        case 'NotificationGetUnreadCount200Response':
          return NotificationGetUnreadCount200Response.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'NotificationGetUnreadCount200ResponseData':
          return NotificationGetUnreadCount200ResponseData.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'NotificationList200Response':
          return NotificationList200Response.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'NotificationList200ResponseDataInner':
          return NotificationList200ResponseDataInner.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'NotificationMarkAsRead200Response':
          return NotificationMarkAsRead200Response.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'NotificationMarkAsRead200ResponseData':
          return NotificationMarkAsRead200ResponseData.fromJson(value as Map<String, dynamic>) as ReturnType;
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
        case 'OrderChatReadStatus':
          return OrderChatReadStatus.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'OrderDriver':
          return OrderDriver.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'OrderEnvelope':
          return OrderEnvelope.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'OrderEnvelopeAction':
          
          
        case 'OrderEnvelopeEvent':
          
          
        case 'OrderEnvelopePayload':
          return OrderEnvelopePayload.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'OrderEnvelopePayloadChatUnreadCount':
          return OrderEnvelopePayloadChatUnreadCount.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'OrderEnvelopePayloadDetail':
          return OrderEnvelopePayloadDetail.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'OrderEnvelopePayloadDone':
          return OrderEnvelopePayloadDone.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'OrderEnvelopePayloadDriverUpdateLocation':
          return OrderEnvelopePayloadDriverUpdateLocation.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'OrderEnvelopePayloadMerchantAction':
          return OrderEnvelopePayloadMerchantAction.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'OrderEnvelopePayloadMessage':
          return OrderEnvelopePayloadMessage.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'OrderEnvelopePayloadNoShow':
          return OrderEnvelopePayloadNoShow.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'OrderEnvelopePayloadRetryInfo':
          return OrderEnvelopePayloadRetryInfo.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'OrderEnvelopePayloadSyncRequest':
          return OrderEnvelopePayloadSyncRequest.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'OrderEstimate200Response':
          return OrderEstimate200Response.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'OrderGetActive200Response':
          return OrderGetActive200Response.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'OrderGetActive200ResponseData':
          return OrderGetActive200ResponseData.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'OrderGetStatusHistory200Response':
          return OrderGetStatusHistory200Response.fromJson(value as Map<String, dynamic>) as ReturnType;
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
        case 'OrderPlaceScheduledOrder200Response':
          return OrderPlaceScheduledOrder200Response.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'OrderSendMessageRequest':
          return OrderSendMessageRequest.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'OrderStatus':
          
          
        case 'OrderStatusHistory':
          return OrderStatusHistory.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'OrderStatusHistoryRole':
          
          
        case 'OrderSummary':
          return OrderSummary.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'OrderSummaryBreakdown':
          return OrderSummaryBreakdown.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'OrderType':
          
          
        case 'OrderUploadDeliveryProof200Response':
          return OrderUploadDeliveryProof200Response.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'OrderUploadDeliveryProof200ResponseData':
          return OrderUploadDeliveryProof200ResponseData.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'OrderUploadDeliveryProofRequest':
          return OrderUploadDeliveryProofRequest.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'OrderVerifyDeliveryOTP200Response':
          return OrderVerifyDeliveryOTP200Response.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'OrderVerifyDeliveryOTP200ResponseData':
          return OrderVerifyDeliveryOTP200ResponseData.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'OrderVerifyDeliveryOTPRequest':
          return OrderVerifyDeliveryOTPRequest.fromJson(value as Map<String, dynamic>) as ReturnType;
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
        case 'PaymentEnvelopeAction':
          
          
        case 'PaymentEnvelopeEvent':
          
          
        case 'PaymentEnvelopePayload':
          return PaymentEnvelopePayload.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'PaymentEnvelopePayloadSyncRequest':
          return PaymentEnvelopePayloadSyncRequest.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'PaymentKey':
          
          
        case 'PaymentMethod':
          
          
        case 'PaymentProvider':
          
          
        case 'PayoutStatus':
          
          
        case 'Phone':
          return Phone.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'PlaceOrder':
          return PlaceOrder.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'PlaceOrderPayment':
          return PlaceOrderPayment.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'PlaceOrderResponse':
          return PlaceOrderResponse.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'PlaceOrderResponseAutoAppliedCoupon':
          return PlaceOrderResponseAutoAppliedCoupon.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'PlaceScheduledOrder':
          return PlaceScheduledOrder.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'PlaceScheduledOrderResponse':
          return PlaceScheduledOrderResponse.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'PricingConfiguration':
          return PricingConfiguration.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'QuickMessageCreate200Response':
          return QuickMessageCreate200Response.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'QuickMessageList200Response':
          return QuickMessageList200Response.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'QuickMessageList200ResponseData':
          return QuickMessageList200ResponseData.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'QuickMessageTemplate':
          return QuickMessageTemplate.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'RejectDriver':
          return RejectDriver.fromJson(value as Map<String, dynamic>) as ReturnType;
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
        case 'ResolveReport':
          return ResolveReport.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'Review':
          return Review.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'ReviewCategory':
          
          
        case 'ReviewCheckCanReview200Response':
          return ReviewCheckCanReview200Response.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'ReviewCheckCanReview200ResponseData':
          return ReviewCheckCanReview200ResponseData.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'ReviewCreate200Response':
          return ReviewCreate200Response.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'ReviewFraudEvent':
          return ReviewFraudEvent.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'ReviewKeySchema':
          
          
        case 'ReviewList200Response':
          return ReviewList200Response.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'RidePricingConfiguration':
          return RidePricingConfiguration.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'RoleAccess':
          
          
        case 'SavedBankAccount':
          return SavedBankAccount.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'SendEmailVerification':
          return SendEmailVerification.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'Session':
          return Session.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'SignInRequest':
          return SignInRequest.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'SignInResponse':
          return SignInResponse.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'SignUpResponse':
          return SignUpResponse.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'StartDriverQuiz':
          return StartDriverQuiz.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'StartInvestigation':
          return StartInvestigation.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'SubmitDriverQuizAnswer':
          return SubmitDriverQuizAnswer.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'SubmitDriverQuizAnswerResponse':
          return SubmitDriverQuizAnswerResponse.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'SupportChatEnvelope':
          return SupportChatEnvelope.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'SupportChatEnvelopeAction':
          
          
        case 'SupportChatEnvelopeEvent':
          
          
        case 'SupportChatEnvelopePayload':
          return SupportChatEnvelopePayload.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'SupportChatMessage':
          return SupportChatMessage.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'SupportChatMessageListQuery':
          return SupportChatMessageListQuery.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'SupportTicket':
          return SupportTicket.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'SupportTicketAssignedTo':
          return SupportTicketAssignedTo.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'SupportTicketCategory':
          
          
        case 'SupportTicketKey':
          
          
        case 'SupportTicketListQuery':
          return SupportTicketListQuery.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'SupportTicketPriority':
          
          
        case 'SupportTicketStatus':
          
          
        case 'SupportTicketUser':
          return SupportTicketUser.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'SuspendDriver':
          return SuspendDriver.fromJson(value as Map<String, dynamic>) as ReturnType;
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
          
          
        case 'TransactionStatus':
          
          
        case 'TransactionType':
          
          
        case 'TransferRequest':
          return TransferRequest.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'TransferResponse':
          return TransferResponse.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'UnbanUser':
          return UnbanUser.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'UpdateAccountDeletion':
          return UpdateAccountDeletion.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'UpdateBroadcast':
          return UpdateBroadcast.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'UpdateConfiguration':
          return UpdateConfiguration.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'UpdateContact':
          return UpdateContact.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'UpdateCoupon':
          return UpdateCoupon.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'UpdateDriverQuizQuestion':
          return UpdateDriverQuizQuestion.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'UpdateEmergency':
          return UpdateEmergency.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'UpdateFraudEvent':
          return UpdateFraudEvent.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'UpdateLeaderboard':
          return UpdateLeaderboard.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'UpdateNewsletter':
          return UpdateNewsletter.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'UpdateOrder':
          return UpdateOrder.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'UpdatePayment':
          return UpdatePayment.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'UpdateQuickMessageTemplate':
          return UpdateQuickMessageTemplate.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'UpdateReport':
          return UpdateReport.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'UpdateReview':
          return UpdateReview.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'UpdateScheduledOrder':
          return UpdateScheduledOrder.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'UpdateSupportTicket':
          return UpdateSupportTicket.fromJson(value as Map<String, dynamic>) as ReturnType;
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
        case 'UserAdminListFiltersParameter':
          return UserAdminListFiltersParameter.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'UserBadge':
          return UserBadge.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'UserBadgeMetadata':
          return UserBadgeMetadata.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'UserFraudProfile':
          return UserFraudProfile.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'UserFraudProfileUser':
          return UserFraudProfileUser.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'UserGender':
          
          
        case 'UserKey':
          
          
        case 'UserLookupByPhone200Response':
          return UserLookupByPhone200Response.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'UserLookupQuery':
          return UserLookupQuery.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'UserLookupResult':
          return UserLookupResult.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'UserLookupResultPhone':
          return UserLookupResultPhone.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'UserMeChangePasswordRequest':
          return UserMeChangePasswordRequest.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'UserRole':
          
          
        case 'UserRules':
          return UserRules.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'VANumber':
          return VANumber.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'VerifyEmail':
          return VerifyEmail.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'Wallet':
          return Wallet.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'WalletGetCommissionReport200Response':
          return WalletGetCommissionReport200Response.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'WalletKey':
          
          
        case 'WalletMonthlySummaryQuery':
          return WalletMonthlySummaryQuery.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'WalletMonthlySummaryResponse':
          return WalletMonthlySummaryResponse.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'WeightSize':
          
          
        case 'WithdrawRequest':
          return WithdrawRequest.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'WithdrawResponse':
          return WithdrawResponse.fromJson(value as Map<String, dynamic>) as ReturnType;
        default:
          RegExpMatch? match;

          if (value is List && (match = _regList.firstMatch(targetType)) != null) {
            targetType = match![1]!; // ignore: parameter_assignments
            return value
              .map<BaseType>((dynamic v) => deserialize<BaseType, BaseType>(v, targetType, growable: growable))
              .toList(growable: growable) as ReturnType;
          }
          if (value is Set && (match = _regSet.firstMatch(targetType)) != null) {
            targetType = match![1]!; // ignore: parameter_assignments
            return value
              .map<BaseType>((dynamic v) => deserialize<BaseType, BaseType>(v, targetType, growable: growable))
              .toSet() as ReturnType;
          }
          if (value is Map && (match = _regMap.firstMatch(targetType)) != null) {
            targetType = match![1]!.trim(); // ignore: parameter_assignments
            return Map<String, BaseType>.fromIterables(
              value.keys as Iterable<String>,
              value.values.map((dynamic v) => deserialize<BaseType, BaseType>(v, targetType, growable: growable)),
            ) as ReturnType;
          }
          break;
    }
    throw Exception('Cannot deserialize');
  }