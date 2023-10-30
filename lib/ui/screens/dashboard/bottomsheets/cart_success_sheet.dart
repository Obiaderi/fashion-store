import 'package:flutter/material.dart';
import 'package:lightsonheights/core/constants/app_color.dart';
import 'package:lightsonheights/ui/shared/custom_btn.dart';
import 'package:lightsonheights/ui/shared/sizer_manager.dart';
import 'package:lottie/lottie.dart';

class CartSuccessSheet extends StatelessWidget {
  const CartSuccessSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      padding: EdgeInsets.symmetric(
        horizontal: Sizer.radius(20),
      ),
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(Sizer.radius(20)),
          topRight: Radius.circular(Sizer.radius(20)),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Lottie.asset(
            'assets/lottie/cart.json',
            height: 180,
            width: 180,
            fit: BoxFit.cover,
          ),
          const VSpace(8),
          Text("Your Order is Successful",
              style: TextStyle(
                fontSize: Sizer.text(20),
                fontWeight: FontWeight.w500,
                color: AppColor.brandBlack,
              )),
          const VSpace(4),
          Text(
            "Thank you for shopping with us. We hope you enjoy your purchase.",
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
              title: "Continue Shopping",
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}
