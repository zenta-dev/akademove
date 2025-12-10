import 'package:akademove/core/_export.dart';
import 'package:akademove/features/features.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

/// Widget for account deletion button
/// Shows confirmation dialogs and provides multiple deletion methods
class DeleteAccountButtonWidget extends StatelessWidget {
  const DeleteAccountButtonWidget({super.key, this.accountType = 'USER'});

  /// Account type: USER, DRIVER, or MERCHANT
  final String accountType;

  @override
  Widget build(BuildContext context) {
    return Button(
      style:
          ButtonStyle.card(
            density: ButtonDensity(
              (val) => EdgeInsets.symmetric(horizontal: 12.dg, vertical: 8.h),
            ),
          ).copyWith(
            decoration: (context, states, value) =>
                value.copyWithIfBoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: context.theme.colorScheme.destructive.withValues(
                      alpha: 0.3,
                    ),
                  ),
                ),
          ),
      onPressed: () {
        _showDeleteAccountConfirmation(context);
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          DefaultText(
            'Delete Account',
            fontSize: 14.sp,
            color: context.theme.colorScheme.destructive,
            fontWeight: FontWeight.w500,
          ),
          Icon(
            LucideIcons.trash2,
            size: 14.sp,
            color: context.theme.colorScheme.destructive,
          ),
        ],
      ),
    );
  }

  /// Show initial confirmation dialog
  void _showDeleteAccountConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Account?'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'This action is permanent and cannot be undone.',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: context.theme.colorScheme.destructive,
                ),
              ),
              SizedBox(height: 16.h),
              const Text('You will lose:'),
              SizedBox(height: 8.h),
              _buildConsequenceItem(context, 'All wallet balance'),
              _buildConsequenceItem(context, 'Order history'),
              _buildConsequenceItem(context, 'Ratings and reviews'),
              _buildConsequenceItem(context, 'Saved addresses'),
              _buildConsequenceItem(context, 'All account data'),
              SizedBox(height: 16.h),
              const Text(
                'To proceed, please use one of the following methods:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _showDeletionMethods(context);
            },
            child: Text(
              'Continue',
              style: TextStyle(color: context.theme.colorScheme.destructive),
            ),
          ),
        ],
      ),
    );
  }

  /// Build consequence list item
  Widget _buildConsequenceItem(BuildContext context, String text) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('• ', style: TextStyle(fontSize: 14.sp)),
          Expanded(
            child: Text(text, style: TextStyle(fontSize: 14.sp)),
          ),
        ],
      ),
    );
  }

  /// Show deletion method selection dialog
  void _showDeletionMethods(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Choose Deletion Method'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text('Select how you want to request account deletion:'),
              SizedBox(height: 16.h),

              // Method 1: Web Form (Recommended)
              Card(
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    _openWebDeletionForm(context);
                  },
                  child: Padding(
                    padding: EdgeInsets.all(12.dg),
                    child: Row(
                      children: [
                        Icon(
                          LucideIcons.globe,
                          color: const Color(0xFF2196F3),
                          size: 24.sp,
                        ),
                        Gap(12.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Online Form (Recommended)'),
                              Text(
                                'Complete form on our website',
                                style: context.typography.small.copyWith(
                                  color: context.colorScheme.mutedForeground,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Icon(LucideIcons.arrowRight),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 8.h),

              // Method 2: Email
              Card(
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    _sendDeletionEmail(context);
                  },
                  child: Padding(
                    padding: EdgeInsets.all(12.dg),
                    child: Row(
                      children: [
                        Icon(
                          LucideIcons.mail,
                          color: const Color(0xFFFF9800),
                          size: 24.sp,
                        ),
                        Gap(12.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Email Request'),
                              Text(
                                'Send request via email',
                                style: context.typography.small.copyWith(
                                  color: context.colorScheme.mutedForeground,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Icon(LucideIcons.arrowRight),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 8.h),

              // Method 3: WhatsApp
              Card(
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    _openWhatsAppSupport(context);
                  },
                  child: Padding(
                    padding: EdgeInsets.all(12.dg),
                    child: Row(
                      children: [
                        Icon(
                          LucideIcons.messageCircle,
                          color: const Color(0xFF4CAF50),
                          size: 24.sp,
                        ),
                        Gap(12.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('WhatsApp Support'),
                              Text(
                                'Chat with support team',
                                style: context.typography.small.copyWith(
                                  color: context.colorScheme.mutedForeground,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Icon(LucideIcons.arrowRight),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }

  /// Open web deletion form in browser
  Future<void> _openWebDeletionForm(BuildContext context) async {
    final url = Uri.parse('https://akademove.com/account-deletion');

    try {
      if (await canLaunchUrl(url)) {
        await launchUrl(url, mode: LaunchMode.externalApplication);
      } else {
        if (context.mounted) {
          _showErrorToast(
            context,
            'Could not open web page. Please try again.',
          );
        }
      }
    } catch (e) {
      if (context.mounted) {
        _showErrorToast(context, 'Could not open web page. Please try again.');
      }
    }
  }

  /// Send deletion request via email
  Future<void> _sendDeletionEmail(BuildContext context) async {
    // Get user data from auth state
    final authState = context.read<AuthCubit>().state;
    final user = authState.user.data?.value;

    final emailUri = Uri(
      scheme: 'mailto',
      path: 'privacy@akademove.com',
      query: _buildEmailQuery(user, accountType),
    );

    try {
      if (await canLaunchUrl(emailUri)) {
        await launchUrl(emailUri);
      } else {
        if (context.mounted) {
          _showErrorToast(
            context,
            'Could not open email app. Please try again.',
          );
        }
      }
    } catch (e) {
      if (context.mounted) {
        _showErrorToast(context, 'Could not open email app. Please try again.');
      }
    }
  }

  /// Build email query string
  String _buildEmailQuery(dynamic user, String accountType) {
    final name = user?.name ?? '';
    final email = user?.email ?? '';
    final phone = user?.phoneNumber ?? '';

    return 'subject=Account Deletion Request'
        '&body=I request that my AkadeMove account be permanently deleted.%0A%0A'
        'Full Name: $name%0A'
        'Email: $email%0A'
        'Phone: $phone%0A'
        'Account Type: $accountType%0A%0A'
        'I understand this action is permanent and cannot be undone.%0A%0A'
        'Date: ${DateTime.now().toIso8601String().split('T')[0]}';
  }

  /// Open WhatsApp support
  Future<void> _openWhatsAppSupport(BuildContext context) async {
    final url = Uri.parse(
      'https://wa.me/622112345678?text=${Uri.encodeComponent("I want to delete my account")}',
    );

    try {
      if (await canLaunchUrl(url)) {
        await launchUrl(url, mode: LaunchMode.externalApplication);
      } else {
        if (context.mounted) {
          _showErrorToast(
            context,
            'Could not open WhatsApp. Please try again.',
          );
        }
      }
    } catch (e) {
      if (context.mounted) {
        _showErrorToast(context, 'Could not open WhatsApp. Please try again.');
      }
    }
  }

  /// Show error toast
  void _showErrorToast(BuildContext context, String message) {
    showToast(
      context: context,
      builder: (context, overlay) =>
          context.buildToast(title: 'Error', message: message),
    );
  }
}
