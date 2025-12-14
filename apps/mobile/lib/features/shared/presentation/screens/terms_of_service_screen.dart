import 'package:akademove/core/_export.dart';
import 'package:akademove/l10n/l10n.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class TermsOfServiceScreen extends StatefulWidget {
  const TermsOfServiceScreen({super.key});

  @override
  State<TermsOfServiceScreen> createState() => _TermsOfServiceScreenState();
}

class _TermsOfServiceScreenState extends State<TermsOfServiceScreen> {
  int? _openIndex;

  List<Map<String, dynamic>> _getSections(BuildContext context) {
    final l10n = context.l10n;
    return [
      {
        'title': l10n.tos_acceptance_title,
        'content': l10n.tos_acceptance_content,
      },
      {
        'title': l10n.tos_service_desc_title,
        'content': l10n.tos_service_desc_content,
        'items': [
          l10n.tos_service_desc_item_ride,
          l10n.tos_service_desc_item_delivery,
          l10n.tos_service_desc_item_food,
        ],
        'footer': l10n.tos_service_desc_footer,
      },
      {
        'title': l10n.tos_eligibility_title,
        'sections': [
          {
            'number': '1',
            'title': l10n.tos_eligibility_passengers_title,
            'items': [
              l10n.tos_eligibility_passengers_item_1,
              l10n.tos_eligibility_passengers_item_2,
              l10n.tos_eligibility_passengers_item_3,
              l10n.tos_eligibility_passengers_item_4,
            ],
          },
          {
            'number': '2',
            'title': l10n.tos_eligibility_drivers_title,
            'items': [
              l10n.tos_eligibility_drivers_item_1,
              l10n.tos_eligibility_drivers_item_2,
              l10n.tos_eligibility_drivers_item_3,
              l10n.tos_eligibility_drivers_item_4,
              l10n.tos_eligibility_drivers_item_5,
              l10n.tos_eligibility_drivers_item_6,
            ],
          },
          {
            'number': '3',
            'title': l10n.tos_eligibility_merchants_title,
            'items': [
              l10n.tos_eligibility_merchants_item_1,
              l10n.tos_eligibility_merchants_item_2,
              l10n.tos_eligibility_merchants_item_3,
              l10n.tos_eligibility_merchants_item_4,
            ],
          },
        ],
      },
      {
        'title': l10n.tos_pricing_title,
        'content': l10n.tos_pricing_content,
        'sections': [
          {
            'number': '1',
            'title': l10n.tos_pricing_commission_title,
            'items': [
              l10n.tos_pricing_commission_item_1,
              l10n.tos_pricing_commission_item_2,
              l10n.tos_pricing_commission_item_3,
            ],
          },
        ],
        'footer': l10n.tos_pricing_footer,
      },
      {
        'title': l10n.tos_wallet_title,
        'content': l10n.tos_wallet_content,
        'items': [
          l10n.tos_wallet_item_1,
          l10n.tos_wallet_item_2,
          l10n.tos_wallet_item_3,
          l10n.tos_wallet_item_4,
        ],
      },
      {
        'title': l10n.tos_cancellation_title,
        'sections': [
          {
            'number': '1',
            'title': l10n.tos_cancellation_user_title,
            'items': [
              l10n.tos_cancellation_user_item_1,
              l10n.tos_cancellation_user_item_2,
              l10n.tos_cancellation_user_item_3,
            ],
          },
          {
            'number': '2',
            'title': l10n.tos_cancellation_driver_title,
            'items': [
              l10n.tos_cancellation_driver_item_1,
              l10n.tos_cancellation_driver_item_2,
            ],
          },
          {
            'number': '3',
            'title': l10n.tos_cancellation_refunds_title,
            'items': [
              l10n.tos_cancellation_refunds_item_1,
              l10n.tos_cancellation_refunds_item_2,
              l10n.tos_cancellation_refunds_item_3,
            ],
          },
        ],
      },
      {
        'title': l10n.tos_rating_title,
        'content': l10n.tos_rating_content,
        'items': [
          l10n.tos_rating_item_1,
          l10n.tos_rating_item_2,
          l10n.tos_rating_item_3,
          l10n.tos_rating_item_4,
        ],
      },
      {
        'title': l10n.tos_driver_req_title,
        'sections': [
          {
            'number': '1',
            'title': l10n.tos_driver_req_schedule_title,
            'description': l10n.tos_driver_req_schedule_desc,
          },
          {
            'number': '2',
            'title': l10n.tos_driver_req_availability_title,
            'items': [
              l10n.tos_driver_req_availability_item_1,
              l10n.tos_driver_req_availability_item_2,
              l10n.tos_driver_req_availability_item_3,
              l10n.tos_driver_req_availability_item_4,
            ],
          },
        ],
      },
      {
        'title': l10n.tos_safety_title,
        'content': l10n.tos_safety_content,
        'items': [
          l10n.tos_safety_item_1,
          l10n.tos_safety_item_2,
          l10n.tos_safety_item_3,
          l10n.tos_safety_item_4,
          l10n.tos_safety_item_5,
        ],
        'footer': l10n.tos_safety_footer,
      },
      {
        'title': l10n.tos_gender_pref_title,
        'content': l10n.tos_gender_pref_content,
        'items': [
          l10n.tos_gender_pref_item_1,
          l10n.tos_gender_pref_item_2,
          l10n.tos_gender_pref_item_3,
          l10n.tos_gender_pref_item_4,
        ],
      },
      {
        'title': l10n.tos_prohibited_title,
        'content': l10n.tos_prohibited_content,
        'items': [
          l10n.tos_prohibited_item_1,
          l10n.tos_prohibited_item_2,
          l10n.tos_prohibited_item_3,
          l10n.tos_prohibited_item_4,
          l10n.tos_prohibited_item_5,
          l10n.tos_prohibited_item_6,
          l10n.tos_prohibited_item_7,
        ],
        'footer': l10n.tos_prohibited_footer,
      },
      {
        'title': l10n.tos_liability_title,
        'content': l10n.tos_liability_content,
        'items': [
          l10n.tos_liability_item_1,
          l10n.tos_liability_item_2,
          l10n.tos_liability_item_3,
          l10n.tos_liability_item_4,
        ],
      },
      {
        'title': l10n.tos_dispute_title,
        'items': [
          l10n.tos_dispute_item_1,
          l10n.tos_dispute_item_2,
          l10n.tos_dispute_item_3,
          l10n.tos_dispute_item_4,
        ],
      },
      {
        'title': l10n.tos_termination_title,
        'sections': [
          {
            'number': '1',
            'title': l10n.tos_termination_user_title,
            'description': l10n.tos_termination_user_desc,
          },
          {
            'number': '2',
            'title': l10n.tos_termination_platform_title,
            'description': l10n.tos_termination_platform_desc,
          },
        ],
        'footer': l10n.tos_termination_footer,
      },
      {
        'title': l10n.tos_changes_title,
        'content': l10n.tos_changes_content,
        'items': [
          l10n.tos_changes_item_1,
          l10n.tos_changes_item_2,
          l10n.tos_changes_item_3,
        ],
        'footer': l10n.tos_changes_footer,
      },
      {
        'title': l10n.tos_contact_title,
        'items': [
          l10n.tos_contact_item_1,
          l10n.tos_contact_item_2,
          l10n.tos_contact_item_3,
          l10n.tos_contact_item_4,
        ],
      },
    ];
  }

