import 'package:akademove/core/widgets/default_text.dart';
import 'package:akademove/l10n/l10n.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class Submiting extends StatelessWidget {
  const Submiting({super.key, this.simpleText = false});
  final bool simpleText;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 16.w,
            height: 16.w,
            child: CircularProgressIndicator(strokeWidth: 2.dg),
          ),
          Gap(8.w),
          DefaultText(
            simpleText ? context.l10n.loading : context.l10n.just_a_moment,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}
