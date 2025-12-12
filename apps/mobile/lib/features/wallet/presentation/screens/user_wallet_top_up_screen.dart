import 'package:akademove/app/router/router.dart';
import 'package:akademove/core/_export.dart';
import 'package:api_client/api_client.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:akademove/l10n/l10n.dart';

class _Option {
  const _Option(this.name, this.method);

  final String name;
  final TopUpRequestMethodEnum method;
}

class UserWalletTopUpScreen extends StatelessWidget {
  const UserWalletTopUpScreen({super.key});

  static const _options = [
    _Option('QRIS', TopUpRequestMethodEnum.QRIS),
    _Option('Bank Transfer', TopUpRequestMethodEnum.BANK_TRANSFER),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      headers: [DefaultAppBar(title: context.l10n.top_up)],
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.dg),
          child: Column(
            spacing: 4.h,
            children: _options.map((option) {
              return Button(
                style: const ButtonStyle.secondary().copyWith(
                  decoration: (context, states, value) =>
                      value.copyWithIfBoxDecoration(
                        color: context.colorScheme.primary.withValues(
                          alpha: 0.2,
                        ),
                      ),
                ),
                onPressed: () {
                  context.pushNamed(
                    Routes.userWalletTopUpInsertAmount.name,
                    queryParameters: {'method': option.method.value},
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    DefaultText(option.name),
                    const Icon(LucideIcons.chevronRight),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
