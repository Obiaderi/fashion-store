import 'package:flutter/material.dart';

import 'package:lightsonheights/core/constants/app_color.dart';
import 'package:lightsonheights/ui/shared/spacer.dart';

import 'sizer_manager.dart';

class CustomBtn extends StatelessWidget {
  const CustomBtn({
    Key? key,
    this.onTap,
    required this.title,
  }) : super(key: key);

  final VoidCallback? onTap;
  final String title;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: Sizer.width(16),
        ).copyWith(
          bottom: Sizer.height(20),
        ),
        decoration: BoxDecoration(
          color: AppColor.brandBlue,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Styles.regular(
            title,
            color: AppColor.white,
            fontSize: 16,
            fontWeight: FWt.bold,
          ),
        ),
      ),
    );
  }
}
