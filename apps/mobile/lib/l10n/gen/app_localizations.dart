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

  /// No description provided for @hello.
  ///
  /// In en, this message translates to:
  /// **'Hello'**
  String get hello;

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

  /// No description provided for @button_cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get button_cancel;

  /// No description provided for @button_continue.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get button_continue;

  /// No description provided for @button_back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get button_back;

  /// No description provided for @button_next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get button_next;

  /// No description provided for @button_submit.
  ///
  /// In en, this message translates to:
  /// **'Submit'**
  String get button_submit;

  /// No description provided for @button_save_changes.
  ///
  /// In en, this message translates to:
  /// **'Save Changes'**
  String get button_save_changes;

  /// No description provided for @button_allow.
  ///
  /// In en, this message translates to:
  /// **'Allow'**
  String get button_allow;

  /// No description provided for @button_open_settings.
  ///
  /// In en, this message translates to:
  /// **'Open Settings'**
  String get button_open_settings;

  /// No description provided for @button_view_all.
  ///
  /// In en, this message translates to:
  /// **'View All'**
  String get button_view_all;

  /// No description provided for @button_send_reset_link.
  ///
  /// In en, this message translates to:
  /// **'Send Reset Link'**
  String get button_send_reset_link;

  /// No description provided for @button_back_to_sign_in.
  ///
  /// In en, this message translates to:
  /// **'Back to Sign In'**
  String get button_back_to_sign_in;

  /// No description provided for @button_reset_password.
  ///
  /// In en, this message translates to:
  /// **'Reset Password'**
  String get button_reset_password;

  /// No description provided for @button_reject.
  ///
  /// In en, this message translates to:
  /// **'Reject'**
  String get button_reject;

  /// No description provided for @button_accept.
  ///
  /// In en, this message translates to:
  /// **'Accept'**
  String get button_accept;

  /// No description provided for @button_grant_permission.
  ///
  /// In en, this message translates to:
  /// **'Grant Permission'**
  String get button_grant_permission;

  /// No description provided for @button_send_alert.
  ///
  /// In en, this message translates to:
  /// **'Send Alert'**
  String get button_send_alert;

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

  /// No description provided for @button_top_up.
  ///
  /// In en, this message translates to:
  /// **'Top Up'**
  String get button_top_up;

  /// No description provided for @button_retry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get button_retry;

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

  /// No description provided for @label_phone.
  ///
  /// In en, this message translates to:
  /// **'Phone'**
  String get label_phone;

  /// No description provided for @label_password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get label_password;

  /// No description provided for @label_gender.
  ///
  /// In en, this message translates to:
  /// **'Gender'**
  String get label_gender;

  /// No description provided for @label_photo.
  ///
  /// In en, this message translates to:
  /// **'Photo'**
  String get label_photo;

  /// No description provided for @label_address.
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get label_address;

  /// No description provided for @label_location.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get label_location;

  /// No description provided for @label_unknown.
  ///
  /// In en, this message translates to:
  /// **'Unknown'**
  String get label_unknown;

  /// No description provided for @label_user_role.
  ///
  /// In en, this message translates to:
  /// **'User'**
  String get label_user_role;

  /// No description provided for @label_driver_role.
  ///
  /// In en, this message translates to:
  /// **'Driver'**
  String get label_driver_role;

  /// No description provided for @label_merchant_role.
  ///
  /// In en, this message translates to:
  /// **'Merchant'**
  String get label_merchant_role;

  /// No description provided for @label_student_id.
  ///
  /// In en, this message translates to:
  /// **'NIM'**
  String get label_student_id;

  /// No description provided for @label_confirm_password.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get label_confirm_password;

  /// No description provided for @label_student_card.
  ///
  /// In en, this message translates to:
  /// **'Student Card (KTM)'**
  String get label_student_card;

  /// No description provided for @label_driver_license.
  ///
  /// In en, this message translates to:
  /// **'Driver License (SIM)'**
  String get label_driver_license;

  /// No description provided for @label_license_plate.
  ///
  /// In en, this message translates to:
  /// **'License Plate'**
  String get label_license_plate;

  /// No description provided for @label_vehicle_registration.
  ///
  /// In en, this message translates to:
  /// **'Vehicle Registration (STNK)'**
  String get label_vehicle_registration;

  /// No description provided for @label_bank_provider.
  ///
  /// In en, this message translates to:
  /// **'Bank Provider'**
  String get label_bank_provider;

  /// No description provided for @label_bank_account.
  ///
  /// In en, this message translates to:
  /// **'Bank Account'**
  String get label_bank_account;

  /// No description provided for @label_owner_name.
  ///
  /// In en, this message translates to:
  /// **'Owner Name'**
  String get label_owner_name;

  /// No description provided for @label_outlet_name.
  ///
  /// In en, this message translates to:
  /// **'Outlet Name'**
  String get label_outlet_name;

  /// No description provided for @label_outlet_category.
  ///
  /// In en, this message translates to:
  /// **'Outlet Category'**
  String get label_outlet_category;

  /// No description provided for @label_outlet_location.
  ///
  /// In en, this message translates to:
  /// **'Outlet Location'**
  String get label_outlet_location;

  /// No description provided for @label_government_document.
  ///
  /// In en, this message translates to:
  /// **'Government Document'**
  String get label_government_document;

  /// No description provided for @label_bank_account_number.
  ///
  /// In en, this message translates to:
  /// **'Bank Account Number'**
  String get label_bank_account_number;

  /// No description provided for @label_choose_service.
  ///
  /// In en, this message translates to:
  /// **'Choose the service that you want'**
  String get label_choose_service;

  /// No description provided for @label_popular_merchant.
  ///
  /// In en, this message translates to:
  /// **'Popular merchant'**
  String get label_popular_merchant;

  /// No description provided for @label_service_ride.
  ///
  /// In en, this message translates to:
  /// **'Ride'**
  String get label_service_ride;

  /// No description provided for @label_service_delivery.
  ///
  /// In en, this message translates to:
  /// **'Delivery'**
  String get label_service_delivery;

  /// No description provided for @label_service_mart.
  ///
  /// In en, this message translates to:
  /// **'AMart'**
  String get label_service_mart;

  /// No description provided for @label_service_wallet.
  ///
  /// In en, this message translates to:
  /// **'E-Wallet'**
  String get label_service_wallet;

  /// No description provided for @label_service_voucher.
  ///
  /// In en, this message translates to:
  /// **'My Voucher'**
  String get label_service_voucher;

  /// No description provided for @label_photo_profile.
  ///
  /// In en, this message translates to:
  /// **'Photo Profile'**
  String get label_photo_profile;

  /// No description provided for @label_old_password.
  ///
  /// In en, this message translates to:
  /// **'Old Password'**
  String get label_old_password;

  /// No description provided for @label_new_password.
  ///
  /// In en, this message translates to:
  /// **'New Password'**
  String get label_new_password;

  /// No description provided for @label_confirm_new_password.
  ///
  /// In en, this message translates to:
  /// **'Confirm New Password'**
  String get label_confirm_new_password;

  /// No description provided for @label_my_balance.
  ///
  /// In en, this message translates to:
  /// **'My Balance'**
  String get label_my_balance;

  /// No description provided for @label_this_month.
  ///
  /// In en, this message translates to:
  /// **'This month'**
  String get label_this_month;

  /// No description provided for @label_expenses.
  ///
  /// In en, this message translates to:
  /// **'Expenses'**
  String get label_expenses;

  /// No description provided for @label_income.
  ///
  /// In en, this message translates to:
  /// **'Income'**
  String get label_income;

  /// No description provided for @label_payment_method_qris.
  ///
  /// In en, this message translates to:
  /// **'QRIS'**
  String get label_payment_method_qris;

  /// No description provided for @label_order_id.
  ///
  /// In en, this message translates to:
  /// **'Order #'**
  String get label_order_id;

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
  /// **'Gender preference: '**
  String get label_gender_preference;

  /// No description provided for @label_note.
  ///
  /// In en, this message translates to:
  /// **'Note:'**
  String get label_note;

  /// No description provided for @label_order_type_ride.
  ///
  /// In en, this message translates to:
  /// **'Ride'**
  String get label_order_type_ride;

  /// No description provided for @label_order_type_delivery.
  ///
  /// In en, this message translates to:
  /// **'Delivery'**
  String get label_order_type_delivery;

  /// No description provided for @label_order_type_food.
  ///
  /// In en, this message translates to:
  /// **'Food'**
  String get label_order_type_food;

  /// No description provided for @label_note_pickup.
  ///
  /// In en, this message translates to:
  /// **'Pickup: '**
  String get label_note_pickup;

  /// No description provided for @label_note_dropoff.
  ///
  /// In en, this message translates to:
  /// **'Dropoff: '**
  String get label_note_dropoff;

  /// No description provided for @label_note_instructions.
  ///
  /// In en, this message translates to:
  /// **'Instructions: '**
  String get label_note_instructions;

  /// No description provided for @label_benefit_nearby_orders.
  ///
  /// In en, this message translates to:
  /// **'Match you with nearby orders'**
  String get label_benefit_nearby_orders;

  /// No description provided for @label_benefit_track_arrival.
  ///
  /// In en, this message translates to:
  /// **'Let customers track your arrival'**
  String get label_benefit_track_arrival;

  /// No description provided for @label_benefit_safety.
  ///
  /// In en, this message translates to:
  /// **'Ensure safety and accountability'**
  String get label_benefit_safety;

  /// No description provided for @label_review_category.
  ///
  /// In en, this message translates to:
  /// **'Review Category'**
  String get label_review_category;

  /// No description provided for @label_category_cleanliness.
  ///
  /// In en, this message translates to:
  /// **'Cleanliness'**
  String get label_category_cleanliness;

  /// No description provided for @label_category_courtesy.
  ///
  /// In en, this message translates to:
  /// **'Courtesy'**
  String get label_category_courtesy;

  /// No description provided for @label_category_other.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get label_category_other;

  /// No description provided for @label_comment_optional.
  ///
  /// In en, this message translates to:
  /// **'Comment (Optional)'**
  String get label_comment_optional;

  /// No description provided for @label_select_emergency_type.
  ///
  /// In en, this message translates to:
  /// **'Select emergency type:'**
  String get label_select_emergency_type;

  /// No description provided for @label_emergency_accident.
  ///
  /// In en, this message translates to:
  /// **'Accident'**
  String get label_emergency_accident;

  /// No description provided for @label_emergency_harassment.
  ///
  /// In en, this message translates to:
  /// **'Harassment'**
  String get label_emergency_harassment;

  /// No description provided for @label_emergency_theft.
  ///
  /// In en, this message translates to:
  /// **'Theft'**
  String get label_emergency_theft;

  /// No description provided for @label_emergency_medical.
  ///
  /// In en, this message translates to:
  /// **'Medical Emergency'**
  String get label_emergency_medical;

  /// No description provided for @label_emergency_other.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get label_emergency_other;

  /// No description provided for @label_description.
  ///
  /// In en, this message translates to:
  /// **'Description:'**
  String get label_description;

  /// No description provided for @label_akademove_pay.
  ///
  /// In en, this message translates to:
  /// **'Akademove Pay'**
  String get label_akademove_pay;

  /// No description provided for @label_valid_until.
  ///
  /// In en, this message translates to:
  /// **'Valid until '**
  String get label_valid_until;

  /// No description provided for @label_remaining_time.
  ///
  /// In en, this message translates to:
  /// **'Remaining Time :'**
  String get label_remaining_time;

  /// No description provided for @label_category_atk.
  ///
  /// In en, this message translates to:
  /// **'ATK (Stationery)'**
  String get label_category_atk;

  /// No description provided for @label_category_printing.
  ///
  /// In en, this message translates to:
  /// **'Printing'**
  String get label_category_printing;

  /// No description provided for @label_category_food.
  ///
  /// In en, this message translates to:
  /// **'Food & Beverages'**
  String get label_category_food;

  /// No description provided for @label_drag_marker.
  ///
  /// In en, this message translates to:
  /// **'Drag to adjust position'**
  String get label_drag_marker;

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

  /// No description provided for @label_step_4.
  ///
  /// In en, this message translates to:
  /// **'Step 4'**
  String get label_step_4;

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

  /// No description provided for @placeholder_name.
  ///
  /// In en, this message translates to:
  /// **'John Doe'**
  String get placeholder_name;

  /// No description provided for @placeholder_student_id.
  ///
  /// In en, this message translates to:
  /// **'25051204020'**
  String get placeholder_student_id;

  /// No description provided for @placeholder_gender.
  ///
  /// In en, this message translates to:
  /// **'Pick your gender'**
  String get placeholder_gender;

  /// No description provided for @placeholder_license_plate.
  ///
  /// In en, this message translates to:
  /// **'B 1234 AM'**
  String get placeholder_license_plate;

  /// No description provided for @placeholder_bank_provider.
  ///
  /// In en, this message translates to:
  /// **'Pick your bank provider'**
  String get placeholder_bank_provider;

  /// No description provided for @placeholder_bank_account.
  ///
  /// In en, this message translates to:
  /// **'11223344'**
  String get placeholder_bank_account;

  /// No description provided for @placeholder_outlet_name.
  ///
  /// In en, this message translates to:
  /// **'Your Outlet Name'**
  String get placeholder_outlet_name;

  /// No description provided for @placeholder_outlet_email.
  ///
  /// In en, this message translates to:
  /// **'outlet@example.com'**
  String get placeholder_outlet_email;

  /// No description provided for @placeholder_outlet_category.
  ///
  /// In en, this message translates to:
  /// **'Select outlet category'**
  String get placeholder_outlet_category;

  /// No description provided for @placeholder_search_location.
  ///
  /// In en, this message translates to:
  /// **'Search location (e.g., Monas Jakarta)'**
  String get placeholder_search_location;

  /// No description provided for @placeholder_share_experience.
  ///
  /// In en, this message translates to:
  /// **'Share your experience...'**
  String get placeholder_share_experience;

  /// No description provided for @placeholder_emergency_description.
  ///
  /// In en, this message translates to:
  /// **'Describe the emergency situation...'**
  String get placeholder_emergency_description;

  /// No description provided for @screen_title_sign_up_choice.
  ///
  /// In en, this message translates to:
  /// **'Start Your Journey with Us!'**
  String get screen_title_sign_up_choice;

  /// No description provided for @screen_title_driver_sign_up_step1.
  ///
  /// In en, this message translates to:
  /// **'Tell us a bit about yourself to get started!'**
  String get screen_title_driver_sign_up_step1;

  /// No description provided for @screen_title_driver_sign_up_step2.
  ///
  /// In en, this message translates to:
  /// **'Upload your photo and documents to verify your account!'**
  String get screen_title_driver_sign_up_step2;

  /// No description provided for @screen_title_driver_sign_up_step3.
  ///
  /// In en, this message translates to:
  /// **'Enter your vehicle details so we can set you up on the road!'**
  String get screen_title_driver_sign_up_step3;

  /// No description provided for @screen_title_driver_sign_up_step4.
  ///
  /// In en, this message translates to:
  /// **'Add your bank account to receive your earnings securely!'**
  String get screen_title_driver_sign_up_step4;

  /// No description provided for @screen_title_user_sign_up.
  ///
  /// In en, this message translates to:
  /// **'Sign up now — your next ride or meal is just a tap away 🚴‍♂️🍔'**
  String get screen_title_user_sign_up;

  /// No description provided for @screen_title_merchant_sign_up_step1.
  ///
  /// In en, this message translates to:
  /// **'Tell us about yourself to kickstart your merchant journey!'**
  String get screen_title_merchant_sign_up_step1;

  /// No description provided for @screen_title_merchant_sign_up_step2.
  ///
  /// In en, this message translates to:
  /// **'Share your outlet details and location so customers can find you easily!'**
  String get screen_title_merchant_sign_up_step2;

  /// No description provided for @screen_title_merchant_sign_up_step3.
  ///
  /// In en, this message translates to:
  /// **'Add your bank account to receive payments securely!'**
  String get screen_title_merchant_sign_up_step3;

  /// No description provided for @screen_title_forgot_password.
  ///
  /// In en, this message translates to:
  /// **'Forgot Password'**
  String get screen_title_forgot_password;

  /// No description provided for @screen_title_reset_password.
  ///
  /// In en, this message translates to:
  /// **'Reset Password'**
  String get screen_title_reset_password;

  /// No description provided for @screen_title_edit_profile.
  ///
  /// In en, this message translates to:
  /// **'Edit Profile'**
  String get screen_title_edit_profile;

  /// No description provided for @screen_title_change_password.
  ///
  /// In en, this message translates to:
  /// **'Change Password'**
  String get screen_title_change_password;

  /// No description provided for @screen_title_wallet.
  ///
  /// In en, this message translates to:
  /// **'E-Wallet'**
  String get screen_title_wallet;

  /// No description provided for @screen_title_top_up.
  ///
  /// In en, this message translates to:
  /// **'Top Up'**
  String get screen_title_top_up;

  /// No description provided for @screen_title_driver_dashboard.
  ///
  /// In en, this message translates to:
  /// **'Driver Dashboard'**
  String get screen_title_driver_dashboard;

  /// No description provided for @screen_title_earnings_wallet.
  ///
  /// In en, this message translates to:
  /// **'Earnings & Wallet'**
  String get screen_title_earnings_wallet;

  /// No description provided for @screen_title_order_history.
  ///
  /// In en, this message translates to:
  /// **'Order History'**
  String get screen_title_order_history;

  /// No description provided for @screen_title_my_schedule.
  ///
  /// In en, this message translates to:
  /// **'My Schedule (KRS)'**
  String get screen_title_my_schedule;

  /// No description provided for @screen_title_merchant_edit_profile.
  ///
  /// In en, this message translates to:
  /// **'Edit Profile'**
  String get screen_title_merchant_edit_profile;

  /// No description provided for @screen_title_setup_outlet.
  ///
  /// In en, this message translates to:
  /// **'Set Up Outlet'**
  String get screen_title_setup_outlet;

  /// No description provided for @screen_title_order_detail.
  ///
  /// In en, this message translates to:
  /// **'Order Detail'**
  String get screen_title_order_detail;

  /// No description provided for @screen_title_menu_detail.
  ///
  /// In en, this message translates to:
  /// **'Menu\'s Detail'**
  String get screen_title_menu_detail;

  /// No description provided for @screen_title_sales_report.
  ///
  /// In en, this message translates to:
  /// **'Sales Report'**
  String get screen_title_sales_report;

  /// No description provided for @screen_title_commission_report.
  ///
  /// In en, this message translates to:
  /// **'Commission Report'**
  String get screen_title_commission_report;

  /// No description provided for @screen_title_merchant_change_password.
  ///
  /// In en, this message translates to:
  /// **'Change Password'**
  String get screen_title_merchant_change_password;

  /// No description provided for @screen_title_where_you_at.
  ///
  /// In en, this message translates to:
  /// **'Where you at?'**
  String get screen_title_where_you_at;

  /// No description provided for @screen_title_where_going.
  ///
  /// In en, this message translates to:
  /// **'Where are you going?'**
  String get screen_title_where_going;

  /// No description provided for @screen_title_on_trip.
  ///
  /// In en, this message translates to:
  /// **'On Trip'**
  String get screen_title_on_trip;

  /// No description provided for @screen_title_trip_details.
  ///
  /// In en, this message translates to:
  /// **'Trip Details'**
  String get screen_title_trip_details;

  /// No description provided for @screen_title_create_menu.
  ///
  /// In en, this message translates to:
  /// **'Create Menu'**
  String get screen_title_create_menu;

  /// No description provided for @screen_title_edit_menu.
  ///
  /// In en, this message translates to:
  /// **'Edit Menu'**
  String get screen_title_edit_menu;

  /// No description provided for @dialog_title_sign_up_success.
  ///
  /// In en, this message translates to:
  /// **'Sign Up Success'**
  String get dialog_title_sign_up_success;

  /// No description provided for @dialog_title_sign_up_failed.
  ///
  /// In en, this message translates to:
  /// **'Sign Up Failed'**
  String get dialog_title_sign_up_failed;

  /// No description provided for @dialog_title_location_permission.
  ///
  /// In en, this message translates to:
  /// **'Location Permission'**
  String get dialog_title_location_permission;

  /// No description provided for @dialog_title_permission_denied.
  ///
  /// In en, this message translates to:
  /// **'Permission Denied'**
  String get dialog_title_permission_denied;

  /// No description provided for @dialog_title_location_disabled.
  ///
  /// In en, this message translates to:
  /// **'Location Services Disabled'**
  String get dialog_title_location_disabled;

  /// No description provided for @dialog_title_location_permission_required.
  ///
  /// In en, this message translates to:
  /// **'Location Permission Required'**
  String get dialog_title_location_permission_required;

  /// No description provided for @dialog_title_search_error.
  ///
  /// In en, this message translates to:
  /// **'Search Error'**
  String get dialog_title_search_error;

  /// No description provided for @dialog_title_location_found.
  ///
  /// In en, this message translates to:
  /// **'Location Found'**
  String get dialog_title_location_found;

  /// No description provided for @dialog_title_not_found.
  ///
  /// In en, this message translates to:
  /// **'Not Found'**
  String get dialog_title_not_found;

  /// No description provided for @dialog_title_validation_error.
  ///
  /// In en, this message translates to:
  /// **'Validation Error'**
  String get dialog_title_validation_error;

  /// No description provided for @dialog_title_error.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get dialog_title_error;

  /// No description provided for @dialog_title_oops.
  ///
  /// In en, this message translates to:
  /// **'Oops...'**
  String get dialog_title_oops;

  /// No description provided for @dialog_title_new_order.
  ///
  /// In en, this message translates to:
  /// **'New {type} Order'**
  String dialog_title_new_order(String type);

  /// No description provided for @dialog_title_order_unavailable.
  ///
  /// In en, this message translates to:
  /// **'Order Unavailable'**
  String get dialog_title_order_unavailable;

  /// No description provided for @dialog_title_order_rejected.
  ///
  /// In en, this message translates to:
  /// **'Order Rejected'**
  String get dialog_title_order_rejected;

  /// No description provided for @dialog_title_rate_customer.
  ///
  /// In en, this message translates to:
  /// **'Rate Customer'**
  String get dialog_title_rate_customer;

  /// No description provided for @dialog_title_success.
  ///
  /// In en, this message translates to:
  /// **'Success'**
  String get dialog_title_success;

  /// No description provided for @dialog_title_emergency_alert.
  ///
  /// In en, this message translates to:
  /// **'Emergency Alert'**
  String get dialog_title_emergency_alert;

  /// No description provided for @dialog_title_report_emergency.
  ///
  /// In en, this message translates to:
  /// **'Report Emergency'**
  String get dialog_title_report_emergency;

  /// No description provided for @dialog_title_confirm_logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get dialog_title_confirm_logout;

  /// No description provided for @dialog_title_reject_order.
  ///
  /// In en, this message translates to:
  /// **'Reject Order'**
  String get dialog_title_reject_order;

  /// No description provided for @dialog_title_cancel_order.
  ///
  /// In en, this message translates to:
  /// **'Cancel Order'**
  String get dialog_title_cancel_order;

  /// No description provided for @dialog_title_delete_schedule.
  ///
  /// In en, this message translates to:
  /// **'Delete Schedule'**
  String get dialog_title_delete_schedule;

  /// No description provided for @dialog_title_accept_order.
  ///
  /// In en, this message translates to:
  /// **'Accept Order'**
  String get dialog_title_accept_order;

  /// No description provided for @dialog_title_delete_menu.
  ///
  /// In en, this message translates to:
  /// **'Delete Menu'**
  String get dialog_title_delete_menu;

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

  /// No description provided for @message_location_permission_required.
  ///
  /// In en, this message translates to:
  /// **'Location permission is required to set your outlet location automatically.'**
  String get message_location_permission_required;

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

  /// No description provided for @message_emergency_confirmation.
  ///
  /// In en, this message translates to:
  /// **'This will send an emergency alert to campus authorities and notify emergency contacts. Are you sure you want to continue?'**
  String get message_emergency_confirmation;

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

  /// No description provided for @status_dragging_marker.
  ///
  /// In en, this message translates to:
  /// **'Dragging...'**
  String get status_dragging_marker;

  /// No description provided for @status_welcome_back.
  ///
  /// In en, this message translates to:
  /// **'Welcome back!'**
  String get status_welcome_back;

  /// No description provided for @status_license_plate.
  ///
  /// In en, this message translates to:
  /// **'License Plate: '**
  String get status_license_plate;

  /// No description provided for @status_rating.
  ///
  /// In en, this message translates to:
  /// **'{rating} rating'**
  String status_rating(String rating);

  /// No description provided for @status_driver_status.
  ///
  /// In en, this message translates to:
  /// **'Driver Status'**
  String get status_driver_status;

  /// No description provided for @status_accepting_orders.
  ///
  /// In en, this message translates to:
  /// **'You are accepting orders'**
  String get status_accepting_orders;

  /// No description provided for @status_offline.
  ///
  /// In en, this message translates to:
  /// **'You are offline'**
  String get status_offline;

  /// No description provided for @status_ready_accept.
  ///
  /// In en, this message translates to:
  /// **'Ready to accept new orders'**
  String get status_ready_accept;

  /// No description provided for @status_toggle_receive.
  ///
  /// In en, this message translates to:
  /// **'Toggle on to start receiving orders'**
  String get status_toggle_receive;

  /// No description provided for @status_today_performance.
  ///
  /// In en, this message translates to:
  /// **'Today\'s Performance'**
  String get status_today_performance;

  /// No description provided for @status_trips.
  ///
  /// In en, this message translates to:
  /// **'Trips'**
  String get status_trips;

  /// No description provided for @status_quick_actions.
  ///
  /// In en, this message translates to:
  /// **'Quick Actions'**
  String get status_quick_actions;

  /// No description provided for @status_manage_schedule.
  ///
  /// In en, this message translates to:
  /// **'Manage Schedule'**
  String get status_manage_schedule;

  /// No description provided for @status_hello.
  ///
  /// In en, this message translates to:
  /// **'Hello, {name}'**
  String status_hello(String name);

  /// No description provided for @status_open_today.
  ///
  /// In en, this message translates to:
  /// **'Open Today'**
  String get status_open_today;

  /// No description provided for @status_operating_hours.
  ///
  /// In en, this message translates to:
  /// **'10.00 - 22.00 WIB'**
  String get status_operating_hours;

  /// No description provided for @status_sales_recap.
  ///
  /// In en, this message translates to:
  /// **'Sales Recap'**
  String get status_sales_recap;

  /// No description provided for @status_today_transaction.
  ///
  /// In en, this message translates to:
  /// **'Today\'s transaction'**
  String get status_today_transaction;

  /// No description provided for @status_today_gross_sales.
  ///
  /// In en, this message translates to:
  /// **'Today\'s gross sales'**
  String get status_today_gross_sales;

  /// No description provided for @status_see_detail.
  ///
  /// In en, this message translates to:
  /// **'See detail'**
  String get status_see_detail;

  /// No description provided for @status_send_packages.
  ///
  /// In en, this message translates to:
  /// **'Send packages within campus'**
  String get status_send_packages;

  /// No description provided for @status_max_weight.
  ///
  /// In en, this message translates to:
  /// **'Max weight: 20kg'**
  String get status_max_weight;

  /// No description provided for @status_fast_delivery.
  ///
  /// In en, this message translates to:
  /// **'Fast delivery'**
  String get status_fast_delivery;

  /// No description provided for @status_secure_handling.
  ///
  /// In en, this message translates to:
  /// **'Secure handling'**
  String get status_secure_handling;

  /// No description provided for @status_start_delivery.
  ///
  /// In en, this message translates to:
  /// **'Start Delivery'**
  String get status_start_delivery;

  /// No description provided for @status_choose_pickup_destination.
  ///
  /// In en, this message translates to:
  /// **'Choose your pick-up and destination point!'**
  String get status_choose_pickup_destination;

  /// No description provided for @status_rating_score.
  ///
  /// In en, this message translates to:
  /// **'Rating: {score} / 5.0'**
  String status_rating_score(String score);

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
