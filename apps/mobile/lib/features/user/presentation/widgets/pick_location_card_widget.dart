import 'package:akademove/core/_export.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class PickLocationParameters {
  const PickLocationParameters({
    this.enabled,
    this.controller,
    this.onPresesed,
    this.onChanged,
    this.text,
  });

  final bool? enabled;
  final TextEditingController? controller;
  final void Function()? onPresesed;
  final ValueChanged<String>? onChanged;
  final String? text;

  bool get disabled {
    if (enabled == null) return true;
    return !enabled!;
  }
}

class PickLocationCardWidget extends StatelessWidget {
  const PickLocationCardWidget({
    super.key,
    this.pickup,
    this.dropoff,
    this.padding,
    this.borderColor,
  });

  final PickLocationParameters? pickup;
  final PickLocationParameters? dropoff;
  final EdgeInsetsGeometry? padding;
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    return Card(
      borderColor:
          borderColor ??
          context.colorScheme.mutedForeground.withValues(alpha: 0.2),
      padding: padding,
      child: Row(
        spacing: 8.h,
        children: [
          Column(
            spacing: 8.h,
            children: [
              Icon(LucideIcons.circle, size: 12.sp),
              SizedBox(height: 20.h, child: const VerticalDivider()),
              Icon(LucideIcons.arrowDown, size: 12.sp),
            ],
          ),
          Expanded(
            child: Column(
              spacing: 8.h,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTextField(context, pickup, true),
                const Divider(),
                _buildTextField(context, dropoff, false),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(
    BuildContext context,
    PickLocationParameters? param,
    bool isPickup,
  ) {
    // If text is provided directly (display mode), create a temporary controller
    final effectiveController = param?.text != null
        ? TextEditingController(text: param!.text)
        : param?.controller;

    return Button(
      style: const ButtonStyle.ghost(density: ButtonDensity.compact),
      onPressed: param?.onPresesed,
      child: TextField(
        controller: effectiveController,
        readOnly:
            param?.disabled ??
            (param?.onPresesed != null && param?.onChanged != null),
        enabled:
            param?.enabled ??
            (param?.onPresesed == null && param?.onChanged == null),
        onChanged: param?.onChanged,
        placeholder: Text(
          'Search ${isPickup ? 'pickup' : 'dropoff'} location',
          style: context.typography.small.copyWith(fontSize: 13.sp),
        ),
        style: context.typography.small.copyWith(fontSize: 13.sp),
      ),
    );
  }
}
