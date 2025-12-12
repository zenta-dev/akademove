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

  static const List<Map<String, dynamic>> _sections = [
    {
      'title': 'Acceptance of Terms',
      'content':
          'Welcome to AkadeMove. These Terms of Service ("Terms") govern your access to and use of our campus mobility and delivery platform. By creating an account or using our Services, you agree to be bound by these Terms and our Privacy Policy.',
    },
    {
      'title': 'Service Description',
      'content':
          'AkadeMove is a campus-specific platform that connects students, faculty, and authorized campus community members for:',
      'items': [
        'Ride-Hailing: Transportation services within and around campus areas',
        'Package Delivery: Delivery of documents, parcels, and goods within campus',
        'Food Delivery: Ordering and delivery of food from campus merchants',
      ],
      'footer':
          'AkadeMove acts as a technology platform connecting users with service providers. We are not a transportation or delivery company. Drivers and merchants are independent contractors.',
    },
    {
      'title': 'User Eligibility',
      'sections': [
        {
          'number': '1',
          'title': 'Passengers/Users',
          'items': [
            'Be at least 17 years of age',
            'Be a current student, faculty, or authorized campus member',
            'Provide valid contact information',
            'Verify campus affiliation (Student ID/KTM when required)',
          ],
        },
        {
          'number': '2',
          'title': 'Drivers',
          'items': [
            'Be at least 18 years of age',
            'Be a currently enrolled student',
            "Possess valid driver's license (SIM C/A)",
            'Provide valid vehicle registration (STNK)',
            'Submit Student ID (KTM) photo',
            'Pass verification and onboarding process',
          ],
        },
        {
          'number': '3',
          'title': 'Merchants',
          'items': [
            'Be an authorized campus food vendor or tenant',
            'Provide valid business documentation',
            'Maintain food safety and hygiene standards',
            'Comply with campus regulations',
          ],
        },
      ],
    },
    {
      'title': 'Pricing & Commission',
      'content':
          'Pricing formula: Base Price + (Distance × Rate) + Tip - Coupon',
      'sections': [
        {
          'number': '1',
          'title': 'Commission Structure',
          'items': [
            'Rides & Delivery: 15% platform commission',
            'Food Orders: 20% total (10% merchant, 10% platform)',
            'Tips: Go 100% to drivers (configurable)',
          ],
        },
      ],
      'footer':
          'Example: Ride total Rp 25,000 → Commission Rp 3,750 → Driver earns Rp 21,250',
    },
    {
      'title': 'Wallet System',
      'content': 'All users have an in-app wallet for managing funds:',
      'items': [
        'Top-Up: Add funds via QRIS, bank transfer, or e-wallet (Midtrans)',
        'Payment: Automatically deducted from wallet balance',
        'Earnings: Credited to wallet after order completion',
        'Withdrawals: Min. Rp 50,000, processed in 1-3 business days',
      ],
    },
    {
      'title': 'Cancellation Policy',
      'sections': [
        {
          'number': '1',
          'title': 'User Cancellations',
          'items': [
            'Free cancellation within 2 minutes of booking',
            'Cancellation fee applies after 2 minutes (configurable)',
            'Full fee if driver arrived or order being prepared',
          ],
        },
        {
          'number': '2',
          'title': 'Driver Cancellations',
          'items': [
            'Can cancel if passenger unresponsive or violates terms',
            'Excessive cancellations may result in suspension',
          ],
        },
        {
          'number': '3',
          'title': 'Refunds',
          'items': [
            'Processed within 5-7 business days for service issues',
            'Issued to original payment method or wallet',
            'Disputes must be raised within 24 hours',
          ],
        },
      ],
    },
    {
      'title': 'Rating & Review System',
      'content':
          'Both users and drivers rate each other on a 5-star scale. Ratings affect service quality and opportunities.',
      'items': [
        'Fairness: Ratings should reflect actual service quality',
        'Prohibition: Do not manipulate ratings or leave false reviews',
        'Disputes: Can be reported to customer support',
        'Consequences: Consistently low ratings may result in suspension',
      ],
    },
    {
      'title': 'Driver Requirements',
      'sections': [
        {
          'number': '1',
          'title': 'Class Schedule Management',
          'description':
              'Drivers can input class schedules to auto-set offline status during class times.',
        },
        {
          'number': '2',
          'title': 'Availability Control',
          'items': [
            'Toggle online/offline status freely',
            'Accept or reject order requests',
            'Excessive rejections affect matching priority',
            'Repeated cancellations may result in warnings',
          ],
        },
      ],
    },
    {
      'title': 'Safety & Reporting',
      'content': 'Your safety is our priority. AkadeMove provides:',
      'items': [
        'In-App Chat: Communicate without sharing phone numbers',
        'Driver Verification: All drivers undergo document verification',
        'Real-Time Tracking: Share trip with trusted contacts',
        'Emergency Button: Quick access to campus security',
        'Report System: Report misconduct or safety concerns',
      ],
      'footer':
          'Reports are reviewed within 24-48 hours. Actions may include warnings, suspension, or permanent ban. Serious incidents may be reported to authorities.',
    },
    {
      'title': 'Gender Preference Feature',
      'content':
          'Users can optionally request same-gender drivers for enhanced comfort and safety:',
      'items': [
        'Optional preference in matching algorithm',
        'Availability depends on nearby drivers',
        'May increase wait times if same-gender drivers not available',
        'Can be enabled/disabled anytime',
      ],
    },
    {
      'title': 'Prohibited Conduct',
      'content': 'Users must not:',
      'items': [
        'Use services for illegal purposes or transport illegal goods',
        'Harass, abuse, threaten, or discriminate against others',
        'Engage in fraudulent activities or fake accounts',
        'Manipulate platform, ratings, pricing, or promotions',
        'Operate vehicles unsafely or violate traffic laws',
        'Attempt unauthorized access to accounts or data',
        "Infringe on AkadeMove's or others' intellectual property",
      ],
      'footer':
          'Violations may result in immediate suspension and legal action.',
    },
    {
      'title': 'Limitation of Liability',
      'content':
          'AkadeMove is a technology platform connecting users with independent service providers. We do not provide transportation or delivery services directly.',
      'items': [
        'Services provided "as is" without warranties',
        'Not liable for indirect or consequential damages',
        'Maximum liability limited to amounts paid in last 12 months',
        'Not responsible for actions of drivers, merchants, or users',
      ],
    },
    {
      'title': 'Dispute Resolution',
      'items': [
        'Informal Resolution: Contact customer support first',
        'Mediation: Attempt mediation before litigation',
        'Governing Law: Republic of Indonesia laws apply',
        'Jurisdiction: Courts of Surabaya, Indonesia',
      ],
    },
    {
      'title': 'Account Termination',
      'sections': [
        {
          'number': '1',
          'title': 'User Termination',
          'description':
              'You may terminate your account anytime through app settings or customer support.',
        },
        {
          'number': '2',
          'title': 'Platform Termination',
          'description':
              'We reserve the right to suspend or terminate accounts that violate Terms, engage in fraud, or pose safety risks.',
        },
      ],
      'footer':
          'Upon termination, access ceases and data may be deleted subject to legal requirements. Outstanding obligations remain.',
    },
    {
      'title': 'Changes to Terms',
      'content':
          'We may modify these Terms at any time. Material changes will be notified via:',
      'items': [
        'In-app notification',
        'Email to registered address',
        'Prominent website notice',
      ],
      'footer':
          'Continued use after changes constitutes acceptance. If you disagree, stop using our Services.',
    },
    {
      'title': 'Contact Information',
      'items': [
        'Email: support@akademove.com',
        'Phone: +62 21 1234 5678',
        'Address: AkadeMove, Universitas Negeri Surabaya, Surabaya, Jawa Timur',
        'Customer Support: Available 24/7 through in-app chat',
      ],
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
        Scaffold(
          headers: [const DefaultAppBar(title: 'Terms of Service')],
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
                    ..._sections.asMap().entries.map((entry) {
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
    return Card(
      child: Column(
        spacing: 8.h,
        children: [
          Text(
            'AkadeMove Terms of Service',
            style: context.typography.small.copyWith(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            'Effective Date: December 6, 2025',
            style: context.typography.small.copyWith(
              fontSize: 13.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            'These Terms of Service constitute a legally binding agreement between you and AkadeMove. Please read them carefully before using our services.',
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
