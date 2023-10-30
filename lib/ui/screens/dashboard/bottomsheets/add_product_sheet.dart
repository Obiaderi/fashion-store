import 'package:flutter/material.dart';
import 'package:lightsonheights/core/constants/app_color.dart';
import 'package:lightsonheights/ui/shared/pop_out_btn.dart';
import 'package:lightsonheights/ui/shared/sizer_manager.dart';
import 'package:lottie/lottie.dart';

class AppProductSheet extends StatelessWidget {
  const AppProductSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(Sizer.radius(20)),
          topRight: Radius.circular(Sizer.radius(20)),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: Sizer.width(16),
              vertical: Sizer.height(16),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const PopOutBtn(),
                Text(
                  "Add Product",
                  style: TextStyle(
                    fontSize: Sizer.text(18),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(),
              ],
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset(
                  'assets/lottie/coming.json',
                  height: 200,
                  width: 200,
                  fit: BoxFit.cover,
                ),
                Text(
                  "Coming Soon",
                  style: TextStyle(
                    fontSize: Sizer.text(18),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
