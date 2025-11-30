import 'package:akademove/core/_export.dart';
import 'package:api_client/api_client.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class BankProviderSelectorWidget extends StatelessWidget {
  const BankProviderSelectorWidget({
    required this.onSelected,
    super.key,
  });

  final void Function(BankProvider provider) onSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.dg),
      child: IntrinsicWidth(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 16.h,
          children: [
            DefaultText(
              'Select Bank Provider',
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
            ),
            ...bankProviderDicts.map((e) {
              return OutlineButton(
                onPressed: () async {
                  onSelected(e.provider);
                  await closeSheet(context);
                },
                child: Row(
                  spacing: 8.w,
                  children: [
                    SizedBox(
                      width: 24.sp,
                      height: 24.sp,
                      child: e.icon.svg(
                        width: 24.sp,
                        height: 24.sp,
                      ),
                    ),
                    DefaultText(e.provider.value),
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
