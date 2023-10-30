import 'dart:async';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lightsonheights/core/constants/app_color.dart';
import 'package:lightsonheights/core/routes/routes.dart';
import 'package:lightsonheights/ui/shared/sizer_manager.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double opacity = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      init();
    });
  }

  init() async {
    Future.delayed(const Duration(milliseconds: 100), () {
      setState(() {
        opacity = 1;
      });
    });

    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, Routes.dashboard);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.brandBlue,
        body: Container(
          width: Sizer.screenWidth,
          height: Sizer.screenHeight,
          color: AppColor.brandBlue,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: Sizer.height(4)),
                  AnimatedOpacity(
                    opacity: opacity,
                    duration: const Duration(seconds: 1),
                    child: Padding(
                        padding: EdgeInsets.only(top: 12.h),
                        child: Text(
                          'Lights on Heights',
                          style: TextStyle(
                            color: AppColor.white,
                            fontSize: 40.sp,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Pacifico',
                          ),
                        )),
                  ),
                  SizedBox(height: Sizer.height(10)),
                  DefaultTextStyle(
                    style: const TextStyle(
                      fontSize: 20.0,
                      fontFamily: 'Agne',
                    ),
                    child: AnimatedTextKit(
                      animatedTexts: [
                        TypewriterAnimatedText(
                          'Welcome to our fashion store',
                          speed: const Duration(milliseconds: 100),
                        ),
                      ],
                    ),
                  ),
                  // AnimatedOpacity(
                  //   opacity: opacity,
                  //   duration: const Duration(seconds: 2),
                  //   child: Padding(
                  //     padding: EdgeInsets.only(top: 2.h),
                  //     child: FadeOutParticle(
                  //       disappear: false,
                  //       duration: const Duration(seconds: 2),
                  //       child: Text(
                  //         'Ecommerce Store',
                  //         style: TextStyle(
                  //           color: AppColor.white,
                  //           fontSize: 20.sp,
                  //           fontWeight: FontWeight.w400,
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ],
          ),
        ));
  }
}
