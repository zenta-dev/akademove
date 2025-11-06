import 'package:akademove/core/_export.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DefaultText extends StatelessWidget {
  const DefaultText(
    this.text, {
    super.key,
    this.overflow,
    this.fontSize,
    this.fontWeight,
    this.color,
    this.style,
  });
  final String text;
  final TextOverflow? overflow;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? color;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: overflow ?? TextOverflow.ellipsis,
      style:
          style ??
          context.typography.small.copyWith(
            fontSize: fontSize ?? 16.sp,
            fontWeight: fontWeight ?? FontWeight.normal,
            color: color ?? context.colorScheme.foreground,
          ),
    );
  }
}
