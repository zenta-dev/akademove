import 'package:api_client/api_client.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class PickPaymentMethodWidget extends StatelessWidget {
  const PickPaymentMethodWidget({
    required this.value,
    required this.onChanged,
    super.key,
  });
  final PaymentMethod value;
  final void Function(PaymentMethod val) onChanged;

  @override
  Widget build(BuildContext context) {
    return OutlineButton(
      onPressed: () {
        openSheet<void>(
          context: context,
          position: OverlayPosition.bottom,
          builder: buildSheet,
        );
      },
      child: Row(
        spacing: 4.w,
        children: [
          Text(value.value),
          Icon(
            LucideIcons.chevronDown,
            size: 16.sp,
          ),
        ],
      ),
    );
  }

  Widget buildSheet(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.dg),
      child: IntrinsicWidth(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 16.h,
          children: PaymentMethod.values
              .map(
                (e) => SizedBox(
                  width: double.infinity,
                  child: OutlineButton(
                    child: Text(e.value),
                    onPressed: () {
                      onChanged(e);
                      closeSheet(context);
                    },
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
