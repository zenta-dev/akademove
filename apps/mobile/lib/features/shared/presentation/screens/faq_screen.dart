import 'package:akademove/core/_export.dart';
import 'package:akademove/l10n/l10n.dart';
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

  List<FaqCategory> _getCategories(BuildContext context) {
    final l10n = context.l10n;
    return [
      FaqCategory(
        id: 'general',
        title: l10n.faq_category_general,
        icon: LucideIcons.circle,
        questions: [
          FaqQuestion(
            id: 'q1',
            question: l10n.faq_general_q1,
            answer: l10n.faq_general_a1,
          ),
          FaqQuestion(
            id: 'q2',
            question: l10n.faq_general_q2,
            answer: l10n.faq_general_a2,
          ),
          FaqQuestion(
            id: 'q3',
            question: l10n.faq_general_q3,
            answer: l10n.faq_general_a3,
          ),
        ],
      ),
      FaqCategory(
        id: 'orders',
        title: l10n.faq_category_orders,
        icon: LucideIcons.shoppingCart,
        questions: [
          FaqQuestion(
            id: 'q1',
            question: l10n.faq_orders_q1,
            answer: l10n.faq_orders_a1,
          ),
          FaqQuestion(
            id: 'q2',
            question: l10n.faq_orders_q2,
            answer: l10n.faq_orders_a2,
          ),
          FaqQuestion(
            id: 'q3',
            question: l10n.faq_orders_q3,
            answer: l10n.faq_orders_a3,
          ),
        ],
      ),
      FaqCategory(
        id: 'payment',
        title: l10n.faq_category_payment,
        icon: LucideIcons.creditCard,
        questions: [
          FaqQuestion(
            id: 'q1',
            question: l10n.faq_payment_q1,
            answer: l10n.faq_payment_a1,
          ),
          FaqQuestion(
            id: 'q2',
            question: l10n.faq_payment_q2,
            answer: l10n.faq_payment_a2,
          ),
          FaqQuestion(
            id: 'q3',
            question: l10n.faq_payment_q3,
            answer: l10n.faq_payment_a3,
          ),
        ],
      ),
      FaqCategory(
        id: 'driver',
        title: l10n.faq_category_driver,
        icon: LucideIcons.car,
        questions: [
          FaqQuestion(
            id: 'q1',
            question: l10n.faq_driver_q1,
            answer: l10n.faq_driver_a1,
          ),
          FaqQuestion(
            id: 'q2',
            question: l10n.faq_driver_q2,
            answer: l10n.faq_driver_a2,
          ),
          FaqQuestion(
            id: 'q3',
            question: l10n.faq_driver_q3,
            answer: l10n.faq_driver_a3,
          ),
        ],
      ),
      FaqCategory(
        id: 'safety',
        title: l10n.faq_category_safety,
        icon: LucideIcons.shield,
        questions: [
          FaqQuestion(
            id: 'q1',
            question: l10n.faq_safety_q1,
            answer: l10n.faq_safety_a1,
          ),
          FaqQuestion(
            id: 'q2',
            question: l10n.faq_safety_q2,
            answer: l10n.faq_safety_a2,
          ),
          FaqQuestion(
            id: 'q3',
            question: l10n.faq_safety_q3,
            answer: l10n.faq_safety_a3,
          ),
        ],
      ),
    ];
  }

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
    final l10n = context.l10n;
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
              message: l10n.faq_error_email,
            ),
            location: ToastLocation.topCenter,
          );
        }
      }
    } catch (e) {
      if (context.mounted) {
        showToast(
          context: context,
          builder: (context, overlay) =>
              context.buildToast(title: 'Error', message: l10n.faq_error_email),
          location: ToastLocation.topCenter,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final categories = _getCategories(context);
    final l10n = context.l10n;

    return Scaffold(
      headers: [DefaultAppBar(title: l10n.faq_title)],
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.dg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 16.h,
            children: [
              _buildHeaderCard(context),
              ...categories.map((category) {
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
        ),
      ),
    );
  }

  Widget _buildHeaderCard(BuildContext context) {
    final l10n = context.l10n;

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
            l10n.faq_header_title,
            style: context.typography.small.copyWith(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            l10n.faq_header_subtitle,
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
    final l10n = context.l10n;

    return Card(
      child: Column(
        spacing: 8.h,
        children: [
          Text(
            l10n.faq_contact_title,
            style: context.typography.small.copyWith(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            l10n.faq_contact_subtitle,
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
                    l10n.faq_contact_support,
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
