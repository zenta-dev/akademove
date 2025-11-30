import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class MyScaffold extends StatelessWidget {
  const MyScaffold({
    required this.body,
    super.key,
    this.controller,
    this.padding,
    this.safeArea = false,
    this.scrollable = true,
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
