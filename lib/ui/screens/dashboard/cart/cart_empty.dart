import 'package:flutter/material.dart';
import 'package:lightsonheights/core/constants/app_color.dart';
import 'package:lightsonheights/ui/shared/custom_btn.dart';
import 'package:lightsonheights/ui/shared/sizer_manager.dart';
import 'package:lottie/lottie.dart';

class CartEmpty extends StatelessWidget {
  const CartEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Sizer.width(40)),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Lottie.asset(
              'assets/lottie/empty.json',
              height: 200,
              width: 200,
              fit: BoxFit.cover,
            ),
            const VSpace(8),
            Text("Your shopping cart is empty",
                style: TextStyle(
                  fontSize: Sizer.text(20),
                  fontWeight: FontWeight.w500,
                  color: AppColor.brandBlack,
                )),
            const VSpace(4),
            Text(
              "Switch things up by filling your cart with must-have essentials",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: Sizer.text(14),
                fontWeight: FontWeight.w400,
                color: AppColor.grey200,
              ),
            ),
            const VSpace(32),
            SizedBox(
              height: Sizer.height(80),
              width: Sizer.screenWidth,
              child: CustomBtn(
                title: "Start Shopping",
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
