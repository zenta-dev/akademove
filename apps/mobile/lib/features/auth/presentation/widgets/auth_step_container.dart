import "package:akademove/core/_export.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:shadcn_flutter/shadcn_flutter.dart";

/// A reusable step container widget for multi-step authentication forms.
///
/// This widget wraps StepContainer with consistent styling.
class AuthStepContainer extends StatelessWidget {
  const AuthStepContainer({
    required this.heroImage,
    required this.title,
    required this.content,
    required this.actions,
    super.key,
  });

  /// The hero image displayed at the top.
  final Widget heroImage;

  /// The title of the step.
  final String title;

  /// The content widgets for this step.
  final List<Widget> content;

  /// The action buttons for this step.
  final List<Widget> actions;

  @override
  Widget build(BuildContext context) {
    return StepContainer(
      actions: actions,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 8.h,
        children: [
          heroImage,
          Text(
            title,
            textAlign: TextAlign.center,
            style: context.theme.typography.h3.copyWith(fontSize: 20.sp),
          ),
          ...content,
        ],
      ),
    );
  }
}
