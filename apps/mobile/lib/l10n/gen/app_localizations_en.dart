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
  String get tax => 'Tax';

  @override
  String get distance => 'Distance';

  @override
  String get fare => 'Fare';

  @override
  String get platform_fee => 'Platform fee';

  @override
  String get transfer => 'Transfer';

  @override
  String get transfer_success => 'Transfer successful';

  @override
  String get transfer_failed => 'Transfer failed';

  @override
  String get recipient_user_id => 'Recipient User ID';

  @override
  String get enter_recipient_user_id => 'Enter recipient\'s user ID';

  @override
  String get enter_amount => 'Enter amount';

  @override
  String get enter_note => 'Enter note (optional)';

  @override
  String get error_recipient_required => 'Recipient user ID is required';

  @override
  String get error_transfer_minimum => 'Minimum transfer amount is Rp 1,000';

  @override
  String get confirm_transfer => 'Confirm Transfer';

  @override
  String get recipient => 'Recipient';

  @override
  String get recipient_phone => 'Recipient Phone Number';

  @override
  String get enter_recipient_phone => 'Enter recipient\'s phone number';

  @override
  String get lookup_recipient => 'Lookup';

  @override
  String get recipient_found => 'Recipient found';

  @override
  String get recipient_not_found => 'User not found with this phone number';

  @override
  String get use_user_id_instead => 'Use User ID instead';

  @override
  String get scan_qr => 'Scan QR';

  @override
  String get my_qr_code => 'My QR Code';

  @override
  String get scan_qr_to_transfer => 'Scan QR code to transfer';

  @override
  String get share_qr_to_receive => 'Share this QR code to receive transfer';

  @override
  String get or_enter_manually => 'Or enter manually';

  @override
  String get confirm => 'Confirm';

  @override
  String get select_bank => 'Select bank';

  @override
  String get edit_detail => 'Edit Detail';

  @override
  String get total_delivery_distance => 'Total delivery distance';

  @override
  String get choose_item_type => 'Choose your item type';

  @override
  String get document => 'Document';

  @override
  String get cloth => 'Cloth';

  @override
  String get medicine => 'Medicine';

  @override
  String get book => 'Book';

  @override
  String get other => 'Other';

  @override
  String get max => 'Max';

  @override
  String get choose_your_items_size => 'Choose your item\'s size';

  @override
  String get choose => 'Choose';

  @override
  String get total_weight => 'Total weight';

  @override
  String get small => 'Small';

  @override
  String get medium => 'Medium';

  @override
  String get large => 'Large';

  @override
  String get add_delivery_detail => 'Add delivery detail';

  @override
  String get pickup_and_dropoff_must_be_set => 'Pickup and dropoff locations must be set';

  @override
  String get start_quiz => 'Start Quiz';

  @override
  String get previous_attempt_failed => 'Previous attempt failed';

  @override
  String get previous_attempt_failed_description => 'Your previous quiz attempt did not pass. You can try again now.';

  @override
  String get driver_knowledge_quiz_description => 'Complete this quiz to demonstrate your understanding of driver guidelines, safety protocols, and platform rules.';

  @override
  String get driver_knowledge_quiz => 'Driver Knowledge Quiz';

  @override
  String get new_order_request => 'New order request';

  @override
  String get you_have_a_new_order_request_from_customer_please_check_your_orders_page => 'You have a new order request from customer, please check your Orders page.';

  @override
  String get dismiss => 'Dismiss';

  @override
  String get view_order => 'View Order';

  @override
  String get no_show => 'No Show';

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
  String get driver_information => 'Driver Information';

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
  String get license_plate => 'License Plate: ';

  @override
  String get failed_to_load_profile => 'Failed to load profile';

  @override
  String get retry => 'Retry';

  @override
  String get close => 'Close';

  @override
  String get chat_with_customer => 'Chat with Customer';

  @override
  String get chat_with_driver => 'Chat with Driver';

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
  String get leaderboard => 'Leaderboard';

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
  String hello(String name) {
    return 'Hello, $name';
  }

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
  String get terms_of_service => 'Terms of Service';

  @override
  String get privacy_policy => 'Privacy Policy';

  @override
  String get faq => 'FAQ';

  @override
  String get i_agree_to_the => 'I agree to the';

  @override
  String get terms_and_conditions => 'Terms and Conditions';

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
  String get send_reset_link => 'Send OTP Code';

  @override
  String get back_to_sign_in => 'Back to Sign In';

  @override
  String get reset_password => 'Reset Password';

  @override
  String get otp_code => 'OTP Code';

  @override
  String get otp_code_sent_to_email => 'We\'ve sent a 6-digit code to your email.';

  @override
  String get placeholder_otp_code => 'Enter 6-digit code';

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
  String get quick_actions => 'Quick Actions';

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
  String get withdraw_wallet_save_bank => 'Save bank details for future withdrawals';

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

  @override
  String get coupon_no_coupons_available => 'No coupons available';

  @override
  String get coupon_select_coupon => 'Select Coupon';

  @override
  String get coupon_remove_coupon => 'Remove Coupon';

  @override
  String get payment_method_wallet => 'Wallet';

  @override
  String get payment_method_bank_transfer => 'Bank Transfer';

  @override
  String get emergency_alert_sent_successfully => 'Emergency alert sent successfully';

  @override
  String get emergency_alert_title => 'Emergency Alert';

  @override
  String get emergency_report_title => 'Report Emergency';

  @override
  String get emergency_select_type => 'Select emergency type:';

  @override
  String get emergency_describe_situation => 'Describe the emergency situation...';

  @override
  String get emergency_send_alert => 'Send Alert';

  @override
  String get button_continue => 'Continue';

  @override
  String get leaderboard_title => 'Leaderboard';

  @override
  String get leaderboard_no_rankings => 'No rankings yet';

  @override
  String get leaderboard_no_badges => 'No badges available';

  @override
  String get leaderboard_pts => 'pts';

  @override
  String get chat_no_messages => 'No messages yet';

  @override
  String get merchant_order_accept => 'Accept';

  @override
  String get merchant_order_time_remaining => '01:00';

  @override
  String get gender_label => 'Gender:';

  @override
  String get top_up_qris => 'Top Up QRIS';

  @override
  String get rate_your_driver => 'Rate Your Driver';

  @override
  String get placeholder_name => 'John Doe';

  @override
  String get placeholder_email => 'john@gmail.com';

  @override
  String get placeholder_password => '********';

  @override
  String get dialog_location_permission => 'Location Permission';

  @override
  String get dialog_location_services_disabled => 'Location Services Disabled';

  @override
  String get dialog_location_permission_required => 'Location Permission Required';

  @override
  String get drag_to_adjust => 'Drag to adjust position';

  @override
  String get error_enter_location_to_search => 'Please enter a location to search';

  @override
  String get success_signed_up => 'Successfully signed up';

  @override
  String get error_fill_all_required_fields => 'Please fill all required fields correctly';

  @override
  String get error_complete_all_required_fields => 'Please complete all required fields';

  @override
  String get error_passwords_not_match => 'Passwords do not match';

  @override
  String get merchant_step_1_description => 'Tell us about yourself to kickstart your merchant journey!';

  @override
  String get merchant_step_2_description => 'Share your outlet details and location so customers can find you easily!';

  @override
  String get merchant_step_3_description => 'Add your bank account to receive payments securely!';

  @override
  String get placeholder_outlet_name => 'Enter outlet name';

  @override
  String get label_outlet_location => 'Outlet\'s Location';

  @override
  String get label_bank_provider => 'Bank Provider';

  @override
  String get label_outlet_category => 'Outlet Category';

  @override
  String get helper_outlet_category_select => 'Select the main category for your outlet';

  @override
  String get placeholder_select_outlet_category => 'Select outlet category';

  @override
  String get label_phone => 'Phone';

  @override
  String get dialog_accept_order => 'Accept Order';

  @override
  String get dialog_accept_order_confirm => 'Are you sure you want to accept this order?';

  @override
  String get toast_validation_error => 'Validation Error';

  @override
  String get error_menu_name_required => 'Menu name is required';

  @override
  String get error_menu_price_required => 'Menu price is required';

  @override
  String get error_valid_price_required => 'Please enter a valid price';

  @override
  String get error_merchant_info_not_found => 'Merchant information not found';

  @override
  String get success_menu_created => 'Menu created successfully';

  @override
  String get error_failed_create_menu => 'Failed to create menu';

  @override
  String get title_create_menu => 'Create Menu';

  @override
  String get placeholder_zero => '0';

  @override
  String get error_menu_info_not_found => 'Menu information not found';

  @override
  String get title_edit_menu => 'Edit Menu';

  @override
  String get error_menu_not_found => 'Menu not found';

  @override
  String get placeholder_search_menu => 'Search menu...';

  @override
  String get title_menu_detail => 'Menu Detail';

  @override
  String get dialog_delete_menu => 'Delete Menu';

  @override
  String dialog_delete_menu_confirm(String name) {
    return 'Are you sure you want to delete \"$name\"?';
  }

  @override
  String get success_menu_deleted => 'Menu deleted successfully';

  @override
  String get error_failed_delete_menu => 'Failed to delete menu';

  @override
  String get label_old_password => 'Old Password';

  @override
  String get placeholder_enter_old_password => 'Enter your old password';

  @override
  String get label_new_password => 'New Password';

  @override
  String get placeholder_enter_new_password => 'Enter your new password';

  @override
  String get label_confirm_password => 'Confirm Password';

  @override
  String get placeholder_confirm_new_password => 'Confirm your new password';

  @override
  String get error_failed_verify_bank => 'Failed to verify bank account';

  @override
  String get loading_map => 'Loading map...';

  @override
  String get success_set_up_merchant => 'Success set up merchant';

  @override
  String get title_set_up_outlet => 'Set Up Outlet';

  @override
  String get placeholder_time_start => '10:00';

  @override
  String get placeholder_time_end => '22:00';

  @override
  String get title_sales_report => 'Sales Report';

  @override
  String get tab_weekly_sales => 'Weekly Sales';

  @override
  String get tab_monthly_sales => 'Monthly Sales';

  @override
  String get title_commission_report => 'Commission Report';

  @override
  String get title_order_detail => 'Order Detail';

  @override
  String get button_add_schedule => 'Add Schedule';

  @override
  String get button_edit => 'Edit';

  @override
  String get placeholder_class_name => 'e.g., Mobile Programming';

  @override
  String get dialog_call_customer => 'Call Customer';

  @override
  String get section_today_performance => 'Today\'s Performance';

  @override
  String get section_quick_actions => 'Quick Actions';

  @override
  String get label_rating_suffix => 'rating';

  @override
  String get dialog_rate_customer => 'Rate Customer';

  @override
  String get label_review_category => 'Review Category';

  @override
  String get label_comment_optional => 'Comment (Optional)';

  @override
  String get placeholder_share_experience => 'Share your experience...';

  @override
  String get button_submit => 'Submit';

  @override
  String dialog_new_order(String type) {
    return 'New $type Order';
  }

  @override
  String get label_order_id_prefix => 'Order #';

  @override
  String get label_pickup => 'Pickup';

  @override
  String get label_dropoff => 'Dropoff';

  @override
  String get label_distance => 'Distance';

  @override
  String get label_earnings => 'Earnings';

  @override
  String label_gender_preference(String gender) {
    return 'Gender preference: $gender';
  }

  @override
  String get label_note => 'Note:';

  @override
  String label_pickup_prefix(String location) {
    return 'Pickup: $location';
  }

  @override
  String label_dropoff_prefix(String location) {
    return 'Dropoff: $location';
  }

  @override
  String label_instructions_prefix(String instructions) {
    return 'Instructions: $instructions';
  }

  @override
  String get order_type_ride_label => 'Ride';

  @override
  String get order_type_delivery_label => 'Delivery';

  @override
  String get order_type_food_label => 'Food';

  @override
  String get toast_order_unavailable => 'Order Unavailable';

  @override
  String get toast_order_unavailable_message => 'This order was cancelled or accepted by another driver';

  @override
  String get toast_order_rejected => 'Order Rejected';

  @override
  String get toast_order_rejected_message => 'You rejected the order';

  @override
  String get label_total_fare => 'Total Fare';

  @override
  String get dialog_unsupported_payment => 'Unsupported payment method';

  @override
  String get dialog_unsupported_payment_message => 'The selected payment method is not supported. Please choose a different method.';

  @override
  String get label_provider => 'Provider :';

  @override
  String get label_va_number => 'VA Number :';

  @override
  String label_valid_until(String date) {
    return 'Valid until $date';
  }

  @override
  String get label_remaining_time => 'Remaining Time :';

  @override
  String get button_copy_va_number => 'Copy VA Number';

  @override
  String get label_no_rating_yet => 'No rating yet';

  @override
  String get message_wait_for_driver => 'Please wait while we match you with a driver';

  @override
  String get label_license_plate => 'License plate';

  @override
  String get status_finding_driver => 'Finding driver';

  @override
  String get status_your_driver => 'Your driver';

  @override
  String get instruction_choose_pickup_destination => 'Choose your pick-up and destination point!';

  @override
  String get button_proceed => 'Proceed';

  @override
  String get placeholder_what_sending => 'What are you sending?';

  @override
  String get placeholder_enter_weight => 'Enter weight in kg (max 20kg)';

  @override
  String get helper_special_instructions => 'Add any special handling or delivery instructions';

  @override
  String get helper_add_photos => 'Add up to 3 photos of the item';

  @override
  String get error_provide_item_description => 'Please provide item description';

  @override
  String get error_no_estimate_available => 'No estimate available';

  @override
  String get button_choose_payment_method => 'Choose Payment Method';

  @override
  String get button_place_order => 'Place Order';

  @override
  String get label_photo_profile => 'Photo Profile';

  @override
  String get label_name => 'Name';

  @override
  String get label_email => 'Email';

  @override
  String get section_achievements => 'Achievements';

  @override
  String get button_rate_this_order => 'Rate this order';

  @override
  String get empty_no_order_history => 'No order history found';

  @override
  String get label_your_current_location => 'Your current location';

  @override
  String label_drivers_around(int count) {
    return 'There are $count drivers around you';
  }

  @override
  String get error_failed_load_mart => 'Failed to load mart data';

  @override
  String get error_failed_load_merchants => 'Failed to load merchants';

  @override
  String get empty_no_merchants_found => 'No merchants found';

  @override
  String get button_select_via_map => 'Select via map';

  @override
  String get error_no_place_found => 'No place found';

  @override
  String get title_select_bank_provider => 'Select Bank Provider';

  @override
  String get payment_akademove_pay => 'Akademove Pay';

  @override
  String get button_download_qr => 'Download QR';

  @override
  String get button_copy_qr_url => 'Copy QR URL';

  @override
  String get separator_colon => ':';

  @override
  String get placeholder_type_message => 'Type a message...';

  @override
  String get tab_on_process => 'On process';

  @override
  String get tab_completed => 'Completed';

  @override
  String get tab_canceled => 'Canceled';

  @override
  String get start_preparing => 'Start Preparing';

  @override
  String get order_ready => 'Order Ready';

  @override
  String get waiting_for_driver_pickup => 'Waiting for driver to pickup...';

  @override
  String get no_menu_items_yet => 'No menu items yet. Tap + to add your first item.';

  @override
  String no_menu_items_found(String query) {
    return 'No menu items found for \"$query\"';
  }

  @override
  String get placeholder_search_menu_hint => 'Search menu...';

  @override
  String get label_menu_name => 'Menu Name';

  @override
  String get label_menu_price => 'Menu Price';

  @override
  String get label_menu_stock => 'Menu Stock';

  @override
  String get label_menu_category => 'Menu Category';

  @override
  String get label_menu_photo => 'Menu Photo';

  @override
  String get placeholder_menu_name => 'Enter menu name';

  @override
  String get placeholder_menu_price => 'Enter price';

  @override
  String get label_category => 'Category';

  @override
  String get label_price => 'Price';

  @override
  String get label_stock => 'Stock';

  @override
  String get label_created => 'Created';

  @override
  String get label_updated => 'Updated';

  @override
  String get placeholder_select_category => 'Select category';

  @override
  String get error_validation => 'Validation Error';

  @override
  String get title_privacy_policies => 'Privacy Policies';

  @override
  String get ordered_by => 'Ordered by';

  @override
  String get driver_assigned => 'Driver assigned';

  @override
  String get order_items => 'Order Items';

  @override
  String get base_price => 'Base Price';

  @override
  String get order_time => 'Order Time';

  @override
  String get order_chat => 'Order Chat';

  @override
  String get toast_order_accepted => 'Order accepted successfully';

  @override
  String get toast_order_rejected_success => 'Order rejected successfully';

  @override
  String get toast_order_marked_preparing => 'Order marked as preparing';

  @override
  String get toast_order_marked_ready => 'Order marked as ready for pickup';

  @override
  String get toast_failed_accept_order => 'Failed to accept order';

  @override
  String get toast_failed_reject_order => 'Failed to reject order';

  @override
  String get toast_failed_update_order => 'Failed to update order';

  @override
  String get toast_merchant_id_not_found => 'Merchant ID not found';

  @override
  String get unknown_item => 'Unknown Item';

  @override
  String get label_status => 'Status';

  @override
  String get label_wib => 'WIB';

  @override
  String get error_valid_price => 'Please enter a valid price';

  @override
  String get toast_menu_created_success => 'Menu created successfully';

  @override
  String get toast_failed_create_menu => 'Failed to create menu';

  @override
  String get toast_menu_updated_success => 'Menu updated successfully';

  @override
  String get toast_failed_update_menu => 'Failed to update menu';

  @override
  String get button_create_menu => 'Create Menu';

  @override
  String get button_create => 'Create';

  @override
  String get label_menu_description => 'Menu Description';

  @override
  String get placeholder_menu_description => 'Combined coffee and brown sugar';

  @override
  String get placeholder_menu_category => 'Drink';

  @override
  String get label_menu_photo_optional => 'Menu Photo (Optional)';

  @override
  String get title_edit_profile => 'Edit Profile';

  @override
  String get label_owner_name => 'Owner\'s Name';

  @override
  String get placeholder_owner_name => 'Enter owner name';

  @override
  String get label_owner_email => 'Owner\'s Email';

  @override
  String get placeholder_owner_email => 'Enter owner email';

  @override
  String get label_owner_phone => 'Owner\'s Phone Number';

  @override
  String get label_outlet_name => 'Outlet\'s Name';

  @override
  String get label_outlet_phone => 'Outlet\'s Phone Number';

  @override
  String get label_outlet_email => 'Outlet\'s Email';

  @override
  String get placeholder_outlet_email => 'Enter outlet email';

  @override
  String get label_outlet_document => 'Outlet\'s Document (Optional)';

  @override
  String get label_choose_bank => 'Choose bank';

  @override
  String get placeholder_select_bank_provider => 'Select bank provider';

  @override
  String get label_bank_account => 'Bank Account';

  @override
  String get placeholder_bank_account => '********1234';

  @override
  String get toast_location_permission => 'Location Permission';

  @override
  String get toast_using_default_location => 'Using default location. You can drag the marker to set your outlet location.';

  @override
  String get dialog_location_permission_title => 'Location Permission';

  @override
  String get dialog_location_permission_message => 'We need access to your location to automatically set your outlet location on the map. This helps customers find your business easily. You can also manually set the location by dragging the marker.';

  @override
  String get dialog_location_services_disabled_title => 'Location Services Disabled';

  @override
  String get dialog_location_services_disabled_message => 'Location services are currently disabled on your device. Please enable them to automatically detect your outlet location.';

  @override
  String get dialog_location_permission_required_title => 'Location Permission Required';

  @override
  String get dialog_location_permission_required_message => 'Location permission has been permanently denied. To use automatic location detection, please enable it in your app settings.\n\nYou can still manually set your outlet location by dragging the marker on the map.';

  @override
  String get label_outlet_location_description => 'Make sure the location point on the map is correct to meet the registration requirements.';

  @override
  String get placeholder_search_dropoff_location => 'Search dropoff location';

  @override
  String get placeholder_search_location => 'Search location';

  @override
  String get placeholder_search_merchant => 'Search merchant';

  @override
  String get placeholder_search_pickup_location => 'Search pickup location';

  @override
  String get label_dragging => 'Dragging...';

  @override
  String get toast_location_found => 'Location Found';

  @override
  String get toast_marker_moved => 'Marker moved to searched location';

  @override
  String get toast_not_found => 'Not Found';

  @override
  String get toast_location_not_found => 'Location not found. Please try a different search.';

  @override
  String get toast_search_error => 'Search Error';

  @override
  String get toast_search_error_message => 'Unable to search location. Please check your internet connection.';

  @override
  String get toast_enter_location => 'Please enter a location to search';

  @override
  String get label_benchmark_optional => 'Benchmark (Optional)';

  @override
  String get placeholder_benchmark => 'Next to the Uniqlo store.';

  @override
  String get toast_bank_account_verified => 'Bank account verified successfully';

  @override
  String get toast_failed_verify_bank => 'Failed to verify bank account';

  @override
  String get toast_enter_bank_account => 'Please enter bank account number';

  @override
  String get toast_bank_account_min_digits => 'Bank account number must be at least 5 digits';

  @override
  String get toast_select_bank_first => 'Please select a bank provider first';

  @override
  String get label_bank_account_number => 'Bank Account Number';

  @override
  String get label_account_holder_name => 'Account Holder\'s Name';

  @override
  String get label_owner_bank_name => 'Owner\'s Name';

  @override
  String get label_unable_get_address => 'Unable to get address';

  @override
  String get label_step_1 => 'Step 1';

  @override
  String get label_step_2 => 'Step 2';

  @override
  String get label_step_3 => 'Step 3';

  @override
  String get label_outlet_photo_profile => 'Outlet Photo Profile';

  @override
  String get placeholder_outlet_category => 'Pick your outlet category';

  @override
  String get label_outlet_operating_hours => 'Outlet Operating Hours';

  @override
  String get label_24_hours => '24 Hours';

  @override
  String get toast_success_set_up => 'Success set up merchant';

  @override
  String get toast_complete_required_fields => 'Please complete all required fields';

  @override
  String get error_outlet_photo_required => 'Outlet photo is required';

  @override
  String get error_menu_photo_required => 'Menu photo is required';

  @override
  String get label_weekly_sales => 'Weekly Sales';

  @override
  String get label_monthly_sales => 'Monthly Sales';

  @override
  String get label_earns => 'Earns';

  @override
  String get label_top_ordered_categories => 'Top Ordered Categories';

  @override
  String get label_top_ordered_products => 'Top Ordered Products';

  @override
  String get button_export_pdf => 'Export to PDF';

  @override
  String get category_junk_food => 'Junk Food';

  @override
  String get category_drinks => 'Drinks';

  @override
  String get category_snack => 'Snack';

  @override
  String get product_fried_chicken => 'Fried Chicken';

  @override
  String get product_coffee_latte => 'Coffee Latte';

  @override
  String get product_laundry_express => 'Laundry Express';

  @override
  String get label_incoming_balance => 'Incoming Balance';

  @override
  String get label_outgoing_balance => 'Outgoing Balance';

  @override
  String get label_balance_detail => 'Balance Detail';

  @override
  String get label_gross_sales => 'Gross Sales';

  @override
  String get label_platform_commission => 'Platform Commission (20%)';

  @override
  String get label_net_income => 'Net Income';

  @override
  String get label_nett_income => 'Nett Income';

  @override
  String get title_change_password => 'Change Password';

  @override
  String get placeholder_old_password => 'Enter your old password';

  @override
  String get placeholder_new_password => 'Enter your new password';

  @override
  String get placeholder_confirm_password => '********';

  @override
  String get button_next => 'Next';

  @override
  String get button_back => 'Back';

  @override
  String get button_save => 'Save';

  @override
  String get label_start => 'Start';

  @override
  String get label_end => 'End';

  @override
  String get placeholder_start_time => '10:00';

  @override
  String get placeholder_end_time => '22:00';

  @override
  String get day_monday => 'Monday';

  @override
  String get day_tuesday => 'Tuesday';

  @override
  String get day_wednesday => 'Wednesday';

  @override
  String get day_thursday => 'Thursday';

  @override
  String get day_friday => 'Friday';

  @override
  String get day_saturday => 'Saturday';

  @override
  String get day_sunday => 'Sunday';

  @override
  String get toast_success => 'Success';

  @override
  String get toast_success_set_up_merchant => 'Success set up merchant';

  @override
  String get outlet_category_restaurant => 'Restaurant';

  @override
  String get outlet_category_cafe => 'Cafe';

  @override
  String get outlet_category_fast_food => 'Fast Food';

  @override
  String get outlet_category_bakery => 'Bakery';

  @override
  String get outlet_category_street_food => 'Street Food';

  @override
  String get outlet_category_food_truck => 'Food Truck';

  @override
  String get outlet_category_bar => 'Bar';

  @override
  String get outlet_category_coffeeshop => 'Coffee Shop';

  @override
  String get outlet_category_dessert_shop => 'Dessert Shop';

  @override
  String get outlet_category_juice_bar => 'Juice Bar';

  @override
  String get menu_category_appetizer => 'Appetizer';

  @override
  String get menu_category_main_course => 'Main Course';

  @override
  String get menu_category_dessert => 'Dessert';

  @override
  String get menu_category_beverage => 'Beverage';

  @override
  String get menu_category_snack => 'Snack';

  @override
  String get menu_category_breakfast => 'Breakfast';

  @override
  String get menu_category_lunch => 'Lunch';

  @override
  String get menu_category_dinner => 'Dinner';

  @override
  String get menu_category_salad => 'Salad';

  @override
  String get menu_category_soup => 'Soup';

  @override
  String get menu_category_seafood => 'Seafood';

  @override
  String get menu_category_vegetarian => 'Vegetarian';

  @override
  String get menu_category_vegan => 'Vegan';

  @override
  String get menu_category_pasta => 'Pasta';

  @override
  String get menu_category_pizza => 'Pizza';

  @override
  String get menu_category_burger => 'Burger';

  @override
  String get menu_category_sandwich => 'Sandwich';

  @override
  String get menu_category_rice => 'Rice';

  @override
  String get menu_category_noodle => 'Noodle';

  @override
  String get menu_category_grill => 'Grill';

  @override
  String get title_delivery => 'Delivery';

  @override
  String get title_where_you_at => 'Where you at?';

  @override
  String get title_where_are_you_going => 'Where are you going?';

  @override
  String get text_choose_pickup_destination => 'Choose your pick-up and destination point!';

  @override
  String get toast_failed_estimate_order => 'Failed to estimate order';

  @override
  String get marker_pickup => 'Pickup';

  @override
  String get marker_dropoff => 'Dropoff';

  @override
  String get title_order_summary => 'Order Summary';

  @override
  String get text_no_estimate_available => 'No estimate available';

  @override
  String get label_delivery_details => 'Delivery Details';

  @override
  String get label_from => 'From';

  @override
  String get label_to => 'To';

  @override
  String get label_item => 'Item';

  @override
  String get label_weight => 'Weight';

  @override
  String get label_instructions => 'Instructions';

  @override
  String get button_apply_coupon => 'Apply Coupon';

  @override
  String get text_coupon => 'Coupon';

  @override
  String get label_price_breakdown => 'Price Breakdown';

  @override
  String get label_base_fare => 'Base Fare';

  @override
  String get label_distance_fare => 'Distance Fare';

  @override
  String get label_subtotal => 'Subtotal';

  @override
  String get label_discount => 'Discount';

  @override
  String get label_total => 'Total';

  @override
  String get title_payment_method => 'Payment Method';

  @override
  String get toast_failed_place_order => 'Failed to place order';

  @override
  String get toast_delivery_order_placed => 'Delivery order placed successfully';

  @override
  String get title_ride => 'Ride';

  @override
  String get title_trip_details => 'Trip Details';

  @override
  String get toast_wallet_payment_failed => 'Wallet payment failed';

  @override
  String get title_ride_payment => 'Ride Payment';

  @override
  String get text_unsupported_payment_method => 'Unsupported payment method';

  @override
  String get text_valid_until => 'Valid until';

  @override
  String get label_confirm_new_password => 'Confirm New Password';

  @override
  String get text_rate_this_order => 'Rate this order';

  @override
  String get text_driver => 'Driver';

  @override
  String get button_save_changes => 'Save Changes';

  @override
  String get text_thank_you_rating => 'Thank you for your rating!';

  @override
  String get label_achievements => 'Achievements';

  @override
  String get text_earned_at => 'Earned at';

  @override
  String get text_all => 'All';

  @override
  String get toast_failed_load_merchants => 'Failed to load merchants';

  @override
  String get text_no_merchants_found => 'No merchants found';

  @override
  String get text_try_different_category => 'Try selecting a different category';

  @override
  String get text_open => 'Open';

  @override
  String get text_closed => 'Closed';

  @override
  String get toast_failed_load_mart_data => 'Failed to load mart data';

  @override
  String get label_categories => 'Categories';

  @override
  String get label_recent_orders => 'Recent Orders';

  @override
  String get button_view_all => 'View All';

  @override
  String get label_best_sellers => 'Best Sellers';

  @override
  String get text_rating => 'Rating';

  @override
  String get text_no_rating_yet => 'No rating yet';

  @override
  String get label_nearby_drivers => 'Nearby drivers';

  @override
  String get text_your_current_location => 'Your current location';

  @override
  String item_count(int count) {
    return '$count item(s)';
  }

  @override
  String get button_accept => 'Accept';

  @override
  String get how_was_your_experience => 'How was your experience?';

  @override
  String get mixed => 'Mixed';

  @override
  String get male => 'Male';

  @override
  String get female => 'Female';

  @override
  String get toast_app_state_corrupted => 'App state corrupted, please restart';

  @override
  String get toast_payment_info_not_available => 'Payment information not available';

  @override
  String get text_apply_coupon => 'Apply Coupon';

  @override
  String text_coupon_applied(String code) {
    return 'Coupon: $code';
  }

  @override
  String get label_payment_method => 'Payment Method';

  @override
  String get label_payment_summary => 'Payment Summary';

  @override
  String get text_payment_successful => 'Payment successful';

  @override
  String get text_payment_failed => 'Payment failed';

  @override
  String get text_unsupported_payment_method_description => 'The selected payment method is not supported. Please choose a different method.';

  @override
  String get toast_va_number_not_available => 'VA Number is not available';

  @override
  String get toast_va_number_copied => 'VA Number copied to clipboard';

  @override
  String get text_provider_label => 'Provider :';

  @override
  String get text_va_number_label => 'VA Number :';

  @override
  String text_valid_until_with_date(String date) {
    return 'Valid until $date';
  }

  @override
  String get text_on_trip => 'On Trip';

  @override
  String get text_license_plate => 'License plate';

  @override
  String get text_finding_driver => 'Finding your driver...';

  @override
  String get text_finding_driver_message => 'Please wait while we match you with a driver';

  @override
  String get status_searching => 'Searching';

  @override
  String get status_driver_found => 'Driver found';

  @override
  String get status_on_the_way => 'On the way';

  @override
  String get text_pickup_location => 'Pickup location';

  @override
  String get text_dropoff_location => 'Dropoff location';

  @override
  String get label_payment_method_lower => 'Payment Method';

  @override
  String get label_total_price => 'Total Price';

  @override
  String get text_order_details => 'Order Details';

  @override
  String get text_finding_driver_title => 'Finding driver';

  @override
  String get text_your_driver_title => 'Your driver';

  @override
  String get text_trip_completed => 'Trip completed!';

  @override
  String get text_trip_canceled => 'Trip was canceled';

  @override
  String get title_delivery_details => 'Delivery Details';

  @override
  String get label_item_description => 'Item Description';

  @override
  String get placeholder_item_description => 'What are you sending?';

  @override
  String get label_weight_kg => 'Weight (kg)';

  @override
  String get placeholder_weight_kg => 'Enter weight in kg (max 20kg)';

  @override
  String get text_maximum_weight => 'Maximum weight: 20kg';

  @override
  String get text_special_handling_instructions => 'Add any special handling or delivery instructions';

  @override
  String get label_item_photos_optional => 'Item Photos (Optional)';

  @override
  String get text_add_up_to_3_photos => 'Add up to 3 photos of the item';

  @override
  String get toast_provide_item_description => 'Please provide item description';

  @override
  String get toast_weight_must_be_valid => 'Weight must be between 0.1kg and 20kg';

  @override
  String get text_thank_you_for_review => 'Thank you for your review!';

  @override
  String get toast_failed_submit_review => 'Failed to submit review';

  @override
  String get text_rate_by_category => 'Rate by category';

  @override
  String get text_rate_overall_experience => 'How would you rate your overall experience?';

  @override
  String get text_select_categories => 'Select applicable categories';

  @override
  String get text_select_categories_hint => 'Choose all that apply to your experience';

  @override
  String get category_cleanliness => 'Cleanliness';

  @override
  String get category_courtesy => 'Courtesy';

  @override
  String get category_punctuality => 'Punctuality';

  @override
  String get category_safety => 'Safety';

  @override
  String get category_communication => 'Communication';

  @override
  String get category_overall => 'Overall';

  @override
  String get category_desc_cleanliness => 'How clean was the vehicle and the driver\'s appearance?';

  @override
  String get category_desc_courtesy => 'How polite and respectful was the driver?';

  @override
  String get category_desc_punctuality => 'Was the driver on time for pickup?';

  @override
  String get category_desc_safety => 'Did you feel safe during the trip?';

  @override
  String get category_desc_communication => 'How well did the driver communicate?';

  @override
  String get category_desc_overall => 'Rate your overall experience with this driver';

  @override
  String get rating_poor => 'Poor';

  @override
  String get rating_below_average => 'Below Average';

  @override
  String get rating_average => 'Average';

  @override
  String get rating_good => 'Good';

  @override
  String get rating_excellent => 'Excellent';

  @override
  String get label_additional_comments => 'Additional comments (optional)';

  @override
  String get placeholder_additional_comments => 'Tell us more about your experience...';

  @override
  String get button_submit_review => 'Submit Review';

  @override
  String toast_please_rate_category(String category) {
    return 'Please rate $category';
  }

  @override
  String text_drivers_around_you(int count) {
    return 'There are $count drivers around you';
  }

  @override
  String get text_no_order_history => 'No order history found';

  @override
  String text_order_id_short(String id) {
    return 'Order #$id';
  }

  @override
  String get label_notes => 'Notes';

  @override
  String get text_unknown_user => 'Unknown User';

  @override
  String get text_customer => 'Customer';

  @override
  String get button_call_customer => 'Call Customer';

  @override
  String get button_delete => 'Delete';

  @override
  String get title_edit_schedule => 'Edit Schedule';

  @override
  String get title_add_schedule => 'Add Schedule';

  @override
  String get placeholder_course_name => 'e.g., Mobile Programming';

  @override
  String get button_cancel => 'Cancel';

  @override
  String get placeholder_full_name => 'John Doe';

  @override
  String get placeholder_stock => '0';

  @override
  String text_failed_to_load_profile(String error) {
    return 'Failed to load profile: $error';
  }

  @override
  String get text_no_rankings_yet => 'No rankings yet';

  @override
  String get title_where_going => 'Where are you going?';

  @override
  String get tab_rankings => 'Rankings';

  @override
  String get tab_badges => 'Badges';

  @override
  String text_user_id(String id) {
    return 'User $id';
  }

  @override
  String text_category_value(String category) {
    return 'Category: $category';
  }

  @override
  String text_period_value(String period) {
    return 'Period: $period';
  }

  @override
  String get text_earned => 'Earned';

  @override
  String text_balance_with_amount(String amount) {
    return 'Balance: $amount';
  }

  @override
  String get button_top_up => 'Top Up';

  @override
  String get text_select_via_map => 'Select via map';

  @override
  String get text_no_place_found => 'No place found';

  @override
  String get title_location_permission_required => 'Location Permission Required';

  @override
  String get text_location_permission_denied => 'Location permission was previously denied. To go online and accept orders, you need to enable location access in your device settings.';

  @override
  String get text_location_permission_request => 'To accept ride and delivery orders, drivers must share their location in real-time. This helps:';

  @override
  String get text_location_benefit_match_orders => 'Match you with nearby orders';

  @override
  String get text_location_benefit_track_arrival => 'Let customers track your arrival';

  @override
  String get text_location_benefit_safety => 'Ensure safety and accountability';

  @override
  String get text_location_redirect_settings => 'You will be redirected to app settings to enable location access.';

  @override
  String get button_open_settings => 'Open Settings';

  @override
  String get button_grant_permission => 'Grant Permission';

  @override
  String get title_rate_customer => 'Rate Customer';

  @override
  String text_experience_with_user(String name) {
    return 'How was your experience with $name?';
  }

  @override
  String get category_other => 'Other';

  @override
  String label_rating_score(String score) {
    return 'Rating: $score / 5.0';
  }

  @override
  String get toast_review_submitted => 'Review submitted successfully';

  @override
  String get toast_review_failed => 'Failed to submit review';

  @override
  String get title_reject_order => 'Reject Order';

  @override
  String get text_select_rejection_reason => 'Please select a reason for rejecting this order:';

  @override
  String get rejection_reason_out_of_stock => 'Out of Stock';

  @override
  String get rejection_reason_too_busy => 'Too Busy / High Order Volume';

  @override
  String get rejection_reason_ingredient_unavailable => 'Ingredient Unavailable';

  @override
  String get rejection_reason_closed => 'Store Closed / Closing Soon';

  @override
  String get rejection_reason_other => 'Other';

  @override
  String get label_additional_note_optional => 'Additional Note (Optional)';

  @override
  String get placeholder_rejection_note => 'e.g., \"We ran out of chicken, will restock tomorrow\"';

  @override
  String get button_reject_order => 'Reject Order';

  @override
  String get my_reviews => 'My Reviews';

  @override
  String get failed_to_load => 'Failed to load';

  @override
  String get no_reviews_yet => 'No reviews yet';

  @override
  String get punctuality => 'Punctuality';

  @override
  String get safety => 'Safety';

  @override
  String get communication => 'Communication';

  @override
  String get delete_account => 'Delete Account';

  @override
  String get delete_account_title => 'Delete Account?';

  @override
  String get delete_account_warning => 'This action is permanent and cannot be undone.';

  @override
  String get delete_account_you_will_lose => 'You will lose:';

  @override
  String get delete_account_lose_wallet => 'All wallet balance';

  @override
  String get delete_account_lose_history => 'Order history';

  @override
  String get delete_account_lose_ratings => 'Ratings and reviews';

  @override
  String get delete_account_lose_addresses => 'Saved addresses';

  @override
  String get delete_account_lose_data => 'All account data';

  @override
  String get delete_account_proceed_methods => 'To proceed, please use one of the following methods:';

  @override
  String get continue_text => 'Continue';

  @override
  String get delete_account_choose_method => 'Choose Deletion Method';

  @override
  String get delete_account_select_method => 'Select how you want to request account deletion:';

  @override
  String get delete_account_method_web => 'Online Form (Recommended)';

  @override
  String get delete_account_method_web_desc => 'Complete form on our website';

  @override
  String get delete_account_method_email => 'Email Request';

  @override
  String get delete_account_method_email_desc => 'Send request via email';

  @override
  String get delete_account_method_whatsapp => 'WhatsApp Support';

  @override
  String get delete_account_method_whatsapp_desc => 'Chat with support team';

  @override
  String get delete_account_error_open_web => 'Could not open web page. Please try again.';

  @override
  String get delete_account_error_open_email => 'Could not open email app. Please try again.';

  @override
  String get delete_account_error_open_whatsapp => 'Could not open WhatsApp. Please try again.';

  @override
  String get email_verification_title => 'Verify Your Email';

  @override
  String get email_verification_description => 'We\'ve sent a verification link to your email address.';

  @override
  String get email_verification_sent => 'Verification email sent successfully!';

  @override
  String get email_verification_instruction => 'Click the link in the email to verify your account. If you don\'t see the email, check your spam folder.';

  @override
  String get email_verification_resend => 'Resend Verification Email';

  @override
  String email_verification_resend_countdown(String seconds) {
    return 'Resend in ${seconds}s';
  }

  @override
  String get email_verification_spam_hint => 'Don\'t forget to check your spam folder!';

  @override
  String get email_verification_success_title => 'Email Verified!';

  @override
  String get email_verification_success_description => 'Your email has been verified successfully. You can now sign in to your account.';

  @override
  String get email_verification_failed => 'Email verification failed';

  @override
  String get email_verification_invalid_token => 'Invalid or expired verification link. Please request a new one.';

  @override
  String get no_vouchers_available => 'No Vouchers Available';

  @override
  String get check_back_later_for_promotions => 'Check back later for promotions and discounts';

  @override
  String get toast_report_submitted => 'Report submitted successfully';

  @override
  String get toast_failed_submit_report => 'Failed to submit report';

  @override
  String get report_user => 'Report User';

  @override
  String get report_user_description => 'Report an issue with this user';

  @override
  String get select_report_category => 'Select Issue Category';

  @override
  String get report_description => 'Description';

  @override
  String get report_description_hint => 'Please describe the issue in detail...';

  @override
  String get report_description_helper => 'Minimum 10 characters required';

  @override
  String get report_guidelines_title => 'Reporting Guidelines';

  @override
  String get report_guidelines_content => 'Your report will be kept confidential. The reported user will not be notified of your identity. Our safety team will review all reports within 24-48 hours.';

  @override
  String get button_submit_report => 'Submit Report';

  @override
  String get report_category_behavior => 'Inappropriate Behavior';

  @override
  String get report_category_safety => 'Safety Concern';

  @override
  String get report_category_fraud => 'Fraud or Scam';

  @override
  String get report_category_other => 'Other Issue';

  @override
  String get report_category_behavior_desc => 'Rude, offensive, or inappropriate conduct during the trip';

  @override
  String get report_category_safety_desc => 'Dangerous driving, harassment, or threatening behavior';

  @override
  String get report_category_fraud_desc => 'Payment manipulation, fake profiles, or scam attempts';

  @override
  String get report_category_other_desc => 'Any other issue not covered by the categories above';

  @override
  String get no_notifications => 'No notifications yet';

  @override
  String get mark_all_as_read => 'Mark all as read';

  @override
  String notification_time_ago(String time) {
    return '$time ago';
  }

  @override
  String get scheduled_orders => 'Scheduled Orders';

  @override
  String get scheduled_order => 'Scheduled Order';

  @override
  String get schedule_a_ride => 'Schedule a Ride';

  @override
  String get schedule_a_delivery => 'Schedule a Delivery';

  @override
  String get schedule_order => 'Schedule Order';

  @override
  String get no_scheduled_orders => 'No scheduled orders';

  @override
  String get no_scheduled_orders_desc => 'You haven\'t scheduled any orders yet. Schedule a ride or delivery for a future time.';

  @override
  String scheduled_for(String datetime) {
    return 'Scheduled for: $datetime';
  }

  @override
  String get schedule_date => 'Schedule Date';

  @override
  String get schedule_time => 'Schedule Time';

  @override
  String get select_date => 'Select Date';

  @override
  String get select_time => 'Select Time';

  @override
  String get scheduled => 'Scheduled';

  @override
  String get schedule_order_title => 'Schedule Your Order';

  @override
  String get schedule_order_desc => 'Choose when you want your order to be fulfilled';

  @override
  String get min_schedule_time => 'Minimum 30 minutes from now';

  @override
  String get max_schedule_time => 'Maximum 7 days in advance';

  @override
  String schedule_confirmation(String datetime) {
    return 'Your order will be scheduled for $datetime. A driver will be matched approximately 15 minutes before the scheduled time.';
  }

  @override
  String get confirm_schedule => 'Confirm Schedule';

  @override
  String get edit_schedule => 'Edit Schedule';

  @override
  String get cancel_scheduled_order => 'Cancel Scheduled Order';

  @override
  String get cancel_scheduled_order_confirm => 'Are you sure you want to cancel this scheduled order?';

  @override
  String get scheduled_order_cancelled => 'Scheduled order cancelled successfully';

  @override
  String get scheduled_order_updated => 'Scheduled order updated successfully';

  @override
  String get scheduled_order_placed => 'Order scheduled successfully';

  @override
  String get failed_to_schedule_order => 'Failed to schedule order';

  @override
  String get failed_to_cancel_scheduled_order => 'Failed to cancel scheduled order';

  @override
  String get failed_to_update_scheduled_order => 'Failed to update scheduled order';

  @override
  String get failed_to_load_scheduled_orders => 'Failed to load scheduled orders';

  @override
  String get schedule_time_too_soon => 'Schedule time must be at least 30 minutes from now';

  @override
  String get schedule_time_too_far => 'Schedule time cannot be more than 7 days in advance';

  @override
  String matching_starts_at(String time) {
    return 'Driver matching starts at $time';
  }

  @override
  String get view_scheduled_orders => 'View Scheduled Orders';

  @override
  String get upcoming_scheduled_orders => 'Upcoming Scheduled Orders';

  @override
  String get past_scheduled_orders => 'Past Scheduled Orders';

  @override
  String get scheduled_order_details => 'Scheduled Order Details';

  @override
  String order_will_be_matched(String time) {
    return 'Order will be matched $time';
  }

  @override
  String get schedule_now => 'Schedule Now';

  @override
  String get order_now => 'Order Now';

  @override
  String get or_schedule_for_later => 'Or schedule for later';

  @override
  String get please_select_schedule_time => 'Please select a schedule time';

  @override
  String get scheduled_order_created => 'Your order has been scheduled successfully';

  @override
  String get schedule_for_later => 'Schedule for Later';

  @override
  String get tap_to_change_schedule => 'Tap to change';

  @override
  String get error_occurred => 'An error occurred';

  @override
  String get scan_to_send_money => 'Scan this QR code to send money to me';

  @override
  String get share_qr_instruction => 'Share this QR code with others so they can easily transfer money to you';

  @override
  String get label_user_id => 'User ID';

  @override
  String get copied_to_clipboard => 'Copied to clipboard';

  @override
  String get merchant_category_atk => 'ATK (Stationery)';

  @override
  String get merchant_category_printing => 'Printing';

  @override
  String get merchant_category_food => 'Food & Beverages';

  @override
  String get placeholder_menu_stock => 'Enter stock quantity';

  @override
  String get hint_menu_category => 'e.g., Beverages, Snacks, Main Course';

  @override
  String get toast_error => 'Error';

  @override
  String get cancel_reason_optional => 'Reason (optional)';

  @override
  String get order_cancelled_successfully => 'Order cancelled successfully';

  @override
  String get failed_to_cancel_order => 'Failed to cancel order';

  @override
  String get view_active_order => 'View Trip';

  @override
  String get title_select_pickup_location => 'Select Pickup Location';

  @override
  String get title_select_dropoff_location => 'Select Dropoff Location';

  @override
  String get button_confirm_location => 'Confirm Location';

  @override
  String get store_status => 'Store Status';

  @override
  String get store_status_open => 'Open';

  @override
  String get store_status_break => 'On Break';

  @override
  String get store_status_maintenance => 'Maintenance';

  @override
  String get store_status_closed => 'Closed';

  @override
  String get store_status_unknown => 'Unknown';

  @override
  String store_status_online(String status) {
    return 'Online - $status';
  }

  @override
  String get store_status_offline => 'Offline';

  @override
  String get store_status_online_toggle => 'Online';

  @override
  String get store_status_offline_toggle => 'Offline';

  @override
  String get store_status_available_for_orders => 'Available for orders';

  @override
  String get store_status_not_available => 'Not available';

  @override
  String get store_status_not_receiving_orders => 'Not receiving orders';

  @override
  String store_status_processing_orders(int count) {
    return 'Processing $count order(s)';
  }

  @override
  String get store_status_ready_to_receive => 'Ready to receive orders';

  @override
  String get store_status_temp_not_accepting => 'Temporarily not accepting new orders';

  @override
  String get store_status_desc_open => 'Accepting new orders from customers';

  @override
  String get store_status_desc_break => 'Temporarily not accepting new orders. Toggle when you\'re busy.';

  @override
  String get store_status_desc_maintenance => 'Store is under maintenance';

  @override
  String get store_status_desc_closed => 'Store is closed, not accepting orders';

  @override
  String get store_status_desc_default => 'Let customers know your store status';

  @override
  String active_orders_count(int count) {
    return '$count active';
  }

  @override
  String get status_updated => 'Status updated';

  @override
  String get failed_update_status => 'Failed to update status';

  @override
  String get current_saldo => 'Current Balance';

  @override
  String get incoming_balance => 'Incoming';

  @override
  String get outgoing_balance => 'Outgoing';

  @override
  String get income_outcome_chart => 'Income & Outcome Chart';

  @override
  String get balance_details => 'Balance Details';

  @override
  String get daily => 'Daily';

  @override
  String get weekly => 'Weekly';

  @override
  String get monthly => 'Monthly';

  @override
  String get outcome => 'Outcome';

  @override
  String get export_pdf => 'Export PDF';

  @override
  String get export_coming_soon => 'Export feature coming soon!';

  @override
  String get no_data_available => 'No data available';

  @override
  String chat_time_days_ago(int count) {
    return '${count}d ago';
  }

  @override
  String chat_time_hours_ago(int count) {
    return '${count}h ago';
  }

  @override
  String chat_time_minutes_ago(int count) {
    return '${count}m ago';
  }

  @override
  String get chat_time_just_now => 'Just now';

  @override
  String get leaderboard_top_drivers => 'Top Drivers';

  @override
  String get leaderboard_other_rankings => 'Other Rankings';

  @override
  String get leaderboard_refreshes_daily => 'Rankings refresh every 24 hours';

  @override
  String get leaderboard_empty_state => 'No drivers on the leaderboard yet';

  @override
  String get current_location => 'Current Location';

  @override
  String get current_location_desc => 'Your current GPS location';

  @override
  String get privacy_policy_title => 'AkadeMove Privacy Policy';

  @override
  String get privacy_policy_date => 'October 2025';

  @override
  String get privacy_policy_intro => 'Welcome to AkadeMove, a platform designed to connect customers, student drivers, and merchants in a unified mobility and delivery ecosystem. Your privacy is important to us. This Privacy Policy explains how we collect, use, store, and protect your personal information when you use our mobile application, website, or any related services (collectively referred to as \"AkadeMove\"). By using AkadeMove, you agree to the collection and use of your data in accordance with this policy. Please read this document carefully to understand how we handle your personal information.';

  @override
  String get privacy_data_we_collect_title => 'Data We Collect';

  @override
  String get privacy_data_we_collect_content => 'We collect personal information from all users of AkadeMove, Customers, Drivers (Students), and Merchants to enable our services and ensure a safe and efficient platform experience.';

  @override
  String get privacy_customer_data_title => 'Customer Data';

  @override
  String get privacy_customer_data_desc => 'When you register and use AkadeMove as a Customer, we collect:';

  @override
  String get privacy_customer_data_item_name => 'Name';

  @override
  String get privacy_customer_data_item_email => 'Email address';

  @override
  String get privacy_customer_data_item_phone => 'Phone number';

  @override
  String get privacy_customer_data_item_gender => 'Gender';

  @override
  String get privacy_customer_data_footer => 'This data allows us to verify your identity, communicate with you, process bookings and payments, and improve your overall experience.';

  @override
  String get privacy_customer_data_additional => 'Customers may select their preferred driver gender to enhance comfort and safety.';

  @override
  String get privacy_driver_data_title => 'Driver (Student) Data';

  @override
  String get privacy_driver_data_desc => 'When you register as a Driver (student driver) on AkadeMove, we collect:';

  @override
  String get privacy_driver_data_item_name => 'Full name';

  @override
  String get privacy_driver_data_item_email => 'Email address';

  @override
  String get privacy_driver_data_item_phone => 'Phone number';

  @override
  String get privacy_driver_data_item_gender => 'Gender';

  @override
  String get privacy_driver_data_item_sim => 'Driver License (SIM)';

  @override
  String get privacy_driver_data_item_ktm => 'Student ID Card (KTM)';

  @override
  String get privacy_driver_data_item_stnk => 'Vehicle Registration Certificate (STNK)';

  @override
  String get privacy_driver_data_item_plate => 'Vehicle license plate number';

  @override
  String get privacy_driver_data_item_bank => 'Bank account number';

  @override
  String get privacy_driver_data_footer => 'Drivers may also manually input their academic schedule (KRS) to indicate unavailable periods (e.g., class hours). This schedule data is not shared with customers or third parties and is used solely to prevent order assignments during academic sessions.';

  @override
  String get privacy_merchant_data_title => 'Merchant Data';

  @override
  String get privacy_merchant_data_desc => 'When you register as a Merchant Partner, we collect:';

  @override
  String get privacy_merchant_data_item_owner_name => 'Owner\'s full name';

  @override
  String get privacy_merchant_data_item_owner_email => 'Owner\'s email address';

  @override
  String get privacy_merchant_data_item_owner_phone => 'Owner\'s phone number';

  @override
  String get privacy_merchant_data_item_outlet_name => 'Outlet\'s name';

  @override
  String get privacy_merchant_data_item_outlet_location => 'Outlet\'s location';

  @override
  String get privacy_merchant_data_item_outlet_phone => 'Outlet\'s phone number';

  @override
  String get privacy_merchant_data_item_outlet_email => 'Outlet\'s email';

  @override
  String get privacy_merchant_data_item_outlet_docs => 'Outlet\'s documents (It is an optional uploads, e.g., tax ID, business license, etc.)';

  @override
  String get privacy_merchant_data_item_bank => 'Bank account number';

  @override
  String get privacy_merchant_data_footer => 'This data helps verify your merchant identity, facilitate transactions, and manage fund withdrawals securely.';

  @override
  String get privacy_use_of_data_title => 'Use of Data';

  @override
  String get privacy_use_of_data_content => 'AkadeMove uses personal information to:';

  @override
  String get privacy_use_of_data_item_1 => 'Provide and manage all AkadeMove services (transportation, delivery, and transactions).';

  @override
  String get privacy_use_of_data_item_2 => 'Verify the identity of Customers, Drivers, and Merchants to prevent fraud and unauthorized access.';

  @override
  String get privacy_use_of_data_item_3 => 'Match customers with suitable drivers based on gender preference, proximity, and availability';

  @override
  String get privacy_use_of_data_item_4 => 'Manage student drivers schedules to ensure service availability aligns with their academic commitments.';

  @override
  String get privacy_use_of_data_item_5 => 'Communicate service updates, notifications, promotions, and account-related information.';

  @override
  String get privacy_use_of_data_item_6 => 'Fulfill legal and regulatory obligations required by applicable laws.';

  @override
  String get privacy_location_access_title => 'Location Access';

  @override
  String get privacy_location_access_content => 'AkadeMove requires location access (GPS) to function properly. We use location data to:';

  @override
  String get privacy_location_access_item_1 => 'Identify pick-up and drop-off points.';

  @override
  String get privacy_location_access_item_2 => 'Show real-time driver locations.';

  @override
  String get privacy_location_access_item_3 => 'Improve route accuracy and service efficiency.';

  @override
  String get privacy_location_access_item_4 => 'Match customers with the nearest available driver.';

  @override
  String get privacy_location_access_footer => 'You may adjust your location permissions in your device settings. However, disabling location access may limit AkadeMove functionality.';

  @override
  String get privacy_data_sharing_title => 'Data Sharing';

  @override
  String get privacy_data_sharing_content => 'We do not sell, rent, or trade your personal data to third parties. However, we may share certain information with:';

  @override
  String get privacy_data_sharing_item_1 => 'Payment service providers to process financial transactions.';

  @override
  String get privacy_data_sharing_item_2 => 'Trusted third-party partners (such as identity verification, insurance, or analytics providers) to support our operations.';

  @override
  String get privacy_data_sharing_item_3 => 'Law enforcement or government authorities, if required by applicable law or legal process.';

  @override
  String get privacy_data_sharing_item_4 => 'Match customers with the nearest available driver.';

  @override
  String get privacy_data_sharing_footer => 'All partners handling your data are required to comply with strict data protection standards.';

  @override
  String get privacy_changes_title => 'Changes to This Privacy Policy';

  @override
  String get privacy_changes_content => 'We may update this Privacy Policy from time to time to reflect changes in our practices or legal obligations. Updates will be communicated via the AkadeMove app or website. Continued use of our services after any update constitutes your acceptance of the revised policy.';

  @override
  String get tos_title => 'AkadeMove Terms of Service';

  @override
  String get tos_effective_date => 'Effective Date: December 6, 2025';

  @override
  String get tos_intro => 'These Terms of Service constitute a legally binding agreement between you and AkadeMove. Please read them carefully before using our services.';

  @override
  String get tos_acceptance_title => 'Acceptance of Terms';

  @override
  String get tos_acceptance_content => 'Welcome to AkadeMove. These Terms of Service (\"Terms\") govern your access to and use of our campus mobility and delivery platform. By creating an account or using our Services, you agree to be bound by these Terms and our Privacy Policy.';

  @override
  String get tos_service_desc_title => 'Service Description';

  @override
  String get tos_service_desc_content => 'AkadeMove is a campus-specific platform that connects students, faculty, and authorized campus community members for:';

  @override
  String get tos_service_desc_item_ride => 'Ride-Hailing: Transportation services within and around campus areas';

  @override
  String get tos_service_desc_item_delivery => 'Package Delivery: Delivery of documents, parcels, and goods within campus';

  @override
  String get tos_service_desc_item_food => 'Food Delivery: Ordering and delivery of food from campus merchants';

  @override
  String get tos_service_desc_footer => 'AkadeMove acts as a technology platform connecting users with service providers. We are not a transportation or delivery company. Drivers and merchants are independent contractors.';

  @override
  String get tos_eligibility_title => 'User Eligibility';

  @override
  String get tos_eligibility_passengers_title => 'Passengers/Users';

  @override
  String get tos_eligibility_passengers_item_1 => 'Be at least 17 years of age';

  @override
  String get tos_eligibility_passengers_item_2 => 'Be a current student, faculty, or authorized campus member';

  @override
  String get tos_eligibility_passengers_item_3 => 'Provide valid contact information';

  @override
  String get tos_eligibility_passengers_item_4 => 'Verify campus affiliation (Student ID/KTM when required)';

  @override
  String get tos_eligibility_drivers_title => 'Drivers';

  @override
  String get tos_eligibility_drivers_item_1 => 'Be at least 18 years of age';

  @override
  String get tos_eligibility_drivers_item_2 => 'Be a currently enrolled student';

  @override
  String get tos_eligibility_drivers_item_3 => 'Possess valid driver\'s license (SIM C/A)';

  @override
  String get tos_eligibility_drivers_item_4 => 'Provide valid vehicle registration (STNK)';

  @override
  String get tos_eligibility_drivers_item_5 => 'Submit Student ID (KTM) photo';

  @override
  String get tos_eligibility_drivers_item_6 => 'Pass verification and onboarding process';

  @override
  String get tos_eligibility_merchants_title => 'Merchants';

  @override
  String get tos_eligibility_merchants_item_1 => 'Be an authorized campus food vendor or tenant';

  @override
  String get tos_eligibility_merchants_item_2 => 'Provide valid business documentation';

  @override
  String get tos_eligibility_merchants_item_3 => 'Maintain food safety and hygiene standards';

  @override
  String get tos_eligibility_merchants_item_4 => 'Comply with campus regulations';

  @override
  String get tos_pricing_title => 'Pricing & Commission';

  @override
  String get tos_pricing_content => 'Pricing formula: Base Price + (Distance × Rate) + Tip - Coupon';

  @override
  String get tos_pricing_commission_title => 'Commission Structure';

  @override
  String get tos_pricing_commission_item_1 => 'Rides & Delivery: 15% platform commission';

  @override
  String get tos_pricing_commission_item_2 => 'Food Orders: 20% total (10% merchant, 10% platform)';

  @override
  String get tos_pricing_commission_item_3 => 'Tips: Go 100% to drivers (configurable)';

  @override
  String get tos_pricing_footer => 'Example: Ride total Rp 25,000 → Commission Rp 3,750 → Driver earns Rp 21,250';

  @override
  String get tos_wallet_title => 'Wallet System';

  @override
  String get tos_wallet_content => 'All users have an in-app wallet for managing funds:';

  @override
  String get tos_wallet_item_1 => 'Top-Up: Add funds via QRIS, bank transfer, or e-wallet (Midtrans)';

  @override
  String get tos_wallet_item_2 => 'Payment: Automatically deducted from wallet balance';

  @override
  String get tos_wallet_item_3 => 'Earnings: Credited to wallet after order completion';

  @override
  String get tos_wallet_item_4 => 'Withdrawals: Min. Rp 50,000, processed in 1-3 business days';

  @override
  String get tos_cancellation_title => 'Cancellation Policy';

  @override
  String get tos_cancellation_user_title => 'User Cancellations';

  @override
  String get tos_cancellation_user_item_1 => 'Free cancellation within 2 minutes of booking';

  @override
  String get tos_cancellation_user_item_2 => 'Cancellation fee applies after 2 minutes (configurable)';

  @override
  String get tos_cancellation_user_item_3 => 'Full fee if driver arrived or order being prepared';

  @override
  String get tos_cancellation_driver_title => 'Driver Cancellations';

  @override
  String get tos_cancellation_driver_item_1 => 'Can cancel if passenger unresponsive or violates terms';

  @override
  String get tos_cancellation_driver_item_2 => 'Excessive cancellations may result in suspension';

  @override
  String get tos_cancellation_refunds_title => 'Refunds';

  @override
  String get tos_cancellation_refunds_item_1 => 'Processed within 5-7 business days for service issues';

  @override
  String get tos_cancellation_refunds_item_2 => 'Issued to original payment method or wallet';

  @override
  String get tos_cancellation_refunds_item_3 => 'Disputes must be raised within 24 hours';

  @override
  String get tos_rating_title => 'Rating & Review System';

  @override
  String get tos_rating_content => 'Both users and drivers rate each other on a 5-star scale. Ratings affect service quality and opportunities.';

  @override
  String get tos_rating_item_1 => 'Fairness: Ratings should reflect actual service quality';

  @override
  String get tos_rating_item_2 => 'Prohibition: Do not manipulate ratings or leave false reviews';

  @override
  String get tos_rating_item_3 => 'Disputes: Can be reported to customer support';

  @override
  String get tos_rating_item_4 => 'Consequences: Consistently low ratings may result in suspension';

  @override
  String get tos_driver_req_title => 'Driver Requirements';

  @override
  String get tos_driver_req_schedule_title => 'Class Schedule Management';

  @override
  String get tos_driver_req_schedule_desc => 'Drivers can input class schedules to auto-set offline status during class times.';

  @override
  String get tos_driver_req_availability_title => 'Availability Control';

  @override
  String get tos_driver_req_availability_item_1 => 'Toggle online/offline status freely';

  @override
  String get tos_driver_req_availability_item_2 => 'Accept or reject order requests';

  @override
  String get tos_driver_req_availability_item_3 => 'Excessive rejections affect matching priority';

  @override
  String get tos_driver_req_availability_item_4 => 'Repeated cancellations may result in warnings';

  @override
  String get tos_safety_title => 'Safety & Reporting';

  @override
  String get tos_safety_content => 'Your safety is our priority. AkadeMove provides:';

  @override
  String get tos_safety_item_1 => 'In-App Chat: Communicate without sharing phone numbers';

  @override
  String get tos_safety_item_2 => 'Driver Verification: All drivers undergo document verification';

  @override
  String get tos_safety_item_3 => 'Real-Time Tracking: Share trip with trusted contacts';

  @override
  String get tos_safety_item_4 => 'Emergency Button: Quick access to campus security';

  @override
  String get tos_safety_item_5 => 'Report System: Report misconduct or safety concerns';

  @override
  String get tos_safety_footer => 'Reports are reviewed within 24-48 hours. Actions may include warnings, suspension, or permanent ban. Serious incidents may be reported to authorities.';

  @override
  String get tos_gender_pref_title => 'Gender Preference Feature';

  @override
  String get tos_gender_pref_content => 'Users can optionally request same-gender drivers for enhanced comfort and safety:';

  @override
  String get tos_gender_pref_item_1 => 'Optional preference in matching algorithm';

  @override
  String get tos_gender_pref_item_2 => 'Availability depends on nearby drivers';

  @override
  String get tos_gender_pref_item_3 => 'May increase wait times if same-gender drivers not available';

  @override
  String get tos_gender_pref_item_4 => 'Can be enabled/disabled anytime';

  @override
  String get tos_prohibited_title => 'Prohibited Conduct';

  @override
  String get tos_prohibited_content => 'Users must not:';

  @override
  String get tos_prohibited_item_1 => 'Use services for illegal purposes or transport illegal goods';

  @override
  String get tos_prohibited_item_2 => 'Harass, abuse, threaten, or discriminate against others';

  @override
  String get tos_prohibited_item_3 => 'Engage in fraudulent activities or fake accounts';

  @override
  String get tos_prohibited_item_4 => 'Manipulate platform, ratings, pricing, or promotions';

  @override
  String get tos_prohibited_item_5 => 'Operate vehicles unsafely or violate traffic laws';

  @override
  String get tos_prohibited_item_6 => 'Attempt unauthorized access to accounts or data';

  @override
  String get tos_prohibited_item_7 => 'Infringe on AkadeMove\'s or others\' intellectual property';

  @override
  String get tos_prohibited_footer => 'Violations may result in immediate suspension and legal action.';

  @override
  String get tos_liability_title => 'Limitation of Liability';

  @override
  String get tos_liability_content => 'AkadeMove is a technology platform connecting users with independent service providers. We do not provide transportation or delivery services directly.';

  @override
  String get tos_liability_item_1 => 'Services provided \"as is\" without warranties';

  @override
  String get tos_liability_item_2 => 'Not liable for indirect or consequential damages';

  @override
  String get tos_liability_item_3 => 'Maximum liability limited to amounts paid in last 12 months';

  @override
  String get tos_liability_item_4 => 'Not responsible for actions of drivers, merchants, or users';

  @override
  String get tos_dispute_title => 'Dispute Resolution';

  @override
  String get tos_dispute_item_1 => 'Informal Resolution: Contact customer support first';

  @override
  String get tos_dispute_item_2 => 'Mediation: Attempt mediation before litigation';

  @override
  String get tos_dispute_item_3 => 'Governing Law: Republic of Indonesia laws apply';

  @override
  String get tos_dispute_item_4 => 'Jurisdiction: Courts of Surabaya, Indonesia';

  @override
  String get tos_termination_title => 'Account Termination';

  @override
  String get tos_termination_user_title => 'User Termination';

  @override
  String get tos_termination_user_desc => 'You may terminate your account anytime through app settings or customer support.';

  @override
  String get tos_termination_platform_title => 'Platform Termination';

  @override
  String get tos_termination_platform_desc => 'We reserve the right to suspend or terminate accounts that violate Terms, engage in fraud, or pose safety risks.';

  @override
  String get tos_termination_footer => 'Upon termination, access ceases and data may be deleted subject to legal requirements. Outstanding obligations remain.';

  @override
  String get tos_changes_title => 'Changes to Terms';

  @override
  String get tos_changes_content => 'We may modify these Terms at any time. Material changes will be notified via:';

  @override
  String get tos_changes_item_1 => 'In-app notification';

  @override
  String get tos_changes_item_2 => 'Email to registered address';

  @override
  String get tos_changes_item_3 => 'Prominent website notice';

  @override
  String get tos_changes_footer => 'Continued use after changes constitutes acceptance. If you disagree, stop using our Services.';

  @override
  String get tos_contact_title => 'Contact Information';

  @override
  String get tos_contact_item_1 => 'Email: support@akademove.com';

  @override
  String get tos_contact_item_2 => 'Phone: +62 21 1234 5678';

  @override
  String get tos_contact_item_3 => 'Address: AkadeMove, Universitas Negeri Surabaya, Surabaya, Jawa Timur';

  @override
  String get tos_contact_item_4 => 'Customer Support: Available 24/7 through in-app chat';

  @override
  String get faq_title => 'Frequently Asked Questions';

  @override
  String get faq_header_title => 'How can we help you?';

  @override
  String get faq_header_subtitle => 'Find quick answers to common questions about using AkadeMove';

  @override
  String get faq_contact_title => 'Still have questions?';

  @override
  String get faq_contact_subtitle => 'Contact our support team for more help';

  @override
  String get faq_contact_support => 'Contact Support';

  @override
  String get faq_error_email => 'Could not open email app. Please try again.';

  @override
  String get faq_category_general => 'General';

  @override
  String get faq_category_orders => 'Orders & Delivery';

  @override
  String get faq_category_payment => 'Payments & Wallet';

  @override
  String get faq_category_driver => 'Driver';

  @override
  String get faq_category_safety => 'Safety & Security';

  @override
  String get faq_general_q1 => 'What is AkadeMove?';

  @override
  String get faq_general_a1 => 'AkadeMove is a campus-specific mobility and delivery platform connecting students as users, drivers, and merchants. We offer ride-hailing, package delivery, and food ordering services exclusively within campus boundaries.';

  @override
  String get faq_general_q2 => 'Who can use AkadeMove?';

  @override
  String get faq_general_a2 => 'AkadeMove is available to all students, faculty, and staff with a valid campus ID. Drivers must be students with valid licenses and vehicle documentation.';

  @override
  String get faq_general_q3 => 'What services does AkadeMove offer?';

  @override
  String get faq_general_a3 => 'We offer three main services: Ride-hailing for campus transportation, Delivery for packages and documents, and Food delivery from campus merchants.';

  @override
  String get faq_orders_q1 => 'How do I place an order?';

  @override
  String get faq_orders_a1 => 'Open the app, select your service type (Ride, Delivery, or Food), set your pickup and destination points, review the fare, and confirm your booking.';

  @override
  String get faq_orders_q2 => 'Can I cancel an order?';

  @override
  String get faq_orders_a2 => 'Yes, you can cancel before a driver accepts your order with no penalty. After acceptance, cancellation fees may apply based on order status.';

  @override
  String get faq_orders_q3 => 'How long does matching take?';

  @override
  String get faq_orders_a3 => 'Matching typically takes less than 30 seconds. If no driver accepts within this time, we\'ll automatically expand the search radius.';

  @override
  String get faq_payment_q1 => 'What payment methods are accepted?';

  @override
  String get faq_payment_a1 => 'You can pay using your in-app wallet, which can be topped up via QRIS or bank transfer through Midtrans.';

  @override
  String get faq_payment_q2 => 'How do I top up my wallet?';

  @override
  String get faq_payment_a2 => 'Go to your wallet, select \'Top Up\', choose your amount and payment method (QRIS or bank transfer), complete the payment through Midtrans.';

  @override
  String get faq_payment_q3 => 'What is the commission structure?';

  @override
  String get faq_payment_a3 => 'For rides and deliveries, the platform takes a 15% commission. For food orders, there\'s a 20% commission split between the platform (10%) and merchant (10%). Tips go 100% to drivers.';

  @override
  String get faq_driver_q1 => 'How do I become a driver?';

  @override
  String get faq_driver_a1 => 'Click \'Become a Driver\', submit your student ID (KTM), driver\'s license (SIM), and vehicle registration (STNK). Once verified and approved, you can start accepting orders.';

  @override
  String get faq_driver_q2 => 'Can I work during my class schedule?';

  @override
  String get faq_driver_a2 => 'The app automatically sets you offline during your scheduled class times. You can manually override this if needed, but we recommend focusing on your studies.';

  @override
  String get faq_driver_q3 => 'When can I withdraw my earnings?';

  @override
  String get faq_driver_a3 => 'You can withdraw your earnings to your bank account anytime after completing orders. Withdrawals are typically processed within 1-3 business days. Minimum withdrawal is Rp 50,000.';

  @override
  String get faq_safety_q1 => 'How does gender preference work?';

  @override
  String get faq_safety_a1 => 'Users can optionally request a driver of the same gender for added comfort and safety. This is especially useful for late-night rides.';

  @override
  String get faq_safety_q2 => 'What if I feel unsafe during a ride?';

  @override
  String get faq_safety_a2 => 'Use the in-app emergency button to alert campus security immediately. You can also report the driver after the trip, and our team will investigate promptly.';

  @override
  String get faq_safety_q3 => 'How are drivers verified?';

  @override
  String get faq_safety_a3 => 'All drivers must submit and get approved for their student ID, driver\'s license, and vehicle registration. We verify all documents before activation.';

  @override
  String get emergency_contact_whatsapp => 'Contact via WA';

  @override
  String get emergency_contact_whatsapp_desc => 'Open WhatsApp to contact campus security';

  @override
  String get emergency_or_divider => 'or';

  @override
  String get emergency_whatsapp_error => 'Could not open WhatsApp. Please try again.';

  @override
  String get emergency_contact_unavailable => 'Emergency contact is not available. Please try again later.';
}
