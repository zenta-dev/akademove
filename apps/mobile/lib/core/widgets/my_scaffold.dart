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
  });

  final Widget body;
  final ScrollController? controller;
  final EdgeInsetsGeometry? padding;
  final bool safeArea;
  final bool scrollable;

  @override
  Widget build(BuildContext context) {
    Widget child = Padding(
      padding: padding ?? EdgeInsets.all(16.dg),
      child: body,
    );

    if (scrollable) {
      child = SingleChildScrollView(
        controller: controller,
        child: child,
      );
    }

    if (safeArea) {
      child = SafeArea(child: child);
    }

    return Scaffold(
      child: child,
    );
  }
}
