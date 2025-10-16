import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class MyScaffold extends StatelessWidget {
  const MyScaffold({required this.body, super.key, this.controller});

  final Widget body;
  final ScrollController? controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      child: SingleChildScrollView(
        controller: controller,
        child: Padding(
          padding: EdgeInsets.all(16.dg),
          child: body,
        ),
      ),
    );
  }
}
