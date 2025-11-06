import 'package:akademove/core/_export.dart';
import 'package:akademove/gen/assets.gen.dart';
import 'package:api_client/api_client.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class PickGenderWidget extends StatelessWidget {
  const PickGenderWidget({
    required this.value,
    required this.onChanged,
    super.key,
  });
  final UserGender? value;
  final void Function(UserGender? val) onChanged;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const DefaultText('Gender:'),
          Button(
            style: const ButtonStyle.outline().copyWith(
              decoration: (context, states, value) =>
                  value.copyWithIfBoxDecoration(
                    color: context.colorScheme.primary.withValues(alpha: 0.2),
                  ),
            ),
            onPressed: () {
              openSheet<void>(
                context: context,
                position: OverlayPosition.bottom,
                builder: (context) {
                  return Container(
                    padding: EdgeInsets.all(16.dg),
                    child: IntrinsicWidth(
                      child: Wrap(
                        spacing: 32.w,
                        runSpacing: 32.w,
                        alignment: WrapAlignment.center,
                        children: [
                          _buildGenderButton(UserGender.male, () {
                            onChanged(UserGender.male);
                            closeOverlay<void>(context);
                          }),
                          _buildGenderButton(UserGender.female, () {
                            onChanged(UserGender.female);
                            closeOverlay<void>(context);
                          }),
                          _buildGenderButton(null, () {
                            onChanged(null);
                            closeOverlay<void>(context);
                          }),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
            child: Row(
              spacing: 8.w,
              children: [
                if (value == UserGender.male)
                  Icon(
                    LucideIcons.mars,
                    size: 24.sp,
                    color: Colors.blue,
                  ),
                if (value == UserGender.female)
                  Icon(
                    LucideIcons.venus,
                    size: 24.sp,
                    color: Colors.pink,
                  ),
                if (value == null)
                  Icon(
                    LucideIcons.nonBinary,
                    size: 24.sp,
                  ),
                DefaultText(
                  value == null ? 'Mixed' : value!.name,
                  fontSize: 14.sp,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGenderButton(
    UserGender? gender,
    void Function() onPresesed,
  ) {
    return Button(
      style: const ButtonStyle.outline().copyWith(
        decoration: (context, states, value) => value.copyWithIfBoxDecoration(
          borderRadius: BorderRadius.circular(32.r),
        ),
        padding: (context, states, value) => EdgeInsetsGeometry.all(24.dg),
      ),
      onPressed: onPresesed,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: 8.h,
        children: [
          if (gender == UserGender.male)
            Assets.icons.male.svg(width: 64.w, height: 64.w),
          if (gender == UserGender.female)
            Assets.icons.female.svg(width: 64.w, height: 64.w),
          if (gender == null)
            Icon(
              LucideIcons.nonBinary,
              size: 64.sp,
            ),
          DefaultText(
            gender == null
                ? 'Mixed'
                : gender == UserGender.male
                ? 'Male'
                : 'Female',
            fontWeight: FontWeight.w500,
          ),
        ],
      ),
    );
  }
}
