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

  /// No description provided for @start_quiz.
  ///
  /// In en, this message translates to:
  /// **'Start Quiz'**
  String get start_quiz;

  /// No description provided for @previous_attempt_failed.
  ///
  /// In en, this message translates to:
  /// **'Previous attempt failed'**
  String get previous_attempt_failed;

  /// No description provided for @previous_attempt_failed_description.
  ///
  /// In en, this message translates to:
  /// **'Your previous quiz attempt did not pass. You can try again now.'**
  String get previous_attempt_failed_description;

  /// No description provided for @driver_knowledge_quiz_description.
  ///
  /// In en, this message translates to:
  /// **'Complete this quiz to demonstrate your understanding of driver guidelines, safety protocols, and platform rules.'**
  String get driver_knowledge_quiz_description;

  /// No description provided for @driver_knowledge_quiz.
  ///
  /// In en, this message translates to:
  /// **'Driver Knowledge Quiz'**
  String get driver_knowledge_quiz;

  /// No description provided for @new_order_request.
  ///
  /// In en, this message translates to:
  /// **'New order request'**
  String get new_order_request;

  /// No description provided for @you_have_a_new_order_request_from_customer_please_check_your_orders_page.
  ///
  /// In en, this message translates to:
  /// **'You have a new order request from customer, please check your Orders page.'**
  String get you_have_a_new_order_request_from_customer_please_check_your_orders_page;

  /// No description provided for @dismiss.
  ///
  /// In en, this message translates to:
  /// **'Dismiss'**
  String get dismiss;

  /// No description provided for @view_order.
  ///
  /// In en, this message translates to:
  /// **'View Order'**
  String get view_order;

  /// No description provided for @no_show.
  ///
  /// In en, this message translates to:
  /// **'No Show'**
  String get no_show;

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
  /// **'License Plate: '**
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
  /// **'Hello, {name}'**
  String hello(String name);

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

  /// No description provided for @terms_of_service.
  ///
  /// In en, this message translates to:
  /// **'Terms of Service'**
  String get terms_of_service;

  /// No description provided for @privacy_policy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacy_policy;

  /// No description provided for @faq.
  ///
  /// In en, this message translates to:
  /// **'FAQ'**
  String get faq;

  /// No description provided for @i_agree_to_the.
  ///
  /// In en, this message translates to:
  /// **'I agree to the'**
  String get i_agree_to_the;

  /// No description provided for @terms_and_conditions.
  ///
  /// In en, this message translates to:
  /// **'Terms and Conditions'**
  String get terms_and_conditions;

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
  /// **'Send OTP Code'**
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

  /// No description provided for @otp_code.
  ///
  /// In en, this message translates to:
  /// **'OTP Code'**
  String get otp_code;

  /// No description provided for @otp_code_sent_to_email.
  ///
  /// In en, this message translates to:
  /// **'We\'ve sent a 6-digit code to your email.'**
  String get otp_code_sent_to_email;

  /// No description provided for @placeholder_otp_code.
  ///
  /// In en, this message translates to:
  /// **'Enter 6-digit code'**
  String get placeholder_otp_code;

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

  /// No description provided for @quick_actions.
  ///
  /// In en, this message translates to:
  /// **'Quick Actions'**
  String get quick_actions;

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

  /// No description provided for @coupon_no_coupons_available.
  ///
  /// In en, this message translates to:
  /// **'No coupons available'**
  String get coupon_no_coupons_available;

  /// No description provided for @coupon_select_coupon.
  ///
  /// In en, this message translates to:
  /// **'Select Coupon'**
  String get coupon_select_coupon;

  /// No description provided for @coupon_remove_coupon.
  ///
  /// In en, this message translates to:
  /// **'Remove Coupon'**
  String get coupon_remove_coupon;

  /// No description provided for @payment_method_wallet.
  ///
  /// In en, this message translates to:
  /// **'Wallet'**
  String get payment_method_wallet;

  /// No description provided for @payment_method_bank_transfer.
  ///
  /// In en, this message translates to:
  /// **'Bank Transfer'**
  String get payment_method_bank_transfer;

  /// No description provided for @emergency_alert_sent_successfully.
  ///
  /// In en, this message translates to:
  /// **'Emergency alert sent successfully'**
  String get emergency_alert_sent_successfully;

  /// No description provided for @emergency_alert_title.
  ///
  /// In en, this message translates to:
  /// **'Emergency Alert'**
  String get emergency_alert_title;

  /// No description provided for @emergency_report_title.
  ///
  /// In en, this message translates to:
  /// **'Report Emergency'**
  String get emergency_report_title;

  /// No description provided for @emergency_select_type.
  ///
  /// In en, this message translates to:
  /// **'Select emergency type:'**
  String get emergency_select_type;

  /// No description provided for @emergency_describe_situation.
  ///
  /// In en, this message translates to:
  /// **'Describe the emergency situation...'**
  String get emergency_describe_situation;

  /// No description provided for @emergency_send_alert.
  ///
  /// In en, this message translates to:
  /// **'Send Alert'**
  String get emergency_send_alert;

  /// No description provided for @button_continue.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get button_continue;

  /// No description provided for @leaderboard_title.
  ///
  /// In en, this message translates to:
  /// **'Leaderboard'**
  String get leaderboard_title;

  /// No description provided for @leaderboard_no_rankings.
  ///
  /// In en, this message translates to:
  /// **'No rankings yet'**
  String get leaderboard_no_rankings;

  /// No description provided for @leaderboard_no_badges.
  ///
  /// In en, this message translates to:
  /// **'No badges available'**
  String get leaderboard_no_badges;

  /// No description provided for @leaderboard_pts.
  ///
  /// In en, this message translates to:
  /// **'pts'**
  String get leaderboard_pts;

  /// No description provided for @chat_no_messages.
  ///
  /// In en, this message translates to:
  /// **'No messages yet'**
  String get chat_no_messages;

  /// No description provided for @merchant_order_accept.
  ///
  /// In en, this message translates to:
  /// **'Accept'**
  String get merchant_order_accept;

  /// No description provided for @merchant_order_time_remaining.
  ///
  /// In en, this message translates to:
  /// **'01:00'**
  String get merchant_order_time_remaining;

  /// No description provided for @gender_label.
  ///
  /// In en, this message translates to:
  /// **'Gender:'**
  String get gender_label;

  /// No description provided for @top_up_qris.
  ///
  /// In en, this message translates to:
  /// **'Top Up QRIS'**
  String get top_up_qris;

  /// No description provided for @rate_your_driver.
  ///
  /// In en, this message translates to:
  /// **'Rate Your Driver'**
  String get rate_your_driver;

  /// No description provided for @placeholder_name.
  ///
  /// In en, this message translates to:
  /// **'John Doe'**
  String get placeholder_name;

  /// No description provided for @placeholder_email.
  ///
  /// In en, this message translates to:
  /// **'john@gmail.com'**
  String get placeholder_email;

  /// No description provided for @placeholder_password.
  ///
  /// In en, this message translates to:
  /// **'********'**
  String get placeholder_password;

  /// No description provided for @dialog_location_permission.
  ///
  /// In en, this message translates to:
  /// **'Location Permission'**
  String get dialog_location_permission;

  /// No description provided for @dialog_location_services_disabled.
  ///
  /// In en, this message translates to:
  /// **'Location Services Disabled'**
  String get dialog_location_services_disabled;

  /// No description provided for @dialog_location_permission_required.
  ///
  /// In en, this message translates to:
  /// **'Location Permission Required'**
  String get dialog_location_permission_required;

  /// No description provided for @drag_to_adjust.
  ///
  /// In en, this message translates to:
  /// **'Drag to adjust position'**
  String get drag_to_adjust;

  /// No description provided for @error_enter_location_to_search.
  ///
  /// In en, this message translates to:
  /// **'Please enter a location to search'**
  String get error_enter_location_to_search;

  /// No description provided for @success_signed_up.
  ///
  /// In en, this message translates to:
  /// **'Successfully signed up'**
  String get success_signed_up;

  /// No description provided for @error_fill_all_required_fields.
  ///
  /// In en, this message translates to:
  /// **'Please fill all required fields correctly'**
  String get error_fill_all_required_fields;

  /// No description provided for @error_complete_all_required_fields.
  ///
  /// In en, this message translates to:
  /// **'Please complete all required fields'**
  String get error_complete_all_required_fields;

  /// No description provided for @error_passwords_not_match.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get error_passwords_not_match;

  /// No description provided for @merchant_step_1_description.
  ///
  /// In en, this message translates to:
  /// **'Tell us about yourself to kickstart your merchant journey!'**
  String get merchant_step_1_description;

  /// No description provided for @merchant_step_2_description.
  ///
  /// In en, this message translates to:
  /// **'Share your outlet details and location so customers can find you easily!'**
  String get merchant_step_2_description;

  /// No description provided for @merchant_step_3_description.
  ///
  /// In en, this message translates to:
  /// **'Add your bank account to receive payments securely!'**
  String get merchant_step_3_description;

  /// No description provided for @placeholder_outlet_name.
  ///
  /// In en, this message translates to:
  /// **'Enter outlet name'**
  String get placeholder_outlet_name;

  /// No description provided for @label_outlet_location.
  ///
  /// In en, this message translates to:
  /// **'Outlet\'s Location'**
  String get label_outlet_location;

  /// No description provided for @label_bank_provider.
  ///
  /// In en, this message translates to:
  /// **'Bank Provider'**
  String get label_bank_provider;

  /// No description provided for @label_outlet_category.
  ///
  /// In en, this message translates to:
  /// **'Outlet Category'**
  String get label_outlet_category;

  /// No description provided for @helper_outlet_category_select.
  ///
  /// In en, this message translates to:
  /// **'Select the main category for your outlet'**
  String get helper_outlet_category_select;

  /// No description provided for @placeholder_select_outlet_category.
  ///
  /// In en, this message translates to:
  /// **'Select outlet category'**
  String get placeholder_select_outlet_category;

  /// No description provided for @label_phone.
  ///
  /// In en, this message translates to:
  /// **'Phone'**
  String get label_phone;

  /// No description provided for @dialog_accept_order.
  ///
  /// In en, this message translates to:
  /// **'Accept Order'**
  String get dialog_accept_order;

  /// No description provided for @dialog_accept_order_confirm.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to accept this order?'**
  String get dialog_accept_order_confirm;

  /// No description provided for @toast_validation_error.
  ///
  /// In en, this message translates to:
  /// **'Validation Error'**
  String get toast_validation_error;

  /// No description provided for @error_menu_name_required.
  ///
  /// In en, this message translates to:
  /// **'Menu name is required'**
  String get error_menu_name_required;

  /// No description provided for @error_menu_price_required.
  ///
  /// In en, this message translates to:
  /// **'Menu price is required'**
  String get error_menu_price_required;

  /// No description provided for @error_valid_price_required.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid price'**
  String get error_valid_price_required;

  /// No description provided for @error_merchant_info_not_found.
  ///
  /// In en, this message translates to:
  /// **'Merchant information not found'**
  String get error_merchant_info_not_found;

  /// No description provided for @success_menu_created.
  ///
  /// In en, this message translates to:
  /// **'Menu created successfully'**
  String get success_menu_created;

  /// No description provided for @error_failed_create_menu.
  ///
  /// In en, this message translates to:
  /// **'Failed to create menu'**
  String get error_failed_create_menu;

  /// No description provided for @title_create_menu.
  ///
  /// In en, this message translates to:
  /// **'Create Menu'**
  String get title_create_menu;

  /// No description provided for @placeholder_zero.
  ///
  /// In en, this message translates to:
  /// **'0'**
  String get placeholder_zero;

  /// No description provided for @error_menu_info_not_found.
  ///
  /// In en, this message translates to:
  /// **'Menu information not found'**
  String get error_menu_info_not_found;

  /// No description provided for @title_edit_menu.
  ///
  /// In en, this message translates to:
  /// **'Edit Menu'**
  String get title_edit_menu;

  /// No description provided for @error_menu_not_found.
  ///
  /// In en, this message translates to:
  /// **'Menu not found'**
  String get error_menu_not_found;

  /// No description provided for @placeholder_search_menu.
  ///
  /// In en, this message translates to:
  /// **'Search menu...'**
  String get placeholder_search_menu;

  /// No description provided for @title_menu_detail.
  ///
  /// In en, this message translates to:
  /// **'Menu Detail'**
  String get title_menu_detail;

  /// No description provided for @dialog_delete_menu.
  ///
  /// In en, this message translates to:
  /// **'Delete Menu'**
  String get dialog_delete_menu;

  /// No description provided for @dialog_delete_menu_confirm.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete \"{name}\"?'**
  String dialog_delete_menu_confirm(String name);

  /// No description provided for @success_menu_deleted.
  ///
  /// In en, this message translates to:
  /// **'Menu deleted successfully'**
  String get success_menu_deleted;

  /// No description provided for @error_failed_delete_menu.
  ///
  /// In en, this message translates to:
  /// **'Failed to delete menu'**
  String get error_failed_delete_menu;

  /// No description provided for @label_old_password.
  ///
  /// In en, this message translates to:
  /// **'Old Password'**
  String get label_old_password;

  /// No description provided for @placeholder_enter_old_password.
  ///
  /// In en, this message translates to:
  /// **'Enter your old password'**
  String get placeholder_enter_old_password;

  /// No description provided for @label_new_password.
  ///
  /// In en, this message translates to:
  /// **'New Password'**
  String get label_new_password;

  /// No description provided for @placeholder_enter_new_password.
  ///
  /// In en, this message translates to:
  /// **'Enter your new password'**
  String get placeholder_enter_new_password;

  /// No description provided for @label_confirm_password.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get label_confirm_password;

  /// No description provided for @placeholder_confirm_new_password.
  ///
  /// In en, this message translates to:
  /// **'Confirm your new password'**
  String get placeholder_confirm_new_password;

  /// No description provided for @error_failed_verify_bank.
  ///
  /// In en, this message translates to:
  /// **'Failed to verify bank account'**
  String get error_failed_verify_bank;

  /// No description provided for @loading_map.
  ///
  /// In en, this message translates to:
  /// **'Loading map...'**
  String get loading_map;

  /// No description provided for @success_set_up_merchant.
  ///
  /// In en, this message translates to:
  /// **'Success set up merchant'**
  String get success_set_up_merchant;

  /// No description provided for @title_set_up_outlet.
  ///
  /// In en, this message translates to:
  /// **'Set Up Outlet'**
  String get title_set_up_outlet;

  /// No description provided for @placeholder_time_start.
  ///
  /// In en, this message translates to:
  /// **'10:00'**
  String get placeholder_time_start;

  /// No description provided for @placeholder_time_end.
  ///
  /// In en, this message translates to:
  /// **'22:00'**
  String get placeholder_time_end;

  /// No description provided for @title_sales_report.
  ///
  /// In en, this message translates to:
  /// **'Sales Report'**
  String get title_sales_report;

  /// No description provided for @tab_weekly_sales.
  ///
  /// In en, this message translates to:
  /// **'Weekly Sales'**
  String get tab_weekly_sales;

  /// No description provided for @tab_monthly_sales.
  ///
  /// In en, this message translates to:
  /// **'Monthly Sales'**
  String get tab_monthly_sales;

  /// No description provided for @title_commission_report.
  ///
  /// In en, this message translates to:
  /// **'Commission Report'**
  String get title_commission_report;

  /// No description provided for @title_order_detail.
  ///
  /// In en, this message translates to:
  /// **'Order Detail'**
  String get title_order_detail;

  /// No description provided for @button_add_schedule.
  ///
  /// In en, this message translates to:
  /// **'Add Schedule'**
  String get button_add_schedule;

  /// No description provided for @button_edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get button_edit;

  /// No description provided for @placeholder_class_name.
  ///
  /// In en, this message translates to:
  /// **'e.g., Mobile Programming'**
  String get placeholder_class_name;

  /// No description provided for @dialog_call_customer.
  ///
  /// In en, this message translates to:
  /// **'Call Customer'**
  String get dialog_call_customer;

  /// No description provided for @section_today_performance.
  ///
  /// In en, this message translates to:
  /// **'Today\'s Performance'**
  String get section_today_performance;

  /// No description provided for @section_quick_actions.
  ///
  /// In en, this message translates to:
  /// **'Quick Actions'**
  String get section_quick_actions;

  /// No description provided for @label_rating_suffix.
  ///
  /// In en, this message translates to:
  /// **'rating'**
  String get label_rating_suffix;

  /// No description provided for @dialog_rate_customer.
  ///
  /// In en, this message translates to:
  /// **'Rate Customer'**
  String get dialog_rate_customer;

  /// No description provided for @label_review_category.
  ///
  /// In en, this message translates to:
  /// **'Review Category'**
  String get label_review_category;

  /// No description provided for @label_comment_optional.
  ///
  /// In en, this message translates to:
  /// **'Comment (Optional)'**
  String get label_comment_optional;

  /// No description provided for @placeholder_share_experience.
  ///
  /// In en, this message translates to:
  /// **'Share your experience...'**
  String get placeholder_share_experience;

  /// No description provided for @button_submit.
  ///
  /// In en, this message translates to:
  /// **'Submit'**
  String get button_submit;

  /// No description provided for @dialog_new_order.
  ///
  /// In en, this message translates to:
  /// **'New {type} Order'**
  String dialog_new_order(String type);

  /// No description provided for @label_order_id_prefix.
  ///
  /// In en, this message translates to:
  /// **'Order #'**
  String get label_order_id_prefix;

  /// No description provided for @label_pickup.
  ///
  /// In en, this message translates to:
  /// **'Pickup'**
  String get label_pickup;

  /// No description provided for @label_dropoff.
  ///
  /// In en, this message translates to:
  /// **'Dropoff'**
  String get label_dropoff;

  /// No description provided for @label_distance.
  ///
  /// In en, this message translates to:
  /// **'Distance'**
  String get label_distance;

  /// No description provided for @label_earnings.
  ///
  /// In en, this message translates to:
  /// **'Earnings'**
  String get label_earnings;

  /// No description provided for @label_gender_preference.
  ///
  /// In en, this message translates to:
  /// **'Gender preference: {gender}'**
  String label_gender_preference(String gender);

  /// No description provided for @label_note.
  ///
  /// In en, this message translates to:
  /// **'Note:'**
  String get label_note;

  /// No description provided for @label_pickup_prefix.
  ///
  /// In en, this message translates to:
  /// **'Pickup: {location}'**
  String label_pickup_prefix(String location);

  /// No description provided for @label_dropoff_prefix.
  ///
  /// In en, this message translates to:
  /// **'Dropoff: {location}'**
  String label_dropoff_prefix(String location);

  /// No description provided for @label_instructions_prefix.
  ///
  /// In en, this message translates to:
  /// **'Instructions: {instructions}'**
  String label_instructions_prefix(String instructions);

  /// No description provided for @order_type_ride_label.
  ///
  /// In en, this message translates to:
  /// **'Ride'**
  String get order_type_ride_label;

  /// No description provided for @order_type_delivery_label.
  ///
  /// In en, this message translates to:
  /// **'Delivery'**
  String get order_type_delivery_label;

  /// No description provided for @order_type_food_label.
  ///
  /// In en, this message translates to:
  /// **'Food'**
  String get order_type_food_label;

  /// No description provided for @toast_order_unavailable.
  ///
  /// In en, this message translates to:
  /// **'Order Unavailable'**
  String get toast_order_unavailable;

  /// No description provided for @toast_order_unavailable_message.
  ///
  /// In en, this message translates to:
  /// **'This order was cancelled or accepted by another driver'**
  String get toast_order_unavailable_message;

  /// No description provided for @toast_order_rejected.
  ///
  /// In en, this message translates to:
  /// **'Order Rejected'**
  String get toast_order_rejected;

  /// No description provided for @toast_order_rejected_message.
  ///
  /// In en, this message translates to:
  /// **'You rejected the order'**
  String get toast_order_rejected_message;

  /// No description provided for @label_total_fare.
  ///
  /// In en, this message translates to:
  /// **'Total Fare'**
  String get label_total_fare;

  /// No description provided for @dialog_unsupported_payment.
  ///
  /// In en, this message translates to:
  /// **'Unsupported payment method'**
  String get dialog_unsupported_payment;

  /// No description provided for @dialog_unsupported_payment_message.
  ///
  /// In en, this message translates to:
  /// **'The selected payment method is not supported. Please choose a different method.'**
  String get dialog_unsupported_payment_message;

  /// No description provided for @label_provider.
  ///
  /// In en, this message translates to:
  /// **'Provider :'**
  String get label_provider;

  /// No description provided for @label_va_number.
  ///
  /// In en, this message translates to:
  /// **'VA Number :'**
  String get label_va_number;

  /// No description provided for @label_valid_until.
  ///
  /// In en, this message translates to:
  /// **'Valid until {date}'**
  String label_valid_until(String date);

  /// No description provided for @label_remaining_time.
  ///
  /// In en, this message translates to:
  /// **'Remaining Time :'**
  String get label_remaining_time;

  /// No description provided for @button_copy_va_number.
  ///
  /// In en, this message translates to:
  /// **'Copy VA Number'**
  String get button_copy_va_number;

  /// No description provided for @label_no_rating_yet.
  ///
  /// In en, this message translates to:
  /// **'No rating yet'**
  String get label_no_rating_yet;

  /// No description provided for @message_wait_for_driver.
  ///
  /// In en, this message translates to:
  /// **'Please wait while we match you with a driver'**
  String get message_wait_for_driver;

  /// No description provided for @label_license_plate.
  ///
  /// In en, this message translates to:
  /// **'License plate'**
  String get label_license_plate;

  /// No description provided for @status_finding_driver.
  ///
  /// In en, this message translates to:
  /// **'Finding driver'**
  String get status_finding_driver;

  /// No description provided for @status_your_driver.
  ///
  /// In en, this message translates to:
  /// **'Your driver'**
  String get status_your_driver;

  /// No description provided for @instruction_choose_pickup_destination.
  ///
  /// In en, this message translates to:
  /// **'Choose your pick-up and destination point!'**
  String get instruction_choose_pickup_destination;

  /// No description provided for @button_proceed.
  ///
  /// In en, this message translates to:
  /// **'Proceed'**
  String get button_proceed;

  /// No description provided for @placeholder_what_sending.
  ///
  /// In en, this message translates to:
  /// **'What are you sending?'**
  String get placeholder_what_sending;

  /// No description provided for @placeholder_enter_weight.
  ///
  /// In en, this message translates to:
  /// **'Enter weight in kg (max 20kg)'**
  String get placeholder_enter_weight;

  /// No description provided for @helper_special_instructions.
  ///
  /// In en, this message translates to:
  /// **'Add any special handling or delivery instructions'**
  String get helper_special_instructions;

  /// No description provided for @helper_add_photos.
  ///
  /// In en, this message translates to:
  /// **'Add up to 3 photos of the item'**
  String get helper_add_photos;

  /// No description provided for @error_provide_item_description.
  ///
  /// In en, this message translates to:
  /// **'Please provide item description'**
  String get error_provide_item_description;

  /// No description provided for @error_no_estimate_available.
  ///
  /// In en, this message translates to:
  /// **'No estimate available'**
  String get error_no_estimate_available;

  /// No description provided for @button_choose_payment_method.
  ///
  /// In en, this message translates to:
  /// **'Choose Payment Method'**
  String get button_choose_payment_method;

  /// No description provided for @button_place_order.
  ///
  /// In en, this message translates to:
  /// **'Place Order'**
  String get button_place_order;

  /// No description provided for @label_photo_profile.
  ///
  /// In en, this message translates to:
  /// **'Photo Profile'**
  String get label_photo_profile;

  /// No description provided for @label_name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get label_name;

  /// No description provided for @label_email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get label_email;

  /// No description provided for @section_achievements.
  ///
  /// In en, this message translates to:
  /// **'Achievements'**
  String get section_achievements;

  /// No description provided for @button_rate_this_order.
  ///
  /// In en, this message translates to:
  /// **'Rate this order'**
  String get button_rate_this_order;

  /// No description provided for @empty_no_order_history.
  ///
  /// In en, this message translates to:
  /// **'No order history found'**
  String get empty_no_order_history;

  /// No description provided for @label_your_current_location.
  ///
  /// In en, this message translates to:
  /// **'Your current location'**
  String get label_your_current_location;

  /// No description provided for @label_drivers_around.
  ///
  /// In en, this message translates to:
  /// **'There are {count} drivers around you'**
  String label_drivers_around(int count);

  /// No description provided for @error_failed_load_mart.
  ///
  /// In en, this message translates to:
  /// **'Failed to load mart data'**
  String get error_failed_load_mart;

  /// No description provided for @error_failed_load_merchants.
  ///
  /// In en, this message translates to:
  /// **'Failed to load merchants'**
  String get error_failed_load_merchants;

  /// No description provided for @empty_no_merchants_found.
  ///
  /// In en, this message translates to:
  /// **'No merchants found'**
  String get empty_no_merchants_found;

  /// No description provided for @button_select_via_map.
  ///
  /// In en, this message translates to:
  /// **'Select via map'**
  String get button_select_via_map;

  /// No description provided for @error_no_place_found.
  ///
  /// In en, this message translates to:
  /// **'No place found'**
  String get error_no_place_found;

  /// No description provided for @title_select_bank_provider.
  ///
  /// In en, this message translates to:
  /// **'Select Bank Provider'**
  String get title_select_bank_provider;

  /// No description provided for @payment_akademove_pay.
  ///
  /// In en, this message translates to:
  /// **'Akademove Pay'**
  String get payment_akademove_pay;

  /// No description provided for @button_download_qr.
  ///
  /// In en, this message translates to:
  /// **'Download QR'**
  String get button_download_qr;

  /// No description provided for @button_copy_qr_url.
  ///
  /// In en, this message translates to:
  /// **'Copy QR URL'**
  String get button_copy_qr_url;

  /// No description provided for @separator_colon.
  ///
  /// In en, this message translates to:
  /// **':'**
  String get separator_colon;

  /// No description provided for @placeholder_type_message.
  ///
  /// In en, this message translates to:
  /// **'Type a message...'**
  String get placeholder_type_message;

  /// No description provided for @tab_on_process.
  ///
  /// In en, this message translates to:
  /// **'On process'**
  String get tab_on_process;

  /// No description provided for @tab_completed.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get tab_completed;

  /// No description provided for @tab_canceled.
  ///
  /// In en, this message translates to:
  /// **'Canceled'**
  String get tab_canceled;

  /// No description provided for @start_preparing.
  ///
  /// In en, this message translates to:
  /// **'Start Preparing'**
  String get start_preparing;

  /// No description provided for @order_ready.
  ///
  /// In en, this message translates to:
  /// **'Order Ready'**
  String get order_ready;

  /// No description provided for @waiting_for_driver_pickup.
  ///
  /// In en, this message translates to:
  /// **'Waiting for driver to pickup...'**
  String get waiting_for_driver_pickup;

  /// No description provided for @no_menu_items_yet.
  ///
  /// In en, this message translates to:
  /// **'No menu items yet. Tap + to add your first item.'**
  String get no_menu_items_yet;

  /// No description provided for @no_menu_items_found.
  ///
  /// In en, this message translates to:
  /// **'No menu items found for \"{query}\"'**
  String no_menu_items_found(String query);

  /// No description provided for @placeholder_search_menu_hint.
  ///
  /// In en, this message translates to:
  /// **'Search menu...'**
  String get placeholder_search_menu_hint;

  /// No description provided for @label_menu_name.
  ///
  /// In en, this message translates to:
  /// **'Menu Name'**
  String get label_menu_name;

  /// No description provided for @label_menu_price.
  ///
  /// In en, this message translates to:
  /// **'Menu Price'**
  String get label_menu_price;

  /// No description provided for @label_menu_stock.
  ///
  /// In en, this message translates to:
  /// **'Menu Stock'**
  String get label_menu_stock;

  /// No description provided for @label_menu_category.
  ///
  /// In en, this message translates to:
  /// **'Menu Category'**
  String get label_menu_category;

  /// No description provided for @label_menu_photo.
  ///
  /// In en, this message translates to:
  /// **'Menu Photo'**
  String get label_menu_photo;

  /// No description provided for @placeholder_menu_name.
  ///
  /// In en, this message translates to:
  /// **'Enter menu name'**
  String get placeholder_menu_name;

  /// No description provided for @placeholder_menu_price.
  ///
  /// In en, this message translates to:
  /// **'Enter price'**
  String get placeholder_menu_price;

  /// No description provided for @label_category.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get label_category;

  /// No description provided for @label_price.
  ///
  /// In en, this message translates to:
  /// **'Price'**
  String get label_price;

  /// No description provided for @label_stock.
  ///
  /// In en, this message translates to:
  /// **'Stock'**
  String get label_stock;

  /// No description provided for @label_created.
  ///
  /// In en, this message translates to:
  /// **'Created'**
  String get label_created;

  /// No description provided for @label_updated.
  ///
  /// In en, this message translates to:
  /// **'Updated'**
  String get label_updated;

  /// No description provided for @placeholder_select_category.
  ///
  /// In en, this message translates to:
  /// **'Select category'**
  String get placeholder_select_category;

  /// No description provided for @error_validation.
  ///
  /// In en, this message translates to:
  /// **'Validation Error'**
  String get error_validation;

  /// No description provided for @title_privacy_policies.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policies'**
  String get title_privacy_policies;

  /// No description provided for @ordered_by.
  ///
  /// In en, this message translates to:
  /// **'Ordered by'**
  String get ordered_by;

  /// No description provided for @driver_assigned.
  ///
  /// In en, this message translates to:
  /// **'Driver assigned'**
  String get driver_assigned;

  /// No description provided for @order_items.
  ///
  /// In en, this message translates to:
  /// **'Order Items'**
  String get order_items;

  /// No description provided for @base_price.
  ///
  /// In en, this message translates to:
  /// **'Base Price'**
  String get base_price;

  /// No description provided for @order_time.
  ///
  /// In en, this message translates to:
  /// **'Order Time'**
  String get order_time;

  /// No description provided for @order_chat.
  ///
  /// In en, this message translates to:
  /// **'Order Chat'**
  String get order_chat;

  /// No description provided for @toast_order_accepted.
  ///
  /// In en, this message translates to:
  /// **'Order accepted successfully'**
  String get toast_order_accepted;

  /// No description provided for @toast_order_rejected_success.
  ///
  /// In en, this message translates to:
  /// **'Order rejected successfully'**
  String get toast_order_rejected_success;

  /// No description provided for @toast_order_marked_preparing.
  ///
  /// In en, this message translates to:
  /// **'Order marked as preparing'**
  String get toast_order_marked_preparing;

  /// No description provided for @toast_order_marked_ready.
  ///
  /// In en, this message translates to:
  /// **'Order marked as ready for pickup'**
  String get toast_order_marked_ready;

  /// No description provided for @toast_failed_accept_order.
  ///
  /// In en, this message translates to:
  /// **'Failed to accept order'**
  String get toast_failed_accept_order;

  /// No description provided for @toast_failed_reject_order.
  ///
  /// In en, this message translates to:
  /// **'Failed to reject order'**
  String get toast_failed_reject_order;

  /// No description provided for @toast_failed_update_order.
  ///
  /// In en, this message translates to:
  /// **'Failed to update order'**
  String get toast_failed_update_order;

  /// No description provided for @toast_merchant_id_not_found.
  ///
  /// In en, this message translates to:
  /// **'Merchant ID not found'**
  String get toast_merchant_id_not_found;

  /// No description provided for @unknown_item.
  ///
  /// In en, this message translates to:
  /// **'Unknown Item'**
  String get unknown_item;

  /// No description provided for @label_status.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get label_status;

  /// No description provided for @label_wib.
  ///
  /// In en, this message translates to:
  /// **'WIB'**
  String get label_wib;

  /// No description provided for @error_valid_price.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid price'**
  String get error_valid_price;

  /// No description provided for @toast_menu_created_success.
  ///
  /// In en, this message translates to:
  /// **'Menu created successfully'**
  String get toast_menu_created_success;

  /// No description provided for @toast_failed_create_menu.
  ///
  /// In en, this message translates to:
  /// **'Failed to create menu'**
  String get toast_failed_create_menu;

  /// No description provided for @toast_menu_updated_success.
  ///
  /// In en, this message translates to:
  /// **'Menu updated successfully'**
  String get toast_menu_updated_success;

  /// No description provided for @toast_failed_update_menu.
  ///
  /// In en, this message translates to:
  /// **'Failed to update menu'**
  String get toast_failed_update_menu;

  /// No description provided for @button_create_menu.
  ///
  /// In en, this message translates to:
  /// **'Create Menu'**
  String get button_create_menu;

  /// No description provided for @button_create.
  ///
  /// In en, this message translates to:
  /// **'Create'**
  String get button_create;

  /// No description provided for @label_menu_description.
  ///
  /// In en, this message translates to:
  /// **'Menu Description'**
  String get label_menu_description;

  /// No description provided for @placeholder_menu_description.
  ///
  /// In en, this message translates to:
  /// **'Combined coffee and brown sugar'**
  String get placeholder_menu_description;

  /// No description provided for @placeholder_menu_category.
  ///
  /// In en, this message translates to:
  /// **'Drink'**
  String get placeholder_menu_category;

  /// No description provided for @label_menu_photo_optional.
  ///
  /// In en, this message translates to:
  /// **'Menu Photo (Optional)'**
  String get label_menu_photo_optional;

  /// No description provided for @title_edit_profile.
  ///
  /// In en, this message translates to:
  /// **'Edit Profile'**
  String get title_edit_profile;

  /// No description provided for @label_owner_name.
  ///
  /// In en, this message translates to:
  /// **'Owner\'s Name'**
  String get label_owner_name;

  /// No description provided for @placeholder_owner_name.
  ///
  /// In en, this message translates to:
  /// **'Enter owner name'**
  String get placeholder_owner_name;

  /// No description provided for @label_owner_email.
  ///
  /// In en, this message translates to:
  /// **'Owner\'s Email'**
  String get label_owner_email;

  /// No description provided for @placeholder_owner_email.
  ///
  /// In en, this message translates to:
  /// **'Enter owner email'**
  String get placeholder_owner_email;

  /// No description provided for @label_owner_phone.
  ///
  /// In en, this message translates to:
  /// **'Owner\'s Phone Number'**
  String get label_owner_phone;

  /// No description provided for @label_outlet_name.
  ///
  /// In en, this message translates to:
  /// **'Outlet\'s Name'**
  String get label_outlet_name;

  /// No description provided for @label_outlet_phone.
  ///
  /// In en, this message translates to:
  /// **'Outlet\'s Phone Number'**
  String get label_outlet_phone;

  /// No description provided for @label_outlet_email.
  ///
  /// In en, this message translates to:
  /// **'Outlet\'s Email'**
  String get label_outlet_email;

  /// No description provided for @placeholder_outlet_email.
  ///
  /// In en, this message translates to:
  /// **'Enter outlet email'**
  String get placeholder_outlet_email;

  /// No description provided for @label_outlet_document.
  ///
  /// In en, this message translates to:
  /// **'Outlet\'s Document (Optional)'**
  String get label_outlet_document;

  /// No description provided for @label_choose_bank.
  ///
  /// In en, this message translates to:
  /// **'Choose bank'**
  String get label_choose_bank;

  /// No description provided for @placeholder_select_bank_provider.
  ///
  /// In en, this message translates to:
  /// **'Select bank provider'**
  String get placeholder_select_bank_provider;

  /// No description provided for @label_bank_account.
  ///
  /// In en, this message translates to:
  /// **'Bank Account'**
  String get label_bank_account;

  /// No description provided for @placeholder_bank_account.
  ///
  /// In en, this message translates to:
  /// **'********1234'**
  String get placeholder_bank_account;

  /// No description provided for @toast_location_permission.
  ///
  /// In en, this message translates to:
  /// **'Location Permission'**
  String get toast_location_permission;

  /// No description provided for @toast_using_default_location.
  ///
  /// In en, this message translates to:
  /// **'Using default location. You can drag the marker to set your outlet location.'**
  String get toast_using_default_location;

  /// No description provided for @dialog_location_permission_title.
  ///
  /// In en, this message translates to:
  /// **'Location Permission'**
  String get dialog_location_permission_title;

  /// No description provided for @dialog_location_permission_message.
  ///
  /// In en, this message translates to:
  /// **'We need access to your location to automatically set your outlet location on the map. This helps customers find your business easily. You can also manually set the location by dragging the marker.'**
  String get dialog_location_permission_message;

  /// No description provided for @dialog_location_services_disabled_title.
  ///
  /// In en, this message translates to:
  /// **'Location Services Disabled'**
  String get dialog_location_services_disabled_title;

  /// No description provided for @dialog_location_services_disabled_message.
  ///
  /// In en, this message translates to:
  /// **'Location services are currently disabled on your device. Please enable them to automatically detect your outlet location.'**
  String get dialog_location_services_disabled_message;

  /// No description provided for @dialog_location_permission_required_title.
  ///
  /// In en, this message translates to:
  /// **'Location Permission Required'**
  String get dialog_location_permission_required_title;

  /// No description provided for @dialog_location_permission_required_message.
  ///
  /// In en, this message translates to:
  /// **'Location permission has been permanently denied. To use automatic location detection, please enable it in your app settings.\n\nYou can still manually set your outlet location by dragging the marker on the map.'**
  String get dialog_location_permission_required_message;

  /// No description provided for @label_outlet_location_description.
  ///
  /// In en, this message translates to:
  /// **'Make sure the location point on the map is correct to meet the registration requirements.'**
  String get label_outlet_location_description;

  /// No description provided for @placeholder_search_location.
  ///
  /// In en, this message translates to:
  /// **'Search location'**
  String get placeholder_search_location;

  /// No description provided for @label_dragging.
  ///
  /// In en, this message translates to:
  /// **'Dragging...'**
  String get label_dragging;

  /// No description provided for @toast_location_found.
  ///
  /// In en, this message translates to:
  /// **'Location Found'**
  String get toast_location_found;

  /// No description provided for @toast_marker_moved.
  ///
  /// In en, this message translates to:
  /// **'Marker moved to searched location'**
  String get toast_marker_moved;

  /// No description provided for @toast_not_found.
  ///
  /// In en, this message translates to:
  /// **'Not Found'**
  String get toast_not_found;

  /// No description provided for @toast_location_not_found.
  ///
  /// In en, this message translates to:
  /// **'Location not found. Please try a different search.'**
  String get toast_location_not_found;

  /// No description provided for @toast_search_error.
  ///
  /// In en, this message translates to:
  /// **'Search Error'**
  String get toast_search_error;

  /// No description provided for @toast_search_error_message.
  ///
  /// In en, this message translates to:
  /// **'Unable to search location. Please check your internet connection.'**
  String get toast_search_error_message;

  /// No description provided for @toast_enter_location.
  ///
  /// In en, this message translates to:
  /// **'Please enter a location to search'**
  String get toast_enter_location;

  /// No description provided for @label_benchmark_optional.
  ///
  /// In en, this message translates to:
  /// **'Benchmark (Optional)'**
  String get label_benchmark_optional;

  /// No description provided for @placeholder_benchmark.
  ///
  /// In en, this message translates to:
  /// **'Next to the Uniqlo store.'**
  String get placeholder_benchmark;

  /// No description provided for @toast_bank_account_verified.
  ///
  /// In en, this message translates to:
  /// **'Bank account verified successfully'**
  String get toast_bank_account_verified;

  /// No description provided for @toast_failed_verify_bank.
  ///
  /// In en, this message translates to:
  /// **'Failed to verify bank account'**
  String get toast_failed_verify_bank;

  /// No description provided for @toast_enter_bank_account.
  ///
  /// In en, this message translates to:
  /// **'Please enter bank account number'**
  String get toast_enter_bank_account;

  /// No description provided for @toast_bank_account_min_digits.
  ///
  /// In en, this message translates to:
  /// **'Bank account number must be at least 5 digits'**
  String get toast_bank_account_min_digits;

  /// No description provided for @toast_select_bank_first.
  ///
  /// In en, this message translates to:
  /// **'Please select a bank provider first'**
  String get toast_select_bank_first;

  /// No description provided for @label_bank_account_number.
  ///
  /// In en, this message translates to:
  /// **'Bank Account Number'**
  String get label_bank_account_number;

  /// No description provided for @label_account_holder_name.
  ///
  /// In en, this message translates to:
  /// **'Account Holder\'s Name'**
  String get label_account_holder_name;

  /// No description provided for @label_owner_bank_name.
  ///
  /// In en, this message translates to:
  /// **'Owner\'s Name'**
  String get label_owner_bank_name;

  /// No description provided for @label_unable_get_address.
  ///
  /// In en, this message translates to:
  /// **'Unable to get address'**
  String get label_unable_get_address;

  /// No description provided for @label_step_1.
  ///
  /// In en, this message translates to:
  /// **'Step 1'**
  String get label_step_1;

  /// No description provided for @label_step_2.
  ///
  /// In en, this message translates to:
  /// **'Step 2'**
  String get label_step_2;

  /// No description provided for @label_step_3.
  ///
  /// In en, this message translates to:
  /// **'Step 3'**
  String get label_step_3;

  /// No description provided for @label_outlet_photo_profile.
  ///
  /// In en, this message translates to:
  /// **'Outlet Photo Profile'**
  String get label_outlet_photo_profile;

  /// No description provided for @placeholder_outlet_category.
  ///
  /// In en, this message translates to:
  /// **'Pick your outlet category'**
  String get placeholder_outlet_category;

  /// No description provided for @label_outlet_operating_hours.
  ///
  /// In en, this message translates to:
  /// **'Outlet Operating Hours'**
  String get label_outlet_operating_hours;

  /// No description provided for @label_24_hours.
  ///
  /// In en, this message translates to:
  /// **'24 Hours'**
  String get label_24_hours;

  /// No description provided for @toast_success_set_up.
  ///
  /// In en, this message translates to:
  /// **'Success set up merchant'**
  String get toast_success_set_up;

  /// No description provided for @toast_complete_required_fields.
  ///
  /// In en, this message translates to:
  /// **'Please complete all required fields'**
  String get toast_complete_required_fields;

  /// No description provided for @error_outlet_photo_required.
  ///
  /// In en, this message translates to:
  /// **'Outlet photo is required'**
  String get error_outlet_photo_required;

  /// No description provided for @error_menu_photo_required.
  ///
  /// In en, this message translates to:
  /// **'Menu photo is required'**
  String get error_menu_photo_required;

  /// No description provided for @label_weekly_sales.
  ///
  /// In en, this message translates to:
  /// **'Weekly Sales'**
  String get label_weekly_sales;

  /// No description provided for @label_monthly_sales.
  ///
  /// In en, this message translates to:
  /// **'Monthly Sales'**
  String get label_monthly_sales;

  /// No description provided for @label_earns.
  ///
  /// In en, this message translates to:
  /// **'Earns'**
  String get label_earns;

  /// No description provided for @label_top_ordered_categories.
  ///
  /// In en, this message translates to:
  /// **'Top Ordered Categories'**
  String get label_top_ordered_categories;

  /// No description provided for @label_top_ordered_products.
  ///
  /// In en, this message translates to:
  /// **'Top Ordered Products'**
  String get label_top_ordered_products;

  /// No description provided for @button_export_pdf.
  ///
  /// In en, this message translates to:
  /// **'Export to PDF'**
  String get button_export_pdf;

  /// No description provided for @category_junk_food.
  ///
  /// In en, this message translates to:
  /// **'Junk Food'**
  String get category_junk_food;

  /// No description provided for @category_drinks.
  ///
  /// In en, this message translates to:
  /// **'Drinks'**
  String get category_drinks;

  /// No description provided for @category_snack.
  ///
  /// In en, this message translates to:
  /// **'Snack'**
  String get category_snack;

  /// No description provided for @product_fried_chicken.
  ///
  /// In en, this message translates to:
  /// **'Fried Chicken'**
  String get product_fried_chicken;

  /// No description provided for @product_coffee_latte.
  ///
  /// In en, this message translates to:
  /// **'Coffee Latte'**
  String get product_coffee_latte;

  /// No description provided for @product_laundry_express.
  ///
  /// In en, this message translates to:
  /// **'Laundry Express'**
  String get product_laundry_express;

  /// No description provided for @label_incoming_balance.
  ///
  /// In en, this message translates to:
  /// **'Incoming Balance'**
  String get label_incoming_balance;

  /// No description provided for @label_outgoing_balance.
  ///
  /// In en, this message translates to:
  /// **'Outgoing Balance'**
  String get label_outgoing_balance;

  /// No description provided for @label_balance_detail.
  ///
  /// In en, this message translates to:
  /// **'Balance Detail'**
  String get label_balance_detail;

  /// No description provided for @label_gross_sales.
  ///
  /// In en, this message translates to:
  /// **'Gross Sales'**
  String get label_gross_sales;

  /// No description provided for @label_platform_commission.
  ///
  /// In en, this message translates to:
  /// **'Platform Commission (20%)'**
  String get label_platform_commission;

  /// No description provided for @label_net_income.
  ///
  /// In en, this message translates to:
  /// **'Net Income'**
  String get label_net_income;

  /// No description provided for @label_nett_income.
  ///
  /// In en, this message translates to:
  /// **'Nett Income'**
  String get label_nett_income;

  /// No description provided for @title_change_password.
  ///
  /// In en, this message translates to:
  /// **'Change Password'**
  String get title_change_password;

  /// No description provided for @placeholder_old_password.
  ///
  /// In en, this message translates to:
  /// **'Enter your old password'**
  String get placeholder_old_password;

  /// No description provided for @placeholder_new_password.
  ///
  /// In en, this message translates to:
  /// **'Enter your new password'**
  String get placeholder_new_password;

  /// No description provided for @placeholder_confirm_password.
  ///
  /// In en, this message translates to:
  /// **'********'**
  String get placeholder_confirm_password;

  /// No description provided for @button_next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get button_next;

  /// No description provided for @button_back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get button_back;

  /// No description provided for @button_save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get button_save;

  /// No description provided for @label_start.
  ///
  /// In en, this message translates to:
  /// **'Start'**
  String get label_start;

  /// No description provided for @label_end.
  ///
  /// In en, this message translates to:
  /// **'End'**
  String get label_end;

  /// No description provided for @placeholder_start_time.
  ///
  /// In en, this message translates to:
  /// **'10:00'**
  String get placeholder_start_time;

  /// No description provided for @placeholder_end_time.
  ///
  /// In en, this message translates to:
  /// **'22:00'**
  String get placeholder_end_time;

  /// No description provided for @day_monday.
  ///
  /// In en, this message translates to:
  /// **'Monday'**
  String get day_monday;

  /// No description provided for @day_tuesday.
  ///
  /// In en, this message translates to:
  /// **'Tuesday'**
  String get day_tuesday;

  /// No description provided for @day_wednesday.
  ///
  /// In en, this message translates to:
  /// **'Wednesday'**
  String get day_wednesday;

  /// No description provided for @day_thursday.
  ///
  /// In en, this message translates to:
  /// **'Thursday'**
  String get day_thursday;

  /// No description provided for @day_friday.
  ///
  /// In en, this message translates to:
  /// **'Friday'**
  String get day_friday;

  /// No description provided for @day_saturday.
  ///
  /// In en, this message translates to:
  /// **'Saturday'**
  String get day_saturday;

  /// No description provided for @day_sunday.
  ///
  /// In en, this message translates to:
  /// **'Sunday'**
  String get day_sunday;

  /// No description provided for @toast_success.
  ///
  /// In en, this message translates to:
  /// **'Success'**
  String get toast_success;

  /// No description provided for @toast_success_set_up_merchant.
  ///
  /// In en, this message translates to:
  /// **'Success set up merchant'**
  String get toast_success_set_up_merchant;

  /// No description provided for @outlet_category_restaurant.
  ///
  /// In en, this message translates to:
  /// **'Restaurant'**
  String get outlet_category_restaurant;

  /// No description provided for @outlet_category_cafe.
  ///
  /// In en, this message translates to:
  /// **'Cafe'**
  String get outlet_category_cafe;

  /// No description provided for @outlet_category_fast_food.
  ///
  /// In en, this message translates to:
  /// **'Fast Food'**
  String get outlet_category_fast_food;

  /// No description provided for @outlet_category_bakery.
  ///
  /// In en, this message translates to:
  /// **'Bakery'**
  String get outlet_category_bakery;

  /// No description provided for @outlet_category_street_food.
  ///
  /// In en, this message translates to:
  /// **'Street Food'**
  String get outlet_category_street_food;

  /// No description provided for @outlet_category_food_truck.
  ///
  /// In en, this message translates to:
  /// **'Food Truck'**
  String get outlet_category_food_truck;

  /// No description provided for @outlet_category_bar.
  ///
  /// In en, this message translates to:
  /// **'Bar'**
  String get outlet_category_bar;

  /// No description provided for @outlet_category_coffeeshop.
  ///
  /// In en, this message translates to:
  /// **'Coffee Shop'**
  String get outlet_category_coffeeshop;

  /// No description provided for @outlet_category_dessert_shop.
  ///
  /// In en, this message translates to:
  /// **'Dessert Shop'**
  String get outlet_category_dessert_shop;

  /// No description provided for @outlet_category_juice_bar.
  ///
  /// In en, this message translates to:
  /// **'Juice Bar'**
  String get outlet_category_juice_bar;

  /// No description provided for @menu_category_appetizer.
  ///
  /// In en, this message translates to:
  /// **'Appetizer'**
  String get menu_category_appetizer;

  /// No description provided for @menu_category_main_course.
  ///
  /// In en, this message translates to:
  /// **'Main Course'**
  String get menu_category_main_course;

  /// No description provided for @menu_category_dessert.
  ///
  /// In en, this message translates to:
  /// **'Dessert'**
  String get menu_category_dessert;

  /// No description provided for @menu_category_beverage.
  ///
  /// In en, this message translates to:
  /// **'Beverage'**
  String get menu_category_beverage;

  /// No description provided for @menu_category_snack.
  ///
  /// In en, this message translates to:
  /// **'Snack'**
  String get menu_category_snack;

  /// No description provided for @menu_category_breakfast.
  ///
  /// In en, this message translates to:
  /// **'Breakfast'**
  String get menu_category_breakfast;

  /// No description provided for @menu_category_lunch.
  ///
  /// In en, this message translates to:
  /// **'Lunch'**
  String get menu_category_lunch;

  /// No description provided for @menu_category_dinner.
  ///
  /// In en, this message translates to:
  /// **'Dinner'**
  String get menu_category_dinner;

  /// No description provided for @menu_category_salad.
  ///
  /// In en, this message translates to:
  /// **'Salad'**
  String get menu_category_salad;

  /// No description provided for @menu_category_soup.
  ///
  /// In en, this message translates to:
  /// **'Soup'**
  String get menu_category_soup;

  /// No description provided for @menu_category_seafood.
  ///
  /// In en, this message translates to:
  /// **'Seafood'**
  String get menu_category_seafood;

  /// No description provided for @menu_category_vegetarian.
  ///
  /// In en, this message translates to:
  /// **'Vegetarian'**
  String get menu_category_vegetarian;

  /// No description provided for @menu_category_vegan.
  ///
  /// In en, this message translates to:
  /// **'Vegan'**
  String get menu_category_vegan;

  /// No description provided for @menu_category_pasta.
  ///
  /// In en, this message translates to:
  /// **'Pasta'**
  String get menu_category_pasta;

  /// No description provided for @menu_category_pizza.
  ///
  /// In en, this message translates to:
  /// **'Pizza'**
  String get menu_category_pizza;

  /// No description provided for @menu_category_burger.
  ///
  /// In en, this message translates to:
  /// **'Burger'**
  String get menu_category_burger;

  /// No description provided for @menu_category_sandwich.
  ///
  /// In en, this message translates to:
  /// **'Sandwich'**
  String get menu_category_sandwich;

  /// No description provided for @menu_category_rice.
  ///
  /// In en, this message translates to:
  /// **'Rice'**
  String get menu_category_rice;

  /// No description provided for @menu_category_noodle.
  ///
  /// In en, this message translates to:
  /// **'Noodle'**
  String get menu_category_noodle;

  /// No description provided for @menu_category_grill.
  ///
  /// In en, this message translates to:
  /// **'Grill'**
  String get menu_category_grill;

  /// No description provided for @title_delivery.
  ///
  /// In en, this message translates to:
  /// **'Delivery'**
  String get title_delivery;

  /// No description provided for @title_where_you_at.
  ///
  /// In en, this message translates to:
  /// **'Where you at?'**
  String get title_where_you_at;

  /// No description provided for @title_where_are_you_going.
  ///
  /// In en, this message translates to:
  /// **'Where are you going?'**
  String get title_where_are_you_going;

  /// No description provided for @text_choose_pickup_destination.
  ///
  /// In en, this message translates to:
  /// **'Choose your pick-up and destination point!'**
  String get text_choose_pickup_destination;

  /// No description provided for @toast_failed_estimate_order.
  ///
  /// In en, this message translates to:
  /// **'Failed to estimate order'**
  String get toast_failed_estimate_order;

  /// No description provided for @marker_pickup.
  ///
  /// In en, this message translates to:
  /// **'Pickup'**
  String get marker_pickup;

  /// No description provided for @marker_dropoff.
  ///
  /// In en, this message translates to:
  /// **'Dropoff'**
  String get marker_dropoff;

  /// No description provided for @title_order_summary.
  ///
  /// In en, this message translates to:
  /// **'Order Summary'**
  String get title_order_summary;

  /// No description provided for @text_no_estimate_available.
  ///
  /// In en, this message translates to:
  /// **'No estimate available'**
  String get text_no_estimate_available;

  /// No description provided for @label_delivery_details.
  ///
  /// In en, this message translates to:
  /// **'Delivery Details'**
  String get label_delivery_details;

  /// No description provided for @label_from.
  ///
  /// In en, this message translates to:
  /// **'From'**
  String get label_from;

  /// No description provided for @label_to.
  ///
  /// In en, this message translates to:
  /// **'To'**
  String get label_to;

  /// No description provided for @label_item.
  ///
  /// In en, this message translates to:
  /// **'Item'**
  String get label_item;

  /// No description provided for @label_weight.
  ///
  /// In en, this message translates to:
  /// **'Weight'**
  String get label_weight;

  /// No description provided for @label_instructions.
  ///
  /// In en, this message translates to:
  /// **'Instructions'**
  String get label_instructions;

  /// No description provided for @button_apply_coupon.
  ///
  /// In en, this message translates to:
  /// **'Apply Coupon'**
  String get button_apply_coupon;

  /// No description provided for @text_coupon.
  ///
  /// In en, this message translates to:
  /// **'Coupon'**
  String get text_coupon;

  /// No description provided for @label_price_breakdown.
  ///
  /// In en, this message translates to:
  /// **'Price Breakdown'**
  String get label_price_breakdown;

  /// No description provided for @label_base_fare.
  ///
  /// In en, this message translates to:
  /// **'Base Fare'**
  String get label_base_fare;

  /// No description provided for @label_distance_fare.
  ///
  /// In en, this message translates to:
  /// **'Distance Fare'**
  String get label_distance_fare;

  /// No description provided for @label_subtotal.
  ///
  /// In en, this message translates to:
  /// **'Subtotal'**
  String get label_subtotal;

  /// No description provided for @label_discount.
  ///
  /// In en, this message translates to:
  /// **'Discount'**
  String get label_discount;

  /// No description provided for @label_total.
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get label_total;

  /// No description provided for @title_payment_method.
  ///
  /// In en, this message translates to:
  /// **'Payment Method'**
  String get title_payment_method;

  /// No description provided for @toast_failed_place_order.
  ///
  /// In en, this message translates to:
  /// **'Failed to place order'**
  String get toast_failed_place_order;

  /// No description provided for @toast_delivery_order_placed.
  ///
  /// In en, this message translates to:
  /// **'Delivery order placed successfully'**
  String get toast_delivery_order_placed;

  /// No description provided for @title_ride.
  ///
  /// In en, this message translates to:
  /// **'Ride'**
  String get title_ride;

  /// No description provided for @title_trip_details.
  ///
  /// In en, this message translates to:
  /// **'Trip Details'**
  String get title_trip_details;

  /// No description provided for @toast_wallet_payment_failed.
  ///
  /// In en, this message translates to:
  /// **'Wallet payment failed'**
  String get toast_wallet_payment_failed;

  /// No description provided for @title_ride_payment.
  ///
  /// In en, this message translates to:
  /// **'Ride Payment'**
  String get title_ride_payment;

  /// No description provided for @text_unsupported_payment_method.
  ///
  /// In en, this message translates to:
  /// **'Unsupported payment method'**
  String get text_unsupported_payment_method;

  /// No description provided for @text_valid_until.
  ///
  /// In en, this message translates to:
  /// **'Valid until'**
  String get text_valid_until;

  /// No description provided for @label_confirm_new_password.
  ///
  /// In en, this message translates to:
  /// **'Confirm New Password'**
  String get label_confirm_new_password;

  /// No description provided for @text_rate_this_order.
  ///
  /// In en, this message translates to:
  /// **'Rate this order'**
  String get text_rate_this_order;

  /// No description provided for @text_driver.
  ///
  /// In en, this message translates to:
  /// **'Driver'**
  String get text_driver;

  /// No description provided for @button_save_changes.
  ///
  /// In en, this message translates to:
  /// **'Save Changes'**
  String get button_save_changes;

  /// No description provided for @text_thank_you_rating.
  ///
  /// In en, this message translates to:
  /// **'Thank you for your rating!'**
  String get text_thank_you_rating;

  /// No description provided for @label_achievements.
  ///
  /// In en, this message translates to:
  /// **'Achievements'**
  String get label_achievements;

  /// No description provided for @text_earned_at.
  ///
  /// In en, this message translates to:
  /// **'Earned at'**
  String get text_earned_at;

  /// No description provided for @text_all.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get text_all;

  /// No description provided for @toast_failed_load_merchants.
  ///
  /// In en, this message translates to:
  /// **'Failed to load merchants'**
  String get toast_failed_load_merchants;

  /// No description provided for @text_no_merchants_found.
  ///
  /// In en, this message translates to:
  /// **'No merchants found'**
  String get text_no_merchants_found;

  /// No description provided for @text_try_different_category.
  ///
  /// In en, this message translates to:
  /// **'Try selecting a different category'**
  String get text_try_different_category;

  /// No description provided for @text_open.
  ///
  /// In en, this message translates to:
  /// **'Open'**
  String get text_open;

  /// No description provided for @text_closed.
  ///
  /// In en, this message translates to:
  /// **'Closed'**
  String get text_closed;

  /// No description provided for @toast_failed_load_mart_data.
  ///
  /// In en, this message translates to:
  /// **'Failed to load mart data'**
  String get toast_failed_load_mart_data;

  /// No description provided for @label_categories.
  ///
  /// In en, this message translates to:
  /// **'Categories'**
  String get label_categories;

  /// No description provided for @label_recent_orders.
  ///
  /// In en, this message translates to:
  /// **'Recent Orders'**
  String get label_recent_orders;

  /// No description provided for @button_view_all.
  ///
  /// In en, this message translates to:
  /// **'View All'**
  String get button_view_all;

  /// No description provided for @label_best_sellers.
  ///
  /// In en, this message translates to:
  /// **'Best Sellers'**
  String get label_best_sellers;

  /// No description provided for @text_rating.
  ///
  /// In en, this message translates to:
  /// **'Rating'**
  String get text_rating;

  /// No description provided for @text_no_rating_yet.
  ///
  /// In en, this message translates to:
  /// **'No rating yet'**
  String get text_no_rating_yet;

  /// No description provided for @label_nearby_drivers.
  ///
  /// In en, this message translates to:
  /// **'Nearby drivers'**
  String get label_nearby_drivers;

  /// No description provided for @text_your_current_location.
  ///
  /// In en, this message translates to:
  /// **'Your current location'**
  String get text_your_current_location;

  /// No description provided for @item_count.
  ///
  /// In en, this message translates to:
  /// **'{count} item(s)'**
  String item_count(Object count);

  /// No description provided for @button_accept.
  ///
  /// In en, this message translates to:
  /// **'Accept'**
  String get button_accept;

  /// No description provided for @how_was_your_experience.
  ///
  /// In en, this message translates to:
  /// **'How was your experience?'**
  String get how_was_your_experience;

  /// No description provided for @mixed.
  ///
  /// In en, this message translates to:
  /// **'Mixed'**
  String get mixed;

  /// No description provided for @male.
  ///
  /// In en, this message translates to:
  /// **'Male'**
  String get male;

  /// No description provided for @female.
  ///
  /// In en, this message translates to:
  /// **'Female'**
  String get female;

  /// No description provided for @toast_app_state_corrupted.
  ///
  /// In en, this message translates to:
  /// **'App state corrupted, please restart'**
  String get toast_app_state_corrupted;

  /// No description provided for @toast_payment_info_not_available.
  ///
  /// In en, this message translates to:
  /// **'Payment information not available'**
  String get toast_payment_info_not_available;

  /// No description provided for @text_apply_coupon.
  ///
  /// In en, this message translates to:
  /// **'Apply Coupon'**
  String get text_apply_coupon;

  /// No description provided for @text_coupon_applied.
  ///
  /// In en, this message translates to:
  /// **'Coupon: {code}'**
  String text_coupon_applied(String code);

  /// No description provided for @label_payment_method.
  ///
  /// In en, this message translates to:
  /// **'Payment Method'**
  String get label_payment_method;

  /// No description provided for @label_payment_summary.
  ///
  /// In en, this message translates to:
  /// **'Payment Summary'**
  String get label_payment_summary;

  /// No description provided for @text_payment_successful.
  ///
  /// In en, this message translates to:
  /// **'Payment successful'**
  String get text_payment_successful;

  /// No description provided for @text_payment_failed.
  ///
  /// In en, this message translates to:
  /// **'Payment failed'**
  String get text_payment_failed;

  /// No description provided for @text_unsupported_payment_method_description.
  ///
  /// In en, this message translates to:
  /// **'The selected payment method is not supported. Please choose a different method.'**
  String get text_unsupported_payment_method_description;

  /// No description provided for @toast_va_number_not_available.
  ///
  /// In en, this message translates to:
  /// **'VA Number is not available'**
  String get toast_va_number_not_available;

  /// No description provided for @toast_va_number_copied.
  ///
  /// In en, this message translates to:
  /// **'VA Number copied to clipboard'**
  String get toast_va_number_copied;

  /// No description provided for @text_provider_label.
  ///
  /// In en, this message translates to:
  /// **'Provider :'**
  String get text_provider_label;

  /// No description provided for @text_va_number_label.
  ///
  /// In en, this message translates to:
  /// **'VA Number :'**
  String get text_va_number_label;

  /// No description provided for @text_valid_until_with_date.
  ///
  /// In en, this message translates to:
  /// **'Valid until {date}'**
  String text_valid_until_with_date(String date);

  /// No description provided for @text_on_trip.
  ///
  /// In en, this message translates to:
  /// **'On Trip'**
  String get text_on_trip;

  /// No description provided for @text_license_plate.
  ///
  /// In en, this message translates to:
  /// **'License plate'**
  String get text_license_plate;

  /// No description provided for @text_finding_driver.
  ///
  /// In en, this message translates to:
  /// **'Finding your driver...'**
  String get text_finding_driver;

  /// No description provided for @text_finding_driver_message.
  ///
  /// In en, this message translates to:
  /// **'Please wait while we match you with a driver'**
  String get text_finding_driver_message;

  /// No description provided for @status_searching.
  ///
  /// In en, this message translates to:
  /// **'Searching'**
  String get status_searching;

  /// No description provided for @status_driver_found.
  ///
  /// In en, this message translates to:
  /// **'Driver found'**
  String get status_driver_found;

  /// No description provided for @status_on_the_way.
  ///
  /// In en, this message translates to:
  /// **'On the way'**
  String get status_on_the_way;

  /// No description provided for @text_pickup_location.
  ///
  /// In en, this message translates to:
  /// **'Pickup location'**
  String get text_pickup_location;

  /// No description provided for @text_dropoff_location.
  ///
  /// In en, this message translates to:
  /// **'Dropoff location'**
  String get text_dropoff_location;

  /// No description provided for @label_payment_method_lower.
  ///
  /// In en, this message translates to:
  /// **'Payment Method'**
  String get label_payment_method_lower;

  /// No description provided for @label_total_price.
  ///
  /// In en, this message translates to:
  /// **'Total Price'**
  String get label_total_price;

  /// No description provided for @text_order_details.
  ///
  /// In en, this message translates to:
  /// **'Order Details'**
  String get text_order_details;

  /// No description provided for @text_finding_driver_title.
  ///
  /// In en, this message translates to:
  /// **'Finding driver'**
  String get text_finding_driver_title;

  /// No description provided for @text_your_driver_title.
  ///
  /// In en, this message translates to:
  /// **'Your driver'**
  String get text_your_driver_title;

  /// No description provided for @text_trip_completed.
  ///
  /// In en, this message translates to:
  /// **'Trip completed!'**
  String get text_trip_completed;

  /// No description provided for @text_trip_canceled.
  ///
  /// In en, this message translates to:
  /// **'Trip was canceled'**
  String get text_trip_canceled;

  /// No description provided for @title_delivery_details.
  ///
  /// In en, this message translates to:
  /// **'Delivery Details'**
  String get title_delivery_details;

  /// No description provided for @label_item_description.
  ///
  /// In en, this message translates to:
  /// **'Item Description'**
  String get label_item_description;

  /// No description provided for @placeholder_item_description.
  ///
  /// In en, this message translates to:
  /// **'What are you sending?'**
  String get placeholder_item_description;

  /// No description provided for @label_weight_kg.
  ///
  /// In en, this message translates to:
  /// **'Weight (kg)'**
  String get label_weight_kg;

  /// No description provided for @placeholder_weight_kg.
  ///
  /// In en, this message translates to:
  /// **'Enter weight in kg (max 20kg)'**
  String get placeholder_weight_kg;

  /// No description provided for @text_maximum_weight.
  ///
  /// In en, this message translates to:
  /// **'Maximum weight: 20kg'**
  String get text_maximum_weight;

  /// No description provided for @text_special_handling_instructions.
  ///
  /// In en, this message translates to:
  /// **'Add any special handling or delivery instructions'**
  String get text_special_handling_instructions;

  /// No description provided for @label_item_photos_optional.
  ///
  /// In en, this message translates to:
  /// **'Item Photos (Optional)'**
  String get label_item_photos_optional;

  /// No description provided for @text_add_up_to_3_photos.
  ///
  /// In en, this message translates to:
  /// **'Add up to 3 photos of the item'**
  String get text_add_up_to_3_photos;

  /// No description provided for @toast_provide_item_description.
  ///
  /// In en, this message translates to:
  /// **'Please provide item description'**
  String get toast_provide_item_description;

  /// No description provided for @toast_weight_must_be_valid.
  ///
  /// In en, this message translates to:
  /// **'Weight must be between 0.1kg and 20kg'**
  String get toast_weight_must_be_valid;

  /// No description provided for @text_thank_you_for_review.
  ///
  /// In en, this message translates to:
  /// **'Thank you for your review!'**
  String get text_thank_you_for_review;

  /// No description provided for @toast_failed_submit_review.
  ///
  /// In en, this message translates to:
  /// **'Failed to submit review'**
  String get toast_failed_submit_review;

  /// No description provided for @text_rate_by_category.
  ///
  /// In en, this message translates to:
  /// **'Rate by category'**
  String get text_rate_by_category;

  /// No description provided for @category_cleanliness.
  ///
  /// In en, this message translates to:
  /// **'Cleanliness'**
  String get category_cleanliness;

  /// No description provided for @category_courtesy.
  ///
  /// In en, this message translates to:
  /// **'Courtesy'**
  String get category_courtesy;

  /// No description provided for @category_punctuality.
  ///
  /// In en, this message translates to:
  /// **'Punctuality'**
  String get category_punctuality;

  /// No description provided for @category_safety.
  ///
  /// In en, this message translates to:
  /// **'Safety'**
  String get category_safety;

  /// No description provided for @category_communication.
  ///
  /// In en, this message translates to:
  /// **'Communication'**
  String get category_communication;

  /// No description provided for @category_overall.
  ///
  /// In en, this message translates to:
  /// **'Overall'**
  String get category_overall;

  /// No description provided for @category_desc_cleanliness.
  ///
  /// In en, this message translates to:
  /// **'How clean was the vehicle and the driver\'s appearance?'**
  String get category_desc_cleanliness;

  /// No description provided for @category_desc_courtesy.
  ///
  /// In en, this message translates to:
  /// **'How polite and respectful was the driver?'**
  String get category_desc_courtesy;

  /// No description provided for @category_desc_punctuality.
  ///
  /// In en, this message translates to:
  /// **'Was the driver on time for pickup?'**
  String get category_desc_punctuality;

  /// No description provided for @category_desc_safety.
  ///
  /// In en, this message translates to:
  /// **'Did you feel safe during the trip?'**
  String get category_desc_safety;

  /// No description provided for @category_desc_communication.
  ///
  /// In en, this message translates to:
  /// **'How well did the driver communicate?'**
  String get category_desc_communication;

  /// No description provided for @category_desc_overall.
  ///
  /// In en, this message translates to:
  /// **'Rate your overall experience with this driver'**
  String get category_desc_overall;

  /// No description provided for @rating_poor.
  ///
  /// In en, this message translates to:
  /// **'Poor'**
  String get rating_poor;

  /// No description provided for @rating_below_average.
  ///
  /// In en, this message translates to:
  /// **'Below Average'**
  String get rating_below_average;

  /// No description provided for @rating_average.
  ///
  /// In en, this message translates to:
  /// **'Average'**
  String get rating_average;

  /// No description provided for @rating_good.
  ///
  /// In en, this message translates to:
  /// **'Good'**
  String get rating_good;

  /// No description provided for @rating_excellent.
  ///
  /// In en, this message translates to:
  /// **'Excellent'**
  String get rating_excellent;

  /// No description provided for @label_additional_comments.
  ///
  /// In en, this message translates to:
  /// **'Additional comments (optional)'**
  String get label_additional_comments;

  /// No description provided for @placeholder_additional_comments.
  ///
  /// In en, this message translates to:
  /// **'Tell us more about your experience...'**
  String get placeholder_additional_comments;

  /// No description provided for @button_submit_review.
  ///
  /// In en, this message translates to:
  /// **'Submit Review'**
  String get button_submit_review;

  /// No description provided for @toast_please_rate_category.
  ///
  /// In en, this message translates to:
  /// **'Please rate {category}'**
  String toast_please_rate_category(String category);

  /// No description provided for @text_drivers_around_you.
  ///
  /// In en, this message translates to:
  /// **'There are {count} drivers around you'**
  String text_drivers_around_you(int count);

  /// No description provided for @text_no_order_history.
  ///
  /// In en, this message translates to:
  /// **'No order history found'**
  String get text_no_order_history;

  /// No description provided for @text_order_id_short.
  ///
  /// In en, this message translates to:
  /// **'Order #{id}'**
  String text_order_id_short(String id);

  /// No description provided for @label_notes.
  ///
  /// In en, this message translates to:
  /// **'Notes'**
  String get label_notes;

  /// No description provided for @text_unknown_user.
  ///
  /// In en, this message translates to:
  /// **'Unknown User'**
  String get text_unknown_user;

  /// No description provided for @text_customer.
  ///
  /// In en, this message translates to:
  /// **'Customer'**
  String get text_customer;

  /// No description provided for @button_call_customer.
  ///
  /// In en, this message translates to:
  /// **'Call Customer'**
  String get button_call_customer;

  /// No description provided for @button_delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get button_delete;

  /// No description provided for @title_edit_schedule.
  ///
  /// In en, this message translates to:
  /// **'Edit Schedule'**
  String get title_edit_schedule;

  /// No description provided for @title_add_schedule.
  ///
  /// In en, this message translates to:
  /// **'Add Schedule'**
  String get title_add_schedule;

  /// No description provided for @placeholder_course_name.
  ///
  /// In en, this message translates to:
  /// **'e.g., Mobile Programming'**
  String get placeholder_course_name;

  /// No description provided for @button_cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get button_cancel;

  /// No description provided for @placeholder_full_name.
  ///
  /// In en, this message translates to:
  /// **'John Doe'**
  String get placeholder_full_name;

  /// No description provided for @placeholder_stock.
  ///
  /// In en, this message translates to:
  /// **'0'**
  String get placeholder_stock;

  /// No description provided for @text_failed_to_load_profile.
  ///
  /// In en, this message translates to:
  /// **'Failed to load profile: {error}'**
  String text_failed_to_load_profile(String error);

  /// No description provided for @text_no_rankings_yet.
  ///
  /// In en, this message translates to:
  /// **'No rankings yet'**
  String get text_no_rankings_yet;

  /// No description provided for @title_where_going.
  ///
  /// In en, this message translates to:
  /// **'Where are you going?'**
  String get title_where_going;

  /// No description provided for @tab_rankings.
  ///
  /// In en, this message translates to:
  /// **'Rankings'**
  String get tab_rankings;

  /// No description provided for @tab_badges.
  ///
  /// In en, this message translates to:
  /// **'Badges'**
  String get tab_badges;

  /// No description provided for @text_user_id.
  ///
  /// In en, this message translates to:
  /// **'User {id}'**
  String text_user_id(String id);

  /// No description provided for @text_category_value.
  ///
  /// In en, this message translates to:
  /// **'Category: {category}'**
  String text_category_value(String category);

  /// No description provided for @text_period_value.
  ///
  /// In en, this message translates to:
  /// **'Period: {period}'**
  String text_period_value(String period);

  /// No description provided for @text_earned.
  ///
  /// In en, this message translates to:
  /// **'Earned'**
  String get text_earned;

  /// No description provided for @text_balance_with_amount.
  ///
  /// In en, this message translates to:
  /// **'Balance: {amount}'**
  String text_balance_with_amount(String amount);

  /// No description provided for @button_top_up.
  ///
  /// In en, this message translates to:
  /// **'Top Up'**
  String get button_top_up;

  /// No description provided for @text_select_via_map.
  ///
  /// In en, this message translates to:
  /// **'Select via map'**
  String get text_select_via_map;

  /// No description provided for @text_no_place_found.
  ///
  /// In en, this message translates to:
  /// **'No place found'**
  String get text_no_place_found;

  /// No description provided for @title_location_permission_required.
  ///
  /// In en, this message translates to:
  /// **'Location Permission Required'**
  String get title_location_permission_required;

  /// No description provided for @text_location_permission_denied.
  ///
  /// In en, this message translates to:
  /// **'Location permission was previously denied. To go online and accept orders, you need to enable location access in your device settings.'**
  String get text_location_permission_denied;

  /// No description provided for @text_location_permission_request.
  ///
  /// In en, this message translates to:
  /// **'To accept ride and delivery orders, drivers must share their location in real-time. This helps:'**
  String get text_location_permission_request;

  /// No description provided for @text_location_benefit_match_orders.
  ///
  /// In en, this message translates to:
  /// **'Match you with nearby orders'**
  String get text_location_benefit_match_orders;

  /// No description provided for @text_location_benefit_track_arrival.
  ///
  /// In en, this message translates to:
  /// **'Let customers track your arrival'**
  String get text_location_benefit_track_arrival;

  /// No description provided for @text_location_benefit_safety.
  ///
  /// In en, this message translates to:
  /// **'Ensure safety and accountability'**
  String get text_location_benefit_safety;

  /// No description provided for @text_location_redirect_settings.
  ///
  /// In en, this message translates to:
  /// **'You will be redirected to app settings to enable location access.'**
  String get text_location_redirect_settings;

  /// No description provided for @button_open_settings.
  ///
  /// In en, this message translates to:
  /// **'Open Settings'**
  String get button_open_settings;

  /// No description provided for @button_grant_permission.
  ///
  /// In en, this message translates to:
  /// **'Grant Permission'**
  String get button_grant_permission;

  /// No description provided for @title_rate_customer.
  ///
  /// In en, this message translates to:
  /// **'Rate Customer'**
  String get title_rate_customer;

  /// No description provided for @text_experience_with_user.
  ///
  /// In en, this message translates to:
  /// **'How was your experience with {name}?'**
  String text_experience_with_user(String name);

  /// No description provided for @category_other.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get category_other;

  /// No description provided for @label_rating_score.
  ///
  /// In en, this message translates to:
  /// **'Rating: {score} / 5.0'**
  String label_rating_score(String score);

  /// No description provided for @toast_review_submitted.
  ///
  /// In en, this message translates to:
  /// **'Review submitted successfully'**
  String get toast_review_submitted;

  /// No description provided for @toast_review_failed.
  ///
  /// In en, this message translates to:
  /// **'Failed to submit review'**
  String get toast_review_failed;

  /// No description provided for @title_reject_order.
  ///
  /// In en, this message translates to:
  /// **'Reject Order'**
  String get title_reject_order;

  /// No description provided for @text_select_rejection_reason.
  ///
  /// In en, this message translates to:
  /// **'Please select a reason for rejecting this order:'**
  String get text_select_rejection_reason;

  /// No description provided for @rejection_reason_out_of_stock.
  ///
  /// In en, this message translates to:
  /// **'Out of Stock'**
  String get rejection_reason_out_of_stock;

  /// No description provided for @rejection_reason_too_busy.
  ///
  /// In en, this message translates to:
  /// **'Too Busy / High Order Volume'**
  String get rejection_reason_too_busy;

  /// No description provided for @rejection_reason_ingredient_unavailable.
  ///
  /// In en, this message translates to:
  /// **'Ingredient Unavailable'**
  String get rejection_reason_ingredient_unavailable;

  /// No description provided for @rejection_reason_closed.
  ///
  /// In en, this message translates to:
  /// **'Store Closed / Closing Soon'**
  String get rejection_reason_closed;

  /// No description provided for @rejection_reason_other.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get rejection_reason_other;

  /// No description provided for @label_additional_note_optional.
  ///
  /// In en, this message translates to:
  /// **'Additional Note (Optional)'**
  String get label_additional_note_optional;

  /// No description provided for @placeholder_rejection_note.
  ///
  /// In en, this message translates to:
  /// **'e.g., \"We ran out of chicken, will restock tomorrow\"'**
  String get placeholder_rejection_note;

  /// No description provided for @button_reject_order.
  ///
  /// In en, this message translates to:
  /// **'Reject Order'**
  String get button_reject_order;

  /// No description provided for @my_reviews.
  ///
  /// In en, this message translates to:
  /// **'My Reviews'**
  String get my_reviews;

  /// No description provided for @failed_to_load.
  ///
  /// In en, this message translates to:
  /// **'Failed to load'**
  String get failed_to_load;

  /// No description provided for @no_reviews_yet.
  ///
  /// In en, this message translates to:
  /// **'No reviews yet'**
  String get no_reviews_yet;

  /// No description provided for @punctuality.
  ///
  /// In en, this message translates to:
  /// **'Punctuality'**
  String get punctuality;

  /// No description provided for @safety.
  ///
  /// In en, this message translates to:
  /// **'Safety'**
  String get safety;

  /// No description provided for @communication.
  ///
  /// In en, this message translates to:
  /// **'Communication'**
  String get communication;

  /// No description provided for @delete_account.
  ///
  /// In en, this message translates to:
  /// **'Delete Account'**
  String get delete_account;

  /// No description provided for @delete_account_title.
  ///
  /// In en, this message translates to:
  /// **'Delete Account?'**
  String get delete_account_title;

  /// No description provided for @delete_account_warning.
  ///
  /// In en, this message translates to:
  /// **'This action is permanent and cannot be undone.'**
  String get delete_account_warning;

  /// No description provided for @delete_account_you_will_lose.
  ///
  /// In en, this message translates to:
  /// **'You will lose:'**
  String get delete_account_you_will_lose;

  /// No description provided for @delete_account_lose_wallet.
  ///
  /// In en, this message translates to:
  /// **'All wallet balance'**
  String get delete_account_lose_wallet;

  /// No description provided for @delete_account_lose_history.
  ///
  /// In en, this message translates to:
  /// **'Order history'**
  String get delete_account_lose_history;

  /// No description provided for @delete_account_lose_ratings.
  ///
  /// In en, this message translates to:
  /// **'Ratings and reviews'**
  String get delete_account_lose_ratings;

  /// No description provided for @delete_account_lose_addresses.
  ///
  /// In en, this message translates to:
  /// **'Saved addresses'**
  String get delete_account_lose_addresses;

  /// No description provided for @delete_account_lose_data.
  ///
  /// In en, this message translates to:
  /// **'All account data'**
  String get delete_account_lose_data;

  /// No description provided for @delete_account_proceed_methods.
  ///
  /// In en, this message translates to:
  /// **'To proceed, please use one of the following methods:'**
  String get delete_account_proceed_methods;

  /// No description provided for @continue_text.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continue_text;

  /// No description provided for @delete_account_choose_method.
  ///
  /// In en, this message translates to:
  /// **'Choose Deletion Method'**
  String get delete_account_choose_method;

  /// No description provided for @delete_account_select_method.
  ///
  /// In en, this message translates to:
  /// **'Select how you want to request account deletion:'**
  String get delete_account_select_method;

  /// No description provided for @delete_account_method_web.
  ///
  /// In en, this message translates to:
  /// **'Online Form (Recommended)'**
  String get delete_account_method_web;

  /// No description provided for @delete_account_method_web_desc.
  ///
  /// In en, this message translates to:
  /// **'Complete form on our website'**
  String get delete_account_method_web_desc;

  /// No description provided for @delete_account_method_email.
  ///
  /// In en, this message translates to:
  /// **'Email Request'**
  String get delete_account_method_email;

  /// No description provided for @delete_account_method_email_desc.
  ///
  /// In en, this message translates to:
  /// **'Send request via email'**
  String get delete_account_method_email_desc;

  /// No description provided for @delete_account_method_whatsapp.
  ///
  /// In en, this message translates to:
  /// **'WhatsApp Support'**
  String get delete_account_method_whatsapp;

  /// No description provided for @delete_account_method_whatsapp_desc.
  ///
  /// In en, this message translates to:
  /// **'Chat with support team'**
  String get delete_account_method_whatsapp_desc;

  /// No description provided for @delete_account_error_open_web.
  ///
  /// In en, this message translates to:
  /// **'Could not open web page. Please try again.'**
  String get delete_account_error_open_web;

  /// No description provided for @delete_account_error_open_email.
  ///
  /// In en, this message translates to:
  /// **'Could not open email app. Please try again.'**
  String get delete_account_error_open_email;

  /// No description provided for @delete_account_error_open_whatsapp.
  ///
  /// In en, this message translates to:
  /// **'Could not open WhatsApp. Please try again.'**
  String get delete_account_error_open_whatsapp;

  /// No description provided for @email_verification_title.
  ///
  /// In en, this message translates to:
  /// **'Verify Your Email'**
  String get email_verification_title;

  /// No description provided for @email_verification_description.
  ///
  /// In en, this message translates to:
  /// **'We\'ve sent a verification link to your email address.'**
  String get email_verification_description;

  /// No description provided for @email_verification_sent.
  ///
  /// In en, this message translates to:
  /// **'Verification email sent successfully!'**
  String get email_verification_sent;

  /// No description provided for @email_verification_instruction.
  ///
  /// In en, this message translates to:
  /// **'Click the link in the email to verify your account. If you don\'t see the email, check your spam folder.'**
  String get email_verification_instruction;

  /// No description provided for @email_verification_resend.
  ///
  /// In en, this message translates to:
  /// **'Resend Verification Email'**
  String get email_verification_resend;

  /// No description provided for @email_verification_resend_countdown.
  ///
  /// In en, this message translates to:
  /// **'Resend in {seconds}s'**
  String email_verification_resend_countdown(String seconds);

  /// No description provided for @email_verification_spam_hint.
  ///
  /// In en, this message translates to:
  /// **'Don\'t forget to check your spam folder!'**
  String get email_verification_spam_hint;

  /// No description provided for @email_verification_success_title.
  ///
  /// In en, this message translates to:
  /// **'Email Verified!'**
  String get email_verification_success_title;

  /// No description provided for @email_verification_success_description.
  ///
  /// In en, this message translates to:
  /// **'Your email has been verified successfully. You can now sign in to your account.'**
  String get email_verification_success_description;

  /// No description provided for @email_verification_failed.
  ///
  /// In en, this message translates to:
  /// **'Email verification failed'**
  String get email_verification_failed;

  /// No description provided for @email_verification_invalid_token.
  ///
  /// In en, this message translates to:
  /// **'Invalid or expired verification link. Please request a new one.'**
  String get email_verification_invalid_token;

  /// No description provided for @no_vouchers_available.
  ///
  /// In en, this message translates to:
  /// **'No Vouchers Available'**
  String get no_vouchers_available;

  /// No description provided for @check_back_later_for_promotions.
  ///
  /// In en, this message translates to:
  /// **'Check back later for promotions and discounts'**
  String get check_back_later_for_promotions;

  /// No description provided for @toast_report_submitted.
  ///
  /// In en, this message translates to:
  /// **'Report submitted successfully'**
  String get toast_report_submitted;

  /// No description provided for @toast_failed_submit_report.
  ///
  /// In en, this message translates to:
  /// **'Failed to submit report'**
  String get toast_failed_submit_report;

  /// No description provided for @report_user.
  ///
  /// In en, this message translates to:
  /// **'Report User'**
  String get report_user;

  /// No description provided for @report_user_description.
  ///
  /// In en, this message translates to:
  /// **'Report an issue with this user'**
  String get report_user_description;

  /// No description provided for @select_report_category.
  ///
  /// In en, this message translates to:
  /// **'Select Issue Category'**
  String get select_report_category;

  /// No description provided for @report_description.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get report_description;

  /// No description provided for @report_description_hint.
  ///
  /// In en, this message translates to:
  /// **'Please describe the issue in detail...'**
  String get report_description_hint;

  /// No description provided for @report_description_helper.
  ///
  /// In en, this message translates to:
  /// **'Minimum 10 characters required'**
  String get report_description_helper;

  /// No description provided for @report_guidelines_title.
  ///
  /// In en, this message translates to:
  /// **'Reporting Guidelines'**
  String get report_guidelines_title;

  /// No description provided for @report_guidelines_content.
  ///
  /// In en, this message translates to:
  /// **'Your report will be kept confidential. The reported user will not be notified of your identity. Our safety team will review all reports within 24-48 hours.'**
  String get report_guidelines_content;

  /// No description provided for @button_submit_report.
  ///
  /// In en, this message translates to:
  /// **'Submit Report'**
  String get button_submit_report;

  /// No description provided for @report_category_behavior.
  ///
  /// In en, this message translates to:
  /// **'Inappropriate Behavior'**
  String get report_category_behavior;

  /// No description provided for @report_category_safety.
  ///
  /// In en, this message translates to:
  /// **'Safety Concern'**
  String get report_category_safety;

  /// No description provided for @report_category_fraud.
  ///
  /// In en, this message translates to:
  /// **'Fraud or Scam'**
  String get report_category_fraud;

  /// No description provided for @report_category_other.
  ///
  /// In en, this message translates to:
  /// **'Other Issue'**
  String get report_category_other;

  /// No description provided for @report_category_behavior_desc.
  ///
  /// In en, this message translates to:
  /// **'Rude, offensive, or inappropriate conduct during the trip'**
  String get report_category_behavior_desc;

  /// No description provided for @report_category_safety_desc.
  ///
  /// In en, this message translates to:
  /// **'Dangerous driving, harassment, or threatening behavior'**
  String get report_category_safety_desc;

  /// No description provided for @report_category_fraud_desc.
  ///
  /// In en, this message translates to:
  /// **'Payment manipulation, fake profiles, or scam attempts'**
  String get report_category_fraud_desc;

  /// No description provided for @report_category_other_desc.
  ///
  /// In en, this message translates to:
  /// **'Any other issue not covered by the categories above'**
  String get report_category_other_desc;

  /// No description provided for @no_notifications.
  ///
  /// In en, this message translates to:
  /// **'No notifications yet'**
  String get no_notifications;

  /// No description provided for @mark_all_as_read.
  ///
  /// In en, this message translates to:
  /// **'Mark all as read'**
  String get mark_all_as_read;

  /// No description provided for @notification_time_ago.
  ///
  /// In en, this message translates to:
  /// **'{time} ago'**
  String notification_time_ago(String time);

  /// No description provided for @scheduled_orders.
  ///
  /// In en, this message translates to:
  /// **'Scheduled Orders'**
  String get scheduled_orders;

  /// No description provided for @scheduled_order.
  ///
  /// In en, this message translates to:
  /// **'Scheduled Order'**
  String get scheduled_order;

  /// No description provided for @schedule_a_ride.
  ///
  /// In en, this message translates to:
  /// **'Schedule a Ride'**
  String get schedule_a_ride;

  /// No description provided for @schedule_a_delivery.
  ///
  /// In en, this message translates to:
  /// **'Schedule a Delivery'**
  String get schedule_a_delivery;

  /// No description provided for @schedule_order.
  ///
  /// In en, this message translates to:
  /// **'Schedule Order'**
  String get schedule_order;

  /// No description provided for @no_scheduled_orders.
  ///
  /// In en, this message translates to:
  /// **'No scheduled orders'**
  String get no_scheduled_orders;

  /// No description provided for @no_scheduled_orders_desc.
  ///
  /// In en, this message translates to:
  /// **'You haven\'t scheduled any orders yet. Schedule a ride or delivery for a future time.'**
  String get no_scheduled_orders_desc;

  /// No description provided for @scheduled_for.
  ///
  /// In en, this message translates to:
  /// **'Scheduled for: {datetime}'**
  String scheduled_for(String datetime);

  /// No description provided for @schedule_date.
  ///
  /// In en, this message translates to:
  /// **'Schedule Date'**
  String get schedule_date;

  /// No description provided for @schedule_time.
  ///
  /// In en, this message translates to:
  /// **'Schedule Time'**
  String get schedule_time;

  /// No description provided for @select_date.
  ///
  /// In en, this message translates to:
  /// **'Select Date'**
  String get select_date;

  /// No description provided for @select_time.
  ///
  /// In en, this message translates to:
  /// **'Select Time'**
  String get select_time;

  /// No description provided for @scheduled.
  ///
  /// In en, this message translates to:
  /// **'Scheduled'**
  String get scheduled;

  /// No description provided for @schedule_order_title.
  ///
  /// In en, this message translates to:
  /// **'Schedule Your Order'**
  String get schedule_order_title;

  /// No description provided for @schedule_order_desc.
  ///
  /// In en, this message translates to:
  /// **'Choose when you want your order to be fulfilled'**
  String get schedule_order_desc;

  /// No description provided for @min_schedule_time.
  ///
  /// In en, this message translates to:
  /// **'Minimum 30 minutes from now'**
  String get min_schedule_time;

  /// No description provided for @max_schedule_time.
  ///
  /// In en, this message translates to:
  /// **'Maximum 7 days in advance'**
  String get max_schedule_time;

  /// No description provided for @schedule_confirmation.
  ///
  /// In en, this message translates to:
  /// **'Your order will be scheduled for {datetime}. A driver will be matched approximately 15 minutes before the scheduled time.'**
  String schedule_confirmation(String datetime);

  /// No description provided for @confirm_schedule.
  ///
  /// In en, this message translates to:
  /// **'Confirm Schedule'**
  String get confirm_schedule;

  /// No description provided for @edit_schedule.
  ///
  /// In en, this message translates to:
  /// **'Edit Schedule'**
  String get edit_schedule;

  /// No description provided for @cancel_scheduled_order.
  ///
  /// In en, this message translates to:
  /// **'Cancel Scheduled Order'**
  String get cancel_scheduled_order;

  /// No description provided for @cancel_scheduled_order_confirm.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to cancel this scheduled order?'**
  String get cancel_scheduled_order_confirm;

  /// No description provided for @scheduled_order_cancelled.
  ///
  /// In en, this message translates to:
  /// **'Scheduled order cancelled successfully'**
  String get scheduled_order_cancelled;

  /// No description provided for @scheduled_order_updated.
  ///
  /// In en, this message translates to:
  /// **'Scheduled order updated successfully'**
  String get scheduled_order_updated;

  /// No description provided for @scheduled_order_placed.
  ///
  /// In en, this message translates to:
  /// **'Order scheduled successfully'**
  String get scheduled_order_placed;

  /// No description provided for @failed_to_schedule_order.
  ///
  /// In en, this message translates to:
  /// **'Failed to schedule order'**
  String get failed_to_schedule_order;

  /// No description provided for @failed_to_cancel_scheduled_order.
  ///
  /// In en, this message translates to:
  /// **'Failed to cancel scheduled order'**
  String get failed_to_cancel_scheduled_order;

  /// No description provided for @failed_to_update_scheduled_order.
  ///
  /// In en, this message translates to:
  /// **'Failed to update scheduled order'**
  String get failed_to_update_scheduled_order;

  /// No description provided for @failed_to_load_scheduled_orders.
  ///
  /// In en, this message translates to:
  /// **'Failed to load scheduled orders'**
  String get failed_to_load_scheduled_orders;

  /// No description provided for @schedule_time_too_soon.
  ///
  /// In en, this message translates to:
  /// **'Schedule time must be at least 30 minutes from now'**
  String get schedule_time_too_soon;

  /// No description provided for @schedule_time_too_far.
  ///
  /// In en, this message translates to:
  /// **'Schedule time cannot be more than 7 days in advance'**
  String get schedule_time_too_far;

  /// No description provided for @matching_starts_at.
  ///
  /// In en, this message translates to:
  /// **'Driver matching starts at {time}'**
  String matching_starts_at(String time);

  /// No description provided for @view_scheduled_orders.
  ///
  /// In en, this message translates to:
  /// **'View Scheduled Orders'**
  String get view_scheduled_orders;

  /// No description provided for @upcoming_scheduled_orders.
  ///
  /// In en, this message translates to:
  /// **'Upcoming Scheduled Orders'**
  String get upcoming_scheduled_orders;

  /// No description provided for @past_scheduled_orders.
  ///
  /// In en, this message translates to:
  /// **'Past Scheduled Orders'**
  String get past_scheduled_orders;

  /// No description provided for @scheduled_order_details.
  ///
  /// In en, this message translates to:
  /// **'Scheduled Order Details'**
  String get scheduled_order_details;

  /// No description provided for @order_will_be_matched.
  ///
  /// In en, this message translates to:
  /// **'Order will be matched {time}'**
  String order_will_be_matched(String time);

  /// No description provided for @schedule_now.
  ///
  /// In en, this message translates to:
  /// **'Schedule Now'**
  String get schedule_now;

  /// No description provided for @order_now.
  ///
  /// In en, this message translates to:
  /// **'Order Now'**
  String get order_now;

  /// No description provided for @or_schedule_for_later.
  ///
  /// In en, this message translates to:
  /// **'Or schedule for later'**
  String get or_schedule_for_later;

  /// No description provided for @please_select_schedule_time.
  ///
  /// In en, this message translates to:
  /// **'Please select a schedule time'**
  String get please_select_schedule_time;

  /// No description provided for @scheduled_order_created.
  ///
  /// In en, this message translates to:
  /// **'Your order has been scheduled successfully'**
  String get scheduled_order_created;

  /// No description provided for @schedule_for_later.
  ///
  /// In en, this message translates to:
  /// **'Schedule for Later'**
  String get schedule_for_later;

  /// No description provided for @tap_to_change_schedule.
  ///
  /// In en, this message translates to:
  /// **'Tap to change'**
  String get tap_to_change_schedule;
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
