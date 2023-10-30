import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Sizer {
  const Sizer._();
  static void init(BuildContext context) {
    ScreenUtil.init(
      context,
      designSize: const Size(375, 812),
      minTextAdapt: true,
    );
  }

  static double get screenWidth => 1.sw;
  static double get screenHeight => 1.sh;
  static get deviceRatio => screenHeight / screenWidth;
  static height(double height) => height.h;
  static width(double width) => width.w;
  static text(double size) => size.sp;
  static radius(double size) => size.r;
}

class HSpace extends StatelessWidget {
  const HSpace(this.space, {this.child, super.key});
  final double space;
  final Widget? child;
  @override
  Widget build(BuildContext context) {
    Sizer.init(context);
    return SizedBox(
      width: Sizer.width(space),
      child: child,
    );
  }
}

class VSpace extends StatelessWidget {
  const VSpace(this.space, {this.child, super.key});
  final double space;
  final Widget? child;
  @override
  Widget build(BuildContext context) {
    Sizer.init(context);
    return SizedBox(
      height: Sizer.height(space),
      child: child,
    );
  }
}
