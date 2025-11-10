import 'package:akademove/core/_export.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class MerchantPrivacyPoliciesScreen extends StatefulWidget {
  const MerchantPrivacyPoliciesScreen({super.key});

  @override
  State<MerchantPrivacyPoliciesScreen> createState() =>
      _MerchantPrivacyPoliciesScreenState();
}

class _MerchantPrivacyPoliciesScreenState
    extends State<MerchantPrivacyPoliciesScreen> {
  int? _openIndex;

  final List<Map<String, String>> details = [
    {
      'title': 'Data We Collect',
      'content':
          'We collect personal information from all users of AkadeMove—Customers, Drivers (Students), and Merchants—to enable our services and ensure a safe and efficient platform experience.',
    },
    {
      'title': 'Use of Data',
      'content': 'AkadeMove uses personal information to:',
    },
    {
      'title': 'Location Access',
      'content':
          'AkadeMove requires location access (GPS) to function properly. We use location data to:',
    },
    {
      'title': 'Data Sharing',
      'content':
          'We do not sell, rent, or trade your personal data to third parties. However, we may share certain information with:',
    },
    {
      'title': 'Changes to this Prvacy Policies',
      'content':
          'We may update this Privacy Policy from time to time to reflect changes in our practices or legal obligations. Updates will be communicated via the AkadeMove app or website. Continued use of our services after any update constitutes your acceptance of the revised policy.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      headers: const [
        DefaultAppBar(title: 'Privacy Policies'),
      ],
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 16.h,
          children: [
            Card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
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
                    'Welcome to AkadeMove, a platform designed to connect customers, student drivers, and merchants in a unified mobility and delivery ecosystem. Your privacy is important to us. This Privacy Policy explains how we collect, use, store, and protect your personal information when you use our mobile application, website, or any related services (collectively referred to as “AkadeMove”). By using AkadeMove, you agree to the collection and use of your data in accordance with this policy. Please read this document carefully to understand how we handle your personal information..',
                    style: context.typography.small.copyWith(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),

            ...List.generate(details.length, (index) {
              final detail = details[index];
              final isOpen = _openIndex == index;

              return Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 8.h,
                  children: [
                    Button(
                      style: ButtonStyle.ghost(density: ButtonDensity.compact),
                      onPressed: () {
                        setState(() {
                          _openIndex = isOpen ? null : index;
                        });
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            detail['title']!,
                            style: context.typography.small.copyWith(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Icon(
                            isOpen
                                ? LucideIcons.chevronUp
                                : LucideIcons.chevronDown,
                            size: 16,
                          ),
                        ],
                      ),
                    ),
                    if (isOpen)
                      Text(
                        detail['content']!,
                        style: context.typography.small.copyWith(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
