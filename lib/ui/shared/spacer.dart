import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lightsonheights/core/constants/app_color.dart';

class FWt {
  FWt._();

  static FontWeight extraLight = FontWeight.w200;
  static FontWeight light = FontWeight.w300;
  static FontWeight regular = FontWeight.w400;
  static FontWeight semiBold = FontWeight.w500;
  static FontWeight mediumBold = FontWeight.w600;

  static FontWeight bold = FontWeight.w700;
  static FontWeight xBold = FontWeight.w800;
  static FontWeight xxBold = FontWeight.w900;
}

class Styles {
  Styles._();
  static Text regular(
    String text, {
    double? fontSize,
    Color? color,
    TextAlign? align,
    double? height,
    FontStyle? fontStyle,
    FontWeight? fontWeight,
    String? fontFamily,
    bool? strike = false,
    int? lines,
    TextOverflow? overflow,
    bool underline = false,
  }) {
    return Text(
      text,
      textAlign: align ?? TextAlign.left,
      maxLines: lines,
      overflow: overflow,
      style: TextStyle(
        fontSize: fontSize ?? 14.sp,
        fontWeight: fontWeight ?? FWt.regular,
        color: color ?? AppColor.black,
        height: height,
        fontStyle: fontStyle ?? FontStyle.normal,
        decoration: underline
            ? TextDecoration.underline
            : strike!
                ? TextDecoration.lineThrough
                : TextDecoration.none,
      ),
    );
  }
}
