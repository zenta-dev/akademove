import 'package:akademove/core/_export.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

/// Model for an FAQ question and answer
class FaqQuestion {
  const FaqQuestion({
    required this.id,
    required this.question,
    required this.answer,
  });

  final String id;
  final String question;
  final String answer;
}

/// Model for an FAQ category containing multiple questions
class FaqCategory {
  const FaqCategory({
    required this.id,
    required this.title,
    required this.icon,
    required this.questions,
  });

  final String id;
  final String title;
  final IconData icon;
  final List<FaqQuestion> questions;
}

class FaqScreen extends StatefulWidget {
  const FaqScreen({super.key});

  @override
  State<FaqScreen> createState() => _FaqScreenState();
}

class _FaqScreenState extends State<FaqScreen> {
  String? _openCategory;
  String? _openQuestion;

  static final List<FaqCategory> _categories = [
    FaqCategory(
      id: 'general',
      title: 'General',
      icon: LucideIcons.circle,
      questions: [
        FaqQuestion(
          id: 'q1',
          question: 'What is AkadeMove?',
          answer:
              'AkadeMove is a campus-specific mobility and delivery platform connecting students as users, drivers, and merchants. We offer ride-hailing, package delivery, and food ordering services exclusively within campus boundaries.',
        ),
        FaqQuestion(
          id: 'q2',
          question: 'Who can use AkadeMove?',
          answer:
              'AkadeMove is available to all students, faculty, and staff with a valid campus ID. Drivers must be students with valid licenses and vehicle documentation.',
        ),
        FaqQuestion(
          id: 'q3',
          question: 'What services does AkadeMove offer?',
          answer:
              'We offer three main services: Ride-hailing for campus transportation, Delivery for packages and documents, and Food delivery from campus merchants.',
        ),
      ],
    ),
    FaqCategory(
      id: 'orders',
      title: 'Orders & Delivery',
      icon: LucideIcons.shoppingCart,
      questions: [
        FaqQuestion(
          id: 'q1',
          question: 'How do I place an order?',
          answer:
              'Open the app, select your service type (Ride, Delivery, or Food), set your pickup and destination points, review the fare, and confirm your booking.',
        ),
        FaqQuestion(
          id: 'q2',
          question: 'Can I cancel an order?',
          answer:
              'Yes, you can cancel before a driver accepts your order with no penalty. After acceptance, cancellation fees may apply based on order status.',
        ),
        FaqQuestion(
          id: 'q3',
          question: 'How long does matching take?',
          answer:
              'Matching typically takes less than 30 seconds. If no driver accepts within this time, we\'ll automatically expand the search radius.',
        ),
      ],
    ),
    FaqCategory(
      id: 'payment',
      title: 'Payments & Wallet',
      icon: LucideIcons.creditCard,
      questions: [
        FaqQuestion(
          id: 'q1',
          question: 'What payment methods are accepted?',
          answer:
              'You can pay using your in-app wallet, which can be topped up via QRIS or bank transfer through Midtrans.',
        ),
        FaqQuestion(
          id: 'q2',
          question: 'How do I top up my wallet?',
          answer:
              'Go to your wallet, select \'Top Up\', choose your amount and payment method (QRIS or bank transfer), complete the payment through Midtrans.',
        ),
        FaqQuestion(
          id: 'q3',
          question: 'What is the commission structure?',
          answer:
              'For rides and deliveries, the platform takes a 15% commission. For food orders, there\'s a 20% commission split between the platform (10%) and merchant (10%). Tips go 100% to drivers.',
        ),
      ],
    ),
    FaqCategory(
      id: 'driver',
      title: 'Driver',
      icon: LucideIcons.car,
      questions: [
        FaqQuestion(
          id: 'q1',
          question: 'How do I become a driver?',
          answer:
              'Click \'Become a Driver\', submit your student ID (KTM), driver\'s license (SIM), and vehicle registration (STNK). Once verified and approved, you can start accepting orders.',
        ),
        FaqQuestion(
          id: 'q2',
          question: 'Can I work during my class schedule?',
          answer:
              'The app automatically sets you offline during your scheduled class times. You can manually override this if needed, but we recommend focusing on your studies.',
        ),
        FaqQuestion(
          id: 'q3',
          question: 'When can I withdraw my earnings?',
          answer:
              'You can withdraw your earnings to your bank account anytime after completing orders. Withdrawals are typically processed within 1-3 business days. Minimum withdrawal is Rp 50,000.',
        ),
      ],
    ),
    FaqCategory(
      id: 'safety',
      title: 'Safety & Security',
      icon: LucideIcons.shield,
      questions: [
        FaqQuestion(
          id: 'q1',
          question: 'How does gender preference work?',
          answer:
              'Users can optionally request a driver of the same gender for added comfort and safety. This is especially useful for late-night rides.',
        ),
        FaqQuestion(
          id: 'q2',
          question: 'What if I feel unsafe during a ride?',
          answer:
              'Use the in-app emergency button to alert campus security immediately. You can also report the driver after the trip, and our team will investigate promptly.',
        ),
        FaqQuestion(
          id: 'q3',
          question: 'How are drivers verified?',
          answer:
              'All drivers must submit and get approved for their student ID, driver\'s license, and vehicle registration. We verify all documents before activation.',
        ),
      ],
    ),
  ];