  void _toggleSection(int index) {
    setState(() {
      _openIndex = _openIndex == index ? null : index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final sections = _getSections(context);
    final l10n = context.l10n;

    return Stack(
      children: [
        Scaffold(
          headers: [DefaultAppBar(title: l10n.tos_title)],
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(16.dg),
              child: Padding(
                padding: EdgeInsets.only(bottom: 100.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 16.h,
                  children: [
                    _buildHeaderCard(context),
                    ...sections.asMap().entries.map((entry) {
                      return _TermsSection(
                        section: entry.value,
                        isOpen: _openIndex == entry.key,
                        onToggle: () => _toggleSection(entry.key),
                      );
                    }),
                  ],
                ),
              ),
            ),
          ),
        ),
        _buildBottomButton(context),
      ],
    );
  }

  Widget _buildHeaderCard(BuildContext context) {
    final l10n = context.l10n;

    return Card(
      child: Column(
        spacing: 8.h,
        children: [
          Text(
            l10n.tos_title,
            style: context.typography.small.copyWith(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            l10n.tos_effective_date,
            style: context.typography.small.copyWith(
              fontSize: 13.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            l10n.tos_intro,
            style: context.typography.small.copyWith(
              fontSize: 12.sp,
              fontWeight: FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomButton(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 16,
      right: 16,
      child: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.card,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Button.primary(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              context.l10n.close,
              style: context.typography.small.copyWith(
                fontSize: 16.sp,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _TermsSection extends StatelessWidget {
  const _TermsSection({
    required this.section,
    required this.isOpen,
    required this.onToggle,
  });
  final Map<String, dynamic> section;
  final bool isOpen;
  final VoidCallback onToggle;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 8.h,
        children: [_buildHeader(context), if (isOpen) _buildContent(context)],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Button(
      style: const ButtonStyle.ghost(density: ButtonDensity.compact),
      onPressed: onToggle,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              section['title'] as String,
              style: context.typography.small.copyWith(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
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

  Widget _buildContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 8.h,
      children: [
        if (section['content'] != null)
          Text(
            section['content'] as String,
            style: context.typography.small.copyWith(
              fontSize: 12.sp,
              fontWeight: FontWeight.normal,
            ),
          ),
        if (section['sections'] != null)
          ...(section['sections'] as List).map((subsection) {
            return _SubSection(subsection: subsection as Map<String, dynamic>);
          }),
        if (section['items'] != null)
          ...(section['items'] as List).map((item) {
            return _BulletItem(item: item as String);
          }),
        if (section['footer'] != null)
          Padding(
            padding: EdgeInsets.only(top: 4.h),
            child: Text(
              section['footer'] as String,
              style: context.typography.small.copyWith(
                fontSize: 12.sp,
                fontWeight: FontWeight.normal,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
      ],
    );
  }
}

class _SubSection extends StatelessWidget {
  const _SubSection({required this.subsection});
  final Map<String, dynamic> subsection;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (subsection['number'] != null)
            _NumberContainer(number: subsection['number'] as String),
          if (subsection['number'] != null) SizedBox(width: 8.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 4.h,
              children: [
                if (subsection['title'] != null)
                  Text(
                    subsection['title'] as String,
                    style: context.typography.small.copyWith(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                if (subsection['description'] != null)
                  Text(
                    subsection['description'] as String,
                    style: context.typography.small.copyWith(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                if (subsection['items'] != null)
                  ...(subsection['items'] as List<dynamic>).map((item) {
                    return Padding(
                      padding: EdgeInsets.only(left: 8.w, bottom: 2.h),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '• ',
                            style: context.typography.small.copyWith(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              item as String,
                              style: context.typography.small.copyWith(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _BulletItem extends StatelessWidget {
  const _BulletItem({required this.item});
  final String item;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 8.w, bottom: 4.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '• ',
            style: context.typography.small.copyWith(
              fontSize: 12.sp,
              fontWeight: FontWeight.normal,
            ),
          ),
          Expanded(
            child: Text(
              item,
              style: context.typography.small.copyWith(
                fontSize: 12.sp,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _NumberContainer extends StatelessWidget {
  const _NumberContainer({required this.number});
  final String number;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 16.w,
      height: 16.h,
      decoration: const BoxDecoration(
        color: Color(0xFFD0ECF1),
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: Text(
        number,
        style: context.typography.small.copyWith(
          fontSize: 10.sp,
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
      ),
    );
  }
}
