import 'package:akademove/core/_export.dart';
import 'package:akademove/features/features.dart';
import 'package:flutter/material.dart' as material;
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
              material.Card(
                child: material.ListTile(
                  leading: const Icon(
                    LucideIcons.globe,
                    color: material.Colors.blue,
                  ),
                  title: const Text('Online Form (Recommended)'),
                  subtitle: const Text('Complete form on our website'),
                  trailing: const Icon(LucideIcons.arrowRight),
                  onTap: () {
                    Navigator.pop(context);
                    _openWebDeletionForm(context);
                  },
                ),
              ),
              SizedBox(height: 8.h),

              // Method 2: Email
              material.Card(
                child: material.ListTile(
                  leading: const Icon(
                    LucideIcons.mail,
                    color: material.Colors.orange,
                  ),
                  title: const Text('Email Request'),
                  subtitle: const Text('Send request via email'),
                  trailing: const Icon(LucideIcons.arrowRight),
                  onTap: () {
                    Navigator.pop(context);
                    _sendDeletionEmail(context);
                  },
                ),
              ),
              SizedBox(height: 8.h),

              // Method 3: WhatsApp
              material.Card(
                child: material.ListTile(
                  leading: const Icon(
                    LucideIcons.messageCircle,
                    color: material.Colors.green,
                  ),
                  title: const Text('WhatsApp Support'),
                  subtitle: const Text('Chat with support team'),
                  trailing: const Icon(LucideIcons.arrowRight),
                  onTap: () {
                    Navigator.pop(context);
                    _openWhatsAppSupport(context);
                  },
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
    final user = authState.data;

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
