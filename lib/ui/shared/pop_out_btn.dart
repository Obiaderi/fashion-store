import 'package:flutter/material.dart';
import 'package:lightsonheights/core/constants/app_color.dart';

import 'sizer_manager.dart';

class PopOutBtn extends StatelessWidget {
  const PopOutBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        width: Sizer.radius(30),
        height: Sizer.radius(30),
        decoration: BoxDecoration(
          color: AppColor.brandBlue,
          borderRadius: BorderRadius.circular(50),
          boxShadow: [
            BoxShadow(
              color: AppColor.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Icon(
          Icons.arrow_back_ios_new_rounded,
          color: AppColor.white,
          size: Sizer.radius(20),
        ),
      ),
    );
  }
}
