import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class MyScaffold extends StatelessWidget {
  const MyScaffold({
    required this.body,
    super.key,
    this.controller,
    this.padding,
    this.safeArea = false,
    this.scrollable = false,
    this.headers = const [],
    this.footers = const [],
    this.loadingProgress,
    this.loadingProgressIndeterminate = false,
    this.floatingHeader = false,
    this.floatingFooter = false,
    this.backgroundColor,
    this.headerBackgroundColor,
    this.footerBackgroundColor,
    this.showLoadingSparks,
    this.resizeToAvoidBottomInset,
    this.onRefresh,
  });

  final Widget body;
  final ScrollController? controller;
  final EdgeInsetsGeometry? padding;
  final bool safeArea;
  final bool scrollable;

  final List<Widget> headers;
  final List<Widget> footers;
  final double? loadingProgress;
  final bool loadingProgressIndeterminate;
  final bool floatingHeader;
  final bool floatingFooter;
  final Color? headerBackgroundColor;
  final Color? footerBackgroundColor;
  final Color? backgroundColor;
  final bool? showLoadingSparks;
  final bool? resizeToAvoidBottomInset;
  final Future<void> Function()? onRefresh;

  @override
  Widget build(BuildContext context) {
    Widget child = Padding(
      padding: padding ?? EdgeInsets.all(16.dg),
      child: body,
    );

    if (scrollable) {
      child = SingleChildScrollView(controller: controller, child: child);
    }

    if (safeArea) {
      child = SafeArea(child: child);
    }

    if (onRefresh != null) {
      child = RefreshTrigger(onRefresh: onRefresh!, child: child);
    }

    return Scaffold(
      headers: headers,
      footers: footers,
      loadingProgress: loadingProgress,
      loadingProgressIndeterminate: loadingProgressIndeterminate,
      floatingHeader: floatingHeader,
      floatingFooter: floatingFooter,
      backgroundColor: backgroundColor,
      headerBackgroundColor: headerBackgroundColor,
      footerBackgroundColor: footerBackgroundColor,
      showLoadingSparks: showLoadingSparks,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      child: child,
    );
  }
}
