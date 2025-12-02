// dart format off
// coverage:ignore-file
import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_id.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'gen/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('id')
  ];

  /// No description provided for @popular_merchants.
  ///
  /// In en, this message translates to:
  /// **'Popular merchants'**
  String get popular_merchants;

  /// No description provided for @choose_the_service_that_you_want.
  ///
  /// In en, this message translates to:
  /// **'Choose the service that you want'**
  String get choose_the_service_that_you_want;

  /// No description provided for @pending_approval.
  ///
  /// In en, this message translates to:
  /// **'Pending Approval'**
  String get pending_approval;

  /// No description provided for @approved.
  ///
  /// In en, this message translates to:
  /// **'Approved'**
  String get approved;

  /// No description provided for @rejected.
  ///
  /// In en, this message translates to:
  /// **'Rejected'**
  String get rejected;

  /// No description provided for @suspended.
  ///
  /// In en, this message translates to:
  /// **'Suspended'**
  String get suspended;

  /// No description provided for @app_version_information.
  ///
  /// In en, this message translates to:
  /// **'App information and version'**
  String get app_version_information;

  /// No description provided for @about.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get about;

  /// No description provided for @manage_notification_preferences.
  ///
  /// In en, this message translates to:
  /// **'Manage notification preferences'**
  String get manage_notification_preferences;

  /// No description provided for @notifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notifications;

  /// No description provided for @driver_preferences_and_settings.
  ///
  /// In en, this message translates to:
  /// **'Driver preferences and settings'**
  String get driver_preferences_and_settings;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @profile_updated_successfully.
  ///
  /// In en, this message translates to:
  /// **'Profile updated successfully'**
  String get profile_updated_successfully;

  /// No description provided for @license_plate_cannot_be_empty.
  ///
  /// In en, this message translates to:
  /// **'License plate cannot be empty'**
  String get license_plate_cannot_be_empty;

  /// No description provided for @enter_license_plate.
  ///
  /// In en, this message translates to:
  /// **'Enter license plate'**
  String get enter_license_plate;

  /// No description provided for @update_your_license_plate.
  ///
  /// In en, this message translates to:
  /// **'Update your license plate information'**
  String get update_your_license_plate;

  /// No description provided for @logged_out_successfully.
  ///
  /// In en, this message translates to:
  /// **'Logged out successfully'**
  String get logged_out_successfully;

  /// No description provided for @are_you_sure_you_want_to_logout.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to logout?'**
  String get are_you_sure_you_want_to_logout;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @bank_account.
  ///
  /// In en, this message translates to:
  /// **'Bank Account'**
  String get bank_account;

  /// No description provided for @uploaded.
  ///
  /// In en, this message translates to:
  /// **'Uploaded'**
  String get uploaded;

  /// No description provided for @missing.
  ///
  /// In en, this message translates to:
  /// **'Missing'**
  String get missing;

  /// No description provided for @student_card.
  ///
  /// In en, this message translates to:
  /// **'Student Card (KTM)'**
  String get student_card;

  /// No description provided for @driver_license.
  ///
  /// In en, this message translates to:
  /// **'Driver License (SIM)'**
  String get driver_license;

  /// No description provided for @vehicle_certificate.
  ///
  /// In en, this message translates to:
  /// **'Vehicle Certificate (STNK)'**
  String get vehicle_certificate;

  /// No description provided for @taking_orders.
  ///
  /// In en, this message translates to:
  /// **'Taking Orders'**
  String get taking_orders;

  /// No description provided for @not_taking_orders.
  ///
  /// In en, this message translates to:
  /// **'Not Taking Orders'**
  String get not_taking_orders;

  /// No description provided for @license_plate.
  ///
  /// In en, this message translates to:
  /// **'License Plate'**
  String get license_plate;

  /// No description provided for @failed_to_load_profile.
  ///
  /// In en, this message translates to:
  /// **'Failed to load profile'**
  String get failed_to_load_profile;

  /// No description provided for @retry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// No description provided for @close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// No description provided for @chat_with_customer.
  ///
  /// In en, this message translates to:
  /// **'Chat with Customer'**
  String get chat_with_customer;

  /// No description provided for @tap_the_phone_number_to_copy_it_then_use_your_phone_app_to_call.
  ///
  /// In en, this message translates to:
  /// **'Ketuk nomor telepon untuk menyalinnya, lalu gunakan aplikasi telepon Anda untuk menelepon.'**
  String get tap_the_phone_number_to_copy_it_then_use_your_phone_app_to_call;

  /// No description provided for @customer_phone_number.
  ///
  /// In en, this message translates to:
  /// **'Customer Phone Number'**
  String get customer_phone_number;

  /// No description provided for @mark_as_arrived.
  ///
  /// In en, this message translates to:
  /// **'Mark as Arrived'**
  String get mark_as_arrived;

  /// No description provided for @no.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get no;

  /// No description provided for @yes_cancel.
  ///
  /// In en, this message translates to:
  /// **'Yes, Cancel'**
  String get yes_cancel;

  /// No description provided for @are_you_sure_you_want_to_cancel_this_order.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to cancel this order? The customer will be notified.'**
  String get are_you_sure_you_want_to_cancel_this_order;

  /// No description provided for @cancel_order.
  ///
  /// In en, this message translates to:
  /// **'Cancel Order'**
  String get cancel_order;

  /// No description provided for @start_trip.
  ///
  /// In en, this message translates to:
  /// **'Start Trip'**
  String get start_trip;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @are_you_sure_you_want_to_reject_this_order.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to reject this order? This action cannot be undone.'**
  String get are_you_sure_you_want_to_reject_this_order;

  /// No description provided for @rate_customer.
  ///
  /// In en, this message translates to:
  /// **'Rate Customer'**
  String get rate_customer;

  /// No description provided for @back_to_home.
  ///
  /// In en, this message translates to:
  /// **'Back to Home'**
  String get back_to_home;

  /// No description provided for @complete_trip.
  ///
  /// In en, this message translates to:
  /// **'Complete Trip'**
  String get complete_trip;

  /// No description provided for @reject_order.
  ///
  /// In en, this message translates to:
  /// **'Reject Order'**
  String get reject_order;

  /// No description provided for @accept_order.
  ///
  /// In en, this message translates to:
  /// **'Accept Order'**
  String get accept_order;

  /// No description provided for @customer_phone_number_not_available.
  ///
  /// In en, this message translates to:
  /// **'Customer phone number not available'**
  String get customer_phone_number_not_available;

  /// No description provided for @warning.
  ///
  /// In en, this message translates to:
  /// **'Warning'**
  String get warning;

  /// No description provided for @customer_info.
  ///
  /// In en, this message translates to:
  /// **'Customer Info'**
  String get customer_info;

  /// No description provided for @distance.
  ///
  /// In en, this message translates to:
  /// **'Distance'**
  String get distance;

  /// No description provided for @fare.
  ///
  /// In en, this message translates to:
  /// **'Fare'**
  String get fare;

  /// No description provided for @service.
  ///
  /// In en, this message translates to:
  /// **'Service'**
  String get service;

  /// No description provided for @cancelled_by_user.
  ///
  /// In en, this message translates to:
  /// **'Cancelled by User'**
  String get cancelled_by_user;

  /// No description provided for @cancelled_by_driver.
  ///
  /// In en, this message translates to:
  /// **'Cancelled by Driver'**
  String get cancelled_by_driver;

  /// No description provided for @cancelled_by_merchant.
  ///
  /// In en, this message translates to:
  /// **'Cancelled by Merchant'**
  String get cancelled_by_merchant;

  /// No description provided for @cancelled_by_system.
  ///
  /// In en, this message translates to:
  /// **'Cancelled by System'**
  String get cancelled_by_system;

  /// No description provided for @preparing_order.
  ///
  /// In en, this message translates to:
  /// **'Preparing Order'**
  String get preparing_order;

  /// No description provided for @finding_driver.
  ///
  /// In en, this message translates to:
  /// **'Finding Driver'**
  String get finding_driver;

  /// No description provided for @pickup_location.
  ///
  /// In en, this message translates to:
  /// **'Pickup Location'**
  String get pickup_location;

  /// No description provided for @dropoff_location.
  ///
  /// In en, this message translates to:
  /// **'Dropoff Location'**
  String get dropoff_location;

  /// No description provided for @schedule_added_successfully.
  ///
  /// In en, this message translates to:
  /// **'Schedule added successfully'**
  String get schedule_added_successfully;

  /// No description provided for @schedule_updated_successfully.
  ///
  /// In en, this message translates to:
  /// **'Schedule updated successfully'**
  String get schedule_updated_successfully;

  /// No description provided for @delete_schedule.
  ///
  /// In en, this message translates to:
  /// **'Delete Schedule'**
  String get delete_schedule;

  /// No description provided for @are_you_sure_you_want_to_delete_schedule.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete \"{name}\"? This action cannot be undone.'**
  String are_you_sure_you_want_to_delete_schedule(Object name);

  /// No description provided for @sunday.
  ///
  /// In en, this message translates to:
  /// **'Sunday'**
  String get sunday;

  /// No description provided for @monday.
  ///
  /// In en, this message translates to:
  /// **'Monday'**
  String get monday;

  /// No description provided for @tuesday.
  ///
  /// In en, this message translates to:
  /// **'Tuesday'**
  String get tuesday;

  /// No description provided for @wednesday.
  ///
  /// In en, this message translates to:
  /// **'Wednesday'**
  String get wednesday;

  /// No description provided for @thursday.
  ///
  /// In en, this message translates to:
  /// **'Thursday'**
  String get thursday;

  /// No description provided for @friday.
  ///
  /// In en, this message translates to:
  /// **'Friday'**
  String get friday;

  /// No description provided for @saturday.
  ///
  /// In en, this message translates to:
  /// **'Saturday'**
  String get saturday;

  /// No description provided for @failed_to_add_schedule.
  ///
  /// In en, this message translates to:
  /// **'Failed to add schedule'**
  String get failed_to_add_schedule;

  /// No description provided for @failed_to_update_schedule.
  ///
  /// In en, this message translates to:
  /// **'Failed to update schedule'**
  String get failed_to_update_schedule;

  /// No description provided for @update.
  ///
  /// In en, this message translates to:
  /// **'Update'**
  String get update;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @add.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get add;

  /// No description provided for @please_enter_a_schedule_name.
  ///
  /// In en, this message translates to:
  /// **'Please enter a schedule name'**
  String get please_enter_a_schedule_name;

  /// No description provided for @disable_orders_during_this_time.
  ///
  /// In en, this message translates to:
  /// **'Disable orders during this time'**
  String get disable_orders_during_this_time;

  /// No description provided for @repeat_every_week.
  ///
  /// In en, this message translates to:
  /// **'Repeat every week'**
  String get repeat_every_week;

  /// No description provided for @start_time.
  ///
  /// In en, this message translates to:
  /// **'Start Time'**
  String get start_time;

  /// No description provided for @end_time.
  ///
  /// In en, this message translates to:
  /// **'End Time'**
  String get end_time;

  /// No description provided for @day_of_week.
  ///
  /// In en, this message translates to:
  /// **'Day of Week'**
  String get day_of_week;

  /// No description provided for @schedule_name.
  ///
  /// In en, this message translates to:
  /// **'Schedule Name'**
  String get schedule_name;

  /// No description provided for @recurring.
  ///
  /// In en, this message translates to:
  /// **'Recurring'**
  String get recurring;

  /// No description provided for @add_your_class_schedule_to_automatically_disable_order_acceptance_during_class_time.
  ///
  /// In en, this message translates to:
  /// **'Add your class schedule to automatically disable order acceptance during class time'**
  String get add_your_class_schedule_to_automatically_disable_order_acceptance_during_class_time;

  /// No description provided for @my_schedule.
  ///
  /// In en, this message translates to:
  /// **'My Schedule (KRS)'**
  String get my_schedule;

  /// No description provided for @no_schedules_found.
  ///
  /// In en, this message translates to:
  /// **'No schedules found'**
  String get no_schedules_found;

  /// No description provided for @no_schedules_yet.
  ///
  /// In en, this message translates to:
  /// **'No schedules yet'**
  String get no_schedules_yet;

  /// No description provided for @schedule_deleted_successfully.
  ///
  /// In en, this message translates to:
  /// **'Schedule deleted successfully'**
  String get schedule_deleted_successfully;

  /// No description provided for @failed_to_delete_schedule.
  ///
  /// In en, this message translates to:
  /// **'Failed to delete schedule'**
  String get failed_to_delete_schedule;

  /// No description provided for @manage_schedule.
  ///
  /// In en, this message translates to:
  /// **'Manage Schedule'**
  String get manage_schedule;

  /// No description provided for @leadeboard_and_badges.
  ///
  /// In en, this message translates to:
  /// **'Leaderboard & Badges'**
  String get leadeboard_and_badges;

  /// No description provided for @trips.
  ///
  /// In en, this message translates to:
  /// **'Trips'**
  String get trips;

  /// No description provided for @ready_to_accept_new_orders.
  ///
  /// In en, this message translates to:
  /// **'Ready to accept new orders'**
  String get ready_to_accept_new_orders;

  /// No description provided for @toggle_on_to_start_receiving_orders.
  ///
  /// In en, this message translates to:
  /// **'Toggle on to start receiving orders'**
  String get toggle_on_to_start_receiving_orders;

  /// No description provided for @requested.
  ///
  /// In en, this message translates to:
  /// **'Requested'**
  String get requested;

  /// No description provided for @matching.
  ///
  /// In en, this message translates to:
  /// **'Matching'**
  String get matching;

  /// No description provided for @preparing.
  ///
  /// In en, this message translates to:
  /// **'Preparing'**
  String get preparing;

  /// No description provided for @ready_for_pickup.
  ///
  /// In en, this message translates to:
  /// **'Ready for Pickup'**
  String get ready_for_pickup;

  /// No description provided for @accepted.
  ///
  /// In en, this message translates to:
  /// **'Accepted'**
  String get accepted;

  /// No description provided for @arriving.
  ///
  /// In en, this message translates to:
  /// **'Arriving'**
  String get arriving;

  /// No description provided for @in_trip.
  ///
  /// In en, this message translates to:
  /// **'In Trip'**
  String get in_trip;

  /// No description provided for @your_completed_and_cancelled_orders_will_appear_here.
  ///
  /// In en, this message translates to:
  /// **'Your completed and cancelled orders will appear here'**
  String get your_completed_and_cancelled_orders_will_appear_here;

  /// No description provided for @no_orders_found.
  ///
  /// In en, this message translates to:
  /// **'No orders found'**
  String get no_orders_found;

  /// No description provided for @all_types.
  ///
  /// In en, this message translates to:
  /// **'All types'**
  String get all_types;

  /// No description provided for @all.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get all;

  /// No description provided for @completed.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get completed;

  /// No description provided for @in_progress.
  ///
  /// In en, this message translates to:
  /// **'In Progress'**
  String get in_progress;

  /// No description provided for @cancelled.
  ///
  /// In en, this message translates to:
  /// **'Cancelled'**
  String get cancelled;

  /// No description provided for @failed_to_load_orders.
  ///
  /// In en, this message translates to:
  /// **'Failed to load orders'**
  String get failed_to_load_orders;

  /// No description provided for @top_up.
  ///
  /// In en, this message translates to:
  /// **'Top Up'**
  String get top_up;

  /// No description provided for @withdrawal.
  ///
  /// In en, this message translates to:
  /// **'Withdrawal'**
  String get withdrawal;

  /// No description provided for @payment.
  ///
  /// In en, this message translates to:
  /// **'Payment'**
  String get payment;

  /// No description provided for @refund.
  ///
  /// In en, this message translates to:
  /// **'Refund'**
  String get refund;

  /// No description provided for @adjustment.
  ///
  /// In en, this message translates to:
  /// **'Adjustment'**
  String get adjustment;

  /// No description provided for @commission.
  ///
  /// In en, this message translates to:
  /// **'Commission'**
  String get commission;

  /// No description provided for @earning.
  ///
  /// In en, this message translates to:
  /// **'Earning'**
  String get earning;

  /// No description provided for @failed_to_withdraw.
  ///
  /// In en, this message translates to:
  /// **'Failed to withdraw '**
  String get failed_to_withdraw;

  /// No description provided for @withdraw.
  ///
  /// In en, this message translates to:
  /// **'Withdraw'**
  String get withdraw;

  /// No description provided for @please_enter_withdrawal_amount.
  ///
  /// In en, this message translates to:
  /// **'Please enter withdrawal amount'**
  String get please_enter_withdrawal_amount;

  /// No description provided for @please_enter_bank_account_number.
  ///
  /// In en, this message translates to:
  /// **'Please enter bank account number'**
  String get please_enter_bank_account_number;

  /// No description provided for @insufficient_balance.
  ///
  /// In en, this message translates to:
  /// **'Insufficient balance'**
  String get insufficient_balance;

  /// No description provided for @hint_account_name.
  ///
  /// In en, this message translates to:
  /// **'Enter the account holder\'s name'**
  String get hint_account_name;

  /// No description provided for @optional.
  ///
  /// In en, this message translates to:
  /// **'Optional'**
  String get optional;

  /// No description provided for @account_name.
  ///
  /// In en, this message translates to:
  /// **'Account Name'**
  String get account_name;

  /// No description provided for @hint_bank_account_number.
  ///
  /// In en, this message translates to:
  /// **'Enter your bank account number'**
  String get hint_bank_account_number;

  /// No description provided for @withdraw_earnings.
  ///
  /// In en, this message translates to:
  /// **'Withdraw Earnings'**
  String get withdraw_earnings;

  /// No description provided for @no_transactions_yet.
  ///
  /// In en, this message translates to:
  /// **'No transactions yet'**
  String get no_transactions_yet;

  /// No description provided for @view_all.
  ///
  /// In en, this message translates to:
  /// **'View All'**
  String get view_all;

  /// No description provided for @recent_transactions.
  ///
  /// In en, this message translates to:
  /// **'Recent Transactions'**
  String get recent_transactions;

  /// No description provided for @net_earnings.
  ///
  /// In en, this message translates to:
  /// **'Net Earnings'**
  String get net_earnings;

  /// No description provided for @total_earnings.
  ///
  /// In en, this message translates to:
  /// **'Total Earnings'**
  String get total_earnings;

  /// No description provided for @total_income.
  ///
  /// In en, this message translates to:
  /// **'Total Income'**
  String get total_income;

  /// No description provided for @total_expenses.
  ///
  /// In en, this message translates to:
  /// **'Total Expenses'**
  String get total_expenses;

  /// No description provided for @active.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get active;

  /// No description provided for @inactive.
  ///
  /// In en, this message translates to:
  /// **'Inactive'**
  String get inactive;

  /// No description provided for @available_balance.
  ///
  /// In en, this message translates to:
  /// **'Available Balance'**
  String get available_balance;

  /// No description provided for @earnings_wallet.
  ///
  /// In en, this message translates to:
  /// **'Earnings & wallet'**
  String get earnings_wallet;

  /// No description provided for @failed_to_load_earnings.
  ///
  /// In en, this message translates to:
  /// **'Failed to load earnings'**
  String get failed_to_load_earnings;

  /// No description provided for @amount.
  ///
  /// In en, this message translates to:
  /// **'Amount'**
  String get amount;

  /// No description provided for @unsupported_role_desc.
  ///
  /// In en, this message translates to:
  /// **'This user role is not supported in the mobile app, please use web app'**
  String get unsupported_role_desc;

  /// No description provided for @invalid_amount.
  ///
  /// In en, this message translates to:
  /// **'Invalid amount'**
  String get invalid_amount;

  /// No description provided for @top_up_success.
  ///
  /// In en, this message translates to:
  /// **'Top up successful'**
  String get top_up_success;

  /// No description provided for @qr_code_expired.
  ///
  /// In en, this message translates to:
  /// **'The QR code has expired'**
  String get qr_code_expired;

  /// No description provided for @hello.
  ///
  /// In en, this message translates to:
  /// **'Hello'**
  String get hello;

  /// No description provided for @payment_expired.
  ///
  /// In en, this message translates to:
  /// **'Payment Expired'**
  String get payment_expired;

  /// No description provided for @total.
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get total;

  /// No description provided for @e_wallet.
  ///
  /// In en, this message translates to:
  /// **'E-wallet'**
  String get e_wallet;

  /// No description provided for @my_balance.
  ///
  /// In en, this message translates to:
  /// **'My Balance'**
  String get my_balance;

  /// No description provided for @success_sign_in.
  ///
  /// In en, this message translates to:
  /// **'Successfully signed in'**
  String get success_sign_in;

  /// No description provided for @light_mode.
  ///
  /// In en, this message translates to:
  /// **'Light Mode'**
  String get light_mode;

  /// No description provided for @dark_mode.
  ///
  /// In en, this message translates to:
  /// **'Dark Mode'**
  String get dark_mode;

  /// No description provided for @system_mode.
  ///
  /// In en, this message translates to:
  /// **'System Mode'**
  String get system_mode;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @forget_password.
  ///
  /// In en, this message translates to:
  /// **'Forget Password?'**
  String get forget_password;

  /// No description provided for @sign_in.
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get sign_in;

  /// No description provided for @loading.
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get loading;

  /// No description provided for @just_a_moment.
  ///
  /// In en, this message translates to:
  /// **'Just a moment...'**
  String get just_a_moment;

  /// No description provided for @didnt_have_account.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account?'**
  String get didnt_have_account;

  /// No description provided for @sign_up.
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get sign_up;

  /// No description provided for @lets_sign_in_to_the_akademove.
  ///
  /// In en, this message translates to:
  /// **'Let\'s Sign In to the AkadeMove!'**
  String get lets_sign_in_to_the_akademove;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @theme.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get theme;

  /// No description provided for @app_settings.
  ///
  /// In en, this message translates to:
  /// **'App Settings'**
  String get app_settings;

  /// No description provided for @account_settings.
  ///
  /// In en, this message translates to:
  /// **'Account Settings'**
  String get account_settings;

  /// No description provided for @privacy_policy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacy_policy;

  /// No description provided for @change_password.
  ///
  /// In en, this message translates to:
  /// **'Change Password'**
  String get change_password;

  /// No description provided for @edit_profile.
  ///
  /// In en, this message translates to:
  /// **'Edit Profile'**
  String get edit_profile;

  /// No description provided for @sign_out.
  ///
  /// In en, this message translates to:
  /// **'Sign Out'**
  String get sign_out;

  /// No description provided for @select_your_preferred_language.
  ///
  /// In en, this message translates to:
  /// **'Select your preferred language'**
  String get select_your_preferred_language;

  /// No description provided for @select_your_preferred_theme.
  ///
  /// In en, this message translates to:
  /// **'Select your preferred theme'**
  String get select_your_preferred_theme;

  /// No description provided for @history.
  ///
  /// In en, this message translates to:
  /// **'History'**
  String get history;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @an_error_occurred.
  ///
  /// In en, this message translates to:
  /// **'An error occurred'**
  String get an_error_occurred;

  /// No description provided for @info.
  ///
  /// In en, this message translates to:
  /// **'Information'**
  String get info;

  /// No description provided for @success.
  ///
  /// In en, this message translates to:
  /// **'Success'**
  String get success;

  /// No description provided for @error.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get error;

  /// No description provided for @failed.
  ///
  /// In en, this message translates to:
  /// **'Failed'**
  String get failed;

  /// No description provided for @your_driver_is.
  ///
  /// In en, this message translates to:
  /// **'Your driver is'**
  String get your_driver_is;

  /// No description provided for @origin.
  ///
  /// In en, this message translates to:
  /// **'Origin'**
  String get origin;

  /// No description provided for @destination.
  ///
  /// In en, this message translates to:
  /// **'Destination'**
  String get destination;

  /// No description provided for @special_instructions.
  ///
  /// In en, this message translates to:
  /// **'Special Instructions (Optional)'**
  String get special_instructions;

  /// No description provided for @special_instructions_hint.
  ///
  /// In en, this message translates to:
  /// **'e.g., \'Please handle with care\', \'Call before delivery\''**
  String get special_instructions_hint;

  /// No description provided for @delivery_service.
  ///
  /// In en, this message translates to:
  /// **'Delivery Service'**
  String get delivery_service;

  /// No description provided for @back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @submit.
  ///
  /// In en, this message translates to:
  /// **'Submit'**
  String get submit;

  /// No description provided for @save_changes.
  ///
  /// In en, this message translates to:
  /// **'Save Changes'**
  String get save_changes;

  /// No description provided for @allow.
  ///
  /// In en, this message translates to:
  /// **'Allow'**
  String get allow;

  /// No description provided for @open_settings.
  ///
  /// In en, this message translates to:
  /// **'Open Settings'**
  String get open_settings;

  /// No description provided for @send_reset_link.
  ///
  /// In en, this message translates to:
  /// **'Send Reset Link'**
  String get send_reset_link;

  /// No description provided for @back_to_sign_in.
  ///
  /// In en, this message translates to:
  /// **'Back to Sign In'**
  String get back_to_sign_in;

  /// No description provided for @reset_password.
  ///
  /// In en, this message translates to:
  /// **'Reset Password'**
  String get reset_password;

  /// No description provided for @reject.
  ///
  /// In en, this message translates to:
  /// **'Reject'**
  String get reject;

  /// No description provided for @accept.
  ///
  /// In en, this message translates to:
  /// **'Accept'**
  String get accept;

  /// No description provided for @grant_permission.
  ///
  /// In en, this message translates to:
  /// **'Grant Permission'**
  String get grant_permission;

  /// No description provided for @send_alert.
  ///
  /// In en, this message translates to:
  /// **'Send Alert'**
  String get send_alert;

  /// No description provided for @download_qr.
  ///
  /// In en, this message translates to:
  /// **'Download QR'**
  String get download_qr;

  /// No description provided for @copy_qr_url.
  ///
  /// In en, this message translates to:
  /// **'Copy QR URL'**
  String get copy_qr_url;

  /// No description provided for @name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get name;

  /// No description provided for @phone.
  ///
  /// In en, this message translates to:
  /// **'Phone'**
  String get phone;

  /// No description provided for @gender.
  ///
  /// In en, this message translates to:
  /// **'Gender'**
  String get gender;

  /// No description provided for @photo.
  ///
  /// In en, this message translates to:
  /// **'Photo'**
  String get photo;

  /// No description provided for @address.
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get address;

  /// No description provided for @location.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get location;

  /// No description provided for @unknown.
  ///
  /// In en, this message translates to:
  /// **'Unknown'**
  String get unknown;

  /// No description provided for @user_role.
  ///
  /// In en, this message translates to:
  /// **'User'**
  String get user_role;

  /// No description provided for @driver_role.
  ///
  /// In en, this message translates to:
  /// **'Driver'**
  String get driver_role;

  /// No description provided for @merchant_role.
  ///
  /// In en, this message translates to:
  /// **'Merchant'**
  String get merchant_role;

  /// No description provided for @student_id.
  ///
  /// In en, this message translates to:
  /// **'NIM'**
  String get student_id;

  /// No description provided for @confirm_password.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get confirm_password;

  /// No description provided for @vehicle_registration.
  ///
  /// In en, this message translates to:
  /// **'Vehicle Registration (STNK)'**
  String get vehicle_registration;

  /// No description provided for @bank_provider.
  ///
  /// In en, this message translates to:
  /// **'Bank Provider'**
  String get bank_provider;

  /// No description provided for @owner_name.
  ///
  /// In en, this message translates to:
  /// **'Owner Name'**
  String get owner_name;

  /// No description provided for @outlet_name.
  ///
  /// In en, this message translates to:
  /// **'Outlet Name'**
  String get outlet_name;

  /// No description provided for @outlet_category.
  ///
  /// In en, this message translates to:
  /// **'Outlet Category'**
  String get outlet_category;

  /// No description provided for @outlet_location.
  ///
  /// In en, this message translates to:
  /// **'Outlet Location'**
  String get outlet_location;

  /// No description provided for @government_document.
  ///
  /// In en, this message translates to:
  /// **'Government Document'**
  String get government_document;

  /// No description provided for @bank_account_number.
  ///
  /// In en, this message translates to:
  /// **'Bank Account Number'**
  String get bank_account_number;

  /// No description provided for @choose_service.
  ///
  /// In en, this message translates to:
  /// **'Choose the service that you want'**
  String get choose_service;

  /// No description provided for @popular_merchant.
  ///
  /// In en, this message translates to:
  /// **'Popular merchant'**
  String get popular_merchant;

  /// No description provided for @ride.
  ///
  /// In en, this message translates to:
  /// **'Ride'**
  String get ride;

  /// No description provided for @delivery.
  ///
  /// In en, this message translates to:
  /// **'Delivery'**
  String get delivery;

  /// No description provided for @mart.
  ///
  /// In en, this message translates to:
  /// **'AMart'**
  String get mart;

  /// No description provided for @wallet.
  ///
  /// In en, this message translates to:
  /// **'E-wallet'**
  String get wallet;

  /// No description provided for @voucher.
  ///
  /// In en, this message translates to:
  /// **'My Voucher'**
  String get voucher;

  /// No description provided for @photo_profile.
  ///
  /// In en, this message translates to:
  /// **'Photo Profile'**
  String get photo_profile;

  /// No description provided for @old_password.
  ///
  /// In en, this message translates to:
  /// **'Old Password'**
  String get old_password;

  /// No description provided for @new_password.
  ///
  /// In en, this message translates to:
  /// **'New Password'**
  String get new_password;

  /// No description provided for @confirm_new_password.
  ///
  /// In en, this message translates to:
  /// **'Confirm New Password'**
  String get confirm_new_password;

  /// No description provided for @this_month.
  ///
  /// In en, this message translates to:
  /// **'This month'**
  String get this_month;

  /// No description provided for @expenses.
  ///
  /// In en, this message translates to:
  /// **'Expenses'**
  String get expenses;

  /// No description provided for @income.
  ///
  /// In en, this message translates to:
  /// **'Income'**
  String get income;

  /// No description provided for @payment_method_qris.
  ///
  /// In en, this message translates to:
  /// **'QRIS'**
  String get payment_method_qris;

  /// No description provided for @order_id.
  ///
  /// In en, this message translates to:
  /// **'Order #'**
  String get order_id;

  /// No description provided for @pickup.
  ///
  /// In en, this message translates to:
  /// **'Pickup'**
  String get pickup;

  /// No description provided for @dropoff.
  ///
  /// In en, this message translates to:
  /// **'Dropoff'**
  String get dropoff;

  /// No description provided for @earnings.
  ///
  /// In en, this message translates to:
  /// **'Earnings'**
  String get earnings;

  /// No description provided for @gender_preference.
  ///
  /// In en, this message translates to:
  /// **'Gender preference: '**
  String get gender_preference;

  /// No description provided for @note.
  ///
  /// In en, this message translates to:
  /// **'Note:'**
  String get note;

  /// No description provided for @order_type_ride.
  ///
  /// In en, this message translates to:
  /// **'Ride'**
  String get order_type_ride;

  /// No description provided for @order_type_delivery.
  ///
  /// In en, this message translates to:
  /// **'Delivery'**
  String get order_type_delivery;

  /// No description provided for @order_type_food.
  ///
  /// In en, this message translates to:
  /// **'Food'**
  String get order_type_food;

  /// No description provided for @note_pickup.
  ///
  /// In en, this message translates to:
  /// **'Pickup: '**
  String get note_pickup;

  /// No description provided for @note_dropoff.
  ///
  /// In en, this message translates to:
  /// **'Dropoff: '**
  String get note_dropoff;

  /// No description provided for @note_instructions.
  ///
  /// In en, this message translates to:
  /// **'Instructions: '**
  String get note_instructions;

  /// No description provided for @benefit_nearby_orders.
  ///
  /// In en, this message translates to:
  /// **'Match you with nearby orders'**
  String get benefit_nearby_orders;

  /// No description provided for @benefit_track_arrival.
  ///
  /// In en, this message translates to:
  /// **'Let customers track your arrival'**
  String get benefit_track_arrival;

  /// No description provided for @benefit_safety.
  ///
  /// In en, this message translates to:
  /// **'Ensure safety and accountability'**
  String get benefit_safety;

  /// No description provided for @review_category.
  ///
  /// In en, this message translates to:
  /// **'Review Category'**
  String get review_category;

  /// No description provided for @cleanliness.
  ///
  /// In en, this message translates to:
  /// **'Cleanliness'**
  String get cleanliness;

  /// No description provided for @courtesy.
  ///
  /// In en, this message translates to:
  /// **'Courtesy'**
  String get courtesy;

  /// No description provided for @other.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get other;

  /// No description provided for @comment_optional.
  ///
  /// In en, this message translates to:
  /// **'Comment (Optional)'**
  String get comment_optional;

  /// No description provided for @select_type.
  ///
  /// In en, this message translates to:
  /// **'Select emergency type:'**
  String get select_type;

  /// No description provided for @accident.
  ///
  /// In en, this message translates to:
  /// **'Accident'**
  String get accident;

  /// No description provided for @harassment.
  ///
  /// In en, this message translates to:
  /// **'Harassment'**
  String get harassment;

  /// No description provided for @theft.
  ///
  /// In en, this message translates to:
  /// **'Theft'**
  String get theft;

  /// No description provided for @medical.
  ///
  /// In en, this message translates to:
  /// **'Medical Emergency'**
  String get medical;

  /// No description provided for @description.
  ///
  /// In en, this message translates to:
  /// **'Description:'**
  String get description;

  /// No description provided for @akademove_pay.
  ///
  /// In en, this message translates to:
  /// **'Akademove Pay'**
  String get akademove_pay;

  /// No description provided for @valid_until.
  ///
  /// In en, this message translates to:
  /// **'Valid until '**
  String get valid_until;

  /// No description provided for @remaining_time.
  ///
  /// In en, this message translates to:
  /// **'Remaining Time :'**
  String get remaining_time;

  /// No description provided for @atk.
  ///
  /// In en, this message translates to:
  /// **'ATK (Stationery)'**
  String get atk;

  /// No description provided for @printing.
  ///
  /// In en, this message translates to:
  /// **'Printing'**
  String get printing;

  /// No description provided for @food.
  ///
  /// In en, this message translates to:
  /// **'Food & Beverages'**
  String get food;

  /// No description provided for @drag_marker.
  ///
  /// In en, this message translates to:
  /// **'Drag to adjust position'**
  String get drag_marker;

  /// No description provided for @step_1.
  ///
  /// In en, this message translates to:
  /// **'Step 1'**
  String get step_1;

  /// No description provided for @step_2.
  ///
  /// In en, this message translates to:
  /// **'Step 2'**
  String get step_2;

  /// No description provided for @step_3.
  ///
  /// In en, this message translates to:
  /// **'Step 3'**
  String get step_3;

  /// No description provided for @step_4.
  ///
  /// In en, this message translates to:
  /// **'Step 4'**
  String get step_4;

  /// No description provided for @hint_bank_provider.
  ///
  /// In en, this message translates to:
  /// **'Pick your bank provider'**
  String get hint_bank_provider;

  /// No description provided for @hint_outlet_category.
  ///
  /// In en, this message translates to:
  /// **'Select outlet category'**
  String get hint_outlet_category;

  /// No description provided for @hint_search_location.
  ///
  /// In en, this message translates to:
  /// **'Search location (e.g., Monas Jakarta)'**
  String get hint_search_location;

  /// No description provided for @hint_share_experience.
  ///
  /// In en, this message translates to:
  /// **'Share your experience...'**
  String get hint_share_experience;

  /// No description provided for @hint_description.
  ///
  /// In en, this message translates to:
  /// **'Describe the emergency situation...'**
  String get hint_description;

  /// No description provided for @sign_up_choice.
  ///
  /// In en, this message translates to:
  /// **'Start Your Journey with Us!'**
  String get sign_up_choice;

  /// No description provided for @driver_sign_up_step1.
  ///
  /// In en, this message translates to:
  /// **'Tell us a bit about yourself to get started!'**
  String get driver_sign_up_step1;

  /// No description provided for @driver_sign_up_step2.
  ///
  /// In en, this message translates to:
  /// **'Upload your photo and documents to verify your account!'**
  String get driver_sign_up_step2;

  /// No description provided for @driver_sign_up_step3.
  ///
  /// In en, this message translates to:
  /// **'Enter your vehicle details so we can set you up on the road!'**
  String get driver_sign_up_step3;

  /// No description provided for @driver_sign_up_step4.
  ///
  /// In en, this message translates to:
  /// **'Add your bank account to receive your earnings securely!'**
  String get driver_sign_up_step4;

  /// No description provided for @user_sign_up.
  ///
  /// In en, this message translates to:
  /// **'Sign up now — your next ride or meal is just a tap away 🚴‍♂️🍔'**
  String get user_sign_up;

  /// No description provided for @merchant_sign_up_step1.
  ///
  /// In en, this message translates to:
  /// **'Tell us about yourself to kickstart your merchant journey!'**
  String get merchant_sign_up_step1;

  /// No description provided for @merchant_sign_up_step2.
  ///
  /// In en, this message translates to:
  /// **'Share your outlet details and location so customers can find you easily!'**
  String get merchant_sign_up_step2;

  /// No description provided for @merchant_sign_up_step3.
  ///
  /// In en, this message translates to:
  /// **'Add your bank account to receive payments securely!'**
  String get merchant_sign_up_step3;

  /// No description provided for @forgot_password.
  ///
  /// In en, this message translates to:
  /// **'Forgot Password'**
  String get forgot_password;

  /// No description provided for @driver_dashboard.
  ///
  /// In en, this message translates to:
  /// **'Driver Dashboard'**
  String get driver_dashboard;

  /// No description provided for @order_history.
  ///
  /// In en, this message translates to:
  /// **'Order History'**
  String get order_history;

  /// No description provided for @merchant_edit_profile.
  ///
  /// In en, this message translates to:
  /// **'Edit Profile'**
  String get merchant_edit_profile;

  /// No description provided for @setup_outlet.
  ///
  /// In en, this message translates to:
  /// **'Set Up Outlet'**
  String get setup_outlet;

  /// No description provided for @order_detail.
  ///
  /// In en, this message translates to:
  /// **'Order Detail'**
  String get order_detail;

  /// No description provided for @menu_detail.
  ///
  /// In en, this message translates to:
  /// **'Menu\'s Detail'**
  String get menu_detail;

  /// No description provided for @sales_report.
  ///
  /// In en, this message translates to:
  /// **'Sales Report'**
  String get sales_report;

  /// No description provided for @commission_report.
  ///
  /// In en, this message translates to:
  /// **'Commission Report'**
  String get commission_report;

  /// No description provided for @merchant_change_password.
  ///
  /// In en, this message translates to:
  /// **'Change Password'**
  String get merchant_change_password;

  /// No description provided for @where_you_at.
  ///
  /// In en, this message translates to:
  /// **'Where you at?'**
  String get where_you_at;

  /// No description provided for @where_going.
  ///
  /// In en, this message translates to:
  /// **'Where are you going?'**
  String get where_going;

  /// No description provided for @on_trip.
  ///
  /// In en, this message translates to:
  /// **'On Trip'**
  String get on_trip;

  /// No description provided for @trip_details.
  ///
  /// In en, this message translates to:
  /// **'Trip Details'**
  String get trip_details;

  /// No description provided for @create_menu.
  ///
  /// In en, this message translates to:
  /// **'Create Menu'**
  String get create_menu;

  /// No description provided for @edit_menu.
  ///
  /// In en, this message translates to:
  /// **'Edit Menu'**
  String get edit_menu;

  /// No description provided for @sign_up_success.
  ///
  /// In en, this message translates to:
  /// **'Sign Up Success'**
  String get sign_up_success;

  /// No description provided for @sign_up_failed.
  ///
  /// In en, this message translates to:
  /// **'Sign Up Failed'**
  String get sign_up_failed;

  /// No description provided for @location_permission.
  ///
  /// In en, this message translates to:
  /// **'Location Permission'**
  String get location_permission;

  /// No description provided for @permission_denied.
  ///
  /// In en, this message translates to:
  /// **'Permission Denied'**
  String get permission_denied;

  /// No description provided for @location_disabled.
  ///
  /// In en, this message translates to:
  /// **'Location Services Disabled'**
  String get location_disabled;

  /// No description provided for @location_permission_required.
  ///
  /// In en, this message translates to:
  /// **'Location Permission Required'**
  String get location_permission_required;

  /// No description provided for @search_error.
  ///
  /// In en, this message translates to:
  /// **'Search Error'**
  String get search_error;

  /// No description provided for @location_found.
  ///
  /// In en, this message translates to:
  /// **'Location Found'**
  String get location_found;

  /// No description provided for @not_found.
  ///
  /// In en, this message translates to:
  /// **'Not Found'**
  String get not_found;

  /// No description provided for @validation_error.
  ///
  /// In en, this message translates to:
  /// **'Validation Error'**
  String get validation_error;

  /// No description provided for @oops.
  ///
  /// In en, this message translates to:
  /// **'Oops...'**
  String get oops;

  /// No description provided for @new_order.
  ///
  /// In en, this message translates to:
  /// **'New {type} Order'**
  String new_order(String type);

  /// No description provided for @order_unavailable.
  ///
  /// In en, this message translates to:
  /// **'Order Unavailable'**
  String get order_unavailable;

  /// No description provided for @order_rejected.
  ///
  /// In en, this message translates to:
  /// **'Order Rejected'**
  String get order_rejected;

  /// No description provided for @alert.
  ///
  /// In en, this message translates to:
  /// **'Emergency Alert'**
  String get alert;

  /// No description provided for @report_emergency.
  ///
  /// In en, this message translates to:
  /// **'Report Emergency'**
  String get report_emergency;

  /// No description provided for @confirm_logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get confirm_logout;

  /// No description provided for @delete_menu.
  ///
  /// In en, this message translates to:
  /// **'Delete Menu'**
  String get delete_menu;

  /// No description provided for @description_user_role.
  ///
  /// In en, this message translates to:
  /// **'Enjoy a comfortable and safe journey to your destination.'**
  String get description_user_role;

  /// No description provided for @description_driver_role.
  ///
  /// In en, this message translates to:
  /// **'Earn extra income by driving with us.'**
  String get description_driver_role;

  /// No description provided for @description_merchant_role.
  ///
  /// In en, this message translates to:
  /// **'Expand your business reach with our platform.'**
  String get description_merchant_role;

  /// No description provided for @description_forgot_password.
  ///
  /// In en, this message translates to:
  /// **'Enter your email to receive password reset instructions'**
  String get description_forgot_password;

  /// No description provided for @description_reset_password.
  ///
  /// In en, this message translates to:
  /// **'Enter your new password'**
  String get description_reset_password;

  /// No description provided for @helper_outlet_category.
  ///
  /// In en, this message translates to:
  /// **'Select the main category for your outlet'**
  String get helper_outlet_category;

  /// No description provided for @helper_outlet_location.
  ///
  /// In en, this message translates to:
  /// **'Search for a location, tap on map, or drag the marker'**
  String get helper_outlet_location;

  /// No description provided for @error_password_mismatch.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get error_password_mismatch;

  /// No description provided for @error_file_required.
  ///
  /// In en, this message translates to:
  /// **'File shouldn\'t be empty'**
  String get error_file_required;

  /// No description provided for @error_photo_pick_failed.
  ///
  /// In en, this message translates to:
  /// **'Failed to pick photo'**
  String get error_photo_pick_failed;

  /// No description provided for @error_unknown.
  ///
  /// In en, this message translates to:
  /// **'Unknown error'**
  String get error_unknown;

  /// No description provided for @error_unexpected.
  ///
  /// In en, this message translates to:
  /// **'An unexpected error occurred'**
  String get error_unexpected;

  /// No description provided for @error_complete_required_fields.
  ///
  /// In en, this message translates to:
  /// **'Please complete all required fields'**
  String get error_complete_required_fields;

  /// No description provided for @error_fill_required_fields.
  ///
  /// In en, this message translates to:
  /// **'Please fill all required fields'**
  String get error_fill_required_fields;

  /// No description provided for @error_location_search_empty.
  ///
  /// In en, this message translates to:
  /// **'Please enter a location to search'**
  String get error_location_search_empty;

  /// No description provided for @error_location_not_found.
  ///
  /// In en, this message translates to:
  /// **'Location not found. Please try a different search.'**
  String get error_location_not_found;

  /// No description provided for @error_location_search_failed.
  ///
  /// In en, this message translates to:
  /// **'Unable to search location. Please check your internet connection.'**
  String get error_location_search_failed;

  /// No description provided for @error_address_unavailable.
  ///
  /// In en, this message translates to:
  /// **'Unable to get address'**
  String get error_address_unavailable;

  /// No description provided for @error_invalid_reset_token.
  ///
  /// In en, this message translates to:
  /// **'Invalid or missing reset token'**
  String get error_invalid_reset_token;

  /// No description provided for @error_description_required.
  ///
  /// In en, this message translates to:
  /// **'Please provide a description'**
  String get error_description_required;

  /// No description provided for @error_access_denied.
  ///
  /// In en, this message translates to:
  /// **'Access denied. Please grant permission in settings.'**
  String get error_access_denied;

  /// No description provided for @error_storage_full.
  ///
  /// In en, this message translates to:
  /// **'Not enough storage space.'**
  String get error_storage_full;

  /// No description provided for @error_format_unsupported.
  ///
  /// In en, this message translates to:
  /// **'Image format not supported.'**
  String get error_format_unsupported;

  /// No description provided for @error_unexpected_prefix.
  ///
  /// In en, this message translates to:
  /// **'Unexpected error: '**
  String get error_unexpected_prefix;

  /// No description provided for @error_qr_save_failed.
  ///
  /// In en, this message translates to:
  /// **'Failed to save QR code: '**
  String get error_qr_save_failed;

  /// No description provided for @error_qr_copy_failed.
  ///
  /// In en, this message translates to:
  /// **'Failed to copy QR URL: '**
  String get error_qr_copy_failed;

  /// No description provided for @error_review_submit_failed.
  ///
  /// In en, this message translates to:
  /// **'Failed to submit review'**
  String get error_review_submit_failed;

  /// No description provided for @error_invalid_amount.
  ///
  /// In en, this message translates to:
  /// **'Invalid amount'**
  String get error_invalid_amount;

  /// No description provided for @error_top_up_minimum.
  ///
  /// In en, this message translates to:
  /// **'Top up amount atleast Rp 10,000'**
  String get error_top_up_minimum;

  /// No description provided for @error_failed_to_estimate.
  ///
  /// In en, this message translates to:
  /// **'Failed to estimate order'**
  String get error_failed_to_estimate;

  /// No description provided for @error_get_estimate_first.
  ///
  /// In en, this message translates to:
  /// **'Please get estimate first'**
  String get error_get_estimate_first;

  /// No description provided for @error_fill_all_fields.
  ///
  /// In en, this message translates to:
  /// **'Please fill all required fields correctly'**
  String get error_fill_all_fields;

  /// No description provided for @error_enter_bank_account.
  ///
  /// In en, this message translates to:
  /// **'Please enter bank account number'**
  String get error_enter_bank_account;

  /// No description provided for @error_select_bank_first.
  ///
  /// In en, this message translates to:
  /// **'Please select a bank provider first'**
  String get error_select_bank_first;

  /// No description provided for @success_sign_up.
  ///
  /// In en, this message translates to:
  /// **'Successfully signed up'**
  String get success_sign_up;

  /// No description provided for @success_location_found.
  ///
  /// In en, this message translates to:
  /// **'Marker moved to searched location'**
  String get success_location_found;

  /// No description provided for @success_review_submitted.
  ///
  /// In en, this message translates to:
  /// **'Review submitted successfully'**
  String get success_review_submitted;

  /// No description provided for @success_qr_saved.
  ///
  /// In en, this message translates to:
  /// **'QR code saved successfully'**
  String get success_qr_saved;

  /// No description provided for @success_qr_url_copied.
  ///
  /// In en, this message translates to:
  /// **'QR URL copied to clipboard'**
  String get success_qr_url_copied;

  /// No description provided for @success_menu_updated.
  ///
  /// In en, this message translates to:
  /// **'Menu updated successfully'**
  String get success_menu_updated;

  /// No description provided for @success_bank_verified.
  ///
  /// In en, this message translates to:
  /// **'Bank account verified successfully'**
  String get success_bank_verified;

  /// No description provided for @message_remember_password.
  ///
  /// In en, this message translates to:
  /// **'Remember your password?'**
  String get message_remember_password;

  /// No description provided for @message_location_default.
  ///
  /// In en, this message translates to:
  /// **'Using default location. You can drag the marker to set your outlet location.'**
  String get message_location_default;

  /// No description provided for @message_leocation_permission_required.
  ///
  /// In en, this message translates to:
  /// **'Location permission is required to set your outlet location automatically.'**
  String get message_leocation_permission_required;

  /// No description provided for @message_location_permission_explanation.
  ///
  /// In en, this message translates to:
  /// **'We need access to your location to automatically set your outlet location on the map. This helps customers find your business easily.\n\nYou can also manually set the location by dragging the marker.'**
  String get message_location_permission_explanation;

  /// No description provided for @message_location_services_disabled.
  ///
  /// In en, this message translates to:
  /// **'Location services are currently disabled on your device. Please enable them to automatically detect your outlet location.'**
  String get message_location_services_disabled;

  /// No description provided for @message_location_permission_denied_forever.
  ///
  /// In en, this message translates to:
  /// **'Location permission has been permanently denied. To use automatic location detection, please enable it in your app settings.\n\nYou can still manually set your outlet location by dragging the marker on the map.'**
  String get message_location_permission_denied_forever;

  /// No description provided for @message_order_unavailable.
  ///
  /// In en, this message translates to:
  /// **'This order was cancelled or accepted by another driver'**
  String get message_order_unavailable;

  /// No description provided for @message_order_rejected.
  ///
  /// In en, this message translates to:
  /// **'You rejected the order'**
  String get message_order_rejected;

  /// No description provided for @message_location_permission_denied_permanent.
  ///
  /// In en, this message translates to:
  /// **'Location permission was previously denied. To go online and accept orders, you need to enable location access in your device settings.'**
  String get message_location_permission_denied_permanent;

  /// No description provided for @message_location_permission_explanation_driver.
  ///
  /// In en, this message translates to:
  /// **'To accept ride and delivery orders, drivers must share their location in real-time. This helps:'**
  String get message_location_permission_explanation_driver;

  /// No description provided for @message_redirect_settings.
  ///
  /// In en, this message translates to:
  /// **'You will be redirected to app settings to enable location access.'**
  String get message_redirect_settings;

  /// No description provided for @message_rate_experience.
  ///
  /// In en, this message translates to:
  /// **'How was your experience with {name}?'**
  String message_rate_experience(String name);

  /// No description provided for @message_confirmation.
  ///
  /// In en, this message translates to:
  /// **'This will send an emergency alert to campus authorities and notify emergency contacts. Are you sure you want to continue?'**
  String get message_confirmation;

  /// No description provided for @message_settings_coming_soon.
  ///
  /// In en, this message translates to:
  /// **'Settings feature coming soon'**
  String get message_settings_coming_soon;

  /// No description provided for @message_failed_load_profile.
  ///
  /// In en, this message translates to:
  /// **'Failed to load profile: '**
  String get message_failed_load_profile;

  /// No description provided for @message_failed_update_menu.
  ///
  /// In en, this message translates to:
  /// **'Failed to update menu'**
  String get message_failed_update_menu;

  /// No description provided for @message_failed_verify_bank.
  ///
  /// In en, this message translates to:
  /// **'Failed to verify bank account'**
  String get message_failed_verify_bank;

  /// No description provided for @message_confirm_reject_order.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to reject this order? This action cannot be undone.'**
  String get message_confirm_reject_order;

  /// No description provided for @message_confirm_cancel_order.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to cancel this order? The customer will be notified.'**
  String get message_confirm_cancel_order;

  /// No description provided for @message_confirm_delete_schedule.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete \"{name}\"? This action cannot be undone.'**
  String message_confirm_delete_schedule(String name);

  /// No description provided for @message_confirm_logout.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to logout?'**
  String get message_confirm_logout;

  /// No description provided for @message_confirm_accept_order.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to accept this order?'**
  String get message_confirm_accept_order;

  /// No description provided for @message_confirm_delete_menu.
  ///
  /// In en, this message translates to:
  /// **'Are you sure want to delete this menu?'**
  String get message_confirm_delete_menu;

  /// No description provided for @message_select_reject_reason.
  ///
  /// In en, this message translates to:
  /// **'Please select a reason for rejecting this order:'**
  String get message_select_reject_reason;

  /// No description provided for @dragging_marker.
  ///
  /// In en, this message translates to:
  /// **'Dragging...'**
  String get dragging_marker;

  /// No description provided for @welcome_back.
  ///
  /// In en, this message translates to:
  /// **'Welcome back!'**
  String get welcome_back;

  /// No description provided for @license_plate.
  ///
  /// In en, this message translates to:
  /// **'License Plate: '**
  String get license_plate;

  /// No description provided for @rating.
  ///
  /// In en, this message translates to:
  /// **'{rating} rating'**
  String rating(String rating);

  /// No description provided for @driver_status.
  ///
  /// In en, this message translates to:
  /// **'Driver Status'**
  String get driver_status;

  /// No description provided for @accepting_orders.
  ///
  /// In en, this message translates to:
  /// **'You are accepting orders'**
  String get accepting_orders;

  /// No description provided for @offline.
  ///
  /// In en, this message translates to:
  /// **'You are offline'**
  String get offline;

  /// No description provided for @ready_accept.
  ///
  /// In en, this message translates to:
  /// **'Ready to accept new orders'**
  String get ready_accept;

  /// No description provided for @toggle_receive.
  ///
  /// In en, this message translates to:
  /// **'Toggle on to start receiving orders'**
  String get toggle_receive;

  /// No description provided for @today_performance.
  ///
  /// In en, this message translates to:
  /// **'Today\'s Performance'**
  String get today_performance;

  /// No description provided for @trips.
  ///
  /// In en, this message translates to:
  /// **'Trips'**
  String get trips;

  /// No description provided for @quick_actions.
  ///
  /// In en, this message translates to:
  /// **'Quick Actions'**
  String get quick_actions;

  /// No description provided for @manage_schedule.
  ///
  /// In en, this message translates to:
  /// **'Manage Schedule'**
  String get manage_schedule;

  /// No description provided for @hello.
  ///
  /// In en, this message translates to:
  /// **'Hello, {name}'**
  String hello(String name);

  /// No description provided for @open_today.
  ///
  /// In en, this message translates to:
  /// **'Open Today'**
  String get open_today;

  /// No description provided for @operating_hours.
  ///
  /// In en, this message translates to:
  /// **'10.00 - 22.00 WIB'**
  String get operating_hours;

  /// No description provided for @sales_recap.
  ///
  /// In en, this message translates to:
  /// **'Sales Recap'**
  String get sales_recap;

  /// No description provided for @today_transaction.
  ///
  /// In en, this message translates to:
  /// **'Today\'s transaction'**
  String get today_transaction;

  /// No description provided for @today_gross_sales.
  ///
  /// In en, this message translates to:
  /// **'Today\'s gross sales'**
  String get today_gross_sales;

  /// No description provided for @see_detail.
  ///
  /// In en, this message translates to:
  /// **'See detail'**
  String get see_detail;

  /// No description provided for @send_packages.
  ///
  /// In en, this message translates to:
  /// **'Send packages within campus'**
  String get send_packages;

  /// No description provided for @max_weight.
  ///
  /// In en, this message translates to:
  /// **'Max weight: 20kg'**
  String get max_weight;

  /// No description provided for @fast_delivery.
  ///
  /// In en, this message translates to:
  /// **'Fast delivery'**
  String get fast_delivery;

  /// No description provided for @secure_handling.
  ///
  /// In en, this message translates to:
  /// **'Secure handling'**
  String get secure_handling;

  /// No description provided for @start_delivery.
  ///
  /// In en, this message translates to:
  /// **'Start Delivery'**
  String get start_delivery;

  /// No description provided for @choose_pickup_destination.
  ///
  /// In en, this message translates to:
  /// **'Choose your pick-up and destination point!'**
  String get choose_pickup_destination;

  /// No description provided for @rating_score.
  ///
  /// In en, this message translates to:
  /// **'Rating: {score} / 5.0'**
  String rating_score(String score);

  /// No description provided for @action_take_photo.
  ///
  /// In en, this message translates to:
  /// **'Take a photo'**
  String get action_take_photo;

  /// No description provided for @action_choose_gallery.
  ///
  /// In en, this message translates to:
  /// **'Choose from gallery'**
  String get action_choose_gallery;

  /// No description provided for @action_remove_image.
  ///
  /// In en, this message translates to:
  /// **'Remove image'**
  String get action_remove_image;

  /// No description provided for @enter_withdrawal_amount.
  ///
  /// In en, this message translates to:
  /// **'Enter withdrawal amount'**
  String get enter_withdrawal_amount;

  /// No description provided for @cart_shopping_cart.
  ///
  /// In en, this message translates to:
  /// **'Shopping Cart'**
  String get cart_shopping_cart;

  /// No description provided for @cart_your_cart_is_empty.
  ///
  /// In en, this message translates to:
  /// **'Your cart is empty'**
  String get cart_your_cart_is_empty;

  /// No description provided for @cart_add_items_to_see_here.
  ///
  /// In en, this message translates to:
  /// **'Add items from AMart to see them here'**
  String get cart_add_items_to_see_here;

  /// No description provided for @cart_browse_amart.
  ///
  /// In en, this message translates to:
  /// **'Browse AMart'**
  String get cart_browse_amart;

  /// No description provided for @cart_total_items.
  ///
  /// In en, this message translates to:
  /// **'Total ({count} items)'**
  String cart_total_items(int count);

  /// No description provided for @cart_checkout.
  ///
  /// In en, this message translates to:
  /// **'Checkout'**
  String get cart_checkout;

  /// No description provided for @cart_coming_soon.
  ///
  /// In en, this message translates to:
  /// **'Coming Soon'**
  String get cart_coming_soon;

  /// No description provided for @cart_order_confirmation_coming_soon.
  ///
  /// In en, this message translates to:
  /// **'Order confirmation screen coming soon'**
  String get cart_order_confirmation_coming_soon;

  /// No description provided for @cart_clear_cart.
  ///
  /// In en, this message translates to:
  /// **'Clear Cart?'**
  String get cart_clear_cart;

  /// No description provided for @cart_clear_cart_confirmation.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to remove all items from your cart?'**
  String get cart_clear_cart_confirmation;

  /// No description provided for @cart_clear.
  ///
  /// In en, this message translates to:
  /// **'Clear'**
  String get cart_clear;

  /// No description provided for @cart_failed_to_load.
  ///
  /// In en, this message translates to:
  /// **'Failed to load cart'**
  String get cart_failed_to_load;

  /// No description provided for @cart_note_prefix.
  ///
  /// In en, this message translates to:
  /// **'Note: '**
  String get cart_note_prefix;

  /// No description provided for @cart_replace_cart_items.
  ///
  /// In en, this message translates to:
  /// **'Replace Cart Items?'**
  String get cart_replace_cart_items;

  /// No description provided for @cart_contains_items_from.
  ///
  /// In en, this message translates to:
  /// **'Your cart contains items from {merchantName}.'**
  String cart_contains_items_from(String merchantName);

  /// No description provided for @cart_discard_and_add_from.
  ///
  /// In en, this message translates to:
  /// **'Do you want to discard those items and add items from {merchantName} instead?'**
  String cart_discard_and_add_from(String merchantName);

  /// No description provided for @cart_current_cart_will_be_cleared.
  ///
  /// In en, this message translates to:
  /// **'Your current cart will be cleared'**
  String get cart_current_cart_will_be_cleared;

  /// No description provided for @cart_replace_cart.
  ///
  /// In en, this message translates to:
  /// **'Replace Cart'**
  String get cart_replace_cart;

  /// No description provided for @menu_details.
  ///
  /// In en, this message translates to:
  /// **'Menu Details'**
  String get menu_details;

  /// No description provided for @menu_in_stock.
  ///
  /// In en, this message translates to:
  /// **'In Stock ({count} available)'**
  String menu_in_stock(int count);

  /// No description provided for @menu_out_of_stock.
  ///
  /// In en, this message translates to:
  /// **'Out of Stock'**
  String get menu_out_of_stock;

  /// No description provided for @menu_quantity.
  ///
  /// In en, this message translates to:
  /// **'Quantity'**
  String get menu_quantity;

  /// No description provided for @menu_special_notes_optional.
  ///
  /// In en, this message translates to:
  /// **'Special Notes (Optional)'**
  String get menu_special_notes_optional;

  /// No description provided for @menu_total_price.
  ///
  /// In en, this message translates to:
  /// **'Total Price'**
  String get menu_total_price;

  /// No description provided for @menu_add_to_cart.
  ///
  /// In en, this message translates to:
  /// **'Add to Cart'**
  String get menu_add_to_cart;

  /// No description provided for @menu_added_to_cart.
  ///
  /// In en, this message translates to:
  /// **'Added to Cart'**
  String get menu_added_to_cart;

  /// No description provided for @menu_item_added_to_cart.
  ///
  /// In en, this message translates to:
  /// **'Item has been added to your cart'**
  String get menu_item_added_to_cart;

  /// No description provided for @order_confirm_title.
  ///
  /// In en, this message translates to:
  /// **'Confirm Order'**
  String get order_confirm_title;

  /// No description provided for @order_confirm_order_summary.
  ///
  /// In en, this message translates to:
  /// **'Order Summary'**
  String get order_confirm_order_summary;

  /// No description provided for @order_confirm_merchant.
  ///
  /// In en, this message translates to:
  /// **'Merchant'**
  String get order_confirm_merchant;

  /// No description provided for @order_confirm_items_count.
  ///
  /// In en, this message translates to:
  /// **'{count} item(s)'**
  String order_confirm_items_count(int count);

  /// No description provided for @order_confirm_subtotal.
  ///
  /// In en, this message translates to:
  /// **'Subtotal'**
  String get order_confirm_subtotal;

  /// No description provided for @order_confirm_payment_method.
  ///
  /// In en, this message translates to:
  /// **'Payment Method'**
  String get order_confirm_payment_method;

  /// No description provided for @order_confirm_select_payment.
  ///
  /// In en, this message translates to:
  /// **'Select payment method'**
  String get order_confirm_select_payment;

  /// No description provided for @order_confirm_payment_wallet.
  ///
  /// In en, this message translates to:
  /// **'wallet'**
  String get order_confirm_payment_wallet;

  /// No description provided for @order_confirm_payment_description.
  ///
  /// In en, this message translates to:
  /// **'Pay using your Akademove wallet balance'**
  String get order_confirm_payment_description;

  /// No description provided for @order_confirm_place_order.
  ///
  /// In en, this message translates to:
  /// **'Place Order'**
  String get order_confirm_place_order;

  /// No description provided for @order_confirm_success.
  ///
  /// In en, this message translates to:
  /// **'Order Placed Successfully'**
  String get order_confirm_success;

  /// No description provided for @order_confirm_success_message.
  ///
  /// In en, this message translates to:
  /// **'Your order has been placed and is being processed'**
  String get order_confirm_success_message;

  /// No description provided for @order_confirm_failed.
  ///
  /// In en, this message translates to:
  /// **'Failed to Place Order'**
  String get order_confirm_failed;

  /// No description provided for @order_confirm_processing.
  ///
  /// In en, this message translates to:
  /// **'Processing Order...'**
  String get order_confirm_processing;

  /// No description provided for @order_confirm_insufficient_balance.
  ///
  /// In en, this message translates to:
  /// **'Insufficient wallet balance'**
  String get order_confirm_insufficient_balance;

  /// No description provided for @rate_your_experience.
  ///
  /// In en, this message translates to:
  /// **'Rate Your Experience'**
  String get rate_your_experience;

  /// No description provided for @overall_rating.
  ///
  /// In en, this message translates to:
  /// **'Overall Rating'**
  String get overall_rating;

  /// No description provided for @cleanliness_rating.
  ///
  /// In en, this message translates to:
  /// **'Cleanliness'**
  String get cleanliness_rating;

  /// No description provided for @courtesy_rating.
  ///
  /// In en, this message translates to:
  /// **'Courtesy'**
  String get courtesy_rating;

  /// No description provided for @other_rating.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get other_rating;

  /// No description provided for @add_comment_optional.
  ///
  /// In en, this message translates to:
  /// **'Add Comment (Optional)'**
  String get add_comment_optional;

  /// No description provided for @submit_review.
  ///
  /// In en, this message translates to:
  /// **'Submit Review'**
  String get submit_review;

  /// No description provided for @review_submitted_successfully.
  ///
  /// In en, this message translates to:
  /// **'Review submitted successfully'**
  String get review_submitted_successfully;

  /// No description provided for @review_submission_failed.
  ///
  /// In en, this message translates to:
  /// **'Failed to submit review'**
  String get review_submission_failed;

  /// No description provided for @you_already_reviewed_order.
  ///
  /// In en, this message translates to:
  /// **'You already reviewed this order'**
  String get you_already_reviewed_order;

  /// No description provided for @order_must_be_completed_first.
  ///
  /// In en, this message translates to:
  /// **'Order must be completed first'**
  String get order_must_be_completed_first;

  /// No description provided for @rating_required.
  ///
  /// In en, this message translates to:
  /// **'Please provide a rating'**
  String get rating_required;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'id'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'id': return AppLocalizationsId();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
