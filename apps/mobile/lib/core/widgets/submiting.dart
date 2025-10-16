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
          const SizedBox(
            width: 16,
            height: 16,
            child: CircularProgressIndicator(
              strokeWidth: 2,
            ),
          ),
          Gap(8.w),
          if (simpleText)
            const Text('Loading')
          else
            const Text('Just a moment...'),
        ],
      ),
    );
  }
}
