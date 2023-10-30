import 'package:flutter/material.dart';

class AppColor {
  static const Color brandBlue = Color(0xff003366);
  static const Color brandOrange = Color(0xffFE6600);
  static const Color brandBlack = Color(0xff000B23);
  static const Color white = Color(0xffFFFFFF);
  static const Color black = Color(0xff000000);
  static const Color blue = Color(0xff003CC2);
  static const Color red = Color(0xffFF0000);
  static const Color grey = Color(0xff7D7D7D);
  static const Color grey200 = Colors.grey;
  static const Color lightGrey = Color(0xffC9C9C9);
  static const Color debitOrange = Color(0xffEB4200);

  //Shimmer
  static final shimmerBaseColor = Colors.grey[300]!;
  static const shimmerHighlightColor = Colors.white;
  static const shimmerGradient = LinearGradient(
    colors: [
      Color(0xFFEBEBF4),
      Color(0xFFF4F4F4),
      Color(0xFFEBEBF4),
    ],
    stops: [
      0.1,
      0.2,
      0.4,
    ],
    begin: Alignment(-1.0, -0.3),
    end: Alignment(1.0, 0.3),
  );
}