  void _toggleCategory(String categoryId) {
    setState(() {
      _openCategory = _openCategory == categoryId ? null : categoryId;
      if (_openCategory != categoryId) {
        _openQuestion = null;
      }
    });
  }

  void _toggleQuestion(String categoryId, String questionId) {
    setState(() {
      final key = '$categoryId-$questionId';
      _openQuestion = _openQuestion == key ? null : key;
    });
  }

  Future<void> _openContactSupport(BuildContext context) async {
    final emailUri = Uri(
      scheme: 'mailto',
      path: 'support@akademove.com',
      query: 'subject=Support Request&body=Hi AkadeMove Support Team,%0A%0A',
    );

    try {
      if (await canLaunchUrl(emailUri)) {
        await launchUrl(emailUri);
      } else {
        if (context.mounted) {
          showToast(
            context: context,
            builder: (context, overlay) => context.buildToast(
              title: 'Error',
              message: 'Could not open email app. Please try again.',
            ),
            location: ToastLocation.topCenter,
          );
        }
      }
    } catch (e) {
      if (context.mounted) {
        showToast(
          context: context,
          builder: (context, overlay) => context.buildToast(
            title: 'Error',
            message: 'Could not open email app. Please try again.',
          ),
          location: ToastLocation.topCenter,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      headers: [const DefaultAppBar(title: 'Frequently Asked Questions')],
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 16.h,
        children: [
          _buildHeaderCard(context),
          ..._categories.map((category) {
            return _FaqCategoryWidget(
              category: category,
              isOpen: _openCategory == category.id,
              openQuestion: _openQuestion,
              onToggleCategory: () => _toggleCategory(category.id),
              onToggleQuestion: (qId) => _toggleQuestion(category.id, qId),
            );
          }),
          _buildContactCard(context),
        ],
      ),
    );
  }

  Widget _buildHeaderCard(BuildContext context) {
    return Card(
      child: Column(
        spacing: 8.h,
        children: [
          Icon(
            LucideIcons.circle,
            size: 32,
            color: Theme.of(context).colorScheme.primary,
          ),
          Text(
            'How can we help you?',
            style: context.typography.small.copyWith(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            'Find quick answers to common questions about using AkadeMove',
            style: context.typography.small.copyWith(
              fontSize: 12.sp,
              fontWeight: FontWeight.normal,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildContactCard(BuildContext context) {
    return Card(
      child: Column(
        spacing: 8.h,
        children: [
          Text(
            'Still have questions?',
            style: context.typography.small.copyWith(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            'Contact our support team for more help',
            style: context.typography.small.copyWith(
              fontSize: 12.sp,
              fontWeight: FontWeight.normal,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 8.h),
          Row(
            spacing: 8.w,
            children: [
              Expanded(
                child: Button.secondary(
                  onPressed: () => _openContactSupport(context),
                  child: Text(
                    'Contact Support',
                    style: context.typography.small.copyWith(fontSize: 14.sp),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _FaqCategoryWidget extends StatelessWidget {
  const _FaqCategoryWidget({
    required this.category,
    required this.isOpen,
    required this.openQuestion,
    required this.onToggleCategory,
    required this.onToggleQuestion,
  });

  final FaqCategory category;
  final bool isOpen;
  final String? openQuestion;
  final VoidCallback onToggleCategory;
  final void Function(String) onToggleQuestion;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCategoryHeader(context),
          if (isOpen) _buildQuestions(context),
        ],
      ),
    );
  }

  Widget _buildCategoryHeader(BuildContext context) {
    return Button(
      style: const ButtonStyle.ghost(density: ButtonDensity.compact),
      onPressed: onToggleCategory,
      child: Row(
        spacing: 12.w,
        children: [
          Container(
            width: 32.w,
            height: 32.h,
            decoration: BoxDecoration(
              color: Theme.of(
                context,
              ).colorScheme.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              category.icon,
              size: 18,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          Expanded(
            child: Text(
              category.title,
              style: context.typography.small.copyWith(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Icon(
            isOpen ? LucideIcons.chevronUp : LucideIcons.chevronDown,
            size: 16,
          ),
        ],
      ),
    );
  }

  Widget _buildQuestions(BuildContext context) {
    final questions = category.questions;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: Column(
        spacing: 8.h,
        children: questions.map((question) {
          final questionId = question.id;
          final categoryId = category.id;
          final isQuestionOpen = openQuestion == '$categoryId-$questionId';

          return _FaqQuestionWidget(
            question: question,
            isOpen: isQuestionOpen,
            onToggle: () => onToggleQuestion(questionId),
          );
        }).toList(),
      ),
    );
  }
}

class _FaqQuestionWidget extends StatelessWidget {
  const _FaqQuestionWidget({
    required this.question,
    required this.isOpen,
    required this.onToggle,
  });

  final FaqQuestion question;
  final bool isOpen;
  final VoidCallback onToggle;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Theme.of(context).colorScheme.border),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Button(
            style: const ButtonStyle.ghost(density: ButtonDensity.compact),
            onPressed: onToggle,
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    question.question,
                    style: context.typography.small.copyWith(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Icon(
                  isOpen ? LucideIcons.chevronUp : LucideIcons.chevronDown,
                  size: 14,
                ),
              ],
            ),
          ),
          if (isOpen)
            Padding(
              padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 12.h),
              child: Text(
                question.answer,
                style: context.typography.small.copyWith(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.normal,
                  color: Theme.of(context).colorScheme.mutedForeground,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
