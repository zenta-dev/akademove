// dart format off
// coverage:ignore-file

// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get popular_merchants => 'Popular merchants';

  @override
  String get choose_the_service_that_you_want => 'Choose the service that you want';

  @override
  String get pending_approval => 'Pending Approval';

  @override
  String get approved => 'Approved';

  @override
  String get rejected => 'Rejected';

  @override
  String get suspended => 'Suspended';

  @override
  String get app_version_information => 'App information and version';

  @override
  String get about => 'About';

  @override
  String get manage_notification_preferences => 'Manage notification preferences';

  @override
  String get notifications => 'Notifications';

  @override
  String get driver_preferences_and_settings => 'Driver preferences and settings';

  @override
  String get settings => 'Settings';

  @override
  String get save => 'Save';

  @override
  String get profile_updated_successfully => 'Profile updated successfully';

  @override
  String get license_plate_cannot_be_empty => 'License plate cannot be empty';

  @override
  String get enter_license_plate => 'Enter license plate';

  @override
  String get update_your_license_plate => 'Update your license plate information';

  @override
  String get logged_out_successfully => 'Logged out successfully';

  @override
  String get are_you_sure_you_want_to_logout => 'Are you sure you want to logout?';

  @override
  String get logout => 'Logout';

  @override
  String get bank_account => 'Bank Account';

  @override
  String get uploaded => 'Uploaded';

  @override
  String get missing => 'Missing';

  @override
  String get student_card => 'Student Card (KTM)';

  @override
  String get driver_license => 'Driver License (SIM)';

  @override
  String get vehicle_certificate => 'Vehicle Certificate (STNK)';

  @override
  String get taking_orders => 'Taking Orders';

  @override
  String get not_taking_orders => 'Not Taking Orders';

  @override
  String get license_plate => 'License Plate';

  @override
  String get failed_to_load_profile => 'Failed to load profile';

  @override
  String get retry => 'Retry';

  @override
  String get close => 'Close';

  @override
  String get chat_with_customer => 'Chat with Customer';

  @override
  String get tap_the_phone_number_to_copy_it_then_use_your_phone_app_to_call => 'Ketuk nomor telepon untuk menyalinnya, lalu gunakan aplikasi telepon Anda untuk menelepon.';

  @override
  String get customer_phone_number => 'Customer Phone Number';

  @override
  String get mark_as_arrived => 'Mark as Arrived';

  @override
  String get no => 'No';

  @override
  String get yes_cancel => 'Yes, Cancel';

  @override
  String get are_you_sure_you_want_to_cancel_this_order => 'Are you sure you want to cancel this order? The customer will be notified.';

  @override
  String get cancel_order => 'Cancel Order';

  @override
  String get start_trip => 'Start Trip';

  @override
  String get cancel => 'Cancel';

  @override
  String get are_you_sure_you_want_to_reject_this_order => 'Are you sure you want to reject this order? This action cannot be undone.';

  @override
  String get rate_customer => 'Rate Customer';

  @override
  String get back_to_home => 'Back to Home';

  @override
  String get complete_trip => 'Complete Trip';

  @override
  String get reject_order => 'Reject Order';

  @override
  String get accept_order => 'Accept Order';

  @override
  String get customer_phone_number_not_available => 'Customer phone number not available';

  @override
  String get warning => 'Warning';

  @override
  String get customer_info => 'Customer Info';

  @override
  String get distance => 'Distance';

  @override
  String get fare => 'Fare';

  @override
  String get service => 'Service';

  @override
  String get cancelled_by_user => 'Cancelled by User';

  @override
  String get cancelled_by_driver => 'Cancelled by Driver';

  @override
  String get cancelled_by_merchant => 'Cancelled by Merchant';

  @override
  String get cancelled_by_system => 'Cancelled by System';

  @override
  String get preparing_order => 'Preparing Order';

  @override
  String get finding_driver => 'Finding Driver';

  @override
  String get pickup_location => 'Pickup Location';

  @override
  String get dropoff_location => 'Dropoff Location';

  @override
  String get schedule_added_successfully => 'Schedule added successfully';

  @override
  String get schedule_updated_successfully => 'Schedule updated successfully';

  @override
  String get delete_schedule => 'Delete Schedule';

  @override
  String are_you_sure_you_want_to_delete_schedule(Object name) {
    return 'Are you sure you want to delete \"$name\"? This action cannot be undone.';
  }

  @override
  String get sunday => 'Sunday';

  @override
  String get monday => 'Monday';

  @override
  String get tuesday => 'Tuesday';

  @override
  String get wednesday => 'Wednesday';

  @override
  String get thursday => 'Thursday';

  @override
  String get friday => 'Friday';

  @override
  String get saturday => 'Saturday';

  @override
  String get failed_to_add_schedule => 'Failed to add schedule';

  @override
  String get failed_to_update_schedule => 'Failed to update schedule';

  @override
  String get update => 'Update';

  @override
  String get delete => 'Delete';

  @override
  String get add => 'Add';

  @override
  String get please_enter_a_schedule_name => 'Please enter a schedule name';

  @override
  String get disable_orders_during_this_time => 'Disable orders during this time';

  @override
  String get repeat_every_week => 'Repeat every week';

  @override
  String get start_time => 'Start Time';

  @override
  String get end_time => 'End Time';

  @override
  String get day_of_week => 'Day of Week';

  @override
  String get schedule_name => 'Schedule Name';

  @override
  String get recurring => 'Recurring';

  @override
  String get add_your_class_schedule_to_automatically_disable_order_acceptance_during_class_time => 'Add your class schedule to automatically disable order acceptance during class time';

  @override
  String get my_schedule => 'My Schedule (KRS)';

  @override
  String get no_schedules_found => 'No schedules found';

  @override
  String get no_schedules_yet => 'No schedules yet';

  @override
  String get schedule_deleted_successfully => 'Schedule deleted successfully';

  @override
  String get failed_to_delete_schedule => 'Failed to delete schedule';

  @override
  String get manage_schedule => 'Manage Schedule';

  @override
  String get leadeboard_and_badges => 'Leaderboard & Badges';

  @override
  String get trips => 'Trips';

  @override
  String get ready_to_accept_new_orders => 'Ready to accept new orders';

  @override
  String get toggle_on_to_start_receiving_orders => 'Toggle on to start receiving orders';

  @override
  String get requested => 'Requested';

  @override
  String get matching => 'Matching';

  @override
  String get preparing => 'Preparing';

  @override
  String get ready_for_pickup => 'Ready for Pickup';

  @override
  String get accepted => 'Accepted';

  @override
  String get arriving => 'Arriving';

  @override
  String get in_trip => 'In Trip';

  @override
  String get your_completed_and_cancelled_orders_will_appear_here => 'Your completed and cancelled orders will appear here';

  @override
  String get no_orders_found => 'No orders found';

  @override
  String get all_types => 'All types';

  @override
  String get all => 'All';

  @override
  String get completed => 'Completed';

  @override
  String get in_progress => 'In Progress';

  @override
  String get cancelled => 'Cancelled';

  @override
  String get failed_to_load_orders => 'Failed to load orders';

  @override
  String get top_up => 'Top Up';

  @override
  String get withdrawal => 'Withdrawal';

  @override
  String get payment => 'Payment';

  @override
  String get refund => 'Refund';

  @override
  String get adjustment => 'Adjustment';

  @override
  String get commission => 'Commission';

  @override
  String get earning => 'Earning';

  @override
  String get failed_to_withdraw => 'Failed to withdraw ';

  @override
  String get withdraw => 'Withdraw';

  @override
  String get please_enter_withdrawal_amount => 'Please enter withdrawal amount';

  @override
  String get please_enter_bank_account_number => 'Please enter bank account number';

  @override
  String get insufficient_balance => 'Insufficient balance';

  @override
  String get hint_account_name => 'Enter the account holder\'s name';

  @override
  String get optional => 'Optional';

  @override
  String get account_name => 'Account Name';

  @override
  String get hint_bank_account_number => 'Enter your bank account number';

  @override
  String get withdraw_earnings => 'Withdraw Earnings';

  @override
  String get no_transactions_yet => 'No transactions yet';

  @override
  String get view_all => 'View All';

  @override
  String get recent_transactions => 'Recent Transactions';

  @override
  String get net_earnings => 'Net Earnings';

  @override
  String get total_earnings => 'Total Earnings';

  @override
  String get total_income => 'Total Income';

  @override
  String get total_expenses => 'Total Expenses';

  @override
  String get active => 'Active';

  @override
  String get inactive => 'Inactive';

  @override
  String get available_balance => 'Available Balance';

  @override
  String get earnings_wallet => 'Earnings & wallet';

  @override
  String get failed_to_load_earnings => 'Failed to load earnings';

  @override
  String get amount => 'Amount';

  @override
  String get unsupported_role_desc => 'This user role is not supported in the mobile app, please use web app';

  @override
  String get invalid_amount => 'Invalid amount';

  @override
  String get top_up_success => 'Top up successful';

  @override
  String get qr_code_expired => 'The QR code has expired';

  @override
  String get hello => 'Hello';

  @override
  String get payment_expired => 'Payment Expired';

  @override
  String get total => 'Total';

  @override
  String get e_wallet => 'E-wallet';

  @override
  String get my_balance => 'My Balance';

  @override
  String get success_sign_in => 'Successfully signed in';

  @override
  String get light_mode => 'Light Mode';

  @override
  String get dark_mode => 'Dark Mode';

  @override
  String get system_mode => 'System Mode';

  @override
  String get email => 'Email';

  @override
  String get password => 'Password';

  @override
  String get forget_password => 'Forget Password?';

  @override
  String get sign_in => 'Sign In';

  @override
  String get loading => 'Loading...';

  @override
  String get just_a_moment => 'Just a moment...';

  @override
  String get didnt_have_account => 'Don\'t have an account?';

  @override
  String get sign_up => 'Sign Up';

  @override
  String get lets_sign_in_to_the_akademove => 'Let\'s Sign In to the AkadeMove!';

  @override
  String get language => 'Language';

  @override
  String get theme => 'Theme';

  @override
  String get app_settings => 'App Settings';

  @override
  String get account_settings => 'Account Settings';

  @override
  String get privacy_policy => 'Privacy Policy';

  @override
  String get change_password => 'Change Password';

  @override
  String get edit_profile => 'Edit Profile';

  @override
  String get sign_out => 'Sign Out';

  @override
  String get select_your_preferred_language => 'Select your preferred language';

  @override
  String get select_your_preferred_theme => 'Select your preferred theme';

  @override
  String get history => 'History';

  @override
  String get home => 'Home';

  @override
  String get profile => 'Profile';

  @override
  String get an_error_occurred => 'An error occurred';

  @override
  String get info => 'Information';

  @override
  String get success => 'Success';

  @override
  String get error => 'Error';

  @override
  String get failed => 'Failed';

  @override
  String get your_driver_is => 'Your driver is';

  @override
  String get origin => 'Origin';

  @override
  String get destination => 'Destination';

  @override
  String get special_instructions => 'Special Instructions (Optional)';

  @override
  String get special_instructions_hint => 'e.g., \'Please handle with care\', \'Call before delivery\'';

  @override
  String get delivery_service => 'Delivery Service';

  @override
  String get back => 'Back';

  @override
  String get next => 'Next';

  @override
  String get submit => 'Submit';

  @override
  String get save_changes => 'Save Changes';

  @override
  String get allow => 'Allow';

  @override
  String get open_settings => 'Open Settings';

  @override
  String get send_reset_link => 'Send Reset Link';

  @override
  String get back_to_sign_in => 'Back to Sign In';

  @override
  String get reset_password => 'Reset Password';

  @override
  String get reject => 'Reject';

  @override
  String get accept => 'Accept';

  @override
  String get grant_permission => 'Grant Permission';

  @override
  String get send_alert => 'Send Alert';

  @override
  String get download_qr => 'Download QR';

  @override
  String get copy_qr_url => 'Copy QR URL';

  @override
  String get name => 'Name';

  @override
  String get phone => 'Phone';

  @override
  String get gender => 'Gender';

  @override
  String get photo => 'Photo';

  @override
  String get address => 'Address';

  @override
  String get location => 'Location';

  @override
  String get unknown => 'Unknown';

  @override
  String get user_role => 'User';

  @override
  String get driver_role => 'Driver';

  @override
  String get merchant_role => 'Merchant';

  @override
  String get student_id => 'NIM';

  @override
  String get confirm_password => 'Confirm Password';

  @override
  String get vehicle_registration => 'Vehicle Registration (STNK)';

  @override
  String get bank_provider => 'Bank Provider';

  @override
  String get owner_name => 'Owner Name';

  @override
  String get outlet_name => 'Outlet Name';

  @override
  String get outlet_category => 'Outlet Category';

  @override
  String get outlet_location => 'Outlet Location';

  @override
  String get government_document => 'Government Document';

  @override
  String get bank_account_number => 'Bank Account Number';

  @override
  String get choose_service => 'Choose the service that you want';

  @override
  String get popular_merchant => 'Popular merchant';

  @override
  String get ride => 'Ride';

  @override
  String get delivery => 'Delivery';

  @override
  String get mart => 'AMart';

  @override
  String get wallet => 'E-wallet';

  @override
  String get voucher => 'My Voucher';

  @override
  String get photo_profile => 'Photo Profile';

  @override
  String get old_password => 'Old Password';

  @override
  String get new_password => 'New Password';

  @override
  String get confirm_new_password => 'Confirm New Password';

  @override
  String get this_month => 'This month';

  @override
  String get expenses => 'Expenses';

  @override
  String get income => 'Income';

  @override
  String get payment_method_qris => 'QRIS';

  @override
  String get order_id => 'Order #';

  @override
  String get pickup => 'Pickup';

  @override
  String get dropoff => 'Dropoff';

  @override
  String get earnings => 'Earnings';

  @override
  String get gender_preference => 'Gender preference: ';

  @override
  String get note => 'Note:';

  @override
  String get order_type_ride => 'Ride';

  @override
  String get order_type_delivery => 'Delivery';

  @override
  String get order_type_food => 'Food';

  @override
  String get note_pickup => 'Pickup: ';

  @override
  String get note_dropoff => 'Dropoff: ';

  @override
  String get note_instructions => 'Instructions: ';

  @override
  String get benefit_nearby_orders => 'Match you with nearby orders';

  @override
  String get benefit_track_arrival => 'Let customers track your arrival';

  @override
  String get benefit_safety => 'Ensure safety and accountability';

  @override
  String get review_category => 'Review Category';

  @override
  String get cleanliness => 'Cleanliness';

  @override
  String get courtesy => 'Courtesy';

  @override
  String get other => 'Other';

  @override
  String get comment_optional => 'Comment (Optional)';

  @override
  String get select_type => 'Select emergency type:';

  @override
  String get accident => 'Accident';

  @override
  String get harassment => 'Harassment';

  @override
  String get theft => 'Theft';

  @override
  String get medical => 'Medical Emergency';

  @override
  String get description => 'Description:';

  @override
  String get akademove_pay => 'Akademove Pay';

  @override
  String get valid_until => 'Valid until ';

  @override
  String get remaining_time => 'Remaining Time :';

  @override
  String get atk => 'ATK (Stationery)';

  @override
  String get printing => 'Printing';

  @override
  String get food => 'Food & Beverages';

  @override
  String get drag_marker => 'Drag to adjust position';

  @override
  String get step_1 => 'Step 1';

  @override
  String get step_2 => 'Step 2';

  @override
  String get step_3 => 'Step 3';

  @override
  String get step_4 => 'Step 4';

  @override
  String get hint_bank_provider => 'Pick your bank provider';

  @override
  String get hint_outlet_category => 'Select outlet category';

  @override
  String get hint_search_location => 'Search location (e.g., Monas Jakarta)';

  @override
  String get hint_share_experience => 'Share your experience...';

  @override
  String get hint_description => 'Describe the emergency situation...';

  @override
  String get sign_up_choice => 'Start Your Journey with Us!';

  @override
  String get driver_sign_up_step1 => 'Tell us a bit about yourself to get started!';

  @override
  String get driver_sign_up_step2 => 'Upload your photo and documents to verify your account!';

  @override
  String get driver_sign_up_step3 => 'Enter your vehicle details so we can set you up on the road!';

  @override
  String get driver_sign_up_step4 => 'Add your bank account to receive your earnings securely!';

  @override
  String get user_sign_up => 'Sign up now — your next ride or meal is just a tap away 🚴‍♂️🍔';

  @override
  String get merchant_sign_up_step1 => 'Tell us about yourself to kickstart your merchant journey!';

  @override
  String get merchant_sign_up_step2 => 'Share your outlet details and location so customers can find you easily!';

  @override
  String get merchant_sign_up_step3 => 'Add your bank account to receive payments securely!';

  @override
  String get forgot_password => 'Forgot Password';

  @override
  String get driver_dashboard => 'Driver Dashboard';

  @override
  String get order_history => 'Order History';

  @override
  String get merchant_edit_profile => 'Edit Profile';

  @override
  String get setup_outlet => 'Set Up Outlet';

  @override
  String get order_detail => 'Order Detail';

  @override
  String get menu_detail => 'Menu\'s Detail';

  @override
  String get sales_report => 'Sales Report';

  @override
  String get commission_report => 'Commission Report';

  @override
  String get merchant_change_password => 'Change Password';

  @override
  String get where_you_at => 'Where you at?';

  @override
  String get where_going => 'Where are you going?';

  @override
  String get on_trip => 'On Trip';

  @override
  String get trip_details => 'Trip Details';

  @override
  String get create_menu => 'Create Menu';

  @override
  String get edit_menu => 'Edit Menu';

  @override
  String get sign_up_success => 'Sign Up Success';

  @override
  String get sign_up_failed => 'Sign Up Failed';

  @override
  String get location_permission => 'Location Permission';

  @override
  String get permission_denied => 'Permission Denied';

  @override
  String get location_disabled => 'Location Services Disabled';

  @override
  String get location_permission_required => 'Location Permission Required';

  @override
  String get search_error => 'Search Error';

  @override
  String get location_found => 'Location Found';

  @override
  String get not_found => 'Not Found';

  @override
  String get validation_error => 'Validation Error';

  @override
  String get oops => 'Oops...';

  @override
  String new_order(String type) {
    return 'New $type Order';
  }

  @override
  String get order_unavailable => 'Order Unavailable';

  @override
  String get order_rejected => 'Order Rejected';

  @override
  String get alert => 'Emergency Alert';

  @override
  String get report_emergency => 'Report Emergency';

  @override
  String get confirm_logout => 'Logout';

  @override
  String get delete_menu => 'Delete Menu';

  @override
  String get description_user_role => 'Enjoy a comfortable and safe journey to your destination.';

  @override
  String get description_driver_role => 'Earn extra income by driving with us.';

  @override
  String get description_merchant_role => 'Expand your business reach with our platform.';

  @override
  String get description_forgot_password => 'Enter your email to receive password reset instructions';

  @override
  String get description_reset_password => 'Enter your new password';

  @override
  String get helper_outlet_category => 'Select the main category for your outlet';

  @override
  String get helper_outlet_location => 'Search for a location, tap on map, or drag the marker';

  @override
  String get error_password_mismatch => 'Passwords do not match';

  @override
  String get error_file_required => 'File shouldn\'t be empty';

  @override
  String get error_photo_pick_failed => 'Failed to pick photo';

  @override
  String get error_unknown => 'Unknown error';

  @override
  String get error_unexpected => 'An unexpected error occurred';

  @override
  String get error_complete_required_fields => 'Please complete all required fields';

  @override
  String get error_fill_required_fields => 'Please fill all required fields';

  @override
  String get error_location_search_empty => 'Please enter a location to search';

  @override
  String get error_location_not_found => 'Location not found. Please try a different search.';

  @override
  String get error_location_search_failed => 'Unable to search location. Please check your internet connection.';

  @override
  String get error_address_unavailable => 'Unable to get address';

  @override
  String get error_invalid_reset_token => 'Invalid or missing reset token';

  @override
  String get error_description_required => 'Please provide a description';

  @override
  String get error_access_denied => 'Access denied. Please grant permission in settings.';

  @override
  String get error_storage_full => 'Not enough storage space.';

  @override
  String get error_format_unsupported => 'Image format not supported.';

  @override
  String get error_unexpected_prefix => 'Unexpected error: ';

  @override
  String get error_qr_save_failed => 'Failed to save QR code: ';

  @override
  String get error_qr_copy_failed => 'Failed to copy QR URL: ';

  @override
  String get error_review_submit_failed => 'Failed to submit review';

  @override
  String get error_invalid_amount => 'Invalid amount';

  @override
  String get error_top_up_minimum => 'Top up amount atleast Rp 10,000';

  @override
  String get error_failed_to_estimate => 'Failed to estimate order';

  @override
  String get error_get_estimate_first => 'Please get estimate first';

  @override
  String get error_fill_all_fields => 'Please fill all required fields correctly';

  @override
  String get error_enter_bank_account => 'Please enter bank account number';

  @override
  String get error_select_bank_first => 'Please select a bank provider first';

  @override
  String get success_sign_up => 'Successfully signed up';

  @override
  String get success_location_found => 'Marker moved to searched location';

  @override
  String get success_review_submitted => 'Review submitted successfully';

  @override
  String get success_qr_saved => 'QR code saved successfully';

  @override
  String get success_qr_url_copied => 'QR URL copied to clipboard';

  @override
  String get success_menu_updated => 'Menu updated successfully';

  @override
  String get success_bank_verified => 'Bank account verified successfully';

  @override
  String get message_remember_password => 'Remember your password?';

  @override
  String get message_location_default => 'Using default location. You can drag the marker to set your outlet location.';

  @override
  String get message_leocation_permission_required => 'Location permission is required to set your outlet location automatically.';

  @override
  String get message_location_permission_explanation => 'We need access to your location to automatically set your outlet location on the map. This helps customers find your business easily.\n\nYou can also manually set the location by dragging the marker.';

  @override
  String get message_location_services_disabled => 'Location services are currently disabled on your device. Please enable them to automatically detect your outlet location.';

  @override
  String get message_location_permission_denied_forever => 'Location permission has been permanently denied. To use automatic location detection, please enable it in your app settings.\n\nYou can still manually set your outlet location by dragging the marker on the map.';

  @override
  String get message_order_unavailable => 'This order was cancelled or accepted by another driver';

  @override
  String get message_order_rejected => 'You rejected the order';

  @override
  String get message_location_permission_denied_permanent => 'Location permission was previously denied. To go online and accept orders, you need to enable location access in your device settings.';

  @override
  String get message_location_permission_explanation_driver => 'To accept ride and delivery orders, drivers must share their location in real-time. This helps:';

  @override
  String get message_redirect_settings => 'You will be redirected to app settings to enable location access.';

  @override
  String message_rate_experience(String name) {
    return 'How was your experience with $name?';
  }

  @override
  String get message_confirmation => 'This will send an emergency alert to campus authorities and notify emergency contacts. Are you sure you want to continue?';

  @override
  String get message_settings_coming_soon => 'Settings feature coming soon';

  @override
  String get message_failed_load_profile => 'Failed to load profile: ';

  @override
  String get message_failed_update_menu => 'Failed to update menu';

  @override
  String get message_failed_verify_bank => 'Failed to verify bank account';

  @override
  String get message_confirm_reject_order => 'Are you sure you want to reject this order? This action cannot be undone.';

  @override
  String get message_confirm_cancel_order => 'Are you sure you want to cancel this order? The customer will be notified.';

  @override
  String message_confirm_delete_schedule(String name) {
    return 'Are you sure you want to delete \"$name\"? This action cannot be undone.';
  }

  @override
  String get message_confirm_logout => 'Are you sure you want to logout?';

  @override
  String get message_confirm_accept_order => 'Are you sure you want to accept this order?';

  @override
  String get message_confirm_delete_menu => 'Are you sure want to delete this menu?';

  @override
  String get message_select_reject_reason => 'Please select a reason for rejecting this order:';

  @override
  String get dragging_marker => 'Dragging...';

  @override
  String get welcome_back => 'Welcome back!';

  @override
  String get license_plate => 'License Plate: ';

  @override
  String rating(String rating) {
    return '$rating rating';
  }

  @override
  String get driver_status => 'Driver Status';

  @override
  String get accepting_orders => 'You are accepting orders';

  @override
  String get offline => 'You are offline';

  @override
  String get ready_accept => 'Ready to accept new orders';

  @override
  String get toggle_receive => 'Toggle on to start receiving orders';

  @override
  String get today_performance => 'Today\'s Performance';

  @override
  String get trips => 'Trips';

  @override
  String get quick_actions => 'Quick Actions';

  @override
  String get manage_schedule => 'Manage Schedule';

  @override
  String hello(String name) {
    return 'Hello, $name';
  }

  @override
  String get open_today => 'Open Today';

  @override
  String get operating_hours => '10.00 - 22.00 WIB';

  @override
  String get sales_recap => 'Sales Recap';

  @override
  String get today_transaction => 'Today\'s transaction';

  @override
  String get today_gross_sales => 'Today\'s gross sales';

  @override
  String get see_detail => 'See detail';

  @override
  String get send_packages => 'Send packages within campus';

  @override
  String get max_weight => 'Max weight: 20kg';

  @override
  String get fast_delivery => 'Fast delivery';

  @override
  String get secure_handling => 'Secure handling';

  @override
  String get start_delivery => 'Start Delivery';

  @override
  String get choose_pickup_destination => 'Choose your pick-up and destination point!';

  @override
  String rating_score(String score) {
    return 'Rating: $score / 5.0';
  }

  @override
  String get action_take_photo => 'Take a photo';

  @override
  String get action_choose_gallery => 'Choose from gallery';

  @override
  String get action_remove_image => 'Remove image';

  @override
  String get enter_withdrawal_amount => 'Enter withdrawal amount';

  @override
  String get cart_shopping_cart => 'Shopping Cart';

  @override
  String get cart_your_cart_is_empty => 'Your cart is empty';

  @override
  String get cart_add_items_to_see_here => 'Add items from AMart to see them here';

  @override
  String get cart_browse_amart => 'Browse AMart';

  @override
  String cart_total_items(int count) {
    return 'Total ($count items)';
  }

  @override
  String get cart_checkout => 'Checkout';

  @override
  String get cart_coming_soon => 'Coming Soon';

  @override
  String get cart_order_confirmation_coming_soon => 'Order confirmation screen coming soon';

  @override
  String get cart_clear_cart => 'Clear Cart?';

  @override
  String get cart_clear_cart_confirmation => 'Are you sure you want to remove all items from your cart?';

  @override
  String get cart_clear => 'Clear';

  @override
  String get cart_failed_to_load => 'Failed to load cart';

  @override
  String get cart_note_prefix => 'Note: ';

  @override
  String get cart_replace_cart_items => 'Replace Cart Items?';

  @override
  String cart_contains_items_from(String merchantName) {
    return 'Your cart contains items from $merchantName.';
  }

  @override
  String cart_discard_and_add_from(String merchantName) {
    return 'Do you want to discard those items and add items from $merchantName instead?';
  }

  @override
  String get cart_current_cart_will_be_cleared => 'Your current cart will be cleared';

  @override
  String get cart_replace_cart => 'Replace Cart';

  @override
  String get menu_details => 'Menu Details';

  @override
  String menu_in_stock(int count) {
    return 'In Stock ($count available)';
  }

  @override
  String get menu_out_of_stock => 'Out of Stock';

  @override
  String get menu_quantity => 'Quantity';

  @override
  String get menu_special_notes_optional => 'Special Notes (Optional)';

  @override
  String get menu_total_price => 'Total Price';

  @override
  String get menu_add_to_cart => 'Add to Cart';

  @override
  String get menu_added_to_cart => 'Added to Cart';

  @override
  String get menu_item_added_to_cart => 'Item has been added to your cart';

  @override
  String get order_confirm_title => 'Confirm Order';

  @override
  String get order_confirm_order_summary => 'Order Summary';

  @override
  String get order_confirm_merchant => 'Merchant';

  @override
  String order_confirm_items_count(int count) {
    return '$count item(s)';
  }

  @override
  String get order_confirm_subtotal => 'Subtotal';

  @override
  String get order_confirm_payment_method => 'Payment Method';

  @override
  String get order_confirm_select_payment => 'Select payment method';

  @override
  String get order_confirm_payment_wallet => 'wallet';

  @override
  String get order_confirm_payment_description => 'Pay using your Akademove wallet balance';

  @override
  String get order_confirm_place_order => 'Place Order';

  @override
  String get order_confirm_success => 'Order Placed Successfully';

  @override
  String get order_confirm_success_message => 'Your order has been placed and is being processed';

  @override
  String get order_confirm_failed => 'Failed to Place Order';

  @override
  String get order_confirm_processing => 'Processing Order...';

  @override
  String get order_confirm_insufficient_balance => 'Insufficient wallet balance';

  @override
  String get rate_your_experience => 'Rate Your Experience';

  @override
  String get overall_rating => 'Overall Rating';

  @override
  String get cleanliness_rating => 'Cleanliness';

  @override
  String get courtesy_rating => 'Courtesy';

  @override
  String get other_rating => 'Other';

  @override
  String get add_comment_optional => 'Add Comment (Optional)';

  @override
  String get submit_review => 'Submit Review';

  @override
  String get review_submitted_successfully => 'Review submitted successfully';

  @override
  String get review_submission_failed => 'Failed to submit review';

  @override
  String get you_already_reviewed_order => 'You already reviewed this order';

  @override
  String get order_must_be_completed_first => 'Order must be completed first';

  @override
  String get rating_required => 'Please provide a rating';
}
