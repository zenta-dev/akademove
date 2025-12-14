import 'package:akademove/core/_export.dart';
import 'package:akademove/l10n/l10n.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class PrivacyPoliciesScreen extends StatefulWidget {
  const PrivacyPoliciesScreen({super.key});

  @override
  State<PrivacyPoliciesScreen> createState() => _PrivacyPoliciesScreenState();
}

class _PrivacyPoliciesScreenState extends State<PrivacyPoliciesScreen> {
  int? _openIndex;

  List<Map<String, dynamic>> _getDetails(BuildContext context) {
    final l10n = context.l10n;
    return [
      {
        'title': l10n.privacy_data_we_collect_title,
        'content': l10n.privacy_data_we_collect_content,
        'sections': [
          {
            'number': '1',
            'title': l10n.privacy_customer_data_title,
            'description': l10n.privacy_customer_data_desc,
            'items': [
              l10n.privacy_customer_data_item_name,
              l10n.privacy_customer_data_item_email,
              l10n.privacy_customer_data_item_phone,
              l10n.privacy_customer_data_item_gender,
            ],
            'footer': l10n.privacy_customer_data_footer,
            'additional': l10n.privacy_customer_data_additional,
          },
          {
            'number': '2',
            'title': l10n.privacy_driver_data_title,
            'description': l10n.privacy_driver_data_desc,
            'items': [
              l10n.privacy_driver_data_item_name,
              l10n.privacy_driver_data_item_email,
              l10n.privacy_driver_data_item_phone,
              l10n.privacy_driver_data_item_gender,
              l10n.privacy_driver_data_item_sim,
              l10n.privacy_driver_data_item_ktm,
              l10n.privacy_driver_data_item_stnk,
              l10n.privacy_driver_data_item_plate,
              l10n.privacy_driver_data_item_bank,
            ],
            'footer': l10n.privacy_driver_data_footer,
          },
          {
            'number': '3',
            'title': l10n.privacy_merchant_data_title,
            'description': l10n.privacy_merchant_data_desc,
            'items': [
              l10n.privacy_merchant_data_item_owner_name,
              l10n.privacy_merchant_data_item_owner_email,
              l10n.privacy_merchant_data_item_owner_phone,
              l10n.privacy_merchant_data_item_outlet_name,
              l10n.privacy_merchant_data_item_outlet_location,
              l10n.privacy_merchant_data_item_outlet_phone,
              l10n.privacy_merchant_data_item_outlet_email,
              l10n.privacy_merchant_data_item_outlet_docs,
              l10n.privacy_merchant_data_item_bank,
            ],
            'footer': l10n.privacy_merchant_data_footer,
          },
        ],
      },
      {
        'title': l10n.privacy_use_of_data_title,
        'content': l10n.privacy_use_of_data_content,
        'items': [
          {'number': '1', 'text': l10n.privacy_use_of_data_item_1},
          {'number': '2', 'text': l10n.privacy_use_of_data_item_2},
          {'number': '3', 'text': l10n.privacy_use_of_data_item_3},
          {'number': '4', 'text': l10n.privacy_use_of_data_item_4},
          {'number': '5', 'text': l10n.privacy_use_of_data_item_5},
          {'number': '6', 'text': l10n.privacy_use_of_data_item_6},
        ],
      },
      {
        'title': l10n.privacy_location_access_title,
        'content': l10n.privacy_location_access_content,
        'items': [
          {'number': '1', 'text': l10n.privacy_location_access_item_1},
          {'number': '2', 'text': l10n.privacy_location_access_item_2},
          {'number': '3', 'text': l10n.privacy_location_access_item_3},
          {'number': '4', 'text': l10n.privacy_location_access_item_4},
        ],
        'footer': l10n.privacy_location_access_footer,
      },
      {
        'title': l10n.privacy_data_sharing_title,
        'content': l10n.privacy_data_sharing_content,
        'items': [
          {'number': '1', 'text': l10n.privacy_data_sharing_item_1},
          {'number': '2', 'text': l10n.privacy_data_sharing_item_2},
          {'number': '3', 'text': l10n.privacy_data_sharing_item_3},
          {'number': '4', 'text': l10n.privacy_data_sharing_item_4},
        ],
        'footer': l10n.privacy_data_sharing_footer,
      },
      {
        'title': l10n.privacy_changes_title,
        'content': l10n.privacy_changes_content,
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
    final details = _getDetails(context);
    return Stack(
      children: [
        Scaffold(
          headers: [DefaultAppBar(title: context.l10n.title_privacy_policies)],
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
                    ...details.asMap().entries.map((entry) {
                      return _PrivacySection(
                        detail: entry.value,
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
            l10n.privacy_policy_title,
            style: context.typography.small.copyWith(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            l10n.privacy_policy_date,
            style: context.typography.small.copyWith(
              fontSize: 13.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            l10n.privacy_policy_intro,
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

// Extracted to separate widget for better performance and reusability
class _PrivacySection extends StatelessWidget {
  const _PrivacySection({
    required this.detail,
    required this.isOpen,
    required this.onToggle,
  });
  final Map<String, dynamic> detail;
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
              detail['title'] as String,
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
        Text(
          detail['content'] as String,
          style: context.typography.small.copyWith(
            fontSize: 12.sp,
            fontWeight: FontWeight.normal,
          ),
        ),
        if (detail['sections'] != null)
          ...(detail['sections'] as List).map((section) {
            return _SectionItem(section: section as Map<String, dynamic>);
          }),
        if (detail['items'] != null)
          ...(detail['items'] as List).map((item) {
            return _NumberedItem(item: item as Map<String, dynamic>);
          }),
        if (detail['footer'] != null)
          Padding(
            padding: EdgeInsets.only(top: 4.h),
            child: Text(
              detail['footer'] as String,
              style: context.typography.small.copyWith(
                fontSize: 12.sp,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
      ],
    );
  }
}

class _SectionItem extends StatelessWidget {
  const _SectionItem({required this.section});
  final Map<String, dynamic> section;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _NumberContainer(number: section['number'] as String),
          SizedBox(width: 8.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 4.h,
              children: [
                Text(
                  section['title'] as String,
                  style: context.typography.small.copyWith(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (section['description'] != null)
                  Text(
                    section['description'] as String,
                    style: context.typography.small.copyWith(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                if (section['items'] != null)
                  ...(section['items'] as List<dynamic>).map((item) {
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
                if (section['footer'] != null)
                  Text(
                    section['footer'] as String,
                    style: context.typography.small.copyWith(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                if (section['additional'] != null)
                  Text(
                    section['additional'] as String,
                    style: context.typography.small.copyWith(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _NumberedItem extends StatelessWidget {
  const _NumberedItem({required this.item});
  final Map<String, dynamic> item;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _NumberContainer(number: item['number'] as String),
          SizedBox(width: 8.w),
          Expanded(
            child: Text(
              item['text'] as String,
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
