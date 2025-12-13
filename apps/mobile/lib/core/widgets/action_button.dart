import "package:akademove/core/widgets/submiting.dart";
import "package:shadcn_flutter/shadcn_flutter.dart";

/// A reusable button widget that handles action-specific loading states.
///
/// Each button listens to its own action's loading state, preventing
/// the antipattern of disabling all buttons when any action is loading.
///
/// Example usage:
/// ```dart
/// BlocBuilder<OrderCubit, OrderState>(
///   builder: (context, state) => ActionButton(
///     isLoading: state.acceptOrderResult.isLoading,  // Only this action
///     onPressed: () => context.read<OrderCubit>().acceptOrder(orderId),
///     child: Text("Accept Order"),
///   ),
/// )
/// ```
class ActionButton extends StatelessWidget {
  const ActionButton({
    required this.isLoading,
    required this.onPressed,
    required this.child,
    super.key,
    this.style,
    this.loadingChild,
    this.enabled = true,
  });

  /// Creates an ActionButton with primary style.
  const ActionButton.primary({
    required this.isLoading,
    required this.onPressed,
    required this.child,
    super.key,
    this.loadingChild,
    this.enabled = true,
  }) : style = const ButtonStyle.primary();

  /// Creates an ActionButton with outline style.
  const ActionButton.outline({
    required this.isLoading,
    required this.onPressed,
    required this.child,
    super.key,
    this.loadingChild,
    this.enabled = true,
  }) : style = const ButtonStyle.outline();

  /// Creates an ActionButton with destructive style.
  const ActionButton.destructive({
    required this.isLoading,
    required this.onPressed,
    required this.child,
    super.key,
    this.loadingChild,
    this.enabled = true,
  }) : style = const ButtonStyle.destructive();

  /// Creates an ActionButton with ghost style.
  const ActionButton.ghost({
    required this.isLoading,
    required this.onPressed,
    required this.child,
    super.key,
    this.loadingChild,
    this.enabled = true,
  }) : style = const ButtonStyle.ghost();

  /// Creates an ActionButton with secondary style.
  const ActionButton.secondary({
    required this.isLoading,
    required this.onPressed,
    required this.child,
    super.key,
    this.loadingChild,
    this.enabled = true,
  }) : style = const ButtonStyle.secondary();

  /// Whether THIS action is currently loading.
  /// Each button should track its own action's loading state.
  final bool isLoading;

  /// Callback when button is pressed.
  /// Will be null (disabled) when [isLoading] is true or [enabled] is false.
  final VoidCallback? onPressed;

  /// The button's child widget (usually Text).
  final Widget child;

  /// The button style. Defaults to primary.
  final ButtonStyle? style;

  /// Custom loading widget. Defaults to [Submiting].
  final Widget? loadingChild;

  /// Whether the button is enabled (independent of loading state).
  /// Useful for form validation states.
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final isDisabled = isLoading || !enabled;

    return Button(
      style: style ?? const ButtonStyle.primary(),
      onPressed: isDisabled ? null : onPressed,
      child: isLoading ? (loadingChild ?? const Submiting()) : child,
    );
  }
}
