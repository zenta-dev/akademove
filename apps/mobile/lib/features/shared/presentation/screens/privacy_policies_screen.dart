import 'package:akademove/core/_export.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class PrivacyPoliciesScreen extends StatefulWidget {
  const PrivacyPoliciesScreen({super.key});

  @override
  State<PrivacyPoliciesScreen> createState() => _PrivacyPoliciesScreenState();
}

class _PrivacyPoliciesScreenState extends State<PrivacyPoliciesScreen> {
  int? _openIndex;

  static const List<Map<String, dynamic>> _details = [
    {
      'title': 'Data We Collect',
      'content':
          'We collect personal information from all users of AkadeMove, Customers, Drivers (Students), and Merchants to enable our services and ensure a safe and efficient platform experience.',
      'sections': [
        {
          'number': '1',
          'title': 'Customer Data',
          'description':
              'When you register and use AkadeMove as a Customer, we collect:',
          'items': [
            'Name',
            'Email address',
            'Phone number',
            'Gender',
          ],
          'footer':
              'This data allows us to verify your identity, communicate with you, process bookings and payments, and improve your overall experience.',
          'additional':
              'Customers may select their preferred driver gender to enhance comfort and safety.',
        },
        {
          'number': '2',
          'title': 'Driver (Student) Data',
          'description':
              'When you register as a Driver (student driver) on AkadeMove, we collect:',
          'items': [
            'Full name',
            'Email address',
            'Phone number',
            'Gender',
            'Driver License (SIM)',
            'Student ID Card (KTM)',
            'Vehicle Registration Certificate (STNK)',
            'Vehicle license plate number',
            'Bank account number',
          ],
          'footer':
              'Drivers may also manually input their academic schedule (KRS) to indicate unavailable periods (e.g., class hours). This schedule data is not shared with customers or third parties and is used solely to prevent order assignments during academic sessions.',
        },
        {
          'number': '3',
          'title': 'Merchant Data',
          'description': 'When you register as a Merchant Partner, we collect:',
          'items': [
            "Owner's full name",
            "Owner's email address",
            "Owner's phone number",
            "Outlet's name",
            "Outlet's location",
            "Outlet's phone number",
            "Outlet's email",
            "Outlet's documents (It is an optional uploads, e.g., tax ID, business license, etc.)",
            'Bank account number',
          ],
          'footer':
              'This data helps verify your merchant identity, facilitate transactions, and manage fund withdrawals securely.',
        },
      ],
    },
    {
      'title': 'Use of Data',
      'content': 'AkadeMove uses personal information to:',
      'items': [
        {
          'number': '1',
          'text':
              'Provide and manage all AkadeMove services (transportation, delivery, and transactions).',
        },
        {
          'number': '2',
          'text':
              'Verify the identity of Customers, Drivers, and Merchants to prevent fraud and unauthorized access.',
        },
        {
          'number': '3',
          'text':
              'Match customers with suitable drivers based on gender preference, proximity, and availability',
        },
        {
          'number': '4',
          'text':
              'Manage student drivers schedules to ensure service availability aligns with their academic commitments.',
        },
        {
          'number': '5',
          'text':
              'Communicate service updates, notifications, promotions, and account-related information.',
        },
        {
          'number': '6',
          'text':
              'Fulfill legal and regulatory obligations required by applicable laws.',
        },
      ],
    },
    {
      'title': 'Location Access',
      'content':
          'AkadeMove requires location access (GPS) to function properly. We use location data to:',
      'items': [
        {
          'number': '1',
          'text': 'Identify pick-up and drop-off points.',
        },
        {
          'number': '2',
          'text': 'Show real-time driver locations.',
        },
        {
          'number': '3',
          'text': 'Improve route accuracy and service efficiency.',
        },
        {
          'number': '4',
          'text': 'Match customers with the nearest available driver.',
        },
      ],
      'footer':
          'You may adjust your location permissions in your device settings. However, disabling location access may limit AkadeMove functionality.',
    },
    {
      'title': 'Data Sharing',
      'content':
          'We do not sell, rent, or trade your personal data to third parties. However, we may share certain information with:',
      'items': [
        {
          'number': '1',
          'text':
              'Payment service providers to process financial transactions.',
        },
        {
          'number': '2',
          'text':
              'Trusted third-party partners (such as identity verification, insurance, or analytics providers) to support our operations.',
        },
        {
          'number': '3',
          'text':
              'Law enforcement or government authorities, if required by applicable law or legal process.',
        },
        {
          'number': '4',
          'text': 'Match customers with the nearest available driver.',
        },
      ],
      'footer':
          'All partners handling your data are required to comply with strict data protection standards.',
    },
    {
      'title': 'Changes to This Privacy Policy',
      'content':
          'We may update this Privacy Policy from time to time to reflect changes in our practices or legal obligations. Updates will be communicated via the AkadeMove app or website. Continued use of our services after any update constitutes your acceptance of the revised policy.',
    },
  ];

  void _toggleSection(int index) {
    setState(() {
      _openIndex = _openIndex == index ? null : index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        MyScaffold(
          headers: const [
            DefaultAppBar(title: 'Privacy Policies'),
          ],
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 16.h,
            children: [
              _buildHeaderCard(context),
              ..._details.asMap().entries.map((entry) {
                return _PrivacySection(
                  detail: entry.value,
                  isOpen: _openIndex == entry.key,
                  onToggle: () => _toggleSection(entry.key),
                );
              }),
            ],
          ),
        ),
        _buildBottomButton(context),
      ],
    );
  }

  Widget _buildHeaderCard(BuildContext context) {
    return Card(
      child: Column(
        spacing: 8.h,
        children: [
          Text(
            'AkadeMove Privacy Policy',
            style: context.typography.small.copyWith(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            'October 2025',
            style: context.typography.small.copyWith(
              fontSize: 13.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            'Welcome to AkadeMove, a platform designed to connect customers, student drivers, and merchants in a unified mobility and delivery ecosystem. Your privacy is important to us. This Privacy Policy explains how we collect, use, store, and protect your personal information when you use our mobile application, website, or any related services (collectively referred to as "AkadeMove"). By using AkadeMove, you agree to the collection and use of your data in accordance with this policy. Please read this document carefully to understand how we handle your personal information.',
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
              'Accept all cookies',
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
        children: [
          _buildHeader(context),
          if (isOpen) _buildContent(context),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Button(
      style: const ButtonStyle.ghost(
        density: ButtonDensity.compact,
      ),
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
